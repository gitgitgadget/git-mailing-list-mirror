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
	by dcvr.yhbt.net (Postfix) with ESMTP id E90A51F462
	for <e@80x24.org>; Sat,  1 Jun 2019 00:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfFAAg3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 20:36:29 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:51845 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfFAAg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 20:36:28 -0400
Received: by mail-ot1-f74.google.com with SMTP id 68so5330635otu.18
        for <git@vger.kernel.org>; Fri, 31 May 2019 17:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dxOE1UKvycoFri0zbfk/c9+hDBCoXzOEGJxEViG+CT8=;
        b=MNm7T43PjPJyC28FPkDjXZ4QLreQ3Hpa5qeoNSV95HikVhplkoy2cRFd2xdT9XRNoW
         TQxKQ6+z6bJ+t2KocvTMPjy8VnZvzWTiqBRj9uFV37V4wY9O3w1epwJS5ZF8Eb0gzM+0
         BznYwcChONcjjelOO0HfWktfJOcwovXucdpvFuwamfgzVP3tHlXQnGD7b+NHMwjOdsCX
         9kVT655d/QfUOgtxpVXKVlLs8PJLGr7xAd3DDfYDT4xpPfCUEJFWt82mkIoY7YXUNkEc
         8YvI2nd02gwt3c+zJXVXnbpITB/QeB1LnKl2FJg9pLrcBgFPSp6oYGTTaVvMotu0wCNF
         Qbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dxOE1UKvycoFri0zbfk/c9+hDBCoXzOEGJxEViG+CT8=;
        b=s+vbe+47cIU6zC+NqgF+u0y/u2GwDQxkZgH7C/lNYnsdd7lkwZ1s/wHrTQg0j4zy+K
         pO9dbWYZGHju4bEiZVwLtbg3pI9fpijLQevs77xut/8JDAGgqQiWGZd4PrDkbQ1n0xYL
         nWr8ctTHTUWv2LoMPT2T2pqbHhaR+/aGfgprothWcCad+dsh0Ihs87nZqF1uIcgjdCzT
         9/QGGd8uzFhRrv3tDMGP0LFU7kVN5XIIxTxTffZyeS7VBcL5KcL3uPmF/6pWZVBsvxDt
         YrImT1xN08ktj2xKtsaK5hnvo6Rd4mw6EzKeJuzWQfxv55+luWuUiZCihjFuKYlTuQ+S
         ZUZQ==
X-Gm-Message-State: APjAAAXdA6uIgk3kmtu3VYHiMUOYKzK8rXuaCN2R8nWOpPQ1wIzgZpFL
        8s+zmvcV/5oHg76MU2eXY2eUC6V7AZA9gO2fCOIkwg1eRIU4nQzE2OP5zwa8hhducQpeRrM/izv
        6IGYeDDUX7TZ46jOLu/Q5jplqf1kWk2JaDkSn1I2mJZ9rH2b998GFw/G6bFg=
X-Google-Smtp-Source: APXvYqxacP5D0Rk7K7nyzJ4qHYdrtumHxGtWeB3JHQcKQDpaC3jLqyu+Gfi2Nq1F+SjmB6rmZrVasXgXMXW3
X-Received: by 2002:a9d:4041:: with SMTP id o1mr3964315oti.178.1559349387789;
 Fri, 31 May 2019 17:36:27 -0700 (PDT)
Date:   Fri, 31 May 2019 17:35:59 -0700
In-Reply-To: <20190601003603.90794-1-matvore@google.com>
Message-Id: <20190601003603.90794-6-matvore@google.com>
Mime-Version: 1.0
References: <20190601003603.90794-1-matvore@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH v2 5/9] list-objects-filter-options: move error check up
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

Move the check that filter_options->choice is set to higher in the call
stack. This can only be set when the gentle parse function is called
from one of the two call sites.

This is important because in an upcoming patch this may or may not be an
error, and whether it is an error is only known to the
parse_list_objects_filter function.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 list-objects-filter-options.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 0f1d4181cb..e8132b811e 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -27,25 +27,22 @@ static int parse_combine_filter(
  * expand_list_objects_filter_spec() first).  We also "intern" the arg for the
  * convenience of the current command.
  */
 static int gently_parse_list_objects_filter(
 	struct list_objects_filter_options *filter_options,
 	const char *arg,
 	struct strbuf *errbuf)
 {
 	const char *v0;
 
-	if (filter_options->choice) {
-		strbuf_addstr(
-			errbuf, _("multiple filter-specs cannot be combined"));
-		return 1;
-	}
+	if (filter_options->choice)
+		BUG("filter_options already populated");
 
 	if (!strcmp(arg, "blob:none")) {
 		filter_options->choice = LOFC_BLOB_NONE;
 		return 0;
 
 	} else if (skip_prefix(arg, "blob:limit=", &v0)) {
 		if (git_parse_ulong(v0, &filter_options->blob_limit_value)) {
 			filter_options->choice = LOFC_BLOB_LIMIT;
 			return 0;
 		}
@@ -204,20 +201,22 @@ cleanup:
 		list_objects_filter_release(filter_options);
 		memset(filter_options, 0, sizeof(*filter_options));
 	}
 	return result;
 }
 
 int parse_list_objects_filter(struct list_objects_filter_options *filter_options,
 			      const char *arg)
 {
 	struct strbuf buf = STRBUF_INIT;
+	if (filter_options->choice)
+		die(_("multiple filter-specs cannot be combined"));
 	filter_options->filter_spec = strdup(arg);
 	if (gently_parse_list_objects_filter(filter_options, arg, &buf))
 		die("%s", buf.buf);
 	return 0;
 }
 
 int opt_parse_list_objects_filter(const struct option *opt,
 				  const char *arg, int unset)
 {
 	struct list_objects_filter_options *filter_options = opt->value;
-- 
2.17.1

