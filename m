Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C10C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 20:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E817360EFF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 20:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbhIUU2c (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 16:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhIUU2b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 16:28:31 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284B0C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 13:27:03 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id q205so314425iod.8
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 13:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=4NgCBaO09vMEWaHh6HFFiCqiZD6VAmbaot3BNSrWjDI=;
        b=QnDRZXRFmgv6JWGC/SjYGYmVNozdXwyj4l6A5MGvqrYdBHBSwSep/05eVbFk4vomPj
         o9AbWZn8fUVTzxeLOHzz2K9rpj50Sz/IELbJPzfnd6ok8XbNhZBExwEWdaSH01uknSlz
         YnK+VM61zRR7GeL76bNw2KkFokUQr/Yj9d/nGVYUbIisVwQC0jlQhrNZg806MXbhA4vo
         IStMbnWuxP2giVeUikFu66vVyQP2VPuvQsElQN3YOdGyRQAaI41ipt+a7PnazkWLsyod
         ls/JjSMgrMF6dRgbMXLGl4WDRuxPtSLDgulesfB3YluHqEsjFCC7CX7vQYr2c0+onTgB
         Oy8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=4NgCBaO09vMEWaHh6HFFiCqiZD6VAmbaot3BNSrWjDI=;
        b=pystqp1VTkgH8YQeyamAp/Ww4wzEGWQSnkIR2kQlSY0ePKtQmjsILKZOFtcqd86wcs
         r0P5ldBOgmMydB97pySsP/UDSvWgRHn7QxNrYqy3sicHOHSNIQ+FkXAlFS7Ec+Iy/d+b
         WSKTlrAzo4iYsGSBPhHlklVAafMQicMyetDoMWhmNH6nDWoe+uHADMNKMTC+pHKy+O4s
         Y7xZmn3cPnAdbg9sHZzoZ7LbU+CcMmT1Jo+qzcCf8vKEsDA43oFdFxfNxcv8VwrcBAKa
         UsKhkYie9VGIZBefSquvY4R88B0+57ITcSqC3+yh1wxpdfXRIqxQswipP/ME3vOvzBa2
         raYg==
X-Gm-Message-State: AOAM5315UFky3Ist9qvIrq+CQJfnwGupOF52Ui3lYmzoyjVophroaqFy
        IuhEN+NLudZDhqI/EUNB2WSmkU0hTo8=
X-Google-Smtp-Source: ABdhPJy07nlH3/sMHIGdAUFU0DYgBaWeIuoEFrmTQFEtwJ7iUUT+O0UWuMOVIrMrKeRABpdaQ1OhRg==
X-Received: by 2002:a5d:850f:: with SMTP id q15mr1627684ion.118.1632256022446;
        Tue, 21 Sep 2021 13:27:02 -0700 (PDT)
Received: from [192.168.1.70] (75-22-130-77.lightspeed.npvlil.sbcglobal.net. [75.22.130.77])
        by smtp.gmail.com with ESMTPSA id p65sm41483iof.26.2021.09.21.13.27.01
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 13:27:02 -0700 (PDT)
To:     git@vger.kernel.org
From:   S R Wright <srw6666@gmail.com>
Subject: .swp files
Message-ID: <e01bdada-1301-739a-9841-6a2182334a9f@gmail.com>
Date:   Tue, 21 Sep 2021 15:27:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When git creates index.lock in the local .git directory,  does it also 
create .index.lock.swp (or any other .swp file)?  If so, can this 
behaviour be disabled?  VIM does this,  but it can be disabled.  Thanks!
