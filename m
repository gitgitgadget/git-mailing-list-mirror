From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 52/83] builtin/apply: read_patch_file() return -1 instead of die()ing
Date: Sun, 24 Apr 2016 15:33:52 +0200
Message-ID: <1461504863-15946-53-git-send-email-chriscool@tuxfamily.org>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 15:36:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKCu-0008Jg-W1
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:36:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937AbcDXNgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:36:08 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36636 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752889AbcDXNgA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:36:00 -0400
Received: by mail-wm0-f42.google.com with SMTP id v188so69571941wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fqtCRw7gFgTiuqeHallhZQePUK5zGsotNMZXenMgQVs=;
        b=dQZducYt8sZQu4/uoPNWh9fqmMRoOIMxsHfvZ1ED0TgxMXDViY5T/GGYkmSVls55vE
         R6c/hoG27AE74qDxU7ad1aqWklWm7H2/xXGwQQyNLcQP8ggXsWjNx7wJZB01RoRFWf83
         Z0Ob9uuL/49od34Y4ThME49NbHNy641t9dqTajwMjVyPeRLelOhrOXGs3/0Aw7tNi4F6
         nlQ6mrCbVDh1XIoABrUxYRyAWfmJIrndHtRtGy0ov5yayPDDsOZWFzjRB5354VbMcMjn
         NkBT1y1cggVjQXTbBkJoZ/fFRWvJehrbsu8TQpZvMrit0TYCf6r2OEEkH92jOrKt8c36
         /YZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fqtCRw7gFgTiuqeHallhZQePUK5zGsotNMZXenMgQVs=;
        b=h/Ci9guHboazR8PMQBeqR0QexAjekp/u3SfG97DyAPRi1rLiUErAl2uoeKs3JMPrYG
         5BUkVIFm8JtHY3V1d2mOqS4jFyLjCkwFAoD8Zk4nAI/GwWupUY3H6fGrNWVImoFe8gk8
         0PEdA6qAnIuYGOLs4YX/PtuCAlJ+1UXWI1z2uwAiyI87mOc1rDE9uvZjTp60otS/CPt4
         czb9tsQVeYdK5MY4MvzkZSUv+DbTWI3AmJ1nJhBb30ll1hJWzZjmjczWziUatTuGx3dc
         bSHsRpddS7Bw2rlNLfj5eTNtgQ8Mz0u0Hk8uvXTQ5w56iIMXjsPs3ynAMgBmJE4qOL4P
         UbSw==
X-Gm-Message-State: AOPr4FVeAIwIENA3BizL/oFkTGMjWtZUYtUCpqm0MEidNv4xTCCrDZsUrwzp+LYD5IEQpw==
X-Received: by 10.194.187.236 with SMTP id fv12mr29818307wjc.96.1461504959164;
        Sun, 24 Apr 2016 06:35:59 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.35.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:35:58 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292352>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index bc209f5..c0bb24c 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -454,10 +454,10 @@ static void say_patch_name(FILE *output, const char *fmt, struct patch *patch)
 
 #define SLOP (16)
 
-static void read_patch_file(struct strbuf *sb, int fd)
+static int read_patch_file(struct strbuf *sb, int fd)
 {
 	if (strbuf_read(sb, fd, 0) < 0)
-		die_errno("git apply: failed to read");
+		return error("git apply: failed to read: %s", strerror(errno));
 
 	/*
 	 * Make sure that we have some slop in the buffer
@@ -466,6 +466,7 @@ static void read_patch_file(struct strbuf *sb, int fd)
 	 */
 	strbuf_grow(sb, SLOP);
 	memset(sb->buf + sb->len, 0, SLOP);
+	return 0;
 }
 
 static unsigned long linelen(const char *buffer, unsigned long size)
@@ -4541,7 +4542,8 @@ static int apply_patch(struct apply_state *state,
 	int skipped_patch = 0;
 
 	state->patch_input_file = filename;
-	read_patch_file(&buf, fd);
+	if (read_patch_file(&buf, fd))
+		return -1;
 	offset = 0;
 	while (offset < buf.len) {
 		struct patch *patch;
-- 
2.8.1.300.g5fed0c0
