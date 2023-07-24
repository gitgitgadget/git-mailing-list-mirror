Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222D2C0015E
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 16:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjGXQj4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 12:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjGXQjh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 12:39:37 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD4410D9
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 09:39:36 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-583b3939521so30595497b3.0
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 09:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1690216775; x=1690821575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xg9xbcNUD7tpViFQ434woqF+JoFPBsrwYgH7/yZi55g=;
        b=Hqk42OTw5EWRZVSKI4h7Df62NPenpyTeKemYrDuUPwnsSpCddBt2l3P4S7rJsCU4B7
         8mJnphaBHEYGRks/RJzSUf9t9YwXyMfArElKbUPh3nAPz2FSDa5IGJtpunIH3c3aHuiM
         nTsdPKh9gd1ZYBrotfNXrHHuycEthTVbhJK+mmiMPBb0wP3IcrkaX8YqVpCknCBWsyEj
         ujNOCAkjDONb2e18gQHi2rLJ5dDxy6qB3wKlAsloafqnv8jl+8i+Fn2rgjMMby1rttag
         qViW1i6wrCNbHU80eQ36fJUSSYBoqcAdoRA79f/488EpIHNku7b+XKK1yYG5PK6HnjiH
         +tmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690216775; x=1690821575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xg9xbcNUD7tpViFQ434woqF+JoFPBsrwYgH7/yZi55g=;
        b=GktoHezNmiYhqFfxThxzFcQxy6nTklCFIpS1dWVK63j+sTCZrGI/KYdu1v8Vt6eCJh
         87H1GTopy0Ter6Xq7UTUNs+FiRLROVIiORRivtDGA0+LIk2ztkwtcQpFbJGkfWHTZWAP
         jJVjZD7N06m2M975QOPOmMj70DCoiawcoH3NqcYcNEP9/mCWvodv4C5rjEhFF0u2tElD
         leLFkyann84zuVz1NW0V78B5fwL6vopZkRTtQGY2/nkB4Ak/cCUAHq8R49HVOjCpP+V7
         zNLLWOF6RqAHA/rUqte13r2AM8RGlfB29AIOJNcbUML4PpXtAB0x1JWC1Ceclv7xtSBw
         viBg==
X-Gm-Message-State: ABy/qLb8y/vzQpaU+x09mDrv0tr/+HzQDx5X7c3oAUOErePyqSLga+NI
        d+JUBO0JX5KTQ/sIrEBr/V87my4f86OdK/VYps42pQ==
X-Google-Smtp-Source: APBJJlEjaJ0ruX0zS5vFtWCqxEwRXJRZDr8sSX4SdT4tkyFTYUOSaC1/Y3pgGt7aR86Vt7LJs5gE8A==
X-Received: by 2002:a0d:eb85:0:b0:57a:1863:755c with SMTP id u127-20020a0deb85000000b0057a1863755cmr7215496ywe.15.1690216775129;
        Mon, 24 Jul 2023 09:39:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q2-20020a0dce02000000b005707d7686ddsm2895503ywd.76.2023.07.24.09.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 09:39:34 -0700 (PDT)
Date:   Mon, 24 Jul 2023 12:39:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 5/5] t/lib-commit-graph.sh: avoid sub-shell in
 `graph_git_behavior()`
Message-ID: <887006eab461908493d377c042dd1b7e74641170.1690216758.git.me@ttaylorr.com>
References: <cover.1689960606.git.me@ttaylorr.com>
 <cover.1690216758.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1690216758.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a previous commit, we introduced a sub-shell in the implementation of
`graph_git_behavior()`, in order to allow us to pass `-C "$DIR"`
directly to the git processes spawned by `graph_git_two_modes()`.

Now that its callers are always operating from the "$TRASH_DIRECTORY"
instead of one of its sub-directories, we can drop the inner sub-shell,
as it is no longer required.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/lib-commit-graph.sh | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/t/lib-commit-graph.sh b/t/lib-commit-graph.sh
index c8bd76a7777..89b26676fbb 100755
--- a/t/lib-commit-graph.sh
+++ b/t/lib-commit-graph.sh
@@ -27,14 +27,11 @@ graph_git_behavior() {
 	BRANCH=$3
 	COMPARE=$4
 	test_expect_success "check normal git operations: $MSG" '
-		(
-			cd "$TRASH_DIRECTORY" &&
-			graph_git_two_modes "${DIR:+-C $DIR} log --oneline $BRANCH" &&
-			graph_git_two_modes "${DIR:+-C $DIR} log --topo-order $BRANCH" &&
-			graph_git_two_modes "${DIR:+-C $DIR} log --graph $COMPARE..$BRANCH" &&
-			graph_git_two_modes "${DIR:+-C $DIR} branch -vv" &&
-			graph_git_two_modes "${DIR:+-C $DIR} merge-base -a $BRANCH $COMPARE"
-		)
+		graph_git_two_modes "${DIR:+-C $DIR} log --oneline $BRANCH" &&
+		graph_git_two_modes "${DIR:+-C $DIR} log --topo-order $BRANCH" &&
+		graph_git_two_modes "${DIR:+-C $DIR} log --graph $COMPARE..$BRANCH" &&
+		graph_git_two_modes "${DIR:+-C $DIR} branch -vv" &&
+		graph_git_two_modes "${DIR:+-C $DIR} merge-base -a $BRANCH $COMPARE"
 	'
 }
 
-- 
2.41.0.399.g887006eab46
