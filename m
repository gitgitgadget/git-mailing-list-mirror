From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 52/94] builtin/apply: read_patch_file() return -1 instead of die()ing
Date: Wed, 11 May 2016 15:17:03 +0200
Message-ID: <20160511131745.2914-53-chriscool@tuxfamily.org>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:23:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U6l-0006wl-80
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:23:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbcEKNXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:23:18 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36318 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932265AbcEKNUO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:20:14 -0400
Received: by mail-wm0-f67.google.com with SMTP id w143so9351127wmw.3
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VZwefoQH5GtriJjOQ3SyVzgYZJezNhtmOn1Vum8vJQw=;
        b=xklpFk/QyprwFZoeqBL580N50aHh+hYYmAALcO+uHDc2ullTNoJgFoUW32LWbjSRZ1
         cnZrMdNmyqUMm8liP1Do4x3GWSflXaGq7S8ue7rTrt8BGZRZzIwZ7FsVTnEcGf5vBVTG
         I8aRpzwWVy+TNMACkKBiwhozrnQLxcuhviZeGPuwh+1bM8/AUgmTSP6APZ6k3XQFubXS
         D8XnvOibGuFjWE+a56luUg93okjKidx9UnAoRv46fiW7A0oILQ++5erJ6snbj3KzFYVa
         tuWwthpF1XGAhli56uT+peRJpKC/ZvabMt5PcrYTp7HGw3wpfCJzzicZCGUMKICcwKg8
         BbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VZwefoQH5GtriJjOQ3SyVzgYZJezNhtmOn1Vum8vJQw=;
        b=lAIBpoMIedwxNIop+l1TLgSijCrEbRW7ONFO0hb6sQHxxTrWO5gtcZQvjt0eK+YuKg
         D7vJwFGvde7iZJ0vUTkbP5YomFMVNbQpRa5cYeWlmRtBIiTUKKg06Q+xpllDozCIb/NA
         toNcDCYyToBQu4DdSi+crgeAmfvdPk+sow5Uek4X4pLOWaOSkefl7FvwykRQziOW7oPG
         n62taRQ9dmbVRVddqfdVqepq7yTOZSEKdgaV0fRjvrNaAEM90t8SXL2UlaRtfU4iUI8J
         t4tSCQfMhafEzE13u9yeBoMqt15/307BU9LJDq0O3swsZ3KrPvvOW9AcyikDA+G07PL5
         af3g==
X-Gm-Message-State: AOPr4FW6rf9blPxyyuqh0wqSTH8pSRj2M63D1ciD0X7zt+lBzl1Dx8t+OtfXbKwo74zCXQ==
X-Received: by 10.28.130.16 with SMTP id e16mr4368392wmd.30.1462972813386;
        Wed, 11 May 2016 06:20:13 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.20.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:20:12 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294322>

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing. Let's do that by using error() instead
of die()ing in read_patch_file().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index d95630c..a166d70 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -445,10 +445,10 @@ static void say_patch_name(FILE *output, const char *fmt, struct patch *patch)
 
 #define SLOP (16)
 
-static void read_patch_file(struct strbuf *sb, int fd)
+static int read_patch_file(struct strbuf *sb, int fd)
 {
 	if (strbuf_read(sb, fd, 0) < 0)
-		die_errno("git apply: failed to read");
+		return error("git apply: failed to read: %s", strerror(errno));
 
 	/*
 	 * Make sure that we have some slop in the buffer
@@ -457,6 +457,7 @@ static void read_patch_file(struct strbuf *sb, int fd)
 	 */
 	strbuf_grow(sb, SLOP);
 	memset(sb->buf + sb->len, 0, SLOP);
+	return 0;
 }
 
 static unsigned long linelen(const char *buffer, unsigned long size)
@@ -4532,7 +4533,8 @@ static int apply_patch(struct apply_state *state,
 	int res = 0;
 
 	state->patch_input_file = filename;
-	read_patch_file(&buf, fd);
+	if (read_patch_file(&buf, fd))
+		return -1;
 	offset = 0;
 	while (offset < buf.len) {
 		struct patch *patch;
-- 
2.8.2.490.g3dabe57
