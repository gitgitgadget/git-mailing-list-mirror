Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69C6C1FC43
	for <e@80x24.org>; Fri,  6 Oct 2017 13:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752064AbdJFNYb (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 09:24:31 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:32784 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751827AbdJFNYa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 09:24:30 -0400
Received: by mail-pg0-f67.google.com with SMTP id b11so9325682pgn.0
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 06:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9rmxWRixIIH0+2snxWYmXw7UGl0Kfb1d3rNowP/0cEI=;
        b=FPj0H2STS1I1HtRuLQdFT6eCx5Ilo05mgO6B+rsRJ8JFz8dz30UOUsC4B71GjYXKm4
         5vUgy+7sqv17UP5GLs5f19FVgDlDhQzWnu5f7GacL9j6ldxXXOGSb5HgO8WddFrG9AYT
         gakaV/Me6KcKDjuGJqwAeP5Tq3cBZl2q+VU6XST5nsVe+oux7xIO1eydIukR5msKb8+T
         iAh67APbQrS2EXHIqV+KkwzaHsOJ9K/AADzSwWhNMy8neSlUmnG6uUAF0D76G/bxWRL7
         /JuYGZfDfRCi+itk6Y4jkoftdcdW34RuOllut1x043hyEU9/AqqOslmODILiJ9dizDxz
         5XjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9rmxWRixIIH0+2snxWYmXw7UGl0Kfb1d3rNowP/0cEI=;
        b=Zeb/+iv3Fjh8+sgJcbT24KD1x5i5gykLfHkJousT4hp4NbBIdi1NnIpVkqx7xUMJhP
         k54Rs6DF+mGsopCCNuRHW919nG0ALen88FKcTh0iZcDjhL1KJn2mSWtLEi80HNKJkvga
         4QgRfSQqjh4QxKi52MD7KMNJFJ9hQJWciStzi/HEuV2hcm5cHjl6yYIsFtLJhu5SNM9c
         DrfO56XtokUO91Q8bIp8drg16mxWj+Z9YruFM006Jh9FOm22fvzuFC2C3ZTO6M96zQ7+
         2tMoBgD4n7VU048y1tn2qv1dmpqWQcVwD5LxeE1LHrhZB6AXOuqs705ZToKFrEsQh6vi
         pw+w==
X-Gm-Message-State: AMCzsaV4R6HXSrDUUEedVpRZB2m3knXbfZ4DAKsW3fC3Bk87MpqS+aw6
        hQNks8RSciCTUTbSCV98Eu0=
X-Google-Smtp-Source: AOwi7QCahoHI5dmhMAktqyYg1Sq2NuJw04QlxV/M+lne4na6wVamHbaXEy2s+JZRjYdg6EXC6aNqVA==
X-Received: by 10.84.215.210 with SMTP id g18mr1967531plj.165.1507296269938;
        Fri, 06 Oct 2017 06:24:29 -0700 (PDT)
Received: from localhost.localdomain ([42.110.180.199])
        by smtp.gmail.com with ESMTPSA id b23sm3770939pfm.148.2017.10.06.06.24.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Oct 2017 06:24:29 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     gitster@pobox.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, hanwen@google.com,
        pc44800@gmail.com, sbeller@google.com
Subject: [PATCH v7 1/3] submodule--helper: introduce get_submodule_displaypath()
Date:   Fri,  6 Oct 2017 18:54:13 +0530
Message-Id: <20171006132415.2876-2-pc44800@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171006132415.2876-1-pc44800@gmail.com>
References: <xmqqy3ouqruh.fsf@gitster.mtv.corp.google.com>
 <20171006132415.2876-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce function get_submodule_displaypath() to replace the code
occurring in submodule_init() for generating displaypath of the
submodule with a call to it.

This new function will also be used in other parts of the system
in later patches.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
 builtin/submodule--helper.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 06ed02f99..56c1c52e2 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -219,6 +219,26 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
 	return 0;
 }
 
+/* the result should be freed by the caller. */
+static char *get_submodule_displaypath(const char *path, const char *prefix)
+{
+	const char *super_prefix = get_super_prefix();
+
+	if (prefix && super_prefix) {
+		BUG("cannot have prefix '%s' and superprefix '%s'",
+		    prefix, super_prefix);
+	} else if (prefix) {
+		struct strbuf sb = STRBUF_INIT;
+		char *displaypath = xstrdup(relative_path(path, prefix, &sb));
+		strbuf_release(&sb);
+		return displaypath;
+	} else if (super_prefix) {
+		return xstrfmt("%s%s", super_prefix, path);
+	} else {
+		return xstrdup(path);
+	}
+}
+
 struct module_list {
 	const struct cache_entry **entries;
 	int alloc, nr;
@@ -334,15 +354,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 	struct strbuf sb = STRBUF_INIT;
 	char *upd = NULL, *url = NULL, *displaypath;
 
-	if (prefix && get_super_prefix())
-		die("BUG: cannot have prefix and superprefix");
-	else if (prefix)
-		displaypath = xstrdup(relative_path(path, prefix, &sb));
-	else if (get_super_prefix()) {
-		strbuf_addf(&sb, "%s%s", get_super_prefix(), path);
-		displaypath = strbuf_detach(&sb, NULL);
-	} else
-		displaypath = xstrdup(path);
+	displaypath = get_submodule_displaypath(path, prefix);
 
 	sub = submodule_from_path(&null_oid, path);
 
@@ -357,9 +369,9 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 	 * Set active flag for the submodule being initialized
 	 */
 	if (!is_submodule_active(the_repository, path)) {
-		strbuf_reset(&sb);
 		strbuf_addf(&sb, "submodule.%s.active", sub->name);
 		git_config_set_gently(sb.buf, "true");
+		strbuf_reset(&sb);
 	}
 
 	/*
@@ -367,7 +379,6 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 	 * To look up the url in .git/config, we must not fall back to
 	 * .gitmodules, so look it up directly.
 	 */
-	strbuf_reset(&sb);
 	strbuf_addf(&sb, "submodule.%s.url", sub->name);
 	if (git_config_get_string(sb.buf, &url)) {
 		if (!sub->url)
@@ -404,9 +415,9 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 				_("Submodule '%s' (%s) registered for path '%s'\n"),
 				sub->name, url, displaypath);
 	}
+	strbuf_reset(&sb);
 
 	/* Copy "update" setting when it is not set yet */
-	strbuf_reset(&sb);
 	strbuf_addf(&sb, "submodule.%s.update", sub->name);
 	if (git_config_get_string(sb.buf, &upd) &&
 	    sub->update_strategy.type != SM_UPDATE_UNSPECIFIED) {
-- 
2.14.2

