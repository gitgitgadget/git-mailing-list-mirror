From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 15/40] builtin/apply: make gitdiff_*() return 1 at end of header
Date: Mon, 13 Jun 2016 18:09:17 +0200
Message-ID: <20160613160942.1806-16-chriscool@tuxfamily.org>
References: <20160613160942.1806-1-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 18:11:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCUSr-0004h1-BJ
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 18:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424981AbcFMQLn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jun 2016 12:11:43 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35083 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424895AbcFMQKS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 12:10:18 -0400
Received: by mail-wm0-f65.google.com with SMTP id k184so16027218wme.2
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 09:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PDKOVifoxdIp1fV3NkocflY0l+9lsDq0SQ8uCn2Bf2M=;
        b=GcndPWDsyg34a46MPqVTxYOrzCnY/W/CQNA1KMjyHT5RoT6SHXhd2cmuVZQEhiRjyn
         S2JhZk8bUiQoEZrd1rqUbjWEWA065QIgx9kiOVltWDvNV6ykQu18/Ro1qZgbclTTijUH
         ACEVKHnaOoIrUO2sm9yTy4XYzduusTFNc4o9PU5ZE9bQ1vwGtu7iAvBaRN94PE0eElnJ
         7ztgAKC798hlYYrWFuPu/DoGXm+F7BX1HbnK6FUTdeZ1JeLxcOlEJo64NBfrQqRS87gs
         0Z1nWcFlBi45Ew3Ud7H90/QdgNsj2gPGHjb+71Md40TC9mWxAOVMDeKj4n6+5N0uFKa6
         6V0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PDKOVifoxdIp1fV3NkocflY0l+9lsDq0SQ8uCn2Bf2M=;
        b=DKPbh49v9u/j05uL4cxyAarWWz/3UsWEE0l9g3HZKBw+6CquUpl6gTU6adDlV0HEVE
         W5r7NbY+b5/jrEjDNP6vn6TTQnoHHChbwcP/z/rY4HB/rp/W5Xk4rqkVJY1mPFHwb47W
         ucuVDbfgmez8iX5eSAV4uOxJU8pPOI4lxkdsa5KQ2qd51kuW0BG8I4EHhJKrfkqXWmYK
         unkL71JSNdfqsUU1QQ/0M5Owx5U99GJQ/WyFgRMRzDvZM9uODOFJZCyDHQjSSNZmWep7
         7yNqcUzbIUcJ5IcMghdVWSuGq7qtVPYSakQWKOvWF/iyl+i8kuJFUI+vL2/PaXvNDXn1
         oOUQ==
X-Gm-Message-State: ALyK8tK6X01/ie6GSkE2bFvsCMQdmpofHVX9G6wfVxPlIpLC12vhVyT4p3/T8TDBJJZyhg==
X-Received: by 10.28.145.203 with SMTP id t194mr2034227wmd.88.1465834217448;
        Mon, 13 Jun 2016 09:10:17 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id g10sm6445369wjl.25.2016.06.13.09.10.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 09:10:16 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.411.gcd7457d
In-Reply-To: <20160613160942.1806-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297224>

The gitdiff_*() functions that are called as p->fn() in parse_git_heade=
r()
should return 1 instead of -1 in case of end of header or unrecognized
input, as these are not real errors. It just instructs the parser to br=
eak
out.

This makes it possible for gitdiff_*() functions to return -1 in case o=
f a
real error. This will be done in a following patch.

Helped-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index eb98116..1142514 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -812,7 +812,7 @@ static int gitdiff_hdrend(struct apply_state *state=
,
 			  const char *line,
 			  struct patch *patch)
 {
-	return -1;
+	return 1;
 }
=20
 /*
@@ -1016,7 +1016,7 @@ static int gitdiff_unrecognized(struct apply_stat=
e *state,
 				const char *line,
 				struct patch *patch)
 {
-	return -1;
+	return 1;
 }
=20
 /*
@@ -1248,9 +1248,13 @@ static int parse_git_header(struct apply_state *=
state,
 		for (i =3D 0; i < ARRAY_SIZE(optable); i++) {
 			const struct opentry *p =3D optable + i;
 			int oplen =3D strlen(p->str);
+			int res;
 			if (len < oplen || memcmp(p->str, line, oplen))
 				continue;
-			if (p->fn(state, line + oplen, patch) < 0)
+			res =3D p->fn(state, line + oplen, patch);
+			if (res < 0)
+				return -1;
+			if (res > 0)
 				return offset;
 			break;
 		}
@@ -1429,6 +1433,8 @@ static int find_header(struct apply_state *state,
 		 */
 		if (!memcmp("diff --git ", line, 11)) {
 			int git_hdr_len =3D parse_git_header(state, line, len, size, patch)=
;
+			if (git_hdr_len < 0)
+				return -1;
 			if (git_hdr_len <=3D len)
 				continue;
 			if (!patch->old_name && !patch->new_name) {
--=20
2.9.0.rc2.411.g3e2ca28
