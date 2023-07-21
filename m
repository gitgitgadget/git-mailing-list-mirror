Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D7BC04A6A
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 17:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjGURao (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 13:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjGURaf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 13:30:35 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B0430F0
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 10:30:25 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-577497ec6c6so26100467b3.2
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 10:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689960625; x=1690565425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bil8lHwhByzVr8aKH8ewLU5EGBgpfst/5j28hi0mBc0=;
        b=WyNy3mtLpeD1Q9DjVvI4Xth+0p2WxoyX4ZuGoNweH4GMszKAOXyQhdBIZX8kldUrXu
         ARrIKyDvr0uuWG5ZIicX1svu7AuzJ4NAWmnw3UhM4bMv6EI3SVcNXZZjFaHxlD52oAaq
         d2CrF6DuKJiP0QiSZHscUt8JbIa1rea1w5MJwGKGnU89X4ioW3H/ppt37kwoJVoHciR/
         NDC+7Rah606gRmF6afF8hHvVtnObpQ6EmCabrOxndRUNHwHirhrwd107/cKT+m4qPkrc
         TbKD5uWY1Txr5J1TbHCPuGNoMzPBADd+HM2VaODXW75rWr9E3QVSs5G0bCZwMPt2OPMJ
         yjdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689960625; x=1690565425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bil8lHwhByzVr8aKH8ewLU5EGBgpfst/5j28hi0mBc0=;
        b=QowH+ZSXcXFBf0QE+mMTyRpHpWNnlRskummii0XXTrs9CeLzVD/5F079XYZGaHo+TS
         1nAfC0upDmqT/EELglUiuReMJyBb6txT/ITM3epggkCCEav4ix0ZTssm48+mCKKdBocQ
         5BWn62UD/Qi0WltHbLwsFyL5bbbGlJ3EQ09efb+QKEYwIOljU6eYcHWxG3FOBZOTHnAw
         1O/gY5C9C7u67E2btj6hrQq9rhIhZaAJZco2wYKL8s+3UDwhP1lJ4IY+Vy+o5kpawO7P
         4YqIre3vLRR5T0H2cZrphA+BluyBWyJS/UsOYsldRtEevKjGUEB4WYYQcmt8DwjL746t
         R5QA==
X-Gm-Message-State: ABy/qLYDjlW7mol5O7RfBPYcj5OGuK4K52uAbrZgGTk1oVx19Qs4qiVC
        FEWAUXGFN2sgtuFWauKuxBwfA+GWsS+ywpxQkfQpkQ==
X-Google-Smtp-Source: APBJJlHFsaq5Av6H+PF7QWeWWTrHhhnP/nr8llCWVcjGjANeQEE/PDfMYC/ZJYiIjupAroHUgE0aGQ==
X-Received: by 2002:a81:7bd6:0:b0:57a:2e83:4daf with SMTP id w205-20020a817bd6000000b0057a2e834dafmr672158ywc.32.1689960624798;
        Fri, 21 Jul 2023 10:30:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h185-20020a0ddec2000000b0057399b3bd26sm1018275ywe.33.2023.07.21.10.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 10:30:24 -0700 (PDT)
Date:   Fri, 21 Jul 2023 13:30:23 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/5] t/lib-commit-graph.sh: avoid sub-shell in
 `graph_git_behavior()`
Message-ID: <c3432f27b94bbd72d3e721bfede94d158acd20ae.1689960606.git.me@ttaylorr.com>
References: <cover.1689960606.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689960606.git.me@ttaylorr.com>
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
index c93969ae74d..b7b52b4291b 100755
--- a/t/lib-commit-graph.sh
+++ b/t/lib-commit-graph.sh
@@ -20,14 +20,11 @@ graph_git_behavior() {
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
2.41.0.381.gd8424d64777
