From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2] reset: Better warning message on git reset --mixed <paths>
Date: Sun, 15 Aug 2010 08:43:20 +0000
Message-ID: <1281861800-424-1-git-send-email-avarab@gmail.com>
References: <20100814210505.GA2372@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ralf Ebert <info@ralfebert.de>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 15 17:34:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkfEU-0003i1-Jm
	for gcvg-git-2@lo.gmane.org; Sun, 15 Aug 2010 17:34:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757545Ab0HOPek convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Aug 2010 11:34:40 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59649 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755715Ab0HOPej (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Aug 2010 11:34:39 -0400
Received: by wwj40 with SMTP id 40so5326802wwj.1
        for <git@vger.kernel.org>; Sun, 15 Aug 2010 08:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=OZdnRu/48cdly/bxq02rvsDdTl1IxjIU9Nf6PWCrhl8=;
        b=Zth/j5avr4xp6jrm1+SkaiYDhYe4BArMhYBdL0iADqFmeGPY26XSIcKfJ2fr5PVZio
         5rBm1jus66+VCFvYyHuTC40gSUGr6KN/JYFeUhsGZ+wq8a98Iy1tSFwBWV5a9XAKDI01
         QXQHdcnVkOP9PahpSkwOPLf49YZ2Xt5AU6nX0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=iINnEV2Pyuso2hAizWAqoBCfF7unNPKusb725GDJKisvCqZx93N8I7NuZH8DIgulh7
         Iof9YK3q1bdesKKjRr32udNk77CuSXGpdzZ01/uMxMiyomZlQdAkEv/RJBIgG/1tIegO
         P2bG0hGLLbiaw+H0xX4mUg3NMZSKjadIwPjac=
Received: by 10.227.208.85 with SMTP id gb21mr3156701wbb.167.1281861808534;
        Sun, 15 Aug 2010 01:43:28 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id h37sm2546520wej.47.2010.08.15.01.43.26
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 15 Aug 2010 01:43:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.339.gfad93
In-Reply-To: <20100814210505.GA2372@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153602>

When you call "git reset --mixed <paths>" git will complain that using
mixed with paths is deprecated:

    warning: --mixed option is deprecated with paths.

That doesn't tell the user why it's deprecated, or what he should use
instead. Expand on the warning and tell the user to just omit --mixed:

    warning: --mixed with paths is deprecated; use 'git reset -- <paths=
>' instead

The exact wording of the warning was suggested by Jonathan Nieder.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

On Sat, Aug 14, 2010 at 21:05, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Maybe:
>
> =C2=A0warning: --mixed with paths is deprecated; use 'git reset -- <p=
aths>' instead

That's better, thanks. Here's an amended version, and with tests this
time.

 builtin/reset.c           |    2 +-
 t/t7112-reset-messages.sh |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletions(-)
 create mode 100755 t/t7112-reset-messages.sh

diff --git a/builtin/reset.c b/builtin/reset.c
index 1283068..0037be4 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -318,7 +318,7 @@ int cmd_reset(int argc, const char **argv, const ch=
ar *prefix)
 	 * affecting the working tree nor HEAD. */
 	if (i < argc) {
 		if (reset_type =3D=3D MIXED)
-			warning("--mixed option is deprecated with paths.");
+			warning("--mixed with paths is deprecated; use 'git reset -- <paths=
>' instead.");
 		else if (reset_type !=3D NONE)
 			die("Cannot do %s reset with paths.",
 					reset_type_names[reset_type]);
diff --git a/t/t7112-reset-messages.sh b/t/t7112-reset-messages.sh
new file mode 100755
index 0000000..6f2669b
--- /dev/null
+++ b/t/t7112-reset-messages.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
+#
+
+test_description=3D'git reset warning and error messages'
+
+. ./test-lib.sh
+
+test_expect_success 'setup {err,out}-expect' "
+	cat >err-expect <<EOF &&
+warning: --mixed with paths is deprecated; use 'git reset -- <paths>' =
instead.
+EOF
+	cat >out-expect <<EOF
+Unstaged changes after reset:
+M	hlagh
+EOF
+"
+
+test_expect_success 'git reset --mixed <paths> warning' '
+	# Not test_commit() due to "ambiguous argument [..] both revision
+	# and filename"
+	echo stuff >hlagh &&
+	git add hlagh &&
+	git commit -m"adding stuff" hlagh &&
+	echo more stuff >hlagh &&
+	git add hlagh &&
+	test_must_fail git reset --mixed hlagh >out 2>err &&
+	test_cmp err-expect err &&
+	test_cmp out-expect out
+'
+
+test_done
--=20
1.7.2.1.339.gfad93
