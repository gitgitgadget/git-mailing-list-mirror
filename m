From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/7] gc -h: show usage even with broken configuration
Date: Fri, 22 Oct 2010 01:47:19 -0500
Message-ID: <20101022064719.GE6081@burratino>
References: <1287544320-8499-1-git-send-email-pclouds@gmail.com>
 <1287544320-8499-4-git-send-email-pclouds@gmail.com>
 <20101022063837.GA6081@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 08:51:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9BT7-0003tO-CW
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 08:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753564Ab0JVGvI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Oct 2010 02:51:08 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54702 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952Ab0JVGvH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 02:51:07 -0400
Received: by gyg4 with SMTP id 4so333066gyg.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 23:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=uOufLE2k3go0G9CPFqNzMhks7Lbfmz1rv52Jhww+gEg=;
        b=RpL7c5bRNzLQ9JwFJFss9n0aYCoP9VCa8J9Nfnv2joRWaIPRsTeZYULkm3XOXf/C1f
         ySATgbGuQRHDmc6upCvuVPaQ7SBlqOXVoVCcl69r6j6vB6E80rVv1Az+jiApn/N1362W
         svRHR0qk43utLzDP5rc03odW+jJ7P9W33qvsw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=CeRhu7XTLqVrPvrgbnKjA5+EmT1qKHcKkaelRVPR+8jEu6WhtqizIFDPQd+QoGsgXE
         J+LqzBkvWtrZrbqr2o5e/tJwk3+LaONUysZTLi5h38FzaSnGUPEgioln7xRlTMp+P1F6
         L140cCbpXZ2XmxYQKhnddcRFKANzC/XzBNAjY=
Received: by 10.150.53.1 with SMTP id b1mr5451130yba.79.1287730265726;
        Thu, 21 Oct 2010 23:51:05 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id t14sm2096215yhc.8.2010.10.21.23.51.04
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 23:51:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101022063837.GA6081@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159654>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Given a request for command-line usage information rather than some
more substantial action, the only friendly thing to do is to report
the usage information as soon as possible and exit.

Without this change, as "git gc" glances over the repository, it can
be distracted by the desire to report a malformed configuration file.

Noticed while working through reports from Duy's repository access
checker.

[jn: with rewritten log message and tests]

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/gc.c  |    3 +++
 t/t6500-gc.sh |   28 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 0 deletions(-)
 create mode 100755 t/t6500-gc.sh

diff --git a/builtin/gc.c b/builtin/gc.c
index c304638..93deed5 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -189,6 +189,9 @@ int cmd_gc(int argc, const char **argv, const char =
*prefix)
 		OPT_END()
 	};
=20
+	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(builtin_gc_usage, builtin_gc_options);
+
 	git_config(gc_config, NULL);
=20
 	if (pack_refs < 0)
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
new file mode 100755
index 0000000..82f3639
--- /dev/null
+++ b/t/t6500-gc.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+
+test_description=3D'basic git gc tests
+'
+
+. ./test-lib.sh
+
+test_expect_success 'gc empty repository' '
+	git gc
+'
+
+test_expect_success 'gc --gobbledegook' '
+	test_expect_code 129 git gc --nonsense 2>err &&
+	grep "[Uu]sage: git gc" err
+'
+
+test_expect_success 'gc -h with invalid configuration' '
+	mkdir broken &&
+	(
+		cd broken &&
+		git init &&
+		echo "[gc] pruneexpire =3D CORRUPT" >>.git/config &&
+		test_expect_code 129 git gc -h >usage 2>&1
+	) &&
+	grep "[Uu]sage" broken/usage
+'
+
+test_done
--=20
1.7.2.3
