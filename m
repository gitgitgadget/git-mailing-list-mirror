Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3013B2098B
	for <e@80x24.org>; Sun, 16 Oct 2016 23:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757201AbcJPXVl (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Oct 2016 19:21:41 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34757 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757178AbcJPXVk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2016 19:21:40 -0400
Received: by mail-pf0-f196.google.com with SMTP id 128so11519479pfz.1
        for <git@vger.kernel.org>; Sun, 16 Oct 2016 16:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LwponuzJWQXr+8UBlCEN28rQh9gIyBQCYXwU3e4yQvk=;
        b=VA1nC4k4GF04v39IRVT39Oc+ObGPoineGtUapmPZme534x/RPTCsIoQgLzRdNkID15
         yei3fOgIN2Jtl5aNufUOJopmmtLFl4jhh/mymOBrL7lKr6yhN/4mRbF9qe8d5JM34p0x
         JI1hZTcp72BcV/C7W9c/f+e9Ikg3J8bwynJ6OXdvhlHS2quYdmG12Zbd7swPIY4+E4TU
         SPlxm9K9nsCZphxn5MJL2037tginrJEWuTN7CQHvJKJwUEJ0ARdxEhlVakJSv7VGeo0e
         fFbvL6nvxcdHQgXzOARcMOSKW1qlFvOp0zRp9qY6eeuaaaNKKpBHWk8SnU10FWyiH8l4
         cdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LwponuzJWQXr+8UBlCEN28rQh9gIyBQCYXwU3e4yQvk=;
        b=RSfpZImHMiNgIzsm0ufub0uLwGRQGxwQZhH1RvoKYe8/r74SJIdS455F/WJe+NIePm
         xfyqBpoO6JfNPVZv6XAphjoEZlczH0HuBmsZl43qJ4zi49uddAP7kGYZHegpFQjdQQW7
         pnkOV4JLcybUTYKH8LZWVtu1tpcVG4wDJiIWyXWxqA63ovw0GwKaQwBmpkCCGZFxvGmm
         r9JxYB0i6Zw3aMhoj7azzt0cMk3MirMTKZJoLauec8p2Bu0BCB7rdECH4xOdpiU6hItR
         oVa+a0XYyVjZ5oyQ1hWDbZhC4FbSsBp5M18eg5lckEvkCKf5UmuNtayxYTJdlVFSUXay
         EUNw==
X-Gm-Message-State: AA6/9RkpqM5Vc1O9/Ij8twir1ALta5vyri+wxGRc393ECb560X5Fm687uEMSwYvnljiSuQ==
X-Received: by 10.98.85.135 with SMTP id j129mr12740775pfb.28.1476660099741;
        Sun, 16 Oct 2016 16:21:39 -0700 (PDT)
Received: from rem3n8pj12.ads.autodesk.com (adsk-nat-ip4.autodesk.com. [132.188.71.4])
        by smtp.gmail.com with ESMTPSA id cp2sm10325691pad.3.2016.10.16.16.21.33
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 16 Oct 2016 16:21:36 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jnareb@gmail.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, tboegi@web.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v11 12/14] convert: prepare filter.<driver>.process option
Date:   Sun, 16 Oct 2016 16:20:36 -0700
Message-Id: <20161016232038.84951-13-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161016232038.84951-1-larsxschneider@gmail.com>
References: <20161016232038.84951-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Refactor the existing 'single shot filter mechanism' and prepare the
new 'long running filter mechanism'.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 convert.c | 60 ++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/convert.c b/convert.c
index 597f561..71e11ff 100644
--- a/convert.c
+++ b/convert.c
@@ -442,7 +442,7 @@ static int filter_buffer_or_fd(int in, int out, void *data)
 	return (write_err || status);
 }
 
