Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04656C7EE25
	for <git@archiver.kernel.org>; Mon, 15 May 2023 19:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245235AbjEOTYf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 15:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245080AbjEOTYG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 15:24:06 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664BF147E8
        for <git@vger.kernel.org>; Mon, 15 May 2023 12:23:44 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-559f1819c5dso193450397b3.0
        for <git@vger.kernel.org>; Mon, 15 May 2023 12:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1684178623; x=1686770623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NNGi53S/3qn1N28jogNqbAYIVtJ4jXnS2kp8JsIHbE8=;
        b=egBp3mRzQVDtAOY+2U05aIzmpRJqiGrLdgakld9/3g+p648c9QVUXG4PqNuAGTyXfB
         gV6RVq1WqBdp8pgw/+NGLonHNGkuukx14bu6xe+ie/XIX6abFBk0fUprZqSc4mdX1B0+
         HxqHf0lWtyCw/h7aExnO61RNWH3T9+XxmT4HoTK3hIUazby0Owy2rpth5LZ4Tubqi9AY
         7QlIds1Zg9m2IRa8MlU0pKZC3m7nEJShU4cN3GcztBr0sTY7GQtZBLy0araT5rUGLMtr
         vefqCelKOLC/0/bzecxWR5jSYQqOML6tgCpvHC1bWeuh1RVxYRCG6xXuAB+G3Inuk0Eb
         J8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684178623; x=1686770623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNGi53S/3qn1N28jogNqbAYIVtJ4jXnS2kp8JsIHbE8=;
        b=NCBvxNxS2gVwcMB9koF3LhMY0DekjpVbWd3t+tehe9BMlI3Kvp7h77SUTwN+3N+whd
         rbyW75qtf5j5rl6BuBUqAZvvTHdi/Qmomwo0VAQRoRuCvtPOAH5aua373m/POKsDkH6j
         qaeGDHzsdEyoVMQ3oKKGpIu3qIKHN8Tf/nVaUDByjJd+YFhrhCECXft9aXiiDpXl3Mqv
         zp9KjmRCXybBn33CIhuVsUPo9fa+5sJi+TuFO4M81mhe1GgHRhHUqsi9USGoJxpc6pVx
         DyAEfo66cnlgz10D0EjB/zJVWH6F8mNhjIE6CDHlVLzxcW5gmO46kZbg8oD26fxoWprS
         H1WA==
X-Gm-Message-State: AC+VfDxaMY1H5GLVOLrccSadWDkEuxmqBGCmgl0z1bDYxWbBgdxb6IXP
        60Sqhj4bY+cnORnKPDwz14tJR4Zk7jTJx8VvsIRbyw==
X-Google-Smtp-Source: ACHHUZ7ycX6lt1Pz5c/DNbMPdGghKLcpuV2No7V2rOuZpOKBsv8yYrSlUh7n0ZbSJwq99D4KCA3uoA==
X-Received: by 2002:a0d:cf42:0:b0:55a:72f6:a451 with SMTP id r63-20020a0dcf42000000b0055a72f6a451mr32080100ywd.41.1684178623394;
        Mon, 15 May 2023 12:23:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b64-20020a0dc043000000b0055aaccfa2c7sm16538ywd.91.2023.05.15.12.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 12:23:43 -0700 (PDT)
Date:   Mon, 15 May 2023 15:23:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 12/16] refs/packed-backend.c: ignore complicated hidden
 refs rules
Message-ID: <254bcc436124e70ae477d2668c22f2274e43e513.1684178576.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1684178576.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1684178576.git.me@ttaylorr.com>
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
2.40.1.572.g5c4ab523ef

