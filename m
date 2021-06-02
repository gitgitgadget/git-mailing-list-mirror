Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDE5C47083
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 15:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0948E613BF
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 15:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbhFBPhm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 11:37:42 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:39441 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbhFBPhk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 11:37:40 -0400
Received: by mail-qt1-f174.google.com with SMTP id c15so2108540qte.6
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 08:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=X9/fU/B/CY0VXAuTsCAKcNgpmecXttX7C9hAUiQ1gRE=;
        b=dkB3No0zJ6cKBtnMPLfDQIG+uTkr+kbMZAMApFBx2vSKapkYf+cy8UPprXN+K++9CB
         gMGADInGqF5CBpA5gLvV8/ZDFCK9HweLj78MmPaRgGNNWQKDz5tlJRmH52PhfnPXDgIZ
         iNfMCOj1/arW7zjWE0BgM6y2ZJO/BkGj4QTpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=X9/fU/B/CY0VXAuTsCAKcNgpmecXttX7C9hAUiQ1gRE=;
        b=ftoRqJxXF/ZMbRldGZElQMTnRBDIlkSQERh5idScein3JLmpkFd7nH4nN9ERLFRfUS
         QyhdjLGSB7EDgDMCtgE0Ze4wr1z9KM/YrvQvX94sBH8ECE271DQ8aIoPwVdd9iNM46Ok
         STpg9yvDetBX7mg3ST7+LCbQ6XvGD5MhCm3KxEd2+Mv9uBOIuPoi2hqFxjkifeofPf0P
         FlazEdjQJzQ005sEhdsYHP6mO5WY4yzLrn0tCqHd3QGfjygEQdXyQkx7yJyruUo8jihR
         nlQBuzBf3f/gT6RoimNVTr50zFR6rN61EmxKdwXCQmayzmu8cRopNqm4cvlVWiKVy0ny
         ac2Q==
X-Gm-Message-State: AOAM532vhb0e0KhvNhnP9cdWVeEffiLxeoeaNLNvICOUjKgwG9REXG3F
        EsEW3MoD2X4FnBMUaaLPIvwX3bQDElikzzElVvo=
X-Google-Smtp-Source: ABdhPJzJ+Rr39mR1dZrf3MfFZDOKJIhhJYITSXuFuLEyS6Z0maY4qDfzvn9+VlflnqxaaWSEe4vveQ==
X-Received: by 2002:ac8:588e:: with SMTP id t14mr25354995qta.39.1622648082819;
        Wed, 02 Jun 2021 08:34:42 -0700 (PDT)
Received: from nitro.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id g9sm44570qka.38.2021.06.02.08.34.42
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 08:34:42 -0700 (PDT)
Date:   Wed, 2 Jun 2021 11:34:41 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     git@vger.kernel.org
Subject: why does git-send-email unwrap headers?
Message-ID: <20210602153441.cjmey63x2vudlnk6@nitro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello:

I've noticed that when a message is sent with git-send-email, it will unwrap
all existing headers into a single line, such that:

    Some-header: This is a long header that happens to be longer than 78
     characters and is therefore wrapped at whitespace chars to properly span
     across multiple lines

becomes:

    Some-header: This is a long header that happens to be longer than 78 characters and is therefore wrapped at whitespace chars to properly span across multiple lines

While it's not *wrong* (the 78-character limit is from a very old RFC), I'm
curious if this is intentional or just an oversight.

-K
