Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27973C433E5
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 21:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 062DC2053B
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 21:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9jxWtMT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgHOVyH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729135AbgHOVwi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:38 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E0FC0068C6
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 10:17:52 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id i92so6561248pje.0
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 10:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=caKEKWGdKp+5Ap1E012huXnjXEaCWna2Ltkuc1hh8KE=;
        b=U9jxWtMTVcY+gmsz5Cw+PX+5/chgF5F1ju3P99m/QyrxFqnuDtMNqqWBM4+CJST8tb
         Vr7S6dE+5QtGLqIspOmwOIK+26rzBuhxe/NIJ28qcbDZG+S/BXgWGNP7CAj5I14MfG+C
         c0vENllxhTbchixaH4urD4XwBYS3A2o4+KdM1+wOPrnt2UAqzgz64ojPhcp9itx1UBJr
         giGSnZLly3iRf2ABQKDHkzU9G8t9aZucSjs5RsKaoV7SutBgPxpfBA4RZGFbhi7vm+A/
         vuJdBRs6Q8N7mii+B1tGMx3d2Rst45Pmqor5LcHAbkWHRz1SDrdTg1bJU6hHgpdaDT+o
         3Dbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=caKEKWGdKp+5Ap1E012huXnjXEaCWna2Ltkuc1hh8KE=;
        b=CDES59cTgjNHRt2zwRAFEe+1E6xO8eqXCadoYmpyR16lEociBhhn3zDgSoYQbGHLE8
         M/lW8cNEB2fU/AFBm/Aa1BkTuh+KQvw5FygsVIyZKYy+UChOzm6ybgvfEOR72iTt3Qiz
         W/CWnNnyFm6aLSw1QGFejWNojKLf2tZpoX/vxOqd1dwWNGWvEfRGN8RZquUHT8sfkmPY
         3bYNBo+uvbAtcDRWX+8PVdKSoakKMrIq+w4CG/q7R0dd4i9HXquxL04vFD68DZlpfpHN
         JTiTqoQPwi5YVV9woWdFVmBubQCay9yaKzpq1KBaINXmVZaO3+FDM5gGC3VVCZIibO7M
         G//g==
X-Gm-Message-State: AOAM532SpbVVU97nXDJPnuMnVwbls6aHQuhz9cG/sRiDwxE5RtiZBx94
        ATYDY33bb8HcRh/Nm9mSRW8=
X-Google-Smtp-Source: ABdhPJxq84sptUz3FCs5WAQ6EOujhFNDUj2YuIqXq2+rTvT7/tYEpV6glhnkM6Tk3IzcuheDzq9eeA==
X-Received: by 2002:a17:90a:8d0b:: with SMTP id c11mr6735463pjo.196.1597511869497;
        Sat, 15 Aug 2020 10:17:49 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id x13sm11040596pga.30.2020.08.15.10.17.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Aug 2020 10:17:49 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v17 01/10] transport: not report a non-head push as a branch
Date:   Sat, 15 Aug 2020 13:17:31 -0400
Message-Id: <20200815171740.6257-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200518094039.757-1-worldhello.net@gmail.com>
References: <20200518094039.757-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

When pushing a new reference (not a head or tag), report it as a new
reference instead of a new branch.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t5516-fetch-push.sh | 2 +-
 transport.c           | 9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 36ad20a849..d11382f769 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1039,7 +1039,7 @@ test_force_fetch_tag "annotated tag" "-f -a -m'tag message'"
 test_expect_success 'push --porcelain' '
 	mk_empty testrepo &&
 	echo >.git/foo  "To testrepo" &&
-	echo >>.git/foo "*	refs/heads/master:refs/remotes/origin/master	[new branch]"  &&
+	echo >>.git/foo "*	refs/heads/master:refs/remotes/origin/master	[new reference]"  &&
 	echo >>.git/foo "Done" &&
 	git push >.git/bar --porcelain  testrepo refs/heads/master:refs/remotes/origin/master &&
 	(
diff --git a/transport.c b/transport.c
index 2d4fd851dc..19b033dc6a 100644
--- a/transport.c
+++ b/transport.c
@@ -499,9 +499,12 @@ static void print_ok_ref_status(struct ref *ref, int porcelain, int summary_widt
 				 porcelain, summary_width);
 	else if (is_null_oid(&ref->old_oid))
 		print_ref_status('*',
-			(starts_with(ref->name, "refs/tags/") ? "[new tag]" :
-			"[new branch]"),
-			ref, ref->peer_ref, NULL, porcelain, summary_width);
+				 (starts_with(ref->name, "refs/tags/")
+				  ? "[new tag]"
+				  : (starts_with(ref->name, "refs/heads/")
+				     ? "[new branch]"
+				     : "[new reference]")),
+				 ref, ref->peer_ref, NULL, porcelain, summary_width);
 	else {
 		struct strbuf quickref = STRBUF_INIT;
 		char type;
-- 
2.28.0

