Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AF7C433E4
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 22:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA6962075D
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 22:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrBzWdD8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgHJW32 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 18:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbgHJW30 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 18:29:26 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33626C061787
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 15:29:26 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 3so1025696wmi.1
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 15:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7LB9Gvzf99PL3pycT84UZuRRyFKy1dC7nI933Lle8sI=;
        b=mrBzWdD87o+a2qQGS3iWkQdEtylf1pogphyAo+MWnoKD6D30kt9pIhQBRuKrryOwtr
         Guu4r6HyGXNidOg3BCpCnfaud2OpPlhDvMKmrSSnE7O6agDVXqHs7wDfxFDYdcEAP+L3
         xXfAp5r4vekD2LPadupStz/RnOupEFnsGxGViYM5jJwlXPfQJnNzODbFMz4pSg/ldYwU
         Tf56sxaPPDpllaUXSpJszVZK7/ns0c3E7DoaEVStWFRJLPkdvkdIHKoIVsa4D/tHfhgy
         8xH3S1p70b7zmNzNGj+a09ZO9VFUMflOLKaZ2uLuVbofFSSo4tdWcyOMIFzZclDXHT2W
         /5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7LB9Gvzf99PL3pycT84UZuRRyFKy1dC7nI933Lle8sI=;
        b=Hgo66BIjsGBE+JAzxSYE/ZNEG7f0qZfJBeDD1R9XflqcgEdI9lR0Fucd0o2qQh6lzl
         Ll3YEFX/jB1F9BB0RprHDxy2nxH97EEYoT2+NeId5A2D9RYqnz48wZ1T7MEZZ5n704H/
         waT9ML+1CpXdo5EerpWR5loFNtho2Tk67LYYLK1Y7AszilE/cwIEMeRZjK8TZYUyJ/Zc
         PngJ1gJ0qoQD1pcSy4jye0oTEI7y08+0NlAf4MBQBxCYCh6GQEOExomau1F8cFB8TOgR
         R9/MZg+XlkG/QlZAX831U0tNZoZ5XDd/MBFhkARvBTPHYBx6xuAlLdU2R9dIrYUr70hX
         y5VQ==
X-Gm-Message-State: AOAM530AJEi0cN03CpjrJTUx6QmBD/uyj8GVkIWi384FGKBErLBy9nrj
        XlJHDXSJ+uj4eLI0cSAVyGJv8JJy
X-Google-Smtp-Source: ABdhPJy4toRjRie+crxe+6EekR5tFql/zDkmXNsSQJOdYBmjlr42dqmBlMp949OM1dgStkAhnHZNsg==
X-Received: by 2002:a7b:c8da:: with SMTP id f26mr1251528wml.126.1597098563200;
        Mon, 10 Aug 2020 15:29:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i7sm23252218wrs.25.2020.08.10.15.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 15:29:22 -0700 (PDT)
Message-Id: <b35b61007e0184b8579c79bcc55ccf7a3964260a.1597098559.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.827.v3.git.git.1597098559.gitgitgadget@gmail.com>
References: <pull.827.v2.git.git.1596906081.gitgitgadget@gmail.com>
        <pull.827.v3.git.git.1597098559.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Aug 2020 22:29:10 +0000
Subject: [PATCH v3 02/11] t6418: tighten delete/normalize conflict testcase
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The testcase only required that the merge complete without conflict,
without specifying what the correct resolution was.  Since normalization
changed this from a modify/delete to a not-modified/delete, the correct
resolution is to have the file be removed at the end.  Add a check for
this resolution.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6418-merge-text-auto.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t6418-merge-text-auto.sh b/t/t6418-merge-text-auto.sh
index 89c86d4e56..30983d18b1 100755
--- a/t/t6418-merge-text-auto.sh
+++ b/t/t6418-merge-text-auto.sh
@@ -197,7 +197,8 @@ test_expect_success 'Test delete/normalize conflict' '
 	git commit -m "remove file" &&
 	git checkout master &&
 	git reset --hard a^ &&
-	git merge side
+	git merge side &&
+	test_path_is_missing file
 '
 
 test_done
-- 
gitgitgadget

