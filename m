Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50999C433E0
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 14:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26BF623135
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 14:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405028AbhASOvz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 09:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389792AbhASNFa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 08:05:30 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562CEC061786
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 04:52:09 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id a9so16162180wrt.5
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 04:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Mh+AJQ5NGaPzH3/qAOl/1xZwT/lL9CimDE038e+brjw=;
        b=mQnjswfhK01PUs3ZOMQMcc1TEH/7OAg/CGNwXdS13Y2KQTgn1PpupqRl2BDngwn7Rf
         EyFkTc0JB6fzkdYS9eXNsSUzHP7qBjXI5QJtHKzTAWYAFqfPxBrr7lNwsAOOHd/IVtut
         820mNGQ4VbnAih2gb2+0vm7/6I59zG0VCcGJAjKtwU7zUEUEVH+stdPq7MJ/XbRGYay0
         D33Vl3mRHm1lpD9ACrI+vttvnKz8nXtkMSpZAnNFE41UqWg3eRx5k6iIkfDZaBQmhnux
         WKcq54l/3bPZ/0yn2HAIMrGdHRu0lvzxBbUJX75OirgkPOKXFoI2SHL6WKxQdVj+5dc9
         krrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Mh+AJQ5NGaPzH3/qAOl/1xZwT/lL9CimDE038e+brjw=;
        b=uny8rH8VqOQd96FRqAb6qZXjF6XatpQfd5nbTuRHmSzSMCw/m+AIYr+1OiPoWgg0Wg
         4UGvXHsYQ+h9KBmfyoF4b4gSxkmIXKxM38KHCH5FtJ7MmXO0ZPGsavwUUHr/EdTdPtQe
         8PqPKHhc2FR+gdEZ2iCQzptzbhe3IXG8kX5ey2Hh6RBlgqtblApX7o3R77l/zN0De7yQ
         UaY+rJHoEjsXCFR4jc6ELyQ/dg/wXd3oDTIsO6O5HLr9ztAM+aORawdPVEsHo6nJeU9P
         LKB3JWpzitzpuYn4rMEdsGqgNhV8N/KU+dkidFCCqKvZUzXVISlstlXW88G+GCtmM+/e
         aPWA==
X-Gm-Message-State: AOAM530OXUfO7g2+2ujaxN1GlRUTUny2WanLeelp1Bw2mM1ez14zRk/g
        Ad2/kNcHImdOkVyCF2lKQzNyljQ++cY=
X-Google-Smtp-Source: ABdhPJyo4fZpGYPl0ticfNTmUmtJ8cu3JghL7WwoW5BwVLePXJJ5PtKkgR6NNHOGB+dJGr/CEu3kIA==
X-Received: by 2002:a5d:5304:: with SMTP id e4mr1512769wrv.167.1611060727930;
        Tue, 19 Jan 2021 04:52:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a184sm4301848wme.35.2021.01.19.04.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 04:52:07 -0800 (PST)
Message-Id: <35038dfd037f6da1e21c1d9f1a24b27cb7100598.1611060724.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.838.v2.git.1611060724.gitgitgadget@gmail.com>
References: <pull.838.git.1610940216.gitgitgadget@gmail.com>
        <pull.838.v2.git.1611060724.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jan 2021 12:52:04 +0000
Subject: [PATCH v2 2/2] t7900: clean up some broken refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Eric Sunshine <sunshine@sunshineco.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The tests for the 'prefetch' task create remotes and fetch refs into
'refs/prefetch/<remote>/' and tags into 'refs/tags/'. These tests use
the remotes to create objects not intended to be seen by the "local"
repository.

In that sense, the incrmental-repack tasks did not have these objects
and refs in mind. That test replaces the object directory with a
specific pack-file layout for testing the batch-size logic. However,
this causes some operations to start showing warnings such as:

 error: refs/prefetch/remote1/one does not point to a valid object!
 error: refs/tags/one does not point to a valid object!

This only shows up if you run the tests verbosely and watch the output.
It caught my eye and I _thought_ that there was a bug where 'git gc' or
'git repack' wouldn't check 'refs/prefetch/' before pruning objects.
That is incorrect. Those commands do handle 'refs/prefetch/' correctly.

All that is left is to clean up the tests in t7900-maintenance.sh to
remove these tags and refs that are not being repacked for the
incremental-repack tests. Use update-ref to ensure this works with all
ref backends.

Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t7900-maintenance.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index f9031cbb44b..78ccf4b33f8 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -256,6 +256,13 @@ test_expect_success 'incremental-repack task' '
 	HEAD
 	^HEAD~1
 	EOF
+
+	# Delete refs that have not been repacked in these packs.
+	git for-each-ref --format="delete %(refname)" \
+		refs/prefetch refs/tags >refs &&
+	git update-ref --stdin <refs &&
+
+	# Replace the object directory with this pack layout.
 	rm -f $packDir/pack-* &&
 	rm -f $packDir/loose-* &&
 	ls $packDir/*.pack >packs-before &&
-- 
gitgitgadget
