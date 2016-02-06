From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v6 11/11] diffcore-pickaxe: support case insensitive match on non-ascii
Date: Sat,  6 Feb 2016 09:03:10 +0700
Message-ID: <1454724190-14063-12-git-send-email-pclouds@gmail.com>
References: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
 <1454724190-14063-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 06 03:04:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRsEk-0004bx-It
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 03:04:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbcBFCEb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2016 21:04:31 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34413 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbcBFCEa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 21:04:30 -0500
Received: by mail-pf0-f178.google.com with SMTP id o185so77925916pfb.1
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 18:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=F+oFWcbXegoB1To+BxHC8KQgCw+Z1a0uo4FPSNJaZ50=;
        b=NUcCBtJwFNtbAmfgjh0UHFHXjNApX89sZgkExPBjwYGJ6erYvkBPZxkPkWqJHLdASO
         zZlRJ1HUDKn2f5PRnlIUOWJbwcVvA98RXRzPosaZGuI2TilKagjEvFbrtJfHtMDc+5+Y
         W6Vvs6OtMCmMMJ6dzD1gCaTYmLAhIVzK3ksfHd93rVGL2giLW9V6hT+kNqKYLdXUAbtM
         pH/ZGsB1I29S1+IUQqq6h2gl3up/ZdmYvCofBrga6zOLy/iOm3rihkenTEbIaz1O2kqH
         /8hvAWQPq4jRNRX6gWX/D+O4e1bvFyRvjjFB1beNvON+wwE85KDvHWts2Vkq4htKb79T
         HGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=F+oFWcbXegoB1To+BxHC8KQgCw+Z1a0uo4FPSNJaZ50=;
        b=JX3AhO9QXvxet44w7uopyZ6d2Wg1Cac8ceRaj3yUb7Sq41p6IVzY/nvsnisRyc7gUE
         jvbjpOTRkaZ8GqGGupOrLWhsrHAjit9sWNKJT+DWZnGMElKaXVYsuY0OxUSgbK9uvh+A
         zMZ1zAPoSmbj3ecB7MoVZfbq3NGROiEHmSBPgvmii01hYGPgj+Kq79gI2RK/1aNOc28z
         GLExDZIB8x5r+Wk8hji4RA85LLOJ/OnTIRcrAXXAy7N4bVV+xwCu4pAB35/UQakiSagN
         P2Y2pYAtc1UPtg+RcWMQMDN2LwbACx9dqfPPIOiJB+ArwDmUd/ZbNrAU056ZfhUn5Egr
         7Z8w==
X-Gm-Message-State: AG10YOQUFjWlL11QPc/nm6605OHiObfG7otG7k+X+Rahd7hJQ768GfzPj1euRy1FuTn57w==
X-Received: by 10.98.8.200 with SMTP id 69mr24886376pfi.39.1454724269906;
        Fri, 05 Feb 2016 18:04:29 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id n84sm27219369pfa.45.2016.02.05.18.04.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2016 18:04:28 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 06 Feb 2016 09:04:44 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454724190-14063-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285676>

Similar to the "grep -F -i" case, we can't use kws on icase search
outside ascii range, so we quote the string and pass it to regcomp as
a basic regexp and let regex engine deal with case sensitivity.

The new test is put in t7812 instead of t4209-log-pickaxe because
lib-gettext.sh might cause problems elsewhere, probably.

Noticed-by: Plamen Totev <plamen.totev@abv.bg>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diffcore-pickaxe.c              | 11 +++++++++++
 t/t7812-grep-icase-non-ascii.sh |  7 +++++++
 2 files changed, 18 insertions(+)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 69c6567..0a5f877 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -7,6 +7,8 @@
 #include "diffcore.h"
 #include "xdiff-interface.h"
 #include "kwset.h"
+#include "commit.h"
+#include "quote.h"
=20
 typedef int (*pickaxe_fn)(mmfile_t *one, mmfile_t *two,
 			  struct diff_options *o,
@@ -212,6 +214,15 @@ void diffcore_pickaxe(struct diff_options *o)
 			cflags |=3D REG_ICASE;
 		err =3D regcomp(&regex, needle, cflags);
 		regexp =3D &regex;
+	} else if (DIFF_OPT_TST(o, PICKAXE_IGNORE_CASE) &&
+		   has_non_ascii(needle)) {
+		struct strbuf sb =3D STRBUF_INIT;
+		int cflags =3D REG_NEWLINE | REG_ICASE;
+
+		basic_regex_quote_buf(&sb, needle);
+		err =3D regcomp(&regex, sb.buf, cflags);
+		strbuf_release(&sb);
+		regexp =3D &regex;
 	} else {
 		kws =3D kwsalloc(DIFF_OPT_TST(o, PICKAXE_IGNORE_CASE)
 			       ? tolower_trans_tbl : NULL);
diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-a=
scii.sh
index 842b26a..4176625 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -61,4 +61,11 @@ test_expect_success REGEX_LOCALE 'grep string with r=
egex, with -F' '
 	test_cmp expect2 debug2
 '
=20
+test_expect_success REGEX_LOCALE 'pickaxe -i on non-ascii' '
+	git commit -m first &&
+	git log --format=3D%f -i -S"TILRAUN: HALL=C3=93 HEIMUR!" >actual &&
+	echo first >expected &&
+	test_cmp expected actual
+'
+
 test_done
--=20
2.7.0.377.g4cd97dd
