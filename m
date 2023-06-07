Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9060C7EE23
	for <git@archiver.kernel.org>; Wed,  7 Jun 2023 10:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239773AbjFGKmI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jun 2023 06:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239672AbjFGKl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2023 06:41:58 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738911BEC
        for <git@vger.kernel.org>; Wed,  7 Jun 2023 03:41:56 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-565aa2cc428so66709877b3.1
        for <git@vger.kernel.org>; Wed, 07 Jun 2023 03:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1686134515; x=1688726515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bq3ESmIcam7O5vlh8zzQ2Y/N+YL92aHyGi81jqxafR4=;
        b=4um+ukqteyLuNQEXer8fMbAFn8uASvcpHrD7Yb+Yk/7HyLCs06lsGO4HzrizdRyV5F
         XMmFrRSJQgseIlY4SePaQWz5Tv9FJZiHCMSI8tj16Kbp/4+DGkP5Gx2/WwkM94qq1RMb
         WRncxpsM6gRL0r0cy3+0Qv56KyGw6NxqjTUIcAhmGGEYGjTQ96BPJUMiUyGHgzb8yPWN
         zkV+gMhQLXGEHgOBHlElEXe/EY6zoXHcBUE34Mfqg81+36KeJlS95LYoq83NPSX9jSLg
         T5ryEYZM+PB9gDLIb0RcC6VRFbUYnlR+XIRm2rJoob03v2tU5fEwPK8iNduVs7+P8bkG
         dbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686134515; x=1688726515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bq3ESmIcam7O5vlh8zzQ2Y/N+YL92aHyGi81jqxafR4=;
        b=M91z1uSs6i61KzCEf7dU44xndZIWlyRjAzNQlByhuSaFD8cIUR2unEUfRIhrZZWxE2
         /hGa0RxR05R1n8oV2KWMTVM3koYK+MQ0dDlF1YgSBDNyAHl1KzqqhqOSyVBdxKvFCpeJ
         L2RuIQ501jioRPYEh1+uXUH36h4DTbfV4mR1z+5usuwKi6ScmO6rAk5JxbICidoHANtz
         JfniTJ/POVoodUAGPNN/9syW2ks/lg5t+jO4PJKsMwUGMZNGw6hJVQ1f11xun22Ml58u
         or7nXk5KbecRZpt8l0hCPE0MIn+nW4S+YxJXJRX4F3qSb7WAdn8NX9o9Aj+IlrWLn4nM
         /Mzg==
X-Gm-Message-State: AC+VfDwgfYFdJMNjSBkDYDKtryCfDAfpW/cbYIzs98n978Uj14XYG8Vg
        eDX4ygNpkVN8sjgCppqo0q1Zv0LC020xAnjDpUNoH6dJ
X-Google-Smtp-Source: ACHHUZ7VHmhy22/Om0iOG+hQnhR48RVPYoISf3aSL5sVnUGHRbR5gXCGGmfoEwW/e06GA6W08+0cNw==
X-Received: by 2002:a81:5b0a:0:b0:561:b00d:1e12 with SMTP id p10-20020a815b0a000000b00561b00d1e12mr5114991ywb.29.1686134515195;
        Wed, 07 Jun 2023 03:41:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w187-20020a8186c4000000b00567679ef3a6sm4608914ywf.109.2023.06.07.03.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 03:41:54 -0700 (PDT)
Date:   Wed, 7 Jun 2023 06:41:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 12/16] refs/packed-backend.c: ignore complicated hidden
 refs rules
Message-ID: <ca006b2c3f3474cdf7cfebbdb8575059e036d9cc.1686134440.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1686134440.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1686134440.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In subsequent commits, we'll teach `receive-pack` and `upload-pack` to
use the new skip-list feature in the packed-refs iterator by ignoring
references which are mentioned via its respective hideRefs lists.

However, the packed-ref skip lists cannot handle un-hiding rules (that
begin with '!'), or namespace comparisons (that begin with '^'). Detect
and avoid these cases by falling back to the normal enumeration without
a skip list when such patterns exist.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 refs/packed-backend.c   | 19 +++++++++++++++++++
 t/t1419-exclude-refs.sh |  9 +++++++++
 2 files changed, 28 insertions(+)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 7ba9fa2bb8..9ea6c07866 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1015,6 +1015,25 @@ static void populate_excluded_jump_list(struct packed_ref_iterator *iter,
 	if (!excluded_patterns)
 		return;
 
+	for (pattern = excluded_patterns; *pattern; pattern++) {
+		/*
+		 * We also can't feed any excludes from hidden refs
+		 * config sections, since later rules may override
+		 * previous ones. For example, with rules "refs/foo" and
+		 * "!refs/foo/bar", we should show "refs/foo/bar" (and
+		 * everything underneath it), but the earlier exclusion
+		 * would cause us to skip all of "refs/foo". We likewise
+		 * don't implement the namespace stripping required for
+		 * '^' rules.
+		 *
+		 * Both are possible to do, but complicated, so avoid
+		 * populating the jump list at all if we see either of
+		 * these patterns.
+		 */
+		if (**pattern == '!' || **pattern == '^')
+			return;
+	}
+
 	for (pattern = excluded_patterns; *pattern; pattern++) {
 		struct jump_list_entry *e;
 
diff --git a/t/t1419-exclude-refs.sh b/t/t1419-exclude-refs.sh
index 350a7d2587..0e91e2f399 100755
--- a/t/t1419-exclude-refs.sh
+++ b/t/t1419-exclude-refs.sh
@@ -119,4 +119,13 @@ test_expect_success 'meta-characters are discarded' '
 	assert_no_jumps
 '
 
+test_expect_success 'complex hidden ref rules are discarded' '
+	for_each_ref__exclude refs/heads refs/heads/foo "!refs/heads/foo/1" \
+		>actual 2>perf &&
+	for_each_ref >expect &&
+
+	test_cmp expect actual &&
+	assert_no_jumps
+'
+
 test_done
-- 
2.41.0.16.g26cd413590

