From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 10/10] diffcore-pickaxe: support case insensitive match on non-ascii
Date: Thu, 28 Jan 2016 18:56:23 +0700
Message-ID: <1453982183-24124-11-git-send-email-pclouds@gmail.com>
References: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 28 12:57:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOlCn-0007O1-Dt
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 12:57:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935242AbcA1L5a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jan 2016 06:57:30 -0500
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33181 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935237AbcA1L5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 06:57:25 -0500
Received: by mail-pa0-f65.google.com with SMTP id pv5so1894871pac.0
        for <git@vger.kernel.org>; Thu, 28 Jan 2016 03:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ba3sCxzJaTtmryHIhkxMlTeq9ajyE4zMy0iw5rpkCtw=;
        b=YwynhF1FsIsshFh0Qcpm2vKuoTjXhSH/5+tpdIns4+HgwwmgvmzCrmi5UPTlA12LBb
         xJvFlxpzYkZ3nxaURHUf7+mGix32uZORBVMgB/tkBzG8KDJZJThRqK7IcufmzjCDlssY
         j9LMdpUF/WqXRt88jq8eno0ktA7Qls6p/y5ehviJk1uXX8tuu6MbXLbxzPqzG2zFDQ35
         BsvFQriS8y8OIJonLqOiVuvQbzmcf6NBQcd9tVA3D/2QMJTcYHc7IvOix8XYf8IFwlNo
         uPONuZKZdm8YOG9/UowXDeZZcXGH5njwW8/olzVRP3WER+t99EuYWzK3voyQPBQLTsiK
         wmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=ba3sCxzJaTtmryHIhkxMlTeq9ajyE4zMy0iw5rpkCtw=;
        b=ishwTFoUDUlRz+x24CES3ulZLURbMiLd97uUJEjxGNZYVQ1WVBPg2IB6aAIuGDiw1x
         5zUwNMnnLcpdCfenUsjDRnQDb6Q2bMK8xVrpucvK6xkeg6PS748tqbmzEAozTcP9Gwuw
         qtK9vL4fYsncGH1LANRbQGm/Ahs+BnKg1ONicSSse+y2QfsuEh4qM6Fa3xlqePW+GSCU
         1nAQcxSlCrNDMs8fNFP/7bjh1iac1pyQCwuAHKhKuGcjKAZWlL1WAoDGP08+gzNLw7S9
         6BikcBjsjo3pM3KT5tFQNBFxJqwmCfZZayYLcUlQCYpTKR4s4ZBuVFh/03KZKF69zFFE
         PMHA==
X-Gm-Message-State: AG10YOSt1t285SvleaXbTxJ5LbG59wGNB7QhSm86nYEXAghYMt7MEvUqytrcdx9qEZoKqw==
X-Received: by 10.66.65.109 with SMTP id w13mr3784763pas.142.1453982245101;
        Thu, 28 Jan 2016 03:57:25 -0800 (PST)
Received: from lanh ([115.76.235.75])
        by smtp.gmail.com with ESMTPSA id 26sm15926019pfo.55.2016.01.28.03.57.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jan 2016 03:57:24 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 28 Jan 2016 18:57:30 +0700
X-Mailer: git-send-email 2.7.0.288.g1d8ad15
In-Reply-To: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285016>

Similar to the "grep -F -i" case, we can't use kws on icase search
outside ascii range, so we quote the string and pass it to regcomp as
a basic regexp and let regex engine deal with case sensitivity.

The new test is put in t7812 instead of t4209-log-pickaxe because
lib-gettext.sh might cause problems elsewhere, probably..

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
index 8896410..a5475bb 100755
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
2.7.0.288.g1d8ad15
