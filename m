From: "Sean" <seanlkml@sympatico.ca>
Subject: Problem resolving an octopus merge conflict
Date: Wed, 11 Jan 2006 01:51:11 -0500 (EST)
Message-ID: <BAYC1-PASMTP1241F00474C3FC5C32F7A6AE240@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Wed Jan 11 08:22:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwaJl-0003Ss-MA
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 08:22:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbWAKHWU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 02:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932644AbWAKHWU
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 02:22:20 -0500
Received: from bayc1-pasmtp12.bayc1.hotmail.com ([65.54.191.172]:42683 "EHLO
	BAYC1-PASMTP12.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1750864AbWAKHWT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 02:22:19 -0500
X-Originating-IP: [69.156.6.171]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.6.171]) by BAYC1-PASMTP12.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 10 Jan 2006 23:24:39 -0800
Received: by linux1.attic.local (Postfix, from userid 48)
	id 33B03644C23; Wed, 11 Jan 2006 01:51:11 -0500 (EST)
Received: from 10.10.10.28
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Wed, 11 Jan 2006 01:51:11 -0500 (EST)
Message-ID: <57422.10.10.10.28.1136962271.squirrel@linux1>
To: git@vger.kernel.org
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 11 Jan 2006 07:24:39.0562 (UTC) FILETIME=[154CD6A0:01C61680]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Hi folks,

After a failed regular merge you can fix up the conflicts by hand and then
do a commit; the proper parents for the merge will be picked up from
MERGE_HEADS.  However, after a failed octopus merge this file doesn't
exist even though conflict markers _do_ exist in the appropriate files.  A
little test case is given below:

mkdir otest
cd otest

git init-db
echo A > file
git add file
git commit -m "new file"

git checkout -b linus
echo B > file
git commit -a -m "B file"

git checkout -b torvalds master
echo C > file
git commit -a -m "C file"

git checkout master
git pull . linus torvalds

At which point you'll get back:

defaulting to local storage area
Committing initial tree a9e3325a07117aa5381e044a8d96c26eb30d729d
Trying simple merge with 87915efc19fb0a71f88c1da6f7da0e4454f32a68
Trying simple merge with ec835c64be51803fb46f82c97b266cc60a0b04b7
Simple merge did not work, trying automatic merge.
Auto-merging file
merge: warning: conflicts during merge
ERROR: Merge conflict in file
fatal: merge program failed
No merge strategy handled the merge.

The "file" will contain:

<<<<<<< .merge_file_e7oHn1
C
=======
B
>>>>>>> .merge_file_6Z4LD0

After fixing this up though, git-commit won't see this as a merge commit
and won't add the proper parent linkages.   I'm not sure at this point
what the proper fix should be or if this is just pilot error.

Thanks,
Sean
