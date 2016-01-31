From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 07/12] ref-filter: introduce parse_align_position()
Date: Sun, 31 Jan 2016 23:12:51 +0530
Message-ID: <1454262176-6594-8-git-send-email-Karthik.188@gmail.com>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 31 18:43:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPw1q-000094-FC
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 18:43:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932918AbcAaRnD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 12:43:03 -0500
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33824 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932512AbcAaRmf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 12:42:35 -0500
Received: by mail-pa0-f65.google.com with SMTP id yy13so6116356pab.1
        for <git@vger.kernel.org>; Sun, 31 Jan 2016 09:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SqF6VoME0jK548zvKlTScJ5LxEmgbBWfyzTucEIY/bY=;
        b=0jdVPHyTQ5/Vemq/+/pYL0FApCKwPMepsVDXCPI0rV8TlC/MEzyw/X2y9StexWWqfR
         xKNlVTq+SLMKnOMs705fR4NwW45aXs3W5ro6dzwwjtmCo/6XbSbs5rkKgiaTP4gl5b8I
         shV4d1/WgbcQDVNoTGW58QXqcDWIno8h9beItbkFvUyrqM4lZo/quajlBhRoJ0lCaVxI
         i/lASXMDjA1vjPuS210biKW4AmOVZyG7633hhgKzfrKBbYbMobJIaQ/Vr1r3/z7Y7V6G
         7Yvb9ACHSIBMROppPdgo8K0xTkIB6AZ/L4zpNDNoywiJUGZziCH1ShR4n3NclzfLRsun
         vjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SqF6VoME0jK548zvKlTScJ5LxEmgbBWfyzTucEIY/bY=;
        b=WAtyhIvvRBKrHiE+I6BFK+e2YZejOwFqkxKNoBD572d7xv9rucSqEHtzF1Xtip4i0n
         wwsdukOCGK0rNlhwZQ4zC2o1tAYhG95x8axZVEHYZPDUU+Lnncf2sxceT/RWj+cA7qj1
         mVfFkhe1KXBUWRrMKICOJysMAeBqqpAHcH73XGXJkGPmRZcnR21kYsFe2AxyhZsOpeKm
         L+AsejWhhfx8nw/2h2b/e9K/9qtAETEjSiBrAdApS9jC6D1g/N7AYt+4q3EzSsCLSPnh
         g727fJCs5ypXNqdYV1uR81P23vsiafJrSqv5cSha/C8FyDDelwNj/T5gLGzAzrMTIM+K
         Hv1w==
X-Gm-Message-State: AG10YOROgyezN8eASQ1RVSZbcTmEonYg8lXBZSapmOFtpnhUra0CYWBbtrGBQsKkqjaydA==
X-Received: by 10.66.139.234 with SMTP id rb10mr31328145pab.82.1454262154550;
        Sun, 31 Jan 2016 09:42:34 -0800 (PST)
Received: from ashley.localdomain ([106.51.132.212])
        by smtp.gmail.com with ESMTPSA id v26sm37274012pfi.56.2016.01.31.09.42.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Jan 2016 09:42:34 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285163>

>From populate_value() extract parse_align_position() which given a
string would give us the alignment position. This is a preparatory
patch as to introduce prefixes for the %(align) atom and avoid
redundancy in the code.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 7adff67..e6b6b55 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -44,6 +44,17 @@ static void color_atom_parser(struct used_atom *atom, const char *color_value)
 		die(_("invalid color value: %s"), atom->u.color);
 }
 
+static align_type parse_align_position(const char *s)
+{
+	if (!strcmp(s, "right"))
+		return ALIGN_RIGHT;
+	else if (!strcmp(s, "middle"))
+		return ALIGN_MIDDLE;
+	else if (!strcmp(s, "left"))
+		return ALIGN_LEFT;
+	return -1;
+}
+
 static struct {
 	const char *name;
 	cmp_type cmp_type;
@@ -910,14 +921,12 @@ static void populate_value(struct ref_array_item *ref)
 			align->position = ALIGN_LEFT;
 
 			while (*s) {
+				int position;
+
 				if (!strtoul_ui(s[0]->buf, 10, (unsigned int *)&width))
 					;
-				else if (!strcmp(s[0]->buf, "left"))
-					align->position = ALIGN_LEFT;
-				else if (!strcmp(s[0]->buf, "right"))
-					align->position = ALIGN_RIGHT;
-				else if (!strcmp(s[0]->buf, "middle"))
-					align->position = ALIGN_MIDDLE;
+				else if ((position = parse_align_position(s[0]->buf)) >= 0)
+					align->position = position;
 				else
 					die(_("improper format entered align:%s"), s[0]->buf);
 				s++;
-- 
2.7.0
