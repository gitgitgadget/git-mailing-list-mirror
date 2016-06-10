From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 15/44] builtin/apply: make gitdiff_*() return 1 at end of header
Date: Fri, 10 Jun 2016 22:10:49 +0200
Message-ID: <20160610201118.13813-16-chriscool@tuxfamily.org>
References: <20160610201118.13813-1-chriscool@tuxfamily.org>
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
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:12:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSmt-0003KY-2U
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:12:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbcFJUME convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 16:12:04 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34222 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932288AbcFJUMB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:12:01 -0400
Received: by mail-wm0-f65.google.com with SMTP id n184so1055169wmn.1
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=adxZgeb4D6U+oAJBQs/0d4vdW6sUzm0U1bpiiCR6lhE=;
        b=KUGolyn85xLExnJemlKxyYuzuFuio06kiPWdGVxeilWZuSBdCPwAQLB6VjV4VKoeJ8
         MnskTZy0SO/oWr+WXYW3uxb2WMR3LkWTHj2N6ntpLk4r8WD9IMhbMd5l+fanUkl5YkSk
         hGeIgNiNN0Qj2rbodPQ2+Q+ACI5yMLGzAzB32EV9DxPLdS7Pn4AFSuwHtmEl16YXA/2G
         qsUnf3yrKQJ2t4JIuC+oBTlWm5rISEIGcgKJ7dakcZthm0HoH+jz3djOHBtsPCiBGQKY
         ySWpRbU49L9+Knrs7YkSMAd42NiWlNc41x68/qLulR7Xpj40znh6wMIHRvybRXN7Ianr
         agTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=adxZgeb4D6U+oAJBQs/0d4vdW6sUzm0U1bpiiCR6lhE=;
        b=LeFmsHJXNW2++3XCOEYV5Vs0IXkYPQ1ZXgFKO5dckgjZLnZNdC4ZgcOrGXtU7a3wrN
         dyWetTNat3dZBwBppTZ/SODRRBdX9868ceN/T0JySAWQ0rrlplqHxjFnBRbtVsbYx/eS
         sDxxYUxpvL0NUkCHSOizvkviRciPum4NzROz4KymQtdQqLGFS4xUH1qxa6VkWfQkkcmV
         znJoHYdottBwUkdbjxHuUwir/F4/4Ncl99UbueF8inNFfq7kPQSjvKDRF1YogmK02bCZ
         PjvZGiR5Pl1JWfQmRTCbJQyfg77+VMkd5De2Km6zQf+0jgnT7mUZWqPaOT1+cl3Y7gDt
         eSHQ==
X-Gm-Message-State: ALyK8tLCfFucpFK6wLzsgQKDdeqrf5fR/wRvWA6hA6Ted3RRgYlJfpO/wEYlwkXnr1s7yQ==
X-Received: by 10.28.11.143 with SMTP id 137mr606598wml.92.1465589520550;
        Fri, 10 Jun 2016 13:12:00 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.11.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:11:59 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297031>

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
2.9.0.rc2.362.g3cd93d0
