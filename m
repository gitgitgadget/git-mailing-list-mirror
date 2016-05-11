From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 65/94] builtin/apply: make gitdiff_*() return 1 at end of header
Date: Wed, 11 May 2016 15:17:16 +0200
Message-ID: <20160511131745.2914-66-chriscool@tuxfamily.org>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 15:22:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U6C-00069s-RW
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183AbcEKNUs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 May 2016 09:20:48 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34727 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932310AbcEKNUm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:20:42 -0400
Received: by mail-wm0-f67.google.com with SMTP id n129so9420827wmn.1
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xVuFvEq7RF44utme1AKOJNJrN0/EcQ8ha0AASyCP4UU=;
        b=zm2bd6Z4chMhLqmiGOzWQt8Af2LT7ycaCTugeuV7fPWcEof4T6mFZLzbdwRahAUP+o
         3GVYft+CDsZ+VC0AV/t3BlQkIlmIMI6Oqmv4ktlanuNC7dDs6nPqDQ5sTxRCMSqddprG
         IhmkUi769IW2pXUmWWjwOLGxOON4ikHAQz+jS+pOIfiQ9djxMdjgAD4GlrGZa5ekzdqh
         yikFXUBqaaN+NIiuYxeipuqI5/hUNuEdrB5+SPsJJloH/Ph9e2j6i5BpLRAbzAtsX73g
         9ZoW+6N2Sodj/T4Co+esZgic/Q6eSAXv6L6z4chuuihpeeqQbAgruRlFeMG0iXW8xgs7
         QYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xVuFvEq7RF44utme1AKOJNJrN0/EcQ8ha0AASyCP4UU=;
        b=FvYAFklxvFyZXVYXcY2io+v3PX/+dPVbqmXWktS/LMlYSSLfNG/MYoop+luHWlVGT1
         Qa+v2KTJyWADUx3lE3CWWpl7q4y5tO9Efq3wMOYYeWzYgdZ7n6NySpBKqBNO+1hk7Pws
         2s1FONCYCQKWBbBPprtx9FhU53Wbw3JsnOPOHJkJTIC4EQmKyvDcXmlp+g/a7aPoI58u
         Qdap/rMupmzxnLqHY7tREvMjzMR5p5ldnuTHC+M5d+oRBxvxwfXYP6KGS99rJ6ThfeWY
         cUAuHFFIWMjkMQ0MBC3eydkDLo/VHOsmjXQ+rBLB15voAStLdqmxGo6ZsUVQhDDMQyur
         TB7A==
X-Gm-Message-State: AOPr4FXipDdVCQCJZpoL163TMTkAb9eC/D5OCNparoLcWlDat/tkr1n6T0350LGrlcPm1Q==
X-Received: by 10.194.38.67 with SMTP id e3mr3780539wjk.127.1462972841112;
        Wed, 11 May 2016 06:20:41 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.20.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:20:40 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294317>

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
index 8e82eea..b3a9c2e 100644
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
2.8.2.490.g3dabe57
