Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00996C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 892B620797
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXXhW9fL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgKKUdV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 15:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKKUdV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 15:33:21 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6DAC0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:33:20 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 10so3440168wml.2
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=1FSbwJyCLlZKIo0wf359AK8blFZfRkLQ2I5yM+S6Ez0=;
        b=DXXhW9fL6Ow76PaDmFe3Bnsdbz7pO53Qal0+01C2wJ/W4Pcg/QB4Q6TE4X1MCNDH8X
         EEH9Abs/FMHXNkmCYmSmLvjgoZ6n5YtAdhVU5Ilv4enNT3/1uVhbaE2lu5UjWCJH3prI
         tOfeco1wZA2sKIXjGopBNU4YyUiYpd6Jd9n04TR9cpNKYqJFYUPCVnK4vng6dXNTVhpv
         ouJxqEbxLwDl2JYeUJ/OTBbMz2u1tXdBFDB5onMOMVegFWPgDz7/Q07Gk1R7Kmr4ZNZX
         AdIPyFptfWbNgsG+bw0QKcIasqkAzRz8ZG4VSiZSA9nYK0QK1+NWxuA3/sD5iNyrpMsk
         YfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1FSbwJyCLlZKIo0wf359AK8blFZfRkLQ2I5yM+S6Ez0=;
        b=BI8ayXslyOUKx7KW/XZJkFaN/3YYbDNvcTZUfHHQ4DHZz7gZT0bOahZr8fVzZ01Sbl
         ujN+Qbob9ySaNTeM13RTkdt1Hr7v16csCW64YqdLBRHBx0UDxX1YJPP+Cb9rWfVHSNnh
         ygLWlg/QPnIxRtIpwAM3lggjDDNV+WQkzVT0f0JloyU/v43o6xQME1Z0v+vVSa3z0PmZ
         bEi/MEZY7vb9clC41Exgu0t3Ur8i/JVOkVeTlm40K0M7BGtoX7pYqCIEzyb4Q9yuw//I
         GyeNdoi2C66/Wypce5q5plf4KMmGp8yj0drtsXYNhSseEqYRxASI4Zrte8bApI3e7kkd
         XlXA==
X-Gm-Message-State: AOAM532X51dhHY/cuJ2sZmJB26sU8MXtySCn55qL6GQoX0WMrDQwzf8S
        FKBmmNuuGqXJMtLIluq2lBsobnTKCa0=
X-Google-Smtp-Source: ABdhPJyt8sYI31b4XIs3EKtkBUmjlUICGpb8bF/oRgsKW8kAKKa31pcVsm2U8gui55XIztDN+g3F3Q==
X-Received: by 2002:a1c:5f83:: with SMTP id t125mr4851122wmb.82.1605126799260;
        Wed, 11 Nov 2020 12:33:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n10sm3999035wrx.9.2020.11.11.12.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 12:33:18 -0800 (PST)
Message-Id: <pull.787.git.1605126798.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Nov 2020 20:33:16 +0000
Subject: [PATCH 0/2] difftool: fix user-defined Beyond Compare setups
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     pudinha <rogi@skylittlesystem.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git v2.29.0 includes patches that try to support Beyond Compare better by
default. However, as reported in 
https://github.com/git-for-windows/git/issues/2893, they broke user-defined
setups that use bc4 as the name for the difftool.

This patch series fixes that and is based on pd/mergetool-nvimdiff.

Johannes Schindelin (2):
  mergetools/bc: add `bc4` to the alias list for Beyond Compare
  mergetool: avoid letting `list_tool_variants` break user-defined
    setups

 git-mergetool--lib.sh | 4 ++++
 mergetools/bc         | 1 +
 2 files changed, 5 insertions(+)


base-commit: 11868978c7c80d3c29071b29e7964e3d62523819
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-787%2Fdscho%2Ffix-beyond-compare-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-787/dscho/fix-beyond-compare-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/787
-- 
gitgitgadget
