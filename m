Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C02EC433E2
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 04:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5042620719
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 04:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UITRrJGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbgHaExH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 00:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgHaExF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 00:53:05 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FBEC061573
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 21:53:04 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id c15so4518443wrs.11
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 21:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=xHc6/Q68dJwSmYow8s/Qwk4SE5qPHGWHCnE/4MjSLA8=;
        b=UITRrJGz0GYAVAdug4iAT7fHOTQrkvylgcuXBUapRaQth0nRVtqXXMcuJjk/cKKzx5
         9O0QR3AOnxQXTJNmRC9m/AIKkWq6YZS8yk2ncmF3Ck+5E1CWoUa9L7loVmfT2VwNXTrK
         I7hq5955bvkQn2N95IDeaNZFC2m+15c4N7Q6rI4BGzbguZUQDN3x6jBrqRWai7rmseEo
         PI8aHIJG5ryBwoEHbVJqI0a0KcCgkgF/B8hBHejgK+TuEb0rQM3yI85mjgjuURB+uBz4
         xmP/xFQlerd9MBcyY/fuY6gOxu2zIhq8vYLW9DznvRPE5s3XYaVYvXzC8V8BRIG+9z2n
         HKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=xHc6/Q68dJwSmYow8s/Qwk4SE5qPHGWHCnE/4MjSLA8=;
        b=JlqO5La93wVmSiRoN0EaUfx+haeeknd6c9nGSxkxECfxLKg/mErcXqCxJIjUMFMaUk
         PhJE8df+vTGenoA/clYBeHNOHy/unfetRilVz36Ssjzv3pzRC2WXJPm9sVXEWgIwTP4j
         WDgPqnRcvNJ1hgMTVjfswqaLi0weq998p72ATZ5rsG7vh/Vv5A5e+3OIlDI7GeludXFb
         NJo29m7ddxEqK3EbtPtf+r90Brbuq5DxikPiFKK0HavJhELiusLCGiuAvrbBM7JM3N/z
         GTnnwPvSYTZl/MDL3wAluQCKMeI6WwQbPvahUTm85JTObvCxjDiZ1QHwDCQb2i7/RvYr
         Ni2w==
X-Gm-Message-State: AOAM5335xv+NPW6UnTXuaSotBVypT9TeOmuNRW5Upwg+ne2d83I8GMY1
        4y4120NEI+Pc3cZP9XYLoRyo0G1p5sg=
X-Google-Smtp-Source: ABdhPJxk2fgaSDsPoxWYefqt4BUYKOZdRBDM9QlNeqDcnoG4MoOtpyCoLQWHDjNxDLwUOkTDMGN40g==
X-Received: by 2002:a5d:4144:: with SMTP id c4mr9579292wrq.200.1598849582168;
        Sun, 30 Aug 2020 21:53:02 -0700 (PDT)
Received: from debian1 (88-144-199-94.host.pobb.as13285.net. [88.144.199.94])
        by smtp.gmail.com with ESMTPSA id f6sm10023968wro.5.2020.08.30.21.53.01
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 21:53:01 -0700 (PDT)
Message-ID: <19eb0eb27b37943271b72c0fc098d6c83626b63a.camel@gmail.com>
Subject: [gitk] moving the cursor position in search boxes
From:   Lyndon Brown <jnqnfe@gmail.com>
To:     git@vger.kernel.org
Date:   Mon, 31 Aug 2020 05:53:00 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Please can the UX of gitk be improved by allowing left and right keys
to move the cursor position in the search boxes, which is currently
only possible with a mouse click (the left/right keys just do nothing).

I'm a Debian Linux user, running version 1:2.28.0-1. This annoyance has
existed for a long time.