-static int apply_filter(const char *path, const char *src, size_t len, int fd,
+static int apply_single_file_filter(const char *path, const char *src, size_t len, int fd,
                         struct strbuf *dst, const char *cmd)
 {
 	/*
@@ -456,12 +456,6 @@ static int apply_filter(const char *path, const char *src, size_t len, int fd,
 	struct async async;
 	struct filter_params params;
 
-	if (!cmd || !*cmd)
-		return 0;
-
-	if (!dst)
-		return 1;
-
 	memset(&async, 0, sizeof(async));
 	async.proc = filter_buffer_or_fd;
 	async.data = &params;
@@ -493,6 +487,9 @@ static int apply_filter(const char *path, const char *src, size_t len, int fd,
 	return !err;
 }
 
+#define CAP_CLEAN    (1u<<0)
+#define CAP_SMUDGE   (1u<<1)
+
 static struct convert_driver {
 	const char *name;
 	struct convert_driver *next;
@@ -501,6 +498,29 @@ static struct convert_driver {
 	int required;
 } *user_convert, **user_convert_tail;
 
+static int apply_filter(const char *path, const char *src, size_t len,
+			int fd, struct strbuf *dst, struct convert_driver *drv,
+			const unsigned int wanted_capability)
+{
+	const char *cmd = NULL;
+
+	if (!drv)
+		return 0;
+
+	if (!dst)
+		return 1;
+
+	if ((CAP_CLEAN & wanted_capability) && drv->clean)
+		cmd = drv->clean;
+	else if ((CAP_SMUDGE & wanted_capability) && drv->smudge)
+		cmd = drv->smudge;
+
+	if (cmd && *cmd)
+		return apply_single_file_filter(path, src, len, fd, dst, cmd);
+
+	return 0;
+}
+
 static int read_convert_config(const char *var, const char *value, void *cb)
 {
 	const char *key, *name;
@@ -839,7 +859,7 @@ int would_convert_to_git_filter_fd(const char *path)
 	if (!ca.drv->required)
 		return 0;
 
-	return apply_filter(path, NULL, 0, -1, NULL, ca.drv->clean);
+	return apply_filter(path, NULL, 0, -1, NULL, ca.drv, CAP_CLEAN);
 }
 
 const char *get_convert_attr_ascii(const char *path)
@@ -872,18 +892,12 @@ int convert_to_git(const char *path, const char *src, size_t len,
                    struct strbuf *dst, enum safe_crlf checksafe)
 {
 	int ret = 0;
-	const char *filter = NULL;
-	int required = 0;
 	struct conv_attrs ca;
 
 	convert_attrs(&ca, path);
-	if (ca.drv) {
-		filter = ca.drv->clean;
-		required = ca.drv->required;
-	}
 
-	ret |= apply_filter(path, src, len, -1, dst, filter);
-	if (!ret && required)
+	ret |= apply_filter(path, src, len, -1, dst, ca.drv, CAP_CLEAN);
+	if (!ret && ca.drv && ca.drv->required)
 		die("%s: clean filter '%s' failed", path, ca.drv->name);
 
 	if (ret && dst) {
@@ -907,7 +921,7 @@ void convert_to_git_filter_fd(const char *path, int fd, struct strbuf *dst,
 	assert(ca.drv);
 	assert(ca.drv->clean);
 
-	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv->clean))
+	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv, CAP_CLEAN))
 		die("%s: clean filter '%s' failed", path, ca.drv->name);
 
 	crlf_to_git(path, dst->buf, dst->len, dst, ca.crlf_action, checksafe);
@@ -919,15 +933,9 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 					    int normalizing)
 {
 	int ret = 0, ret_filter = 0;
-	const char *filter = NULL;
-	int required = 0;
 	struct conv_attrs ca;
 
 	convert_attrs(&ca, path);
-	if (ca.drv) {
-		filter = ca.drv->smudge;
-		required = ca.drv->required;
-	}
 
 	ret |= ident_to_worktree(path, src, len, dst, ca.ident);
 	if (ret) {
@@ -938,7 +946,7 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 	 * CRLF conversion can be skipped if normalizing, unless there
 	 * is a smudge filter.  The filter might expect CRLFs.
 	 */
-	if (filter || !normalizing) {
+	if ((ca.drv && ca.drv->smudge) || !normalizing) {
 		ret |= crlf_to_worktree(path, src, len, dst, ca.crlf_action);
 		if (ret) {
 			src = dst->buf;
@@ -946,8 +954,8 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 		}
 	}
 
-	ret_filter = apply_filter(path, src, len, -1, dst, filter);
-	if (!ret_filter && required)
+	ret_filter = apply_filter(path, src, len, -1, dst, ca.drv, CAP_SMUDGE);
+	if (!ret_filter && ca.drv && ca.drv->required)
 		die("%s: smudge filter %s failed", path, ca.drv->name);
 
 	return ret | ret_filter;
-- 
2.10.0

