From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/2] Set Makefile variables from configure
Date: Tue, 3 Nov 2009 16:21:23 -0600
Message-ID: <20091103222123.GA17097@progeny.tock>
References: <1257021695-21260-1-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Tue Nov 03 23:11:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5RbW-0004bO-Uy
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 23:11:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755299AbZKCWLo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Nov 2009 17:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755004AbZKCWLo
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 17:11:44 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:40679 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754799AbZKCWLn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 17:11:43 -0500
Received: by bwz27 with SMTP id 27so8151918bwz.21
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 14:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=XD7kHVFglv+02okZnEm+/hgJTxJK7bkS5ASEUBWWjm8=;
        b=f63fOgsnozN0GE7kM5a+tnRL0JoJBl7AxDuXvW9fft/yjQ8B2zKAL7bnHD43TKuEzn
         3zo803+3BdtGqPlsW8iT0xd7/qLHnZPXrz9DiVeHiMCAjzZ5lMJ9wgTjnEfQrmBEJgiY
         7Y8K5iYLIxk6QyqJ9XNnMg8WflNXU9pZ1LZeU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=xPSV/C5HDsx8KSaDOQaG2Dp6ieysw2ZSZ7BaC6Q3a/7uHvyWAe/s1U4BCM9DvWgFm9
         psI3LYu6UxGo1fwhsSxYHZoFYtCcXikeeZ/wLz1Xgdw33OI65ut4PBlKwjsTO9nCq/0f
         JNmfHn5qmMgXyBdSpO/R+7KCVWwrLERBEkytw=
Received: by 10.204.10.2 with SMTP id n2mr585319bkn.91.1257286307649;
        Tue, 03 Nov 2009 14:11:47 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 18sm1312743fkq.37.2009.11.03.14.11.44
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 03 Nov 2009 14:11:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1257021695-21260-1-git-send-email-bwalton@artsci.utoronto.ca>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132003>

Ben Walton wrote:
> These patches add support for setting the newly created DEFAULT_EDITO=
R
> and DEFAULT_PAGER from the configure script.  I also tacked in
> ETC_GITCONFIG, since I can't currently toggle this without setting a
> command line value when building, but have need to alter it.

Would the --sysconfdir option work for you here?  Setting --sysconfdir
currently does nothing, so the question is kind of moot without some
change like this (untested):

Hook up more of ./configure=E2=80=99s installation directory options to
actually do something.  Unfortunately, this defeats the RUNTIME_PREFIX
facility unless all the relevant paths are explicitly set.  Probably
the defaults set in Makefile should not be overridden unless
explicitly requested.

This patch also changes the default location for HTML documentation
after running ./configure from /usr/local/share/git-doc to
/usr/local/share/git.  In my opinion, the fix to this would also be to
make the configure script not override defaults from Makefile.

 config.mak.in |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/config.mak.in b/config.mak.in
index 67b12f7..430134a 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -11,17 +11,21 @@ TAR =3D @TAR@
 TCLTK_PATH =3D @TCLTK_PATH@
=20
 prefix =3D @prefix@
-exec_prefix =3D @exec_prefix@
 bindir =3D @bindir@
+mandir =3D @mandir@
+infodir =3D @infodir@
 gitexecdir =3D @libexecdir@/git-core
-datarootdir =3D @datarootdir@
+sharedir =3D @datadir@
 template_dir =3D @datadir@/git-core/templates
+htmldir =3D @htmldir@
+sysconfdir =3D @sysconfdir@
=20
-mandir=3D@mandir@
-
+exec_prefix =3D @exec_prefix@
+datarootdir =3D @datarootdir@
+PACKAGE_TARNAME =3D @PACKAGE_TARNAME@
+docdir =3D @docdir@
 srcdir =3D @srcdir@
 VPATH =3D @srcdir@
-
 export exec_prefix mandir
 export srcdir VPATH
=20
--=20
1.6.5.2
