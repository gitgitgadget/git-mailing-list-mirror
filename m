Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449E8C43469
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 11:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12C5B20EDD
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 11:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbG11VtX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgITLWq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 07:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgITLWk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Sep 2020 07:22:40 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95760C0613CF
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 04:22:40 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id u3so5465198pjr.3
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 04:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gfpWlT4sg5lq1KMppHolcjV1QEI4dUWXY/Lsv3SmB6o=;
        b=gbG11VtXMGK+8oo149uMVi/g70OLzzinb0RrO/+V7HaZIuaOjsiTlmJrnoGhHXf5xe
         3ClvQKvYfh05DxQ520kmY6L6psvJzOGRct+VHR0zazwSr21G6EMaOe+b/T+K7B0WQddF
         sWhfuPG3BkKPgo19CvnqlNasUYbdAw7sC86U3ThzuuKECeIU7o4ClGHgkgAX5F4TqXh5
         D0M3Bzn+PUcl08NihzMwRCk1dpjzbQ8GJiQKFak/QrihmfQ5xabw1niItpyGkHL84/xN
         441bYY4Grya63bwslqrW7jN62xzYFDE7qQKJJjDLbEdPEQA90I3SxMbhaMfxA49ap5YI
         1h6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gfpWlT4sg5lq1KMppHolcjV1QEI4dUWXY/Lsv3SmB6o=;
        b=mocV0r/sRBUiWUET8OnNyVcWRlNnGysBBOkTW5M3hrPptjpwFOCKeppxNVJIxoKFXX
         dUbgd3HBFpG0jiTg+h4XNK0KJi6q2VklFZEtlXh+EW5KD3yq4HKbGEJ/ldyduqRWC0GF
         Js3DAmFxFDQARnit4QolxnVTNXSyEvipJNGOb1En/TytHkkYzNAh6nBBBpdvI28ASAEc
         sPZDVbmw27EgueaG8xudCmXerbb4vqw7gh8EsqDXy+v6f/+jzXPZoXjyYPFANrK/o9ET
         I/s7bnM5+siYuG0w5ijhcllghFrz2LcD37iSXrniG6fZJaQeO/tF7yeQv/DQRcwhwGUT
         4/Kw==
X-Gm-Message-State: AOAM530FzzIJXrrfR+zgt79hMx/lMafRffImR0sJxxxSijyipUNqdxUd
        4xfPqn5YX/T6dL158P2AMZ8rqXMDMEA=
X-Google-Smtp-Source: ABdhPJyTIZDPx7z4E/ucAqgvg98SAYpKovAGmLDXHnsvA+Baa8VX/INqP618x9XE1K9lSLMi5bToCw==
X-Received: by 2002:a17:90b:e01:: with SMTP id ge1mr19758264pjb.187.1600600960004;
        Sun, 20 Sep 2020 04:22:40 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id y79sm9550737pfb.45.2020.09.20.04.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 04:22:39 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 04/10] contrib/completion: extract common diff/difftool options
Date:   Sun, 20 Sep 2020 04:22:21 -0700
Message-Id: <1ac84595419d8d1ecd8129395c3261ebca643bc2.1600600823.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.760.g8d73e04208
In-Reply-To: <cover.1600600823.git.liu.denton@gmail.com>
References: <cover.1600328335.git.liu.denton@gmail.com> <cover.1600600823.git.liu.denton@gmail.com>
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
2.28.0.760.g8d73e04208

