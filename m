Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED45C433DF
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 19:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1AAE208B3
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 19:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvzYJYBk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbgFPTUs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 15:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728861AbgFPTUr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 15:20:47 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6386C061573
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 12:20:46 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id b6so2809002wrs.11
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 12:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=T+voneQ0Whz61s3+JQuey70k8Ow9ROVzOJ6Axj3DAC0=;
        b=AvzYJYBkir26Utl1UMMJgXy7Y1kp2fVhaleIdar82W7R3t2fBuyTblxy31qVs9IKOF
         vNNfbKXhR1XSFkm0oRYF/ikG47rr7Gwh9jvaBtLf7eHmgq1Q4Tn9pgw+GZwH3pMPwqCx
         foJ+WX/dfNUvoCBOajhEKDn00NnSkp32cvhd5CDRXf4qJbD9/vjA8NH69EXmwCbed6Va
         qCF3In7TjivQCgw2gMPW0eQy/mU6RyrCexSlRvKljInbXKwBfX9eGrP9HAoCU4zrCX3X
         0FrMF85uKHmBLnEz2S5gnjEkUWE8URJXLNNzMvMLv1XY2Ha8xKLujzqjCPk6/fMyVBqG
         p+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=T+voneQ0Whz61s3+JQuey70k8Ow9ROVzOJ6Axj3DAC0=;
        b=GTUxZ7OBKxXLOgHdNg83sh2I99lC5RrP3VynkVj+Xq+Ywh+GzUIjZiRJ5gg3nnK23y
         F29EDgvEcQ3d6WTkX6wzjOk68ityHIkGecrUwDCU2sU6Lajojvt2oWHMx+5DoXWXbu0e
         jVihr0h+C7MKAUhhv08TH+Kk7dUvka0QhCb0Kzu5Ih2EBy35uVAwBPI90dcIC4sO0GgM
         RBYSdAkHCtW6Gc6VoVHGJl+6k8hJXNT7lJfo9izj5gwiJgSrCs4Ftk2xJQpIwpOGK/we
         4ggHrFUhCeYkZAEe7vMywRwd5oTWEgrxIqbQK+69cSfG42n/LH9KQbgtCXxfqY3+oQSB
         j6bQ==
X-Gm-Message-State: AOAM53096KrnJCBwnzSq4r3vkDr9xgIm8dLJiAQYepC6sOiU2uVDxyMw
        8q84Akm6kcXD64ILVhD6dUhbpb4y
X-Google-Smtp-Source: ABdhPJzZ6ysTdietSvCPXuq7u/J+p6gxlgn4Vnnh5Q8y0WennCUnXqo19QvnRbZpm9Uh5Tfrk6ZNbw==
X-Received: by 2002:adf:f389:: with SMTP id m9mr4311735wro.195.1592335245545;
        Tue, 16 Jun 2020 12:20:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d63sm5566385wmc.22.2020.06.16.12.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 12:20:45 -0700 (PDT)
Message-Id: <8304c3d63797613ae6e4b5e4529bd5cfc7137264.1592335242.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v17.git.1592335242.gitgitgadget@gmail.com>
References: <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
        <pull.539.v17.git.1592335242.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Jun 2020 19:20:26 +0000
Subject: [PATCH v17 01/17] lib-t6000.sh: write tag using git-update-ref
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/lib-t6000.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/lib-t6000.sh b/t/lib-t6000.sh
index b0ed4767e32..fba6778ca35 100644
--- a/t/lib-t6000.sh
+++ b/t/lib-t6000.sh
@@ -1,7 +1,5 @@
 : included from 6002 and others
 
-mkdir -p .git/refs/tags
-
 >sed.script
 
 # Answer the sha1 has associated with the tag. The tag must exist under refs/tags
@@ -26,7 +24,8 @@ save_tag () {
 	_tag=$1
 	test -n "$_tag" || error "usage: save_tag tag commit-args ..."
 	shift 1
-	"$@" >".git/refs/tags/$_tag"
+
+	git update-ref "refs/tags/$_tag" $("$@")
 
 	echo "s/$(tag $_tag)/$_tag/g" >sed.script.tmp
 	cat sed.script >>sed.script.tmp
-- 
gitgitgadget

