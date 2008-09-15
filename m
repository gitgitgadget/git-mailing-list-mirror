From: "Paul Johnston" <pcj127@gmail.com>
Subject: git-clone: path or ssh problem with git-upload-pack in 1.6.0?
Date: Mon, 15 Sep 2008 01:30:16 -0700
Message-ID: <d3a045300809150130w6f78edd8xf599d1c7f639b77d@mail.gmail.com>
References: <d3a045300809091929h18c3c447gb3d4e79131f66986@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 15 10:31:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kf9UV-00019n-AS
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 10:31:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbYIOIaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 04:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbYIOIaU
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 04:30:20 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:28209 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999AbYIOIaR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 04:30:17 -0400
Received: by yx-out-2324.google.com with SMTP id 8so594963yxm.1
        for <git@vger.kernel.org>; Mon, 15 Sep 2008 01:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=qR0uKJXIV6BsX02S09lhgga+hpVG4cn5rPZ0kR6xqEg=;
        b=KLEI5T1gkTV3sRLf5ZQpu8X4ELb2kjOb9vd6q8p0Ab1W5mGIADmpveL6Av0JrF/ubJ
         DT27pyT8Qy0qgCgnns08k85dSYjogFzwmWRE+H65BoitAM7aQgB1/8GN2gN9jPgGWsGV
         GT4koPkiCrD01NlthbOm0GrzwJXPtlKSjeppU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=a9tT6vtyzr0SGm1ZakEf9snxIg7/XNRz422PIIGudnmMChprRrmpgBGw7Jh5vmV4Gt
         RNSqrZ3y6r61xGL60AKLg/DcfQeHdPvJ4Cn7IdNJLDE2XAEuaN5e6d3Mo7DX1MiuWaO3
         XJii1lakIwgX7EkjgzTjkSprnqY6yXtq819BE=
Received: by 10.150.154.6 with SMTP id b6mr10302296ybe.92.1221467416691;
        Mon, 15 Sep 2008 01:30:16 -0700 (PDT)
Received: by 10.150.11.21 with HTTP; Mon, 15 Sep 2008 01:30:16 -0700 (PDT)
In-Reply-To: <d3a045300809091929h18c3c447gb3d4e79131f66986@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95892>

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
/Users/paul/bin/git
/Users/paul/bin/git-shell
/Users/paul/bin/git-upload-pack
/Users/paul/bin/git-receive-pack
/Users/paul/bin/git-upload-archive

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
