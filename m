Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FDA020986
	for <e@80x24.org>; Tue,  4 Oct 2016 13:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754120AbcJDNAO (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 09:00:14 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35721 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754091AbcJDNAE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 09:00:04 -0400
Received: by mail-wm0-f66.google.com with SMTP id f193so14973105wmg.2
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 06:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LwponuzJWQXr+8UBlCEN28rQh9gIyBQCYXwU3e4yQvk=;
        b=RMrWJRfwFtXjF7GgMvZUblDelZmS1nz+C6rs4Nhl1FhAb38x8KuPn1SID2HrrO7oPR
         yq8d66J2wWPOv4AyL28+/SUY0EV5wSqUCJBXPE9iZfSV9jSXWGMFL6hx3RZxzI7C8tqV
         D0K4pcVDB0kAEmeWXB1194T2uWKGqOU8dkgG7qYvM0JE7yxPINZvqs2HEPq+FdpDGYWT
         IpC/pYSWHMGx47qHzd0EyCL5PB3VuxyXX8nec14z8/V6+T7Ftm4zDL5ixorKuG4RtmRj
         0VWPz3s5swWRK/h4eGcyuhIyLCYWEtTX55wCsYJ5C2qLyB0NGNO8KKiEQojzgyIkZAjP
         4K3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LwponuzJWQXr+8UBlCEN28rQh9gIyBQCYXwU3e4yQvk=;
        b=fbcAWWJsQ1TmefUdSQ4u4dGiql8en0JYHyg+T4R2f1P5jiECYdXrRAyzLwRYa/nrqz
         M9dNDUTDtN9oT8dsROZkSo32QcV/KmtEWHJvbbkoBGGaqEUOfLM361uA6zEzWZzGoyZ7
         AtPU0oTZ++EJXThXzpc16jYk7vExWQiVYI85HptR9OUCvt82XpqCfNy2XlfPhoRQb0a1
         yYvmXGJVj2ZELB55LsnxZpHWxdM5rnRgtvNG00L+pyMN+5Mrk+MnnHHLrzFRj+GfUZPW
         pzJdDyUarl5Z6dDAgmvw7Rt5qga/2MySD6tC7tZiurof6rhdINX3nQdqIL9ZMuQ6V4Ws
         tIpg==
X-Gm-Message-State: AA6/9RkD7hBwFGXGmqDbRBfNtHRwJFst2hTi/2TP/V4NaM5tl4JTQk/6BkWwAihld5ibiA==
X-Received: by 10.194.58.175 with SMTP id s15mr2949144wjq.97.1475586003338;
        Tue, 04 Oct 2016 06:00:03 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id qo8sm3426934wjc.46.2016.10.04.06.00.02
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 04 Oct 2016 06:00:02 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     ramsay@ramsayjones.plus.com, jnareb@gmail.com, gitster@pobox.com,
        j6t@kdbg.org, tboegi@web.de, peff@peff.net, mlbright@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v9 12/14] convert: prepare filter.<driver>.process option
Date:   Tue,  4 Oct 2016 14:59:45 +0200
Message-Id: <20161004125947.67104-13-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161004125947.67104-1-larsxschneider@gmail.com>
References: <20161004125947.67104-1-larsxschneider@gmail.com>
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

