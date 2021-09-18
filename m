Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED45EC433EF
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 16:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1F9060EE9
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 16:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbhIRQED (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 12:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbhIRQEC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 12:04:02 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C0EC06175F
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 09:02:39 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id a22so16163614iok.12
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 09:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/+iW3Nz/x0uTMV+UnbyzIEycxhClDfl0hItQYkta3/E=;
        b=R7Tttlc4l/9EcWGhDQxrlb0huj9LduwRq+vAKxRSTxQdfVZSterbqPBZrmVDDMEIEp
         hlXJ1j3OA1yeye1+YBAg7ooFr6v1RjSx/mYor5aCs+qBJHOmBxrb0necwjR5/ooRvWi0
         rdwNOeNOcuk8DdEo/ET0NKLQnJJBrbGxncOg8bowdqfO9qkulS1kNkR66+HB041BT0w8
         jQKYIQNiZ7n6ZKxCpOyB70++sIn/ferIvK9K1JqVjvEp8oFa0CeYe57AKg5XyKkrUUm/
         0ddf/Y8D1Qkqq8qooSjcfnCA82NJXYUvWv52vgsgYbDWXSmr7EUlBGGiJyoOKg2pZfH9
         Wsxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/+iW3Nz/x0uTMV+UnbyzIEycxhClDfl0hItQYkta3/E=;
        b=3+d04DGSu3NvTL/B1IME0FULVuOpMocLEoaqooMFiqQ5lqp3H+IvthhdBvPHqw3IDL
         cIZNqekUU/Om0jj8natZZLeG5qPVN+hAiiuH6MO2FOHR1YnyyVMVQIt1exaC+GVG5lRv
         VPFc0KNMLFrF8sxc/K3HG7SlbPsb/i11EWKuOtq5OsuRkaCpVUVcCVnxAyUiVIALeAIv
         cybVpDUIFpljdGscQUF2B7XXDvbQxGsFEG+x4bb53hWfQLtbOnjJPeUfp9+qAIZjR8oi
         2Rf4C2fnUsGNkoBIWSXPmergEEkODTX7dV0g/hMAWfa+1PByjE5rgVqJHXvnRkL2D/g9
         C+rw==
X-Gm-Message-State: AOAM53345bxnPsltNkA/6TERRV+1L43fgVilKHwCuR8kLMekW288p2/J
        h/obPCWz7q0GVBa9JIwQ77lVfdgzSVq0Ka9E
X-Google-Smtp-Source: ABdhPJxhHU6YmG07UiqLRPy7t0PMHN4j5utptnqxC1tdwd5CYNsEIsHk4xGjlw/VxPsgweTQ0y6Nvg==
X-Received: by 2002:a05:6602:730:: with SMTP id g16mr12675683iox.138.1631980958382;
        Sat, 18 Sep 2021 09:02:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b16sm5451819ila.1.2021.09.18.09.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 09:02:38 -0700 (PDT)
Date:   Sat, 18 Sep 2021 12:02:37 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, szeder.dev@gmail.com, avarab@gmail.com,
        dstolee@microsoft.com
Subject: [PATCH 1/1] builtin/commit-graph.c: don't accept common
 --[no-]progress
Message-ID: <e41e65ddf77c596a7926e75bfc15f21c075d0f03.1631980949.git.me@ttaylorr.com>
References: <cover.1631980949.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1631980949.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 84e4484f12 (commit-graph: use parse_options_concat(), 2021-08-23) we
unified common options of commit-graph's subcommands into a single
"common_opts" array.

But 84e4484f12 introduced a behavior change which is to accept the
"--[no-]progress" option before any sub-commands, e.g.,

    git commit-graph --progress write ...

Prior to that commit, the above would error out with "unknown option".

There are two issues with this behavior change. First is that the
top-level --[no-]progress is not always respected. This is because
isatty(2) is performed in the sub-commands, which unconditionally
overwrites any --[no-]progress that was given at the top-level.

But the second issue is that the existing sub-commands of commit-graph
only happen to both have a sensible interpretation of what `--progress`
or `--no-progress` means. If we ever added a sub-command which didn't
have a notion of progress, we would be forced to ignore the top-level
`--[no-]progress` altogether.

Since we haven't released a version of Git that supports --[no-]progress
as a top-level option for `git commit-graph`, let's remove it.

Suggested-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/commit-graph.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 21fc6e934b..067587a0fd 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -50,8 +50,6 @@ static struct option common_opts[] = {
 	OPT_STRING(0, "object-dir", &opts.obj_dir,
 		   N_("dir"),
 		   N_("the object directory to store the graph")),
-	OPT_BOOL(0, "progress", &opts.progress,
-		 N_("force progress reporting")),
 	OPT_END()
 };
 
@@ -95,6 +93,8 @@ static int graph_verify(int argc, const char **argv)
 	static struct option builtin_commit_graph_verify_options[] = {
 		OPT_BOOL(0, "shallow", &opts.shallow,
 			 N_("if the commit-graph is split, only verify the tip file")),
+		OPT_BOOL(0, "progress", &opts.progress,
+			 N_("force progress reporting")),
 		OPT_END(),
 	};
 	struct option *options = add_common_options(builtin_commit_graph_verify_options);
@@ -246,6 +246,8 @@ static int graph_write(int argc, const char **argv)
 		OPT_CALLBACK_F(0, "max-new-filters", &write_opts.max_new_filters,
 			NULL, N_("maximum number of changed-path Bloom filters to compute"),
 			0, write_option_max_new_filters),
+		OPT_BOOL(0, "progress", &opts.progress,
+			 N_("force progress reporting")),
 		OPT_END(),
 	};
 	struct option *options = add_common_options(builtin_commit_graph_write_options);
-- 
2.33.0.96.g73915697e6
