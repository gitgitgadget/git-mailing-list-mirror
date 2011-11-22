From: Pascal Obry <pascal@obry.net>
Subject: Re: How to deal with mixed tree?
Date: Tue, 22 Nov 2011 15:20:39 +0100
Organization: Home - http://www.obry.net
Message-ID: <4ECBAFB7.9040505@obry.net>
References: <CA+9ZNic-9U0nP1NGL0shUijnxdhaoEHwyxWM8rOzR2B6Qjq6zQ@mail.gmail.com> <4ECB8917.8010305@ira.uka.de>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Nov 22 15:20:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSrDM-0007XU-8d
	for gcvg-git-2@lo.gmane.org; Tue, 22 Nov 2011 15:20:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755915Ab1KVOUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Nov 2011 09:20:43 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42370 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755752Ab1KVOUm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2011 09:20:42 -0500
Received: by bke11 with SMTP id 11so255152bke.19
        for <git@vger.kernel.org>; Tue, 22 Nov 2011 06:20:41 -0800 (PST)
Received: by 10.205.139.65 with SMTP id iv1mr6915960bkc.34.1321971641069;
        Tue, 22 Nov 2011 06:20:41 -0800 (PST)
Received: from [192.168.0.100] (AVelizy-154-1-55-184.w83-199.abo.wanadoo.fr. [83.199.37.184])
        by mx.google.com with ESMTPS id f14sm10218905bkv.3.2011.11.22.06.20.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 Nov 2011 06:20:39 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <4ECB8917.8010305@ira.uka.de>
X-Enigmail-Version: 1.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185794>


Holger,

> Remove SD in P1, make a logical link from P2 to SD, add SD to
> .git/info/exclude

Thanks for your quick reply. That's what I have tested but...

> (see "Bug report - local (and git ignored) file silently removed after
> checkout" on the mailing list why exclude is better than .gitignore at
> the moment)

Seems like this is working only if file names are different. This is not
my case as the replacement is very similar. With the following script
I'm expecting empty status and no diff:

<<
#!/bin/sh

# create sd (directory that will replace src2)
mkdir sd
echo sd1 > sd/file1
echo sd2 > sd/file2

# create Git repo
mkdir repo
cd repo
git init
mkdir src1
mkdir src2
echo file > src1/file
echo 3 > src2/file3
git add .
git ci -a -m "first"

# let's replace src2 by sd

rm -fr src2
# ln -s ../sd src2
cp -r ../sd src2

# make sure src2 is excluded

echo 'src2/*' >> .git/info/exclude

# the following output should be clean

echo '============== Status'
git status

echo '============== Diff'
git diff
>>

But the output is actually:

Initialized empty Git repository in /home/obry/tmp/repo/.git/
[master (root-commit) 527c7a1] first
 2 files changed, 2 insertions(+), 0 deletions(-)
 create mode 100644 src1/file
 create mode 100644 src2/file3
cp: cannot stat `../src': No such file or directory
============== Status
# On branch master
# Changes not staged for commit:
#   (use "git add/rm <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working
directory)
#
#	deleted:    src2/file3
#
no changes added to commit (use "git add" and/or "git commit -a")
============== Diff
diff --git a/src2/file3 b/src2/file3
deleted file mode 100644
index 00750ed..0000000
--- a/src2/file3
+++ /dev/null
@@ -1 +0,0 @@
-3

Any other idea?

Thanks.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
