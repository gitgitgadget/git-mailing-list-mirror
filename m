From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 01/48] builtin/apply: avoid parameter shadowing 'p_value' global
Date: Wed,  9 Mar 2016 18:48:29 +0100
Message-ID: <1457545756-20616-2-git-send-email-chriscool@tuxfamily.org>
References: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 18:52:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiHF-0007PZ-7M
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:52:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753790AbcCIRwB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:52:01 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35117 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753764AbcCIRv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:51:59 -0500
Received: by mail-wm0-f47.google.com with SMTP id l68so190181518wml.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ud4KHpZxoZHcV427Q47FwUB6WSaASskQ9MipH/vrwvo=;
        b=vCA9e04vN1+uHGDreX8aW5AzlHjfawM2R2Cs566FCJATcM071X0/7U4XQCpB/GVZ7Q
         p7fxARh5Ig+gvdbf0kezbav6tJYsr9hNd0lWUsPtsDJ2l39BYBfhBlyj+Xvz10yG7mX/
         et/INSPVA0+fiynVPznjK1rvu7a7V1HSS3dYfcKZpNF8+3h1O6I0xnToDE95oVadNUv8
         pwigt2JqcGqGg6BbS/1lDSoKDwMy6F4raPQx/DerGJKKlrNYM88LdaRdEdxqIJXzSPdj
         sd/rM/IUS24gKeNjRrJ+i54z3J4Y+GU5tI7vffBl+2W3ibjgkPhJONDfXqt5a2sXRHha
         9Kog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ud4KHpZxoZHcV427Q47FwUB6WSaASskQ9MipH/vrwvo=;
        b=cv8hCKO8S6qsuRfCx3NzxdtY5ZWLiF918Ikj07nnjkTDZ2pIKBetcyApNP1N8Yn3Pd
         5wetDXpQVKzCPoi23XxrE2mDthcj2kmRAxUf0rZHkTa9rQlL3pIlzLjGLK3YIF5SPo8s
         QYYf1WFyzUK0AgvTmRwiiYHdkmbv34alWrpM7AYnXIw86xdQUtzJ/r3xZzBdcJTVl3W5
         +g/USYZpeApp8IXOenCN9iYLp8UdknDMJhz0ZCqINf8dyV53yZseuarZFrxA0VlQarhz
         pRpggHp8WQrKq8wuR810ZaYFi8EQJdoFiG1T1VipCfXT2ix+ikZdWuYQ51N/BiQc5C3/
         d4rA==
X-Gm-Message-State: AD7BkJI7ymbL9p4Wo89SsXXtH19g4q+WuKa2kLYjggww3GCZ3UbLEO5w8DQKVo0c8qzZzg==
X-Received: by 10.194.83.101 with SMTP id p5mr36385879wjy.141.1457545918210;
        Wed, 09 Mar 2016 09:51:58 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.51.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:51:57 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288490>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 42c610e..7d9be63 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -469,7 +469,7 @@ static char *squash_slash(char *name)
 	return name;
 }
 
-static char *find_name_gnu(const char *line, const char *def, int p_value)
+static char *find_name_gnu(const char *line, const char *def, int p_v)
 {
 	struct strbuf name = STRBUF_INIT;
 	char *cp;
@@ -483,7 +483,7 @@ static char *find_name_gnu(const char *line, const char *def, int p_value)
 		return NULL;
 	}
 
-	for (cp = name.buf; p_value; p_value--) {
+	for (cp = name.buf; p_v; p_v--) {
 		cp = strchr(cp, '/');
 		if (!cp) {
 			strbuf_release(&name);
@@ -658,12 +658,12 @@ static size_t diff_timestamp_len(const char *line, size_t len)
 }
 
 static char *find_name_common(const char *line, const char *def,
-			      int p_value, const char *end, int terminate)
+			      int p_v, const char *end, int terminate)
 {
 	int len;
 	const char *start = NULL;
 
-	if (p_value == 0)
+	if (p_v == 0)
 		start = line;
 	while (line != end) {
 		char c = *line;
@@ -675,7 +675,7 @@ static char *find_name_common(const char *line, const char *def,
 				break;
 		}
 		line++;
-		if (c == '/' && !--p_value)
+		if (c == '/' && !--p_v)
 			start = line;
 	}
 	if (!start)
@@ -704,24 +704,24 @@ static char *find_name_common(const char *line, const char *def,
 	return squash_slash(xmemdupz(start, len));
 }
 
-static char *find_name(const char *line, char *def, int p_value, int terminate)
+static char *find_name(const char *line, char *def, int p_v, int terminate)
 {
 	if (*line == '"') {
-		char *name = find_name_gnu(line, def, p_value);
+		char *name = find_name_gnu(line, def, p_v);
 		if (name)
 			return name;
 	}
 
-	return find_name_common(line, def, p_value, NULL, terminate);
+	return find_name_common(line, def, p_v, NULL, terminate);
 }
 
-static char *find_name_traditional(const char *line, char *def, int p_value)
+static char *find_name_traditional(const char *line, char *def, int p_v)
 {
 	size_t len;
 	size_t date_len;
 
 	if (*line == '"') {
-		char *name = find_name_gnu(line, def, p_value);
+		char *name = find_name_gnu(line, def, p_v);
 		if (name)
 			return name;
 	}
@@ -729,10 +729,10 @@ static char *find_name_traditional(const char *line, char *def, int p_value)
 	len = strchrnul(line, '\n') - line;
 	date_len = diff_timestamp_len(line, len);
 	if (!date_len)
-		return find_name_common(line, def, p_value, NULL, TERM_TAB);
+		return find_name_common(line, def, p_v, NULL, TERM_TAB);
 	len -= date_len;
 
-	return find_name_common(line, def, p_value, line + len, 0);
+	return find_name_common(line, def, p_v, line + len, 0);
 }
 
 static int count_slashes(const char *cp)
-- 
2.8.0.rc1.49.gca61272
