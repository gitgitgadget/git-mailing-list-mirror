Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D8AC04FDF
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 17:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjGURai (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 13:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjGURa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 13:30:28 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B91E2706
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 10:30:17 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5839f38342fso7123017b3.0
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 10:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689960616; x=1690565416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cwSP5vL0D8ChpzCq31ya0welVHt+EV4+M7Nd3tHmdo0=;
        b=TF0xHfnMxVTd8i1ahqaOtSR4gHMKu5Kf/K43I1NPyjepxLdYWHFqxZzpQ6T8Amxa++
         mupYJvnRZ6g5cEsq4sIqrht0a34ltOWQOWo/RC9zWBCr+kvUkrQwLVZ1/caKxVXW6OaB
         gy00UjtmDJAh8P8HTry8BtNIska0RVjIk3AlgehenYuaT5ICWcA0lq0cfdmP1cX0/Ygf
         B2I0m9LxVJ892OMoag1JfYhtv4Z1gz2kUS6xAUhbZt3/X7Lr19QKKEewt+R7GIMR1cFg
         G/icB/e22NCHLImHia6yD4nbSjuhUrj+TjyG7fcEO1vrcCU3ym7hLlBWP2n4wYFTccAf
         N25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689960616; x=1690565416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwSP5vL0D8ChpzCq31ya0welVHt+EV4+M7Nd3tHmdo0=;
        b=kPHPPAHOpAZ9df3TmYu4cXM7IUBd8VdUHOnC/4Ck1Vg1Ol6ElBqZBuMvn93FubnENV
         fSapUGmVaNp/U53+Ibe7N+MAZo6dpfJgAszyQrjQPZWMx4WkoparIweA5KUyh+zYUl/o
         is0SIFccGQhN5dv8ZBvbLP4+ZX72Rtj5kfl9XdjhzeDfvAB1suRXFQqcu9/8LtOFZRor
         OCjh+BnHkKzhELlY9zQ+vl0Xskp015dcU4Z/dIiW58qwhCcqxjediBf/veiAVYNn6oWA
         nZeQSV6l2nx3kp6xP6fxCW/8R4FaNgOtvzZYWLuxjOZPZu1lb0LiiSOQ5rUKuXDJisud
         Ciow==
X-Gm-Message-State: ABy/qLYBwPYAp1J5aukfAsr53m0Oqv3iq760kwo5CjomVDvufwmEL24E
        VxI/6RIEUq+AbFFI/D9y5WCLDEiK8RlzA+w51Y2DHw==
X-Google-Smtp-Source: APBJJlGN8hLkqTLy86UKXo8mn7NqgdcZVS+LC0uDwh/kLsj3Cc2mKg0xr4Jc83reYDwiGpZG55rGyA==
X-Received: by 2002:a0d:de84:0:b0:576:777f:28bc with SMTP id h126-20020a0dde84000000b00576777f28bcmr733250ywe.21.1689960616465;
        Fri, 21 Jul 2023 10:30:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k185-20020a0dc8c2000000b0057a165e6ee1sm1014642ywd.35.2023.07.21.10.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 10:30:16 -0700 (PDT)
Date:   Fri, 21 Jul 2023 13:30:15 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/5] t/lib-commit-graph.sh: avoid directory change in
 `graph_git_behavior()`
Message-ID: <715a160903be6dc8873a7215c55f90894e62f589.1689960606.git.me@ttaylorr.com>
References: <cover.1689960606.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689960606.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `graph_git_behavior()` helper asserts that a number of common Git
operations (such as `git log --oneline`, `git log --topo-order`, etc.)
produce identical output regardless of whether or not a commit-graph is
in use.

This helper takes as its second argument the location (relative to the
`$TRASH_DIRECTORY`) of the Git repostiory under test. In order to run
each of its commands within that repository, it first changes into that
directory, without the use of a sub-shell.

This pollutes future tests which expect to be run in the top-level
`$TRASH_DIRECTORY` as usual. We could wrap `graph_git_behavior()` in a
sub-shell, like:

    graph_git_behavior() {
      # ...
      (
        cd "$TRASH_DIRECTORY/$DIR" &&
        graph_git_two_modesl
      )
    }

, but since we're invoking git directly, we can pass along a "-C $DIR"
when "$DIR" is non-empty.

Note, however, that until the remaining callers are cleaned up to avoid
changing working directories outside of a sub-shell, that we need to
ensure that we are operating in the top-level $TRASH_DIRECTORY. The
inner-subshell will go away in a future commit once it is no longer
necessary.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/lib-commit-graph.sh | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/t/lib-commit-graph.sh b/t/lib-commit-graph.sh
index c50553df0ed..c93969ae74d 100755
--- a/t/lib-commit-graph.sh
+++ b/t/lib-commit-graph.sh
@@ -20,12 +20,14 @@ graph_git_behavior() {
 	BRANCH=$3
 	COMPARE=$4
 	test_expect_success "check normal git operations: $MSG" '
-		cd "$TRASH_DIRECTORY/$DIR" &&
-		graph_git_two_modes "log --oneline $BRANCH" &&
-		graph_git_two_modes "log --topo-order $BRANCH" &&
-		graph_git_two_modes "log --graph $COMPARE..$BRANCH" &&
-		graph_git_two_modes "branch -vv" &&
-		graph_git_two_modes "merge-base -a $BRANCH $COMPARE"
+		(
+			cd "$TRASH_DIRECTORY" &&
+			graph_git_two_modes "${DIR:+-C $DIR} log --oneline $BRANCH" &&
+			graph_git_two_modes "${DIR:+-C $DIR} log --topo-order $BRANCH" &&
+			graph_git_two_modes "${DIR:+-C $DIR} log --graph $COMPARE..$BRANCH" &&
+			graph_git_two_modes "${DIR:+-C $DIR} branch -vv" &&
+			graph_git_two_modes "${DIR:+-C $DIR} merge-base -a $BRANCH $COMPARE"
+		)
 	'
 }
 
-- 
2.41.0.381.gd8424d64777

