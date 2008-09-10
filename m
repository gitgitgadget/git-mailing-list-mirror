From: "Paul Johnston" <pcj127@gmail.com>
Subject: git-clone: path or ssh problem with git-upload-pack in 1.6.0?
Date: Tue, 9 Sep 2008 19:29:27 -0700
Message-ID: <d3a045300809091929h18c3c447gb3d4e79131f66986@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 10 04:30:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdFTY-0007LK-IX
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 04:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826AbYIJC33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 22:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbYIJC33
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 22:29:29 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:51498 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779AbYIJC32 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 22:29:28 -0400
Received: by gxk9 with SMTP id 9so12541785gxk.13
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 19:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=vz9iDQBW/rnUKCGyxb6uEDM2Gjkvqq4vBWFMM9DRhaE=;
        b=DHWnOCRvVoSW+Td6iHYJwWuM9LjEVnll/JdJ5qljg8CK1qnam0B6emPktrDoWYkeGv
         IGq8CNy0hZSb46XQW2nLiZAhzuRkyOHs1kcBLKPDWDzxmKYQn24JlJ/Oqlv7Hu7+hJm0
         CWl18L2f7uUPZsygj+3r68naKFN8w8na3PReQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=blI7/siE+sspS/kgDVgKyPWtse5oiwftnILARAeFr0rHqqJYetQWJB/OXtJNcVi2Fq
         Jk+07jg/87t8Fe4o5W1Z0H4RuvYnixc4o7BcMLw8h0tL6Ue+NgFrbvo8Oxuig/3hSWwG
         FACVZBUtsjM54jDthwZ2BBcvDSSo5dMq6YCJk=
Received: by 10.150.182.16 with SMTP id e16mr1097206ybf.148.1221013767358;
        Tue, 09 Sep 2008 19:29:27 -0700 (PDT)
Received: by 10.150.11.21 with HTTP; Tue, 9 Sep 2008 19:29:27 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95475>

I'm having trouble with git-clone and I'm wondering if there's
something I'm doing wrong or something wrong with git.  Probably the
former, hopefully someone can set me straight.

I'm an admittedly novice git user. I'm trying to clone a repository
over ssh. The host machine 'imac' is my mac osx 10.4 with git 1.6.0
installed from a macports package.  This installs into /opt/local/bin.
I also cloned git from HEAD and 'make; make install'ed into ~/bin,
this is the version shown below.  Either way, these are
nonstandard/non-system-wide installation locations, and it requires
that my shell PATH reflect this, obviously.

----------------------------------------------

# About my installation
imac:~ paul$ which git
/Users/paul/bin/git

imac:~ paul$ git --version
git version 1.6.0.1.285.g1070

imac:~ paul$ ls /opt/local/bin/git*
/opt/local/bin/git
/opt/local/bin/git-upload-archive       /opt/local/bin/gitk
/opt/local/bin/git-receive-pack         /opt/local/bin/git-upload-pack

imac:~ paul$ ls ~/bin/git*
/Users/paul/bin/git                     /Users/paul/bin/git-shell
         /Users/paul/bin/git-upload-pack
/Users/paul/bin/git-receive-pack        /Users/paul/bin/git-upload-archive

# Make a simple reposirtory /tmp/test/.git
imac:~ paul$ cd /tmp
imac:/tmp paul$ mkdir test; cd test; echo 'Hello World' > README; git
init; git add README; git commit -a -m'Initial import'; cd ..
Initialized empty Git repository in /private/tmp/test/.git/
Created initial commit 49c10e6: Initial import
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 README

# OK, this fails expectedly
imac:/tmp paul$ cd ~
imac:~ paul$ git clone ssh://localhost/tmp/test/.git
Initialized empty Git repository in /Users/paul/test/.git/
Password:
bash: line 1: git-upload-pack: command not found
fatal: The remote end hung up unexpectedly

# This has been killing me...  Have tried numerous variants of the
same with similar results...
imac:~ paul$ git clone --upload-pack /opt/local/bin/git-upload-pack
ssh://localhost/tmp/test/.git
Initialized empty Git repository in /Users/paul/test/.git/
Password:
remote: fatal: exec pack-objects failed.
error: git-upload-pack: git-pack-objects died with error.
fatal: git-upload-pack: aborting due to possible repository corruption
on the remote side.
remote: aborting due to possible repository corruption on the remote side.
fatal: early EOF
fatal: index-pack failed

# Fix it with symlinks in /usr/bin
imac:~ paul$ cd /usr/bin/
imac:/usr/bin paul$ sudo ln -s /opt/local/bin/git* .
imac:/usr/bin paul$ ls -al git*
lrwxr-xr-x   1 root  wheel  18 Sep  9 19:18 git -> /opt/local/bin/git
lrwxr-xr-x   1 root  wheel  31 Sep  9 19:18 git-receive-pack ->
/opt/local/bin/git-receive-pack
lrwxr-xr-x   1 root  wheel  33 Sep  9 19:18 git-upload-archive ->
/opt/local/bin/git-upload-archive
lrwxr-xr-x   1 root  wheel  30 Sep  9 19:18 git-upload-pack ->
/opt/local/bin/git-upload-pack
lrwxr-xr-x   1 root  wheel  19 Sep  9 19:18 gitk -> /opt/local/bin/gitk

# And now git-clone works as expected...
imac:/usr/bin paul$ cd
imac:~ paul$ git clone ssh://localhost/tmp/test/.git
Initialized empty Git repository in /Users/paul/test/.git/
Password:
remote: Counting objects: 3, done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Receiving objects: 100% (3/3), done.

imac:~ paul$ find test/
test/
test//.git
   { file listing removed for brevity... }
test//README

-------------------------------------------

OK, great, now it works. I suspect I'm not using the --upload-pack
option correctly or my ssh installation is suboptimal, but as I could
find no existing documentation on the subject, I am posting this
message.  Any thoughts?

Paul Johnston
