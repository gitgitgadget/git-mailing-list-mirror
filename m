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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B49BC48BC2
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 12:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33B4B61C20
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 12:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhF0Mid (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Jun 2021 08:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbhF0MiX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jun 2021 08:38:23 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AB2C061766
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 05:35:59 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id p8-20020a7bcc880000b02901dbb595a9f1so9066094wma.2
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 05:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lfbYbfzHd+Vf6Fe8m7hXH4Krc1XXpNy92hpUxXnxmLQ=;
        b=rPVHFk6wi0mjmIiswFUAt0trekAVHSDrZUSUWCalhHBdOJQVPgey9ulqKsUvopyCSt
         KHvj+k8TgqtXt414qo0qa7zN4YknTpNHjMD41NT1rW/rQLT0tvuNuEDYPvDPwAQRF5m/
         g7BW9MkwavsrbOtHV2/NKZRYLgb3ANS18KZ7di8cPXpTYY22lH11xxWrGiwbW6CZFMfk
         AgppUUr8ijwtFIwlqtMzpC8VPYBMkqzTdRCEQIiKrssGu16oXdgW3Q2clL71r2VK7HDw
         yDa/Oy8E6lx68gUjvMye4l9BYuSu8EuWAU/234FcWYRBOuvpfFoTtz2IpRGSr0TD9gVm
         h6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lfbYbfzHd+Vf6Fe8m7hXH4Krc1XXpNy92hpUxXnxmLQ=;
        b=EnGsBdlQRAw6QuecYkkPNF0TPFXoh/hjQSJrRlABQBVMpPNF0S2D42/URDmwJ5oOjm
         mYJrAYbYhuA7xPx71UaHH7OKKKiL4RT7aftafTFk7cE24W4KU3xtTHiy9dhYz8N4FPyA
         ZK66FI6qRdaWl73iFFfdRBclfUiSBtz7qO6R8A6sKYpVFsZB4L8WSK1BQLsgPchM20Xc
         5xga2WDdO//QE9sF/V0+DrMu1ytekE7gBaQi7zHq2fdQzfoJX88LiWnxtham0CET/DA5
         +RbFO2DFJ5Bw9GBYpB6ZhwpNQbdc01jp9EQDVGFV0u1YOZOmZvegv+nG+JH2Ovf/Rgz4
         EPeA==
X-Gm-Message-State: AOAM530275dK5tygEe8ha6t/d7pTKd9BpOqWv2h/Bltfr7mN9J07n3KS
        GCgHl2y37DrUWQZQigU98/9l9D5VLek=
X-Google-Smtp-Source: ABdhPJyjjxV2kwBEZcKw6tZT01DfqsDdlEt/8hTK0KWenuGcbPf/kXxzp1jdY5bv5PMaRFCXkkidcw==
X-Received: by 2002:a05:600c:5112:: with SMTP id o18mr20293647wms.15.1624797357794;
        Sun, 27 Jun 2021 05:35:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g15sm11084876wri.75.2021.06.27.05.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 05:35:57 -0700 (PDT)
Message-Id: <85686187d49500b9ac4afaf526f5031ff5842aff.1624797351.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.v6.git.1624797350.gitgitgadget@gmail.com>
References: <pull.980.v5.git.1624636945.gitgitgadget@gmail.com>
        <pull.980.v6.git.1624797350.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 27 Jun 2021 12:35:44 +0000
Subject: [PATCH v6 09/15] [GSOC] ref-filter: modify the error message and
 value in get_object
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Let get_object() return 1 and print "<oid> missing" instead
of returning -1 and printing "missing object <oid> for <refname>"
if oid_object_info_extended() unable to find the data corresponding
to oid. When `cat-file --batch` use ref-filter logic later it can
help `format_ref_array_item()` just report that the object is missing
without letting Git exit.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c                   | 4 ++--
 t/t6301-for-each-ref-errors.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 45122959eef..9ca3dd5557d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1749,8 +1749,8 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
 	}
 	if (oid_object_info_extended(the_repository, &oi->oid, &oi->info,
 				     OBJECT_INFO_LOOKUP_REPLACE))
-		return strbuf_addf_ret(err, -1, _("missing object %s for %s"),
-				       oid_to_hex(&oi->oid), ref->refname);
+		return strbuf_addf_ret(err, 1, _("%s missing"),
+				       oid_to_hex(&oi->oid));
 	if (oi->info.disk_sizep && oi->disk_size < 0)
 		BUG("Object size is less than zero.");
 
diff --git a/t/t6301-for-each-ref-errors.sh b/t/t6301-for-each-ref-errors.sh
index 40edf9dab53..3553f84a00c 100755
--- a/t/t6301-for-each-ref-errors.sh
+++ b/t/t6301-for-each-ref-errors.sh
@@ -41,7 +41,7 @@ test_expect_success 'Missing objects are reported correctly' '
 	r=refs/heads/missing &&
 	echo $MISSING >.git/$r &&
 	test_when_finished "rm -f .git/$r" &&
-	echo "fatal: missing object $MISSING for $r" >missing-err &&
+	echo "fatal: $MISSING missing" >missing-err &&
 	test_must_fail git for-each-ref 2>err &&
 	test_cmp missing-err err &&
 	(
-- 
gitgitgadget

