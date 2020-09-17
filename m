Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EC5C43461
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 07:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FCD5206DC
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 07:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tg6P5APr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgIQHph (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 03:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgIQHol (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 03:44:41 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF863C061788
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 00:44:37 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id y1so868556pgk.8
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 00:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZYqdZNkC2obKcgZewbiD+Abk/bCuuK7TokBtxHeU/lo=;
        b=Tg6P5APrUZ47Bi1VCtEg2nwoWlBAJJ7f6hEU01fxpY1ps1N6lhJ/VpNEAmRI32ko4w
         H3FHRdf04i2t+6sXdEd5XbeEEUN82aM55fzXEfabdFzcXWQ5aX/NzhD+FR7gRnsi05fi
         jvvoEdi8uUy1o/V2Dqt/Z3lNGf/9aLvjJcNeJjKwa2nJ0C37dHbHuZIFUtQB/UO1M4bY
         BKxgLvwOoKuLNuEueR28UZ4hEfGh0IrbIV0CVBrX/6RSY2NZCT/IU573zCldH5V+mouO
         H5eO0Nz9w1MONI3BjWOVnI1JBvdmEmAb8PfeJn9w4NcWgC2wFeG/M0nysT70eJ1i4zA8
         Yh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZYqdZNkC2obKcgZewbiD+Abk/bCuuK7TokBtxHeU/lo=;
        b=MS/oxFY+W7PgvXvp+4uzEQbOP30aq20r8GpCuk6ikobHHhfoG4VzJvDY+P1CPKcrcd
         waMrB5amQo2ejQH6o5vhdYS857B17rQrIytH0uBfkiUNoClhw9R9TCzq/17hAthhMdkc
         Oohryh6CHJznOHGGJLKuKO9qth0xjNvn6PpY8SuWhZW60xuWub+RmzJDQYHsOoF2f+YM
         WeRaCmu5sohCZSn42EVkFZdq9RubY2KQZ/i5dUOVFFFK2KP2HnBMZhA1SdIsnsnRHZTf
         4kZxdmgqAeXmq/mGq5PSQLNA+Xwq8SN8XigoZZtldY+arUMTDtMFnBdkuJZrD2wriRlH
         CrGw==
X-Gm-Message-State: AOAM533EPxsy2Y6U3wHc/m/bvp7mxk29EniLvjgOEb8SW4WR+EXv3+Bn
        7foyPLRBorCcGjIe8RvUxLgRV1s9CzEmpQ==
X-Google-Smtp-Source: ABdhPJzyCVF78GtclGgxMC5Tn+MoueNa0khajxRTC+BxzJXorFJoAYGdHU6j3zncrGrev8f/KZ9iNQ==
X-Received: by 2002:a63:f342:: with SMTP id t2mr21807745pgj.313.1600328677262;
        Thu, 17 Sep 2020 00:44:37 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id j9sm4931711pfc.175.2020.09.17.00.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 00:44:36 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 04/10] contrib/completion: extract common diff/difftool options
Date:   Thu, 17 Sep 2020 00:44:08 -0700
Message-Id: <1ac84595419d8d1ecd8129395c3261ebca643bc2.1600328335.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7
In-Reply-To: <cover.1600328335.git.liu.denton@gmail.com>
References: <cover.1599723087.git.liu.denton@gmail.com> <cover.1600328335.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

difftool parses its own options and then passes the remaining options
onto diff. As a result, they share common command-line options. Instead
of duplicating the list, use a shared $__git_diff_difftool_options list.

The completion for diff is missing --relative and the completion for
difftool is missing --no-index. Add both of these to the common list.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 contrib/completion/git-completion.bash | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9147fba3d5..f68c8e0646 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1691,6 +1691,10 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--textconv --no-textconv
 "
 
+__git_diff_difftool_options="--cached --staged --pickaxe-all --pickaxe-regex
+			--base --ours --theirs --no-index --relative
+			$__git_diff_common_options"
+
 _git_diff ()
 {
 	__git_has_doubledash && return
@@ -1713,10 +1717,7 @@ _git_diff ()
 		return
 		;;
 	--*)
-		__gitcomp "--cached --staged --pickaxe-all --pickaxe-regex
-			--base --ours --theirs --no-index
-			$__git_diff_common_options
-			"
+		__gitcomp "$__git_diff_difftool_options"
 		return
 		;;
 	esac
@@ -1738,11 +1739,7 @@ _git_difftool ()
 		return
 		;;
 	--*)
-		__gitcomp_builtin difftool "$__git_diff_common_options
-					--base --cached --ours --theirs
-					--pickaxe-all --pickaxe-regex
-					--relative --staged
-					"
+		__gitcomp_builtin difftool "$__git_diff_difftool_options"
 		return
 		;;
 	esac
-- 
2.28.0.618.gf4bc123cb7

