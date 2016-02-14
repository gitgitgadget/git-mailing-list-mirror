From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 11/12] diffcore-pickaxe: support case insensitive match on non-ascii
Date: Sun, 14 Feb 2016 18:49:55 +0700
Message-ID: <1455450596-11904-12-git-send-email-pclouds@gmail.com>
References: <1454724190-14063-1-git-send-email-pclouds@gmail.com>
 <1455450596-11904-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 14 12:52:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUvDw-0001ex-M4
	for gcvg-git-2@plane.gmane.org; Sun, 14 Feb 2016 12:52:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751960AbcBNLwR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Feb 2016 06:52:17 -0500
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35779 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543AbcBNLwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2016 06:52:16 -0500
Received: by mail-pa0-f66.google.com with SMTP id fl4so5964971pad.2
        for <git@vger.kernel.org>; Sun, 14 Feb 2016 03:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=F+oFWcbXegoB1To+BxHC8KQgCw+Z1a0uo4FPSNJaZ50=;
        b=dymicedgd9X9Lwn9BpBRxrPXsdsbZMhnRThQ2FzbsYcSC8TT1wYTBx7zxN8U2GIVvG
         PFsRZX1BCugP+o0xnpZwvqNxRKMHnNNPd1ewPYrWGtP9SmHNMAdLRVgccmg93kReT200
         c1NgcLrs9xDWNUECKp11Yp7Mi6Qth3QyA9lzyNEi8bqAEKhVu2gXWJExaUubhNnQqBCo
         rL0yi4/Hqph81CMU3RUOrVLJj/lwfk07iLm//cFQFhwzXvHRFR/d8ZpKDSPMYmAiTaiu
         0Qp490lZJjjxQwwvKYdCkpqK3fzl+P5y6BZVwJFD0XbLekD+XR8boHFe0nDEhtCthdTh
         MKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=F+oFWcbXegoB1To+BxHC8KQgCw+Z1a0uo4FPSNJaZ50=;
        b=CH0bJYChF0nYUQMzrhtRmdo/4u5DXbmpb6ggY63422RFEe5IfqhHxIf+cTWIolDWqI
         O6iHypQJXwWBK9J1py3tc40JpfeeIqxtVAKUk7UdEtlVtt+ybb+riXhyWZL5Saz/POIs
         WaKDYrfXwdgBP1/RqNKybd3Yry5ZntfuK57DLqVsTJFwR59Awxbv8DD2n6hDC3vJ5KXi
         STwsrBzqMHvlJdBXsIQ55/iXzOVag1rusCKFixL1dLMMDTSKjJIfuNh0DVB+iTcqbgd1
         MZmmsN51V9pEQOAHcK6F6PsFBeMHwBKZAyOIpep09AWux4+/FmN90SZjqWnBASrJZjyy
         WT6Q==
X-Gm-Message-State: AG10YOTWK9MqvNdY4aJUmddzV5MUZyA52dvhYTM3vgdtAs+PKOcZjF+atcuCMx6anYxuNg==
X-Received: by 10.67.1.237 with SMTP id bj13mr15955590pad.130.1455450735721;
        Sun, 14 Feb 2016 03:52:15 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id to9sm31363922pab.3.2016.02.14.03.52.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Feb 2016 03:52:14 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Feb 2016 18:52:36 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455450596-11904-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286146>

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
