Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7225C433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 14:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7211610A5
	for <git@archiver.kernel.org>; Thu,  6 May 2021 14:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbhEFOLS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 10:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233737AbhEFOLQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 10:11:16 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B920CC061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 07:10:17 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id i9so1420960lfe.13
        for <git@vger.kernel.org>; Thu, 06 May 2021 07:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k6tY29XqWMJhZDgB6brWYKFnv0UhrDXyEsNLYX5k/Cc=;
        b=Tt1GhvdU9vgBcYB4LrDxvjDqwWECBoplWULEAVGUe2Iyiy1PoFhE6BbAbytH3o+C/N
         +KYKKP5NHVuA4f273CJ0UcGAzWn/hjwy95qDk1HZgzQY+xd9qci6FT8GfcuT+0B3lcub
         08KBX1BdH0pSrhdrRoRXBqELKFnTuRX06eUuLIZxsxpSZZ0qTYjeMzGymza+oGI4K4Pg
         6rZNUU3oOUXTAaCJVxAuifGws+1/fwVYjdC5c308xQFSKhrBFGFyPeHy+2ZJZR/Qqbhs
         NxuWGgqIGz4YBRKG8u1+LZKbUCdDuabc4mTWK3MTKaUmNcJ6O2bQfCbCbc/AHMIwluzl
         gjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k6tY29XqWMJhZDgB6brWYKFnv0UhrDXyEsNLYX5k/Cc=;
        b=ccWtuO+/KwriHOx2h4ekaprRgh4kBmsFpbFJ7dtjqzXIz8V17IEYh52WsJxereLO+l
         DkjM8Zgup5mvQEGn0VF9fWb2T0I9YZUCR/e7un8bjk41UU0f26zn1cyhZMS2ftxQbFNx
         XkxsrqES3amKCJ4ukZJ4Vw8hof926pZ90Q1jUVGVwkoV5TJSlwxAu8RiuTvfu3f1GNzY
         XvqnMxYOtF2HHlPx+rUSajx+dj1J8a+6IOUNKAQ2eTATMERa/jEOWACuE6du2e0ZQTyT
         nrOhWnXHHTg0Tjx/XwFjO8fEjb+BWY79oPPRRsibfd9Wb3hGMtRolk6Lko88IOP2Ke8A
         BViQ==
X-Gm-Message-State: AOAM532ufvq5ZThYWHFU4fz7GkVu6lJDFKrgAt/Xy/gjoeC5wyHWh5pl
        O0ZwDskBrx0WLueaviYJ07w=
X-Google-Smtp-Source: ABdhPJwxDquxwjfLhL25dsImuvMNolPbFUjcdViwE7l2WNRgdxPkaxdvRAbWjB7pwbULAy6cx9VvzA==
X-Received: by 2002:a05:6512:11e6:: with SMTP id p6mr2996154lfs.578.1620310216271;
        Thu, 06 May 2021 07:10:16 -0700 (PDT)
Received: from raspberrypi.lan (150.37-191-137.fiber.lynet.no. [37.191.137.150])
        by smtp.gmail.com with ESMTPSA id e26sm920752ljl.81.2021.05.06.07.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 07:10:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To:     oystwa@gmail.com, gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] add: die if both --dry-run and --interactive are given
Date:   Thu,  6 May 2021 16:10:11 +0200
Message-Id: <20210506141011.18245-1-oystwa@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210505145204.51614-1-oystwa@gmail.com>
References: <20210505145204.51614-1-oystwa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Junio and thanks for accepting the patch.

> The interactive machinery does not obey --dry-run. Die appropriate if
> both flags are passed.

I just noticed a minor spelling error here: "appropriate" should be
"appropriately". I can send a v2 if that's easier for you.

Øsse
