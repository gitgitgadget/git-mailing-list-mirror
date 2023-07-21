Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D884CC0015E
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 17:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjGURal (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 13:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjGURa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 13:30:27 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40DE35B3
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 10:30:14 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-579ef51428eso24228037b3.2
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 10:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689960613; x=1690565413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p8ABMqalkWIxd3TL6kFRCtv0Vk7cnJxvPn8S6xo/LfE=;
        b=OqrvD9zKhVtaZPWePfDalG5JyWQO3jCWulo/xNmxLKQGbS09d8b95K0SuofO1h8Yxt
         1e5o0CP4US1wXfkblJUzrNXFx0/Iko7BJVxH6sOzOuvzOYXCk6BsyQEoWGLrCU9kpGNt
         hrHXh9KiWKUpsEX3Uo3FmkzE/24M98Sh15YC1vSk0cdMz5CgsXOGHPTBGFpifQYAvOo1
         UVOVx8zvHFmXIT3bQ4Jir3hjNhR95mm6oRjuxG7x7jAx1Ak4lgS6Z3hiBn9YseEdvCUy
         cckLwJ9L8I0LliHr7N5up1UPlOoxuTqwNwwXH3f3yeiEzLmGOIE28xfwrz3Gd7TVFBuc
         AYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689960613; x=1690565413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8ABMqalkWIxd3TL6kFRCtv0Vk7cnJxvPn8S6xo/LfE=;
        b=HQFq8vvGc+Xrh8LHRSqhhWDKF0r0HnUcTWdWT8BSSeJHIhyy1Vdmxnq8jIXDr4Y8CG
         JJEEAZs8U8Qgp5+tpg/8+0TxjUFCufdW7wFz9bsPAC8Dt/FTzJV9y/PwESUPBuGzPhUl
         knK381YbiCKWK57yzAixCXJl4owA7pAl9JmReCg7oywJq4Oj6brDEI5cYth8uEVeEJqc
         /R/UjT0t5iIgd2QY1JuRJ/BoqX7x0bZG6KA4ia9rvdJdxdEEzxvKhkpQAKmOsM7ZGU6J
         1OqD2jxh0uyj1kHQO7KqYMVT/rCEr8IciIZQhWN0vFMKllTQhDAYxVsqT6xJ/fqOmQN/
         pw6A==
X-Gm-Message-State: ABy/qLY7QExHymFrEi36cNxU4H53a/n2PGmtGO4j4JAY7Fk9nqtYnQD/
        OX3xma7rqGpTh9/2uJY5sKxmLinb0D6xxV05faGK9g==
X-Google-Smtp-Source: APBJJlE+WSDyOVvXDWwv9VT3Kev2dF536nA4Sg7twzPYchJM4MXW1l55Vtv9fnU+mgItDrQqN3k47A==
X-Received: by 2002:a0d:e28f:0:b0:57a:40aa:3fe4 with SMTP id l137-20020a0de28f000000b0057a40aa3fe4mr761003ywe.22.1689960613690;
        Fri, 21 Jul 2023 10:30:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f123-20020a0ddc81000000b005772e9388cdsm1007941ywe.62.2023.07.21.10.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 10:30:13 -0700 (PDT)
Date:   Fri, 21 Jul 2023 13:30:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/5] t/lib-commit-graph.sh: allow `graph_read_expect()` in
 sub-directories
Message-ID: <084822126301c0e723155fd76942f2e259b77158.1689960606.git.me@ttaylorr.com>
References: <cover.1689960606.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689960606.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `graph_read_expect()` function is used to ensure that the output of
the "read-graph" test helper matches certain parameters (e.g., how many
commits are in the graph, which chunks were written, etc.).

It expects the Git repository being tested to be at the current working
directory. However, a handful of t5318 tests use different repositories
stored in sub-directories. To work around this, several tests in t5318
change into the relevant repository outside of a sub-shell, altering the
context for the rest of the suite.

Prepare to remove these globally-scoped directory changes by teaching
`graph_read_expect()` to take an optional "-C dir" to specify where the
repository containing the commit-graph being tested is.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/lib-commit-graph.sh | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/t/lib-commit-graph.sh b/t/lib-commit-graph.sh
index 5d79e1a4e96..c50553df0ed 100755
--- a/t/lib-commit-graph.sh
+++ b/t/lib-commit-graph.sh
@@ -32,6 +32,13 @@ graph_git_behavior() {
 graph_read_expect() {
 	OPTIONAL=""
 	NUM_CHUNKS=3
+	DIR="."
+	if test "$1" = -C
+	then
+		shift
+		DIR="$1"
+		shift
+	fi
 	if test -n "$2"
 	then
 		OPTIONAL=" $2"
@@ -47,12 +54,15 @@ graph_read_expect() {
 	then
 		OPTIONS=" read_generation_data"
 	fi
-	cat >expect <<- EOF
+	cat >$DIR/expect <<- EOF
 	header: 43475048 1 $(test_oid oid_version) $NUM_CHUNKS 0
 	num_commits: $1
 	chunks: oid_fanout oid_lookup commit_metadata$OPTIONAL
 	options:$OPTIONS
 	EOF
-	test-tool read-graph >output &&
-	test_cmp expect output
+	(
+		cd "$DIR" &&
+		test-tool read-graph >output &&
+		test_cmp expect output
+	)
 }
-- 
2.41.0.381.gd8424d64777

