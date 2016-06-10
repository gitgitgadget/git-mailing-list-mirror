From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 03/44] builtin/apply: read_patch_file() return -1 instead of die()ing
Date: Fri, 10 Jun 2016 22:10:37 +0200
Message-ID: <20160610201118.13813-4-chriscool@tuxfamily.org>
References: <20160610201118.13813-1-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Fri Jun 10 22:13:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSoS-0004b4-6W
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:13:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932744AbcFJUNs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:13:48 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33198 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752762AbcFJULp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:11:45 -0400
Received: by mail-wm0-f67.google.com with SMTP id r5so1066919wmr.0
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=500AgcoKpqC8ob4gL/i8OWbK+AJzX7DQm9yKqCPSqy8=;
        b=RgjSHBAHcy/s4OTwg9A1iYCMdQU1NTMsz5AwL/v42214AWBp7QtOq1r4rtXvS3TYDh
         6PbGrOLul3l3ylQSh6yWxrxtsSNux3f3xh8g4pVzNTIIAdR+z6XLcTl0BDrTp7gcSucn
         PXl9IlRYYD4fIWszrjx4eCAA0+7QsLtkif/6zS+TOiWE9penY1zpq8E/TJsCz42N54NS
         7JrGNFc9j3iuHsvdPJuOKbLy6tV8VGV9fzT3lp4VcWlXu5gOMHu2PTe4VmbxxXK1UONn
         iR4vkBoc47R+mX4b+nqSjGYVKCCP/qxZveGNac/56deTzXCkx8YXZ/kF3+lBKAV82fIN
         p4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=500AgcoKpqC8ob4gL/i8OWbK+AJzX7DQm9yKqCPSqy8=;
        b=O1XKG9mwt6DwV2Q5FAmWl4TB4hgQL0idXsER/jUoOtrXjRz6oHUpPclFhCK8/nop/Z
         qy8PFPvK2FlJQ/GwciTwfvhkCMQtrkT3QMN5HfmEiOZt2rSVJvwjp8h3gSFwWxUhDPOs
         6Yn58evDt6sGxwyfs8QN1zp5Yuw7ekT2a3LidOyftN42Yu0fDKyKfxIm4FUrHldlkSFj
         mkame5ASLVCiKQIWe5x0mwBl31xTzed5c6K649ah8Itq89rw8haTIXxuG6TnYjI0DS2v
         0KHgmwnyBN83uByJG8i97LJsJS1qTE255ruuZwJ3RyLu58bRwYexmUf21Lh+aklDEKbu
         OZTg==
X-Gm-Message-State: ALyK8tIEgpIt5pmKm5MvTPbu2bx7IKJp7tuLbdVCWgH3KXoHmaEnUWpglVwZmwc/Av9JDg==
X-Received: by 10.28.1.151 with SMTP id 145mr593636wmb.25.1465589503824;
        Fri, 10 Jun 2016 13:11:43 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.11.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:11:43 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297064>

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing. Let's do that by returning -1 instead of
die()ing in read_patch_file().

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 598e479..2ff8450 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -335,10 +335,10 @@ static void say_patch_name(FILE *output, const char *fmt, struct patch *patch)
 
 #define SLOP (16)
 
-static void read_patch_file(struct strbuf *sb, int fd)
+static int read_patch_file(struct strbuf *sb, int fd)
 {
 	if (strbuf_read(sb, fd, 0) < 0)
-		die_errno("git apply: failed to read");
+		return error_errno("git apply: failed to read");
 
 	/*
 	 * Make sure that we have some slop in the buffer
@@ -347,6 +347,7 @@ static void read_patch_file(struct strbuf *sb, int fd)
 	 */
 	strbuf_grow(sb, SLOP);
 	memset(sb->buf + sb->len, 0, SLOP);
+	return 0;
 }
 
 static unsigned long linelen(const char *buffer, unsigned long size)
@@ -4424,7 +4425,8 @@ static int apply_patch(struct apply_state *state,
 	int res = 0;
 
 	state->patch_input_file = filename;
-	read_patch_file(&buf, fd);
+	if (read_patch_file(&buf, fd))
+		return -1;
 	offset = 0;
 	while (offset < buf.len) {
 		struct patch *patch;
-- 
2.9.0.rc2.362.g3cd93d0
