Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96ECCC77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 22:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbjEHWAo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 18:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234500AbjEHWA2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 18:00:28 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A62549CE
        for <git@vger.kernel.org>; Mon,  8 May 2023 15:00:22 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-b9a6ab9ede3so6672336276.2
        for <git@vger.kernel.org>; Mon, 08 May 2023 15:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683583221; x=1686175221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rhIr3gh/rYbKoW0ZD837fYOPtntHhCQxbh/pYJvisp0=;
        b=4ukg/q+1Exf4Hg/imHsRDs+BtfECNo3AZzpkuqqU7lfqAS9FgqpBUUpg9rY2V3bc68
         osilyxb/Y6Qpgr466e4CviAWsnpQCk+LCiwBsr+NwzliGg7RGtYCaXePWgs9W97fsL48
         +c+zd689uC50zOquGBPhkH1D+2hL63k8d3jAJ7sxitTZwxfl7Mb/awGTGwgiz7sA06NM
         KH/oPKMSQONuPR4EI3MIGWAvSUNCh1UPIl8wbFM9gz6SFxH/zdkgP9GcD1OwhaATFIcM
         0sZt2DmmDvziCTqNTgt3c06QFuZwBFjGbsqONbBBv4axv3xNz/aeWSAklEXlD9e987RU
         yCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683583221; x=1686175221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhIr3gh/rYbKoW0ZD837fYOPtntHhCQxbh/pYJvisp0=;
        b=PEmmzuhN9zKQX0GPufd2bpIUW2P/e70xxkFTQ4npxKboqz65msDK+GnemW/Bqy5j72
         nmMYVyHE+cGS+exdwaHaXE90JTILEk0GLDWNB/6AUaUz1H3Q6RHmnB1kavn0NEZlNpOs
         p9P0xY/ZZGswd3B2X3CcKm2IFS3AEcIcEMH0gGDPq25A9pzhFouCkAQgJw+IvfOYwx73
         vk1d9CSla6rDGtD3IM4/QNVpU6V35KUXF0WO+9YExb7cM8kcxhP72Vat36XopLxLVsWA
         PnSzja5v8Q17nrznYlvu3thvkQNUqau5Eojd6R4UItenXlvr2A42+6NgcyVknxqVX60W
         kCqw==
X-Gm-Message-State: AC+VfDw8z2pbNfQ5dOFvJ4hZdNo2W57Al3i/xkmK3MLW+0JWwK3o3n7F
        Pe8Ry9NItIRY1bWnfLv7/v64lZg/owiuG0ucNuIX+A==
X-Google-Smtp-Source: ACHHUZ46STM1HRtJ2vPKS/HQiUs6sAxovX2ZBOOVfkFL76yb7wgqYH8rnF5em1txZ8LeCL/3EYsKKQ==
X-Received: by 2002:a25:4f08:0:b0:b9d:bcb3:deae with SMTP id d8-20020a254f08000000b00b9dbcb3deaemr12066100ybb.45.1683583221255;
        Mon, 08 May 2023 15:00:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p141-20020a257493000000b00b8c08669033sm2613497ybc.40.2023.05.08.15.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 15:00:20 -0700 (PDT)
Date:   Mon, 8 May 2023 18:00:19 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 12/15] refs/packed-backend.c: ignore complicated hidden refs
 rules
Message-ID: <dd5b34185cdb42eb43738aa837e811e42739b659.1683581621.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1683581621.git.me@ttaylorr.com>
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
 t/t1419-exclude-refs.sh | 10 ++++++++++
 2 files changed, 29 insertions(+)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index ddfa9add14..7f09201f35 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1013,6 +1013,25 @@ static void populate_excluded_skip_list(struct packed_ref_iterator *iter,
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
+		 * populating the skip list at all if we see either of
+		 * these patterns.
+		 */
+		if (**pattern == '!' || **pattern == '^')
+			return;
+	}
+
 	for (pattern = excluded_patterns; *pattern; pattern++) {
 		struct skip_list_entry *e;
 
diff --git a/t/t1419-exclude-refs.sh b/t/t1419-exclude-refs.sh
index 051b5a54ce..026e4414cd 100755
--- a/t/t1419-exclude-refs.sh
+++ b/t/t1419-exclude-refs.sh
@@ -118,4 +118,14 @@ test_expect_success 'for_each_ref__exclude(refs/heads/ba*)' '
 	assert_no_skips
 '
 
+test_expect_success 'for_each_ref__exclude(refs/heads/foo, !refs/heads/foo/1)' '
+	# discards complex hidden ref rules
+	for_each_ref__exclude refs/heads refs/heads/foo "!refs/heads/foo/1" \
+		>actual 2>perf &&
+	for_each_ref >expect &&
+
+	test_cmp expect actual &&
+	assert_no_skips
+'
+
 test_done
-- 
2.40.1.477.g956c797dfc

