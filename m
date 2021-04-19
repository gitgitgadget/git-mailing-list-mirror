Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A249EC433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 10:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A05F6101E
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 10:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238399AbhDSKxp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 06:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237708AbhDSKxj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 06:53:39 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E5AC061761
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 03:53:07 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id p6so26795672wrn.9
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 03:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PNXYjsqBmokYYN4Q17OeJZD7G3XLhxhwmPXKh3TfUPc=;
        b=CqYgsJ9y9a3Lqe9qwePnTI7yAgd/w6tUahdOawSfSZL6eJ2Jq6A8C5/abpVy0wuuBb
         L65TkmAlNMsjxJm/rW7jbL1brHpfH8eHPVsRuF2mLHGS2ubgY4UgJ+0j+swcNrIWPrMB
         C14awNG4wob3CZMTdLHnMoCTC6Tt5JXVIo1MibCQlWHT9IKICua8W+1SuzRjx7a1RCAc
         cSoQtwGBbihxHN2pqC9nAKZICumuJZQYAmRkTX5XDQlElqsdmF5EAE5k0xGI4RBoP3At
         RKqEkaUHgP0rT81iN/4QmSQeWi/4sBn6X5QoYK+HMTLdOpTAUrcvc5Cx9BeaF1ipXLWR
         6xgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PNXYjsqBmokYYN4Q17OeJZD7G3XLhxhwmPXKh3TfUPc=;
        b=Cy8eTJ/2F7bdHWWUCiSUGKTInpI37bHtvAw3VNhwwL1d2Vlq8Kz/jowptYBp/vnj3R
         d481lDi5f7QOlQVQOtBCV05LtCbnIXTu/8oxVv0Ki72CCaxdHu51aD6U32w+ftnSZxQu
         bGpYoWtsXw9xYz2tt8E3H5jtU23kaOPxrJEHRXFFCLtoIHI8sY9C229DSJbK3UjryJak
         uLZXcQY54luLStuvK9QsQVqAPqQfnMEGS0hgL+rXtBAfR0B/d/1GmPkMw1C9OEnEYU/f
         39/oMMEH8m5Mb2lc1RqKnOxmnf2x6eTcjWaU9ONLm21Ce2kC8Ad0QJOtVQc4lkz7bmTu
         Rv7Q==
X-Gm-Message-State: AOAM530GYqNLap1YOl84TbLHbuoCNHNJ40nqIRcmvNcOE7RtCXMIISdR
        j+KMRvsN7F2ioKczi9mnrTVob5xuOsY=
X-Google-Smtp-Source: ABdhPJxwd8HSp4lOengK1QOVOq8TnaCFQCmpkLTunOEzEHkK6wV/zj5fbzcPCyE/eLjsOHSxGVgMGA==
X-Received: by 2002:adf:e607:: with SMTP id p7mr13564903wrm.381.1618829585809;
        Mon, 19 Apr 2021 03:53:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g84sm15528296wmg.42.2021.04.19.03.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 03:53:05 -0700 (PDT)
Message-Id: <ccc26a8950be41e5be4dc78295c66ecbade8a50e.1618829583.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 10:52:47 +0000
Subject: [PATCH 02/18] t9300: check ref existence using git-rev-parse rather
 than FS check
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t9300-fast-import.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 5c47ac4465cb..087ddf097036 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -392,7 +392,7 @@ test_expect_success 'B: accept branch name "TEMP_TAG"' '
 		git gc
 		git prune" &&
 	git fast-import <input &&
-	test -f .git/TEMP_TAG &&
+	git rev-parse TEMP_TAG &&
 	test $(git rev-parse main) = $(git rev-parse TEMP_TAG^)
 '
 
-- 
gitgitgadget

