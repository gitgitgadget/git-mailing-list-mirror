Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFF1C001DF
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 16:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjGXQj1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 12:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjGXQjX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 12:39:23 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49255125
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 09:39:22 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5774098f16eso57959487b3.0
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 09:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1690216761; x=1690821561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r6xeMdgQ/QCP4eJauLInObSumM2r826mXmHuAVHJ6BI=;
        b=vjQMFm+vHitaXa7HM9rHZHnQajt7DBl0hJ359isnrVu/GrxucwOXY+rV08ucb8mo5a
         wkigWMTQvIT2eo/8zEq6U6yOcHOvXiL5vTWj2oTwSgO/5LqNdZQJksLfCRGHoalnZgJg
         CRf4bEW3+1EwCmyyWUYhJkwtays9KWaQuQQczbsScWHX4qOu5BJAuudo6aDdrFIFNdNx
         XJiw8sNSIkdZqeooLb3PbTAod9qgi4v83aQs5DfqicWnmq76tGXWzVCYlxRiU9oueMuy
         klYfnc1vygCpMyuzGOOX3K6qB6jnwwHM0mGUTpNe3Ld7YGY3TcUUn7dx7lQqgGSRhtWi
         ILag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690216761; x=1690821561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6xeMdgQ/QCP4eJauLInObSumM2r826mXmHuAVHJ6BI=;
        b=WDvTxtYh3rGgINYabfVTT4L1uqhpxMh0H0NpU305EWohtEbpohCl5GnPUxD+fqhvux
         mGFHQMMcOnWBzPfz0K2yrB2MMyJW0U5FUBMiBI5iEKjZe7UEFHTZjMVAq/FtErOzxwxh
         W0ttykn8PsxcNWdVUZ4Px6GLSo6gjGlv+WPOmW74lDW4fMJP2UevDVHupubxtIDGTiLF
         lNnZisYCc3Btf2BQVlgzvKbgs18zQPrhEfQHO6n0lzB49rPydZtot8K9GUhqXGWjz2VY
         1mLoXqoKqHELqUfrA9rbsaKvTSbDdxHzX/e8/kzKe5/AjS72tAZwmWbe0Gx6+p7KdMN5
         kG1Q==
X-Gm-Message-State: ABy/qLaYuEDMRm9vr6YPfq90C3rQQpVjKkrmPlr9MfZEQXv6cXcsmEIw
        vLhS1pbMvC6gNTaACgreyuhh+T0UT6ynM9gfbfUICg==
X-Google-Smtp-Source: APBJJlEhDjkKi4+gR+Vk/92qrRThoJGbaA4qOJZ+yXEEIKpWGiU606oBdU8IPeHiyE40a01H+Rmypw==
X-Received: by 2002:a0d:c383:0:b0:55a:3ce9:dc3d with SMTP id f125-20020a0dc383000000b0055a3ce9dc3dmr9218458ywd.13.1690216761074;
        Mon, 24 Jul 2023 09:39:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a10-20020a0dd80a000000b0057a560a9832sm2903073ywe.1.2023.07.24.09.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 09:39:20 -0700 (PDT)
Date:   Mon, 24 Jul 2023 12:39:19 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/5] commit-graph: test cleanup and modernization
Message-ID: <cover.1690216758.git.me@ttaylorr.com>
References: <cover.1689960606.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689960606.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a reroll of my series to address a few style nitpicks in the
commit-graph tests.

Much is the same from the previous round, except for:

  - quotes >"$DIR/expect" to ensure that we work on all shells>
  - adds a NOTE above graph_git_behavior to indicate that its second
    argument cannot contain any character in $IFS.
  - rebased on top of the current tip of 'master'.

As usual, a range-diff is available below. Thanks in advance for your
review!

Taylor Blau (5):
  t/lib-commit-graph.sh: allow `graph_read_expect()` in sub-directories
  t/lib-commit-graph.sh: avoid directory change in
    `graph_git_behavior()`
  t5318: avoid top-level directory changes
  t5328: avoid top-level directory changes
  t/lib-commit-graph.sh: avoid sub-shell in `graph_git_behavior()`

 t/lib-commit-graph.sh              |  34 ++-
 t/t5318-commit-graph.sh            | 378 +++++++++++++----------------
 t/t5328-commit-graph-64bit-time.sh |  54 ++---
 3 files changed, 224 insertions(+), 242 deletions(-)

Range-diff against v1:
1:  08482212630 ! 1:  c81a059c181 t/lib-commit-graph.sh: allow `graph_read_expect()` in sub-directories
    @@ t/lib-commit-graph.sh: graph_read_expect() {
      		OPTIONS=" read_generation_data"
      	fi
     -	cat >expect <<- EOF
    -+	cat >$DIR/expect <<- EOF
    ++	cat >"$DIR/expect" <<-EOF
      	header: 43475048 1 $(test_oid oid_version) $NUM_CHUNKS 0
      	num_commits: $1
      	chunks: oid_fanout oid_lookup commit_metadata$OPTIONAL
2:  715a160903b ! 2:  115df6fe226 t/lib-commit-graph.sh: avoid directory change in `graph_git_behavior()`
    @@ Commit message
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## t/lib-commit-graph.sh ##
    -@@ t/lib-commit-graph.sh: graph_git_behavior() {
    +@@ t/lib-commit-graph.sh: graph_git_two_modes() {
    + 	test_cmp expect output
    + }
    + 
    ++# graph_git_behavior <name> <directory> <branch> <compare>
    ++#
    ++# Ensures that a handful of traversal operations produce the same
    ++# results with and without the commit-graph in use.
    ++#
    ++# NOTE: it is a bug to call this function with <directory> containing
    ++# any characters in $IFS.
    + graph_git_behavior() {
    + 	MSG=$1
    + 	DIR=$2
      	BRANCH=$3
      	COMPARE=$4
      	test_expect_success "check normal git operations: $MSG" '
3:  451ec003be8 = 3:  12ce967bafe t5318: avoid top-level directory changes
4:  ba550987055 = 4:  79b3444660f t5328: avoid top-level directory changes
5:  c3432f27b94 = 5:  887006eab46 t/lib-commit-graph.sh: avoid sub-shell in `graph_git_behavior()`
-- 
2.41.0.399.g887006eab46
