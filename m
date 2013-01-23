From: Stefan Norgren <stefan.norgren@gmail.com>
Subject: Bug in EOL conversion?
Date: Wed, 23 Jan 2013 03:44:23 +0100
Message-ID: <CANrZfmGXtKcB+i_xhNJELftRc1pC2TJKKhOieHm=5Qkni9OKrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 23 03:51:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxqRP-0005gd-Ux
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 03:51:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622Ab3AWCvf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 21:51:35 -0500
Received: from mail-yh0-f54.google.com ([209.85.213.54]:34419 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346Ab3AWCve (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 21:51:34 -0500
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Jan 2013 21:51:34 EST
Received: by mail-yh0-f54.google.com with SMTP id 29so395106yhr.27
        for <git@vger.kernel.org>; Tue, 22 Jan 2013 18:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=7UmVfa5TeRor/7bE+q+QqPdwShJo/frdGcQgi2ITye4=;
        b=wtnzyfFK3xeemZNJw/W/63BTWgICdvxlzq7mor1c/YQ9qE2OYunBROxqv8BmeH5ZH8
         yRJHJ4/VnISgmylqC5UytpnkrwbTQB5AeCZnOkRaGlTEDAI6sUbj47eYIR896dxKjUuY
         lnr4uJDRZnaqT+RW9W3b6UgUiqU1bAj4mkWpdBsWi+OydsQFt3iOU7YCxwDUwMqCFghc
         bU63rE4kvrDe872MJMHHnD+sutM7SEOJXIOxO6I+OUKwjgvFDYpXyrZMZw5oAKEM67Rx
         vamhMYu50vzLmiX4nGpBA8qCNV+2LESw/3AC13h1j6SjiRM/tSkYffR9clelEffdxYPv
         LBQA==
X-Received: by 10.236.122.238 with SMTP id t74mr26759408yhh.96.1358909063546;
 Tue, 22 Jan 2013 18:44:23 -0800 (PST)
Received: by 10.100.165.5 with HTTP; Tue, 22 Jan 2013 18:44:23 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214275>

Hi,

The EOL conversion does not behave as indicated by output message from
add and commit. Here is my test case executed on Windows 7 64 bit.


$ git --version
git version 1.8.0.msysgit.0
$ which git
/cygdrive/c/Program Files (x86)/Git/cmd/git
$ git config --list
core.symlinks=false
core.autocrlf=true
color.diff=auto
color.status=auto
color.branch=auto
color.interactive=true
pack.packsizelimit=2g
help.format=html
http.sslcainfo=/bin/curl-ca-bundle.crt
sendemail.smtpserver=/bin/msmtp.exe
diff.astextplain.textconv=astextplain
rebase.autosquash=true
user.name=Stefan
user.email=stefan@---.com
core.repositoryformatversion=0
core.filemode=false
core.bare=false
core.logallrefupdates=true
core.symlinks=false
core.ignorecase=true
core.hidedotfiles=dotGitOnly

-- Note core.autocrlf=true.
-- Created withcrlf.txt with one character and one CRLF line feed.
File size 3 bytes.
-- Created withlf.txt with one character and one LF line feed. File
size 2 bytes.
-- Now let's init repository.

$ git init
Initialized empty Git repository in D:/Dev/workspaces/gittest/.git/
$ ls -la
total 10
d---------+ 1 Stefan None 0 Jan 23 02:12 .
d---------+ 1 Stefan None 0 Jan 23 02:10 ..
d---------+ 1 Stefan None 0 Jan 23 02:13 .git
----------+ 1 Stefan None 3 Jan 23 01:55 withcrlf.txt
----------+ 1 Stefan None 2 Jan 23 01:55 withlf.txt

-- Note no .gitattributes file that will affect EOL conversion.

$ ls -la .git/info/
total 5
d---------+ 1 Stefan None   0 Jan 23 02:12 .
d---------+ 1 Stefan None   0 Jan 23 02:13 ..
----------+ 1 Stefan None 240 Jan 23 02:12 exclude

-- Note no attribute file in .git/info/ that will affect EOL conversion.

$ git add *
warning: LF will be replaced by CRLF in withlf.txt.
The file will have its original line endings in your working directory.
$ git commit -m 'Testing EOL'
[master (root-commit) 9a0b2f5] Testing EOL
 2 files changed, 2 insertions(+)
 create mode 100644 withcrlf.txt
 create mode 100644 withlf.txt
warning: LF will be replaced by CRLF in withlf.txt.
The file will have its original line endings in your working directory.
$ ls -la
total 10
d---------+ 1 Stefan None 0 Jan 23 02:12 .
d---------+ 1 Stefan None 0 Jan 23 02:10 ..
d---------+ 1 Stefan None 0 Jan 23 02:22 .git
----------+ 1 Stefan None 3 Jan 23 01:55 withcrlf.txt
----------+ 1 Stefan None 2 Jan 23 01:55 withlf.txt

-- So no changes (see file size) to files in working directory. This
is expected and according to output warning from add and commit.

-- Now lets look in the repository

$ git ls-tree -l HEAD withcrlf.txt
100644 blob d00491fd7e5bb6fa28c517a0bb32b8b506539d4d       2    withcrlf.txt
$ git ls-tree -l HEAD withlf.txt
100644 blob d00491fd7e5bb6fa28c517a0bb32b8b506539d4d       2    withlf.txt

-- Note that size of withlf.txt is 2 in repository indicating that LF
was not replaced by CRLF in withlf.txt as indicated in output from add
and commit. Also note that size of withcrlf.txt is also 2 in
repository so it looks like CRLF was replaced by LF in withcrlf.txt.
To verify I will delete the files from working directory, turn off EOL
conversion, checkout files and look at file endings in the working
directory.

$ rm with*
$ ls -la
total 8
d---------+ 1 Stefan None 0 Jan 23 02:31 .
d---------+ 1 Stefan None 0 Jan 23 02:10 ..
d---------+ 1 Stefan None 0 Jan 23 02:22 .git
$ git status
# On branch master
# Changes not staged for commit:
#   (use "git add/rm <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#       deleted:    withcrlf.txt
#       deleted:    withlf.txt
#
no changes added to commit (use "git add" and/or "git commit -a")
$ git config --global core.autocrlf false
$ git config --global core.autocrlf
false
$ git checkout -- with*
$ ls -la
total 10
d---------+ 1 Stefan None 0 Jan 23 02:38 .
d---------+ 1 Stefan None 0 Jan 23 02:10 ..
d---------+ 1 Stefan None 0 Jan 23 02:38 .git
----------+ 1 Stefan None 2 Jan 23 02:38 withcrlf.txt
----------+ 1 Stefan None 2 Jan 23 02:38 withlf.txt

-- Both files in working directory files now have LF line endings
confirming that files in repository have LF file endings. Either the
output message of add and commit is wrong or the behavior of the EOL
conversion is wrong... or... have I missed something...?

   /Stefan
