Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80395C433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 01:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443117AbiDVBmQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 21:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344083AbiDVBmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 21:42:16 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDCB49F9A
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 18:39:24 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id x24so4581113qtq.11
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 18:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+PdNmFDSMV4/yc4SzxphCLcaxbWXZi0GV600KZWUS54=;
        b=Js/WHI0X2u8Ueny2hNgCgbaszgiBhKC3zezGvD4+puQApigwEQsnh/Ut0JkGdJfmpS
         kbMhhH5XkctLpdChZy3c/BedVawgi4SyKwVl9C0qY504Nyd3f6o2bFi4SseDA1Gcpxdl
         X0Oy9aISV29HPTh7YTc3WavCYk41FTOWghXHe6jbkNcmrX8fpbDAtUd+SQgr3NQDFE31
         Lpzlf1IVOeimzfqoh+F1w91E+5rXMyM+dmEijkbJnpHGKbDPz+7NFzjOwjio5HYmYQiv
         cupJ+iyE5+k2KXbIzVfHvPK24MvvbAdaoKjBfAePpvssaWdoJSA4HpwtT0LOw74X9DNQ
         u4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+PdNmFDSMV4/yc4SzxphCLcaxbWXZi0GV600KZWUS54=;
        b=ycGyj+O0SOugwDr1VizRJPniJ8D8SbQJ8mqwXPMbqT+jsGP0kudQ6Fw2RchCjqDXzT
         INhuz941KKV0SjZAUTHJvAi7e9Q+L9HxSn5WmOYoDRmwgoR2JnYKPeHzviszFsVr2BwP
         9lxG0pxwa83p8NypwNW3EEp30u3DwFEhikl2jB44O+W5NL/XvwG8oJp9SlUn61mma89l
         02OD8QyzTfj/d/5m0jj8U+zUkNV10WtWiVG0unFdcI7mLTSg6Hk7atmHadj1rLOHkgXI
         bQg+P1+CR5+Pav0Lon9E8Tg149ZVjm1T4hJ9u0m7hoRtMCYpPFRaga1GSOrAjuZ/WenI
         C1iQ==
X-Gm-Message-State: AOAM532ofm1kLKd/Xb+ygQWdOwAGQqDzWDyG8dy+tItM2+6nJqE0nv00
        l9ZDppMLUDzh2pUrwAoCijFxU94dOeU=
X-Google-Smtp-Source: ABdhPJyE9gc3es1CDyAMV3cdf5LlG86Op2YVpOppd32Gd4Lyvt+Xhh082UdRx7MQvZ08J3qxwh9BxA==
X-Received: by 2002:ac8:5c42:0:b0:2f1:e7f8:3e62 with SMTP id j2-20020ac85c42000000b002f1e7f83e62mr1672382qtj.41.1650591563725;
        Thu, 21 Apr 2022 18:39:23 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id y3-20020a376403000000b0069e899ec3c7sm308026qkb.75.2022.04.21.18.39.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Apr 2022 18:39:23 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, sunshine@sunshineco.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2 0/2] ci: avoid perforce/brew issues affecting macOS
Date:   Thu, 21 Apr 2022 18:39:09 -0700
Message-Id: <20220422013911.7646-1-carenas@gmail.com>
X-Mailer: git-send-email 2.36.0.266.g59f845bde02
In-Reply-To: <20220421225515.6316-1-carenas@gmail.com>
References: <20220421225515.6316-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is a simpler alternative to ab/ci-osx-loosen-package-requirement
which while it doesn't address the underlying issue, avoids the CI failures
in macOS as well.

For an example of a successful run with it merged with next see:

  https://github.com/carenas/git/actions/runs/2205005763

Carlo Marcelo Arenas Belón (2):
  ci: make failure to find perforce more user friendly
  ci: make perforce installation optional in macOS

 ci/install-dependencies.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.36.0.266.g59f845bde02

