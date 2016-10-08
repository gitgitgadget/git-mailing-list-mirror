Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13FF320987
	for <e@80x24.org>; Sat,  8 Oct 2016 11:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935111AbcJHL0H (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Oct 2016 07:26:07 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33104 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935042AbcJHLZu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2016 07:25:50 -0400
Received: by mail-wm0-f68.google.com with SMTP id i130so6638348wmg.0
        for <git@vger.kernel.org>; Sat, 08 Oct 2016 04:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LwponuzJWQXr+8UBlCEN28rQh9gIyBQCYXwU3e4yQvk=;
        b=nAw6NqG0FcXfVB24ggdFIx1T9LJ7DRblMdfB5vUMlqbQsmwB6jxaqhIsM9ZBslRsmy
         knKwRhvBrZF5gTOdWVqo8hSpswu/QoAN6Uc1wdbzDQf+n0/CeIzO6wuJI60e0HnTXc2C
         yHRqXLuGU9gS7DCaomgkEZUznEhTjFTiiKPsNtYrwvKvix5UIzNkZK8qREA8UiVo1jhx
         Q3mT+sDnLsSMffFBmj/B9Y5aZ3lbNpCZrk7cw5vGhSUoDJssPqItsNM6Uk7PJrBSVYBt
         vC3BMFtX1rFJZoAL5Za3l8AJyHrsHqcJomOkhE/JI/tXgbabangp6ZXnui9fo+hslAC2
         OSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LwponuzJWQXr+8UBlCEN28rQh9gIyBQCYXwU3e4yQvk=;
        b=Ih5b/nOMWw7+bbd9QJybWD/VBur3YFOS94ctu4zJEARyhsElffMcPTYkClrFEjxEcD
         5IL7Mc1v6KlpqCiB9Ertr6OL0gKO8vy1rjgjgRpHKkQ1ve1FxN1qOA9oad4Az285KlVf
         mm9baPND4jNbMFew1OrvcUJrcObM9g9/MCj4B7v+hb+6wDYZEetz0cOgeqPfYao3moyl
         YKfi5unnuGkvRr+bKo3slHwWiyWN3nQ0l7daRsUoQGI1BSSy1+W/Dgib/0M+xyVcuxg+
         OdyEEJwdkq0/27SOs1W63bG+S+je59JMI52gozHe/nXxkMEtgLKzAFTBiSEXja4MRs5R
         4m1Q==
X-Gm-Message-State: AA6/9Rk00s3ipHo78H8TU5c+sbjTtqYlTFyXr3X5d/SgPG/6IsK8LYXenCnE2Z+CnOqqfw==
X-Received: by 10.28.189.197 with SMTP id n188mr2458727wmf.80.1475925948132;
        Sat, 08 Oct 2016 04:25:48 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB73B1.dip0.t-ipconnect.de. [93.219.115.177])
        by smtp.gmail.com with ESMTPSA id a1sm24599623wju.41.2016.10.08.04.25.47
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 08 Oct 2016 04:25:47 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jnareb@gmail.com, peff@peff.net,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v10 12/14] convert: prepare filter.<driver>.process option
Date:   Sat,  8 Oct 2016 13:25:28 +0200
Message-Id: <20161008112530.15506-13-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161008112530.15506-1-larsxschneider@gmail.com>
References: <20161008112530.15506-1-larsxschneider@gmail.com>
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

