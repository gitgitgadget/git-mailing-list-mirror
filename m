Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D74211F462
	for <e@80x24.org>; Sat,  1 Jun 2019 00:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfFAAgY (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 20:36:24 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:52691 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfFAAgX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 20:36:23 -0400
Received: by mail-vs1-f74.google.com with SMTP id x10so2338837vsj.19
        for <git@vger.kernel.org>; Fri, 31 May 2019 17:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Etk/YcOOQAFgNrjKK70hHfrOn3ZSVae7qoO5uYh1Yjk=;
        b=Ht/ZzIWBjcj3Q5hqchguGtQLe1sKyLVYlcbg1NKJVBecNCYBHHb/Dc9TCT19L5rwxg
         2YGBzsj5fQ3qpW4TkyViPsBtYi9+V8h/FF8X5RVh3xxttMzH5AUVCeqaMpmjJqkq8RoR
         smKM1Y1L3HDFQGIqx3Z0EJU+RNJaqMyUau9q012wTlQVnERt1H4ZGLi6CUhAGQIiscOo
         07zg81bcKrwm3J4U81EEZMwUmY9aYhvy6jiys4OZ2qR4me+dPVkbJ5XzuuqregZwTDiw
         Gjhq81YcGt2PMYpvQwtDdkvcZNQTpl2gqhTr6oHNV/eW6775yfThLt0GStnbg8xKow5g
         G40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Etk/YcOOQAFgNrjKK70hHfrOn3ZSVae7qoO5uYh1Yjk=;
        b=hNli3srukZHK3+yEF1ED7gj5ndXedV4gF0p0L3FLUtJEo9oRMfcPrk9H8UnUgEx0e+
         2BsuxS7L3x0szJRcR11gmsKZkWhWf6JfLBh7LvXjVWmoAmeHMmxyjzS7YcijX82hpeA4
         ltbqTLitMmkfqMW0qHZ0AF/hmpK8hTRq/XWDB4a4iA61tBEuzGW8D4kk4R/MNhcXFOUY
         1F88uYbhbxRlP0Ar0gJA+S9mzzo3xfwy6TxW5ThtarGZ1wtV+qbbqjaf2SsH2M5YW2Mm
         182FTwPCNLCX53/zVrlpR9HRvuypEngEfhxOtVF3TPrW6vGfGMd0C5ynC2LUFeAN4C5Q
         TV2Q==
X-Gm-Message-State: APjAAAWqjxT7AIKW14u+VFs2IXrBqLaYHaSBf36FqQo1vE5+d2sQn6rP
        DM31PcLyRSVFEIPQZX6f+BsSvEpFglunE0zIWpsQiYr8iuYm4Bu5uWdhYAPuvh9UDaGcmAU/JG0
        J5XClGffWQSE5JZaZPtKLlnn8ndCjtLmdgmfMaqCvETULBYyA3HCY6boUYxI=
X-Google-Smtp-Source: APXvYqy9ElqofoyS2kSOmucs+GN6h1RR3Rb4nIoO0NmzRjiTWcP8i/FLClUqp8l+y8KHslY4iqhogJkOEqyU
X-Received: by 2002:a67:b30b:: with SMTP id a11mr6884958vsm.86.1559349382624;
 Fri, 31 May 2019 17:36:22 -0700 (PDT)
Date:   Fri, 31 May 2019 17:35:57 -0700
In-Reply-To: <20190601003603.90794-1-matvore@google.com>
Message-Id: <20190601003603.90794-4-matvore@google.com>
Mime-Version: 1.0
References: <20190601003603.90794-1-matvore@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH v2 3/9] list-objects-filter-options: always supply *errbuf
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org, jonathantanmy@google.com, jrn@google.com,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com,
        pclouds@gmail.com, emilyshaffer@google.com
Cc:     Matthew DeVore <matvore@google.com>, matvore@comcast.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Making errbuf an optional argument complicates error reporting. Fix this
by making all callers supply an errbuf, even if they may ignore it. This
will be important in follow-up patches where the filter-spec parsing has
more pitfalls and possible errors.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 list-objects-filter-options.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index c0036f7378..aef24ddae3 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -23,47 +23,40 @@
  * convenience of the current command.
  */
 static int gently_parse_list_objects_filter(
 	struct list_objects_filter_options *filter_options,
 	const char *arg,
 	struct strbuf *errbuf)
 {
 	const char *v0;
 
 	if (filter_options->choice) {
-		if (errbuf) {
-			strbuf_addstr(
-				errbuf,
-				_("multiple filter-specs cannot be combined"));
-		}
+		strbuf_addstr(
+			errbuf, _("multiple filter-specs cannot be combined"));
 		return 1;
 	}
 
 	filter_options->filter_spec = strdup(arg);
 
 	if (!strcmp(arg, "blob:none")) {
 		filter_options->choice = LOFC_BLOB_NONE;
 		return 0;
 
 	} else if (skip_prefix(arg, "blob:limit=", &v0)) {
 		if (git_parse_ulong(v0, &filter_options->blob_limit_value)) {
 			filter_options->choice = LOFC_BLOB_LIMIT;
 			return 0;
 		}
 
 	} else if (skip_prefix(arg, "tree:", &v0)) {
 		if (!git_parse_ulong(v0, &filter_options->tree_exclude_depth)) {
-			if (errbuf) {
-				strbuf_addstr(
-					errbuf,
-					_("expected 'tree:<depth>'"));
-			}
+			strbuf_addstr(errbuf, _("expected 'tree:<depth>'"));
 			return 1;
 		}
 		filter_options->choice = LOFC_TREE_DEPTH;
 		return 0;
 
 	} else if (skip_prefix(arg, "sparse:oid=", &v0)) {
 		struct object_context oc;
 		struct object_id sparse_oid;
 
 		/*
@@ -80,22 +73,21 @@ static int gently_parse_list_objects_filter(
 	} else if (skip_prefix(arg, "sparse:path=", &v0)) {
 		filter_options->choice = LOFC_SPARSE_PATH;
 		filter_options->sparse_path_value = strdup(v0);
 		return 0;
 	}
 	/*
 	 * Please update _git_fetch() in git-completion.bash when you
 	 * add new filters
 	 */
 
-	if (errbuf)
-		strbuf_addf(errbuf, "invalid filter-spec '%s'", arg);
+	strbuf_addf(errbuf, "invalid filter-spec '%s'", arg);
 
 	memset(filter_options, 0, sizeof(*filter_options));
 	return 1;
 }
 
 int parse_list_objects_filter(struct list_objects_filter_options *filter_options,
 			      const char *arg)
 {
 	struct strbuf buf = STRBUF_INIT;
 	if (gently_parse_list_objects_filter(filter_options, arg, &buf))
@@ -166,19 +158,22 @@ void partial_clone_register(
 	 */
 	core_partial_clone_filter_default =
 		xstrdup(filter_options->filter_spec);
 	git_config_set("core.partialclonefilter",
 		       core_partial_clone_filter_default);
 }
 
 void partial_clone_get_default_filter_spec(
 	struct list_objects_filter_options *filter_options)
 {
+	struct strbuf errbuf = STRBUF_INIT;
+
 	/*
 	 * Parse default value, but silently ignore it if it is invalid.
 	 */
 	if (!core_partial_clone_filter_default)
 		return;
 	gently_parse_list_objects_filter(filter_options,
 					 core_partial_clone_filter_default,
-					 NULL);
+					 &errbuf);
+	strbuf_release(&errbuf);
 }
-- 
2.17.1

