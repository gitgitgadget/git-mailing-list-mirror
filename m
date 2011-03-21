From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: "git rm" is not a valid merge resolution?
Date: Mon, 21 Mar 2011 19:27:14 +0100
Message-ID: <4D879882.4070608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 21 19:27:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1jpB-0001hL-C8
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 19:27:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108Ab1CUS1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 14:27:25 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43404 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753985Ab1CUS1X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 14:27:23 -0400
Received: by bwz15 with SMTP id 15so5251413bwz.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 11:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :subject:content-type:content-transfer-encoding;
        bh=J8PnGM0sUW4s4oL/XnmBLkwkqYNVPK4A0KI08jQuayM=;
        b=dHHGda9fNkUVGcb2ubeXMYSRiPlZJPzD0T+dyOtuJgtkJXH82gDx7K05rjQHd1LYCY
         IEFWbMYTFA8lI3uROlFqQeNbOCL+LWR1MdJ1B78zRl/afTKNF4rF/X6IV/DK8/qTMYUz
         FjTDDxSRMVQEHfGIM9v8V5A/VLU0Nr8Nu96SY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=rOIahFu1cWjtcapwszSpR2XTbmjm6lUi4fsH7L9iLw6ndwEijtaDjMjf9syIVxYf4a
         tzDU295haf69EvW/GAnAmyW9mSHljkojx38hA1rd8rYMt7yD1PdDQerLje9jTVOQx4og
         JPEnF9JEjSgaLU1LwMfYcW9OphlYbAFNv3fDE=
Received: by 10.204.19.14 with SMTP id y14mr4085761bka.187.1300732042269;
        Mon, 21 Mar 2011 11:27:22 -0700 (PDT)
Received: from [192.168.1.101] (aadh98.neoplus.adsl.tpnet.pl [83.4.85.98])
        by mx.google.com with ESMTPS id c11sm4539036bkc.14.2011.03.21.11.27.20
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Mar 2011 11:27:21 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169635>

Hi,

git-status shows a hint that says
    use "git add/rm <file>..." as appropriate to mark resolution
 
But if I "git rm file" the file gets deleted. Is this really the 
appropriate merge resolution?

I would expect "git rm" to maybe reset all the merge changes but
it seems to just delete the file.

I doubt that when you get merge conflicts you would like to delete
the file. That might be the case when in one of merge parents
the file was deleted, but not if both files existed.

When deleting the file it shows a message "needs merge", perhaps
the intention was to not delete the file in such case?

So maybe:
- don't list "rm" as appropriate to mark resolution, or
- list it only if the files was deleted on one parent


Example:

$ git init
$ echo a > a 
$ git add a
$ git commit -a -m a
$ echo b > a
$ git commit -a -m b
$ git checkout  -b topic HEAD^
$ echo c > a
$ git commit -a -m c

$ git merge master
Auto-merging a
CONFLICT (content): Merge conflict in a
Automatic merge failed; fix conflicts and then commit the result.

$ git status
# On branch topic
# Unmerged paths:
#   (use "git add/rm <file>..." as appropriate to mark resolution)
#
#	both modified:      a
#
no changes added to commit (use "git add" and/or "git commit -a")

$ git rm a
a: needs merge
rm 'a'

$ git status
# On branch topic
# Changes to be committed:
#
#	deleted:    a
#

  
-- 
Piotr Krukowiecki
