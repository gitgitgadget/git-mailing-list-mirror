Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A9DC43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5CCF21655
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wxh5fnM5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbgIPSLa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 14:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbgIPSLP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 14:11:15 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6115C061797
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 11:10:59 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e16so7905131wrm.2
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 11:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Iaubz4Z5RCnlOaRNxePs2n3D8EJw5yieWuKUtsG0RpQ=;
        b=Wxh5fnM5iT21cB9Gz44citR+6rtW/h67G/m7e8bGFr9QSizsU7CMRYs3J0AiPMBHZ/
         SMIdEA5F5cupFp4viCIi/kiXkOH+PLFauOFAW0crGX2L0gr0GDzTQazkshjSe0jrZH28
         PoT2rusWWOZ8mvq5lq63JXH2ZJE475jjLEUVyJB3nTm5ZRaKWuvh5g3hV8zcGcHPSGWw
         UE9rlPSUN4cWhy/CLKc2dT8bYNny1OTDw/ttP/FFURSZIAxCz0tmpkbz2Op6XG3KgB8o
         0v8phLn8K0IDLklqEOi7yqdMHmJvJ6nQzvcw5xqsiqIRFNXlbCwLWcmq6BXQve2125j8
         2NGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Iaubz4Z5RCnlOaRNxePs2n3D8EJw5yieWuKUtsG0RpQ=;
        b=rSQdkxxeuxffLMgKMcySc4ZY7LGL9DU5WP7M17bQpGCFGqD52SYLP3bvlWb4myKwZx
         sCzabus8GgFTeS+6Gbh+CpqpzjTZE+idSM//IA2kUUyhUao/QGcoFWO7gUzCcKbN8RlU
         9yCvCxS3JCx+f/0/g5WL56rULCsjNwTmJLA0CtLVQOU/sAhIwZvf9OnAzVYVsB5tm0YR
         EE6JOYzSjxPS/YJuVWEEGNATtdRazmXHlDgTmyjhg0xh1S3qdVjxtKMRbcx42fH5zXGB
         dxubLoR2i7EWVb7fGjz06e+xm/fbOAIs8XbZrm7c0xa4DUib+x8Zu8F5GyexVS+VL/W4
         zwJQ==
X-Gm-Message-State: AOAM532/Af/WLmLS5yEUk48R8lXU1Ycs3LZ0vr2CKyL0qqdMFD7q4qrQ
        Dcbe1yQZzsedlBsJ6UsbtVR75ZBcbLM=
X-Google-Smtp-Source: ABdhPJxMVGryu+Xi0vjzFS2vXbnEbwzuIY40rQBgoaeZFbgFDCcit0QIT0IJWxJt7qh3fo779O9c9Q==
X-Received: by 2002:adf:8481:: with SMTP id 1mr27200129wrg.231.1600279858260;
        Wed, 16 Sep 2020 11:10:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d18sm34460921wrm.10.2020.09.16.11.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 11:10:57 -0700 (PDT)
Message-Id: <d135a8423ba1dfd4cfc1208174e18786372fcf6d.1600279853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.734.git.1600279853.gitgitgadget@gmail.com>
References: <pull.734.git.1600279853.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Sep 2020 18:10:53 +0000
Subject: [PATCH 5/5] t9902: avoid using the branch name `master`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The completion tests used that name unnecessarily, and it is a
non-inclusive term, so let's avoid using it here.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t9902-completion.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 8425b9a531..7b7bc6e4bd 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -542,37 +542,37 @@ test_expect_success '__gitcomp - doesnt fail because of invalid variable name' '
 '
 
 read -r -d "" refs <<-\EOF
+main
 maint
-master
 next
 seen
 EOF
 
 test_expect_success '__gitcomp_nl - trailing space' '
 	test_gitcomp_nl "m" "$refs" <<-EOF
+	main Z
 	maint Z
-	master Z
 	EOF
 '
 
 test_expect_success '__gitcomp_nl - prefix' '
 	test_gitcomp_nl "--fixup=m" "$refs" "--fixup=" "m" <<-EOF
+	--fixup=main Z
 	--fixup=maint Z
-	--fixup=master Z
 	EOF
 '
 
 test_expect_success '__gitcomp_nl - suffix' '
 	test_gitcomp_nl "branch.ma" "$refs" "branch." "ma" "." <<-\EOF
+	branch.main.Z
 	branch.maint.Z
-	branch.master.Z
 	EOF
 '
 
 test_expect_success '__gitcomp_nl - no suffix' '
 	test_gitcomp_nl "ma" "$refs" "" "ma" "" <<-\EOF
+	mainZ
 	maintZ
-	masterZ
 	EOF
 '
 
-- 
gitgitgadget
