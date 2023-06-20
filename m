Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64BAEB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 14:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbjFTOW0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 10:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbjFTOWH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 10:22:07 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C73B3
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 07:22:06 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5701810884aso43377297b3.0
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 07:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687270926; x=1689862926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcwsGUdDIK9XgqmEi5PIvBVVGHMWuOnSOjV9HefS6o0=;
        b=vcysne6Hf9FNiwUTpb1ovPfcPh0aGwN0U/f76Fzd+nk2aPPLtJwobi/lP/3UGX6DIg
         ArBnelRXBnSNJ+b06MH+I8Ul9H81CjUIBOPrvLEj4JYPhFoWL92Gj83/uuy1/jgjYd3q
         K0QjG+9WNUEmXu9z4UH47TUn4o8HX6gp20FZLMjraAM9HxB1Cesc5noH4teavW9Slgtq
         7vjRznHWSxXeVzrTwc5sqS63w/kWABFRBX6A6Wy2Dvi3vqG9FbiMVpWfdOT1mDhrQ+Di
         oVn1q1bxziKcGAt6yZDb1LK0qMHfnBP5uxHyi266nCi+478s8JK52qaUMOk4Ratj5qrP
         vDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687270926; x=1689862926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcwsGUdDIK9XgqmEi5PIvBVVGHMWuOnSOjV9HefS6o0=;
        b=gN2PYy7q2eBVPJUY+aZ4viKWIND2I8trHMMgXgQuxbAQeqelo4RK3K+Q26thWZ4KcN
         8IWZ7qW0kRkXcHSWf3gTWivYMsEs8u2opjRKAbUKO1n+xclk/WQ0qqs8+KPMBSxRn0kF
         6X17cPH3cgASJeKWO2HijH5hmpZjaTlElIw/gmraUZEH0J3zF/rXznpxH0kLoY1RSAlJ
         DrPqaagd1Ie8R+Ci8OH6wRFtdHLtAey88okxZO4hGCUfaroB6Sy6yDoVaXrUURLPlPIB
         6PktlJrku9BAJUcaoJeJEd3jd4LJ41lZEnT/ns8BMtJJbc1GZhCoIb/kXHoo1/bdlcmN
         dACw==
X-Gm-Message-State: AC+VfDzwyrRWXv4UQVhdt2EIagSZBUo1KOa0PlLS1VMVi9+DHHk8XG5T
        UdeDPqkkYQkUUueWgMvbbP7ThMNjkCitRwB8wzGW4KUH
X-Google-Smtp-Source: ACHHUZ6j17IzcRp6pi8yB0M04wj7QcFyJBO38M/QPoFn2eiFg3fgYWulg8C6a9CJkAISSlszaiPGoQ==
X-Received: by 2002:a81:6dc6:0:b0:56d:74a:d0d4 with SMTP id i189-20020a816dc6000000b0056d074ad0d4mr4502011ywc.22.1687270926024;
        Tue, 20 Jun 2023 07:22:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y65-20020a817d44000000b00545a08184e0sm505147ywc.112.2023.06.20.07.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 07:22:05 -0700 (PDT)
Date:   Tue, 20 Jun 2023 10:22:02 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 12/16] refs/packed-backend.c: ignore complicated hidden
 refs rules
Message-ID: <845904853eeae1741d681a35fdd7816ea16b939a.1687270849.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1687270849.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1687270849.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In subsequent commits, we'll teach `receive-pack` and `upload-pack` to
use the new jump list feature in the packed-refs iterator by ignoring
references which are mentioned via its respective hideRefs lists.

However, the packed-ref jump lists cannot handle un-hiding rules (that
begin with '!'), or namespace comparisons (that begin with '^'). Detect
and avoid these cases by falling back to the normal enumeration without
a jump list when such patterns exist.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 refs/packed-backend.c   | 19 +++++++++++++++++++
 t/t1419-exclude-refs.sh |  9 +++++++++
 2 files changed, 28 insertions(+)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 80b877e00c..2aeec5c601 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1008,6 +1008,25 @@ static void populate_excluded_jump_list(struct packed_ref_iterator *iter,
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
index 5d8c86b657..f8abf75ab8 100755
--- a/t/t1419-exclude-refs.sh
+++ b/t/t1419-exclude-refs.sh
@@ -119,4 +119,13 @@ test_expect_success 'meta-characters are discarded' '
 	assert_no_jumps perf
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
2.41.0.44.gf2359540d2

