From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 03/40] builtin/apply: read_patch_file() return -1 instead of die()ing
Date: Mon, 13 Jun 2016 18:09:05 +0200
Message-ID: <20160613160942.1806-4-chriscool@tuxfamily.org>
References: <20160613160942.1806-1-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Mon Jun 13 18:11:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCUSx-0004no-He
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 18:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424810AbcFMQKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 12:10:07 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34902 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424605AbcFMQKC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 12:10:02 -0400
Received: by mail-wm0-f67.google.com with SMTP id k184so16025567wme.2
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 09:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C8l0c6kb+Be5NHGMlOPfJldG4dZvuB95E1xNRL4xnWU=;
        b=hiWH5tNOWn4no6SN70Lq7/P1qC8j9U8ifyqIooiuoQIhkBJDswwSM8W8sziSy1rwPP
         pjN49fDIFuo9nnXiYbzacjO9/7zavDUnRMfu6JuPeYAVKzClWZqbyB510Mmh8tMVKqyx
         yieRraZGxfmSgEwlfNnxczS49cil9hzp1kwy/7XUEN20EhG6I2dMGa1axvo1iIzkfEly
         jA4QyyjXwXPkpAEz+tt5ZMq6xPhPQOd06ngb9PMolrulpdagWygCYXN3VzFqzlduARVl
         /0tP9rcNcb2s8dd+k1/sfFnN6p6Y93KrrxL/5z1oULdHrXeNJ1wBouvhSb7mSmQQQusM
         PFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C8l0c6kb+Be5NHGMlOPfJldG4dZvuB95E1xNRL4xnWU=;
        b=OsyQzTWoPvxTH+AL/T17UsduZ9H3zUkb78/0xgkC6p9/VuRVXvWlNTO5JPGASix+gP
         KNLl3m1LQp2sdXemu1D1sD0oOd4thjIVp4Nub96cIo9gE/4ERqg/Vb8vRJFMBBP12Wo3
         XK9z1pQWVDWrsy3IqW1IVX43LI4Oan9Z7W2DEXz+UcPQ4K7pnXxPzF+Nvw94yaPXf/8Z
         Fkegn9z3uvohn19l0vm/c3U5WeRb5znFI3tArbZI/UdDdW3QBtWr+WkLZ3gOk0aQmp6P
         TgNgZbXAlM8v9/pOM5hpD7Xhc73RXL2GgZR1yyzYZ89U/5skPC4JDFaOWxnwjFl7k0FP
         ygrA==
X-Gm-Message-State: ALyK8tLeDPp5iKFLeb0eelGGW7q10smoidnOkoSTlHR6mBZPqr7DJRDBMSctvMWjPJprFA==
X-Received: by 10.194.242.163 with SMTP id wr3mr1876739wjc.1.1465834201161;
        Mon, 13 Jun 2016 09:10:01 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id g10sm6445369wjl.25.2016.06.13.09.09.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 09:10:00 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.411.gcd7457d
In-Reply-To: <20160613160942.1806-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297225>

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing. Let's do that by returning -1 instead of
die()ing in read_patch_file().

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
2.9.0.rc2.411.g3e2ca28
