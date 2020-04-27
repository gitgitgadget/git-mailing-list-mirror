Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DD4C54FCB
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 16:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C794206B9
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 16:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="gfxas3gB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgD0Q2M (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728287AbgD0Q2K (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 12:28:10 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85226C0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 09:28:10 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x2so5530777pfx.7
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 09:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8F6KzhXqp89RdN6V0M3p1ls0KC1woOV4+YC8Rtgpbso=;
        b=gfxas3gBGy/h19fWbt6vjUJkAITw44LDkQ3aanc2agknWG1ZuTELXD+PRkGqVm6c8T
         uoLOaTGBSpm5bEXHU7bSD6oPne/fDEKO4TB+CJ7QPb7+LaUqlvTwJ6hHGEh+Ru61dUNZ
         T950NjCptbM4fC5VYeaumg6SnxnNHrUwuzL6R4J66oTML34NiIUEmB1K8D0Ki6myW8Kh
         U/+13xzL2/3+Aq0/SiSus66as8aB2WnvJ2zYwW36dvtZRAgsc+Q87QUUQxn5SzoqdjKz
         7ZhtBqxwF56jHkTnUOrOzkhkQvf5vM/983EdAgjX7XW3NL1nw2Bp4XfsYu++KNGcO2eZ
         +aCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8F6KzhXqp89RdN6V0M3p1ls0KC1woOV4+YC8Rtgpbso=;
        b=cyaPN23H0FWdX5Ltg7C2/MzBMQa9nJWyJt/lOBku3Ng9Ze4xvuPezDF2RaW2b4vYgx
         i3znw88x/MdHQ25Bx6Uw/47YWmq/A7VsU9pa1sfPLypOZcCxtGD1AyGGo7wWGzoQC2MM
         k/iKNYg1RoApA7J7wLhglbiBjkOeu/HbdooNryxR/wv1zLv49jHgGLXDUmwNcbmKeS70
         67VL0ag/EoKpHyqg+mQ+R1UW8zw/oFz7IeLmIlY3i5KS7WjEAyThcQBAh6+qElt0Nhd8
         xqZai4kLvgcT2+A+4xmcM2KW2dhOSmkijZCf7Rtw/pHFYjGsOa7S4za0VgKrU1Pte+jr
         UG0A==
X-Gm-Message-State: AGi0PuYSvRE4Q9u3xxd+Vefz9NurmOi5+xzG4+K9O9av2tPKCJpJcZ8Q
        9xjfufesPs00MKgdAoyTC7t59eNBnMblHw==
X-Google-Smtp-Source: APiQypLCmAuE3VHrVhHY+K7/vd3XoHrCCTmG5xwEWTuw8aPyueMAYO0m9WmrlwDeJU2F3suq0CrlpA==
X-Received: by 2002:aa7:9ab3:: with SMTP id x19mr24439155pfi.141.1588004887136;
        Mon, 27 Apr 2020 09:28:07 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id 128sm12498330pfy.5.2020.04.27.09.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 09:28:06 -0700 (PDT)
Date:   Mon, 27 Apr 2020 10:28:05 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        mhagger@alum.mit.edu
Subject: [PATCH v2 4/4] commit-graph.c: ensure graph layers respect
 core.sharedRepository
Message-ID: <f83437f130812d172167d335ba2d13b1545a9f58.1588004647.git.me@ttaylorr.com>
References: <cover.1587422630.git.me@ttaylorr.com>
 <cover.1588004647.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588004647.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Non-layered commit-graphs use 'adjust_shared_perm' to make the
commit-graph file readable (or not) to a combination of the user, group,
and others.

Call 'adjust_shared_perm' for split-graph layers to make sure that these
also respect 'core.sharedRepository'. The 'commit-graph-chain' file
already respects this configuration since it uses
'hold_lock_file_for_update' (which calls 'adjust_shared_perm' eventually
in 'create_tempfile_mode').

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c                |  6 ++++++
 t/t5324-split-commit-graph.sh | 18 ++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 5b5047a7dd..d05a55901d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1386,6 +1386,12 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 			return -1;
 		}
 
+		if (adjust_shared_perm(ctx->graph_name)) {
+			error(_("unable to adjust shared permissions for '%s'"),
+			      ctx->graph_name);
+			return -1;
+		}
+
 		f = hashfd(fd, ctx->graph_name);
 	} else {
 		hold_lock_file_for_update_mode(&lk, ctx->graph_name,
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 53b2e6b455..61136c737f 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -351,4 +351,22 @@ test_expect_success 'split across alternate where alternate is not split' '
 	test_cmp commit-graph .git/objects/info/commit-graph
 '
 
+while read mode modebits
+do
+	test_expect_success POSIXPERM "split commit-graph respects core.sharedrepository $mode" '
+		rm -rf $graphdir $infodir/commit-graph &&
+		git reset --hard commits/1 &&
+		test_config core.sharedrepository "$mode" &&
+		git commit-graph write --split --reachable &&
+		ls $graphdir/graph-*.graph >graph-files &&
+		test_line_count = 1 graph-files &&
+		echo "$modebits" >expect &&
+		test_modebits $graphdir/graph-*.graph >actual &&
+		test_cmp expect actual
+	'
+done <<\EOF
+0666 -r--r--r--
+0600 -r--------
+EOF
+
 test_done
-- 
2.26.0.113.ge9739cdccc
