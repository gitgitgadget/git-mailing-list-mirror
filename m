From: Reece Dunn <msclrhd@googlemail.com>
Subject: Re: Running 'git pull' from an unnamed branch
Date: Sun, 5 Apr 2009 23:15:40 +0100
Message-ID: <3f4fd2640904051515x797e10b5ia20543f207084a60@mail.gmail.com>
References: <3f4fd2640904051433u199587c3wc9bf080d138944e7@mail.gmail.com>
	 <200904052342.44856.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Mon Apr 06 00:17:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqaeV-0007ks-1r
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 00:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753718AbZDEWPp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Apr 2009 18:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753642AbZDEWPo
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 18:15:44 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:60707 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753492AbZDEWPn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Apr 2009 18:15:43 -0400
Received: by bwz17 with SMTP id 17so1641932bwz.37
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 15:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=r0865XDHtltQZAD4Bxp1RUEf/HNrRgJh81yrejlexOA=;
        b=KLtAQ8emc1GMtE2vs9ex+g8jn2czsBdcLrn7j7bEj4JPtm7/rXp0EvxUfbSzcZfb7W
         cJ1M5dlD+R9VSzEFbiQDXNdhhRY6uVOsw/rN7aMAmyd9n7EsQyXLJAmpqXXgl8VK8pna
         AxazE7CnTkfz3H9r3Gi765DCyspzouWNHIMzk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jHNCsHOvW7cRHBjtzRRKCwQsJZ/t6UA76bluSdXb0bgvH2xGaB/bgKnbXaVn+mu8mD
         rAs6tNej4pV/IvcVbgVE0hdPQ/2jpl0pyy9QAC7JETL+T6e0oKMMbLrmt/zKRluDkGAZ
         9Wz3vD7kKzfSsFgUFNyJfsHjPS3Zofp7UuFPI=
Received: by 10.239.135.77 with SMTP id c13mr82551hbc.104.1238969740739; Sun, 
	05 Apr 2009 15:15:40 -0700 (PDT)
In-Reply-To: <200904052342.44856.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115727>

2009/4/5 Markus Heidelberg <markus.heidelberg@web.de>:
> Reece Dunn, 05.04.2009:
>> Hi,
>>
>> Here is something I have just recently tripped up on.
>>
>> $ git pull
>>
>> [..]
>>
>> $ git branch
>> * (no branch)
>> =A0 master
>>
>> Running `git checkout master && git pull` fixed the above issue. The
>> patch below improves the error message for users that are in this
>> state.
>>
>> Also, is "branch..remote" valid? Should this be "branch.remote"?
>
> The current branch has no name, so there is nothing between the two
> dots. For clarification: branch.(no branch).remote

Ok. I see now.

>> + =A0 =A0 echo "You may not be on a branch. In this case, you need t=
o move"
>> + =A0 =A0 echo "onto the branch you want to pull to (usually master)=
:"
>> + =A0 =A0 echo " =A0 =A0git checkout <branch>"
>> + =A0 =A0 echo
>
> Not being on a branch is not the general case when you receive this
> message. Maybe determining if you are not on a branch and adjusting t=
he
> message acordingly is an option.

So, something like:

=46rom 59e8b71be1585a3a6c8c1233811c19ef0022b3e5 Mon Sep 17 00:00:00 200=
1
=46rom: Reece Dunn <msclrhd@gmail.com>
Date: Sun, 5 Apr 2009 23:15:03 +0100
Subject: [PATCH] Improve the message when pulling to a headless branch.

---
 git-pull.sh |   40 +++++++++++++++++++++++-----------------
 1 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 8a26763..f263c04 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -90,23 +90,29 @@ error_on_no_merge_candidates () {

 	curr_branch=3D${curr_branch#refs/heads/}

-	echo "You asked me to pull without telling me which branch you"
-	echo "want to merge with, and 'branch.${curr_branch}.merge' in"
-	echo "your configuration file does not tell me either.  Please"
-	echo "name which branch you want to merge on the command line and"
-	echo "try again (e.g. 'git pull <repository> <refspec>')."
-	echo "See git-pull(1) for details on the refspec."
-	echo
-	echo "If you often merge with the same branch, you may want to"
-	echo "configure the following variables in your configuration"
-	echo "file:"
-	echo
-	echo "    branch.${curr_branch}.remote =3D <nickname>"
-	echo "    branch.${curr_branch}.merge =3D <remote-ref>"
-	echo "    remote.<nickname>.url =3D <url>"
-	echo "    remote.<nickname>.fetch =3D <refspec>"
-	echo
-	echo "See git-config(1) for details."
+	if [ -n "$curr_branch" ]; then
+		echo "You asked me to pull without telling me which branch you"
+		echo "want to merge with, and 'branch.${curr_branch}.merge' in"
+		echo "your configuration file does not tell me either.  Please"
+		echo "name which branch you want to merge on the command line"
+		echo "and try again (e.g. 'git pull <repository> <refspec>')."
+		echo "See git-pull(1) for details on the refspec."
+		echo
+		echo "If you often merge with the same branch, you may want to"
+		echo "configure the following variables in your configuration"
+		echo "file:"
+		echo
+		echo "    branch.${curr_branch}.remote =3D <nickname>"
+		echo "    branch.${curr_branch}.merge =3D <remote-ref>"
+		echo "    remote.<nickname>.url =3D <url>"
+		echo "    remote.<nickname>.fetch =3D <refspec>"
+		echo
+		echo "See git-config(1) for details."
+	else
+		echo "You may not be on a branch. In this case, you need to"
+		echo "move to the branch you want to pull to (usually master):"
+		echo "    git checkout <branch>"
+	fi
 	exit 1
 }

--=20
1.6.2.2.414.g81aa.dirty
