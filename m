Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59826C433E1
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 15:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36DE6206A4
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 15:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzKD4QXk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgFKPPR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 11:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728425AbgFKPPP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 11:15:15 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A40C08C5C2
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 08:15:15 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x13so6570117wrv.4
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 08:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=h8MOdG5ScNHrk8SrMGWVSBQUlVk0ldpdLpEf4d/7LXw=;
        b=DzKD4QXkuLMopa2uMPHVAh/+T+FTGFVKhwKbgciHAL1qfq1BYZ5/Tu8bxF2zxy+mpe
         zN5d02lXX8Moe9gZEYyhTjHRGJNYf8Zt2+1HVUQoSraeCA4ECwr8QNRL41V8uRKv6ufY
         qPpc85B41Nd0iGloZA9zXcNGGKjLlBqz/tuqDenkQjoZLgqIVPkdz/f/Agu6e3Clqu8V
         EZ4PE2AgrHDgiSA12Uknb3D4Nn89ViklK2LNNe8iMyj5+WpAiSVsfGNa31rlK8PSdc0r
         j5y8Frr+6L3ZS84HGP+ii69LKzXyUoHC7y8zdLV5y6H8qb0Qc5k6FNnYCaVJpuzDbROo
         21Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=h8MOdG5ScNHrk8SrMGWVSBQUlVk0ldpdLpEf4d/7LXw=;
        b=Y7gDSBGqAAIjXn3P2HSp45edcyJ9HJmbDxRQRO7faYHTVsr/+nXYe7gD4Wo2UPXhBq
         L13nP6bMZP7/e578A+be+gSXLM/D6rfOo/zO+oFW5Ng2xX44nvD93cfu92VOjLS4HSl1
         SKhZWxIqRSLOIzbCSzF1Z0CZehu8KWCJGyT8QTfcQBEnLriCAn6seNS2O0OPCgyOnhs+
         XszmybCOhURydj2yN0JOhD3DtBLLtKVqcg9ONOWXc/Idhirkl+pZryeoL8sfCC9q1doi
         fKV588yRLt9p4t8rQiZYuhbQAmbua6jst0V74+LmpyOJYzdtB0hsLz/hLdxShW+8xVCm
         S/Dw==
X-Gm-Message-State: AOAM530r8LOV3R8LMlgU+rqFzUvZY1CJqGwVwRlilROvgP0MooFAemUU
        eO5feyh+sgJsC89C3WFxkMdmN8sS
X-Google-Smtp-Source: ABdhPJylbsv+hEJRQkA5xuXGrx7LhTHgjw1kXm/cSXPsybnPcSODgF8LKNdlv9BLtlWVetf9ho234g==
X-Received: by 2002:adf:e3c4:: with SMTP id k4mr9928396wrm.262.1591888513657;
        Thu, 11 Jun 2020 08:15:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 23sm4784750wmo.18.2020.06.11.08.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 08:15:13 -0700 (PDT)
Message-Id: <2ccaad645ff01b786e76dc63210d75da633389a6.1591888511.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.804.v3.git.git.1591888511.gitgitgadget@gmail.com>
References: <pull.804.v2.git.git.1591729224.gitgitgadget@gmail.com>
        <pull.804.v3.git.git.1591888511.gitgitgadget@gmail.com>
From:   "Chris Torek via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 Jun 2020 15:15:08 +0000
Subject: [PATCH v3 1/3] t/t3430: avoid undefined git diff behavior
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Chris Torek <chris.torek@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Chris Torek <chris.torek@gmail.com>

The autosquash-and-exec test used "git diff HEAD^!" to mean
"git diff HEAD^ HEAD".  Use these directly instead of relying
on the undefined but actual-current behavior of "HEAD^!".

Signed-off-by: Chris Torek <chris.torek@gmail.com>
---
 t/t3430-rebase-merges.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index a1bc3e20016..b454f400ebd 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -420,7 +420,7 @@ test_expect_success 'with --autosquash and --exec' '
 	git commit --fixup B B.t &&
 	write_script show.sh <<-\EOF &&
 	subject="$(git show -s --format=%s HEAD)"
-	content="$(git diff HEAD^! | tail -n 1)"
+	content="$(git diff HEAD^ HEAD | tail -n 1)"
 	echo "$subject: $content"
 	EOF
 	test_tick &&
-- 
gitgitgadget

