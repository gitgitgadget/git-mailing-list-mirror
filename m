Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5472BC433F5
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 12:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 335386109E
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 12:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbhITMoH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 08:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbhITMoG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 08:44:06 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1495AC061574
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 05:42:40 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id r26so24546048oij.2
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 05:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KxMYM7TNfoRapVtWQT8lSxw8nwPOND3WK/j+HJ85tk4=;
        b=FpfziIngicyqCMsVA+pU6fyJ/96utg0KqDX03a7JOvihirAVcQYfIzopbGiJ/AhAbW
         EfmJxbQhdDuUL7BT1s+qA7dblas/hwEDOYrMgSfEW8yTnViTwIId8telQXdGmodJ4TEn
         4a6CnQ0kwRL7Uo1f8aY+ktzwnQ7Ts3gsvqyKcU0v0bTiAvmTGTIVRID2uEEz661i0RAt
         cVYxsnI3CCQphULk3KyY9oV6RoQ/scFF93n8z1Y8vaIzh2rNlve4m5sXP8y5+E1lSBto
         cNnirXF59umByHpuQL5vMGxrgUgWuJVeTwIqAO8nlsyNLhaJHVpHAV9sstarSxMuIj3d
         o3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KxMYM7TNfoRapVtWQT8lSxw8nwPOND3WK/j+HJ85tk4=;
        b=0Suwjh0MmvGp56iMvMKDqLlDxI+QjQmAS4QQZGQDY7b2qPgUDUj3iqA7d9TYLbGCDh
         rHV2E7Fsp5hhPaijyKrzVuEmhaeluhzGt9uxDNXQHgpbFRP6OztGXstyu3c1bBMN7NMR
         JhyofXC6w7s9jRg36iOBvg9er177pM54KhXWo/LeR21CJ9SVZjJeAHwgvK+PdxVCnYi7
         KXWbbGZ5xEYymetRPNw/q4AsrcklmgVZyZkPiJ2+NTFWy8PFpr4r7XMDoDgISWEhVqMB
         PSLs4C9SwzKVnmX4via1nE35ThVUdQEIrnoyxk6A7uNnhecPSTmv+KyAEwl4W/pGSnaR
         UBgg==
X-Gm-Message-State: AOAM531geOlRulbbXSCJTtAyXfszYI4Z6ZQ4pCb1T6ccCEok7ryjecnx
        FzG9JxW7J4bwY4KW0b20z70=
X-Google-Smtp-Source: ABdhPJz3Z1LOSnj0+Jb/gOpff0OXjV5AGZ2VbpM5g/i3Hv03XdNGju14hcXzdbeBlIO9DKyP9OzNfQ==
X-Received: by 2002:a05:6808:f15:: with SMTP id m21mr21424897oiw.107.1632141759242;
        Mon, 20 Sep 2021 05:42:39 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3dd4:10d2:c651:2ba0? ([2600:1700:e72:80a0:3dd4:10d2:c651:2ba0])
        by smtp.gmail.com with ESMTPSA id j10sm3457750oog.13.2021.09.20.05.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 05:42:38 -0700 (PDT)
Subject: Re: [PATCH v3 4/5] repo-settings.c: simplify the setup
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
References: <cover-v2-0.5-00000000000-20210916T182918Z-avarab@gmail.com>
 <cover-v3-0.5-00000000000-20210919T084703Z-avarab@gmail.com>
 <patch-v3-4.5-28286a61162-20210919T084703Z-avarab@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ddf328f2-30cf-2881-c61f-0698d499ac39@gmail.com>
Date:   Mon, 20 Sep 2021 08:42:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <patch-v3-4.5-28286a61162-20210919T084703Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/19/2021 4:47 AM, Ævar Arnfjörð Bjarmason wrote:
> Simplify the setup code in repo-settings.c in various ways, making the
> code shorter, easier to read, and requiring fewer hacks to do the same
> thing as it did before:

Popping in here to say that I agree this new arrangement is cleaner.

The previous patterns were confusing, and probably led to at least one bug,
including one in the builtin FS Monitor shipped with git-for-windows/git [1]
where enabling features.experimental overrides core.useBuiltinFSMonitor=false.
The newer organization should make it harder for mistakes like that to happen.

Thanks,
-Stolee

[1] https://github.com/git-for-windows/git/discussions/3251#discussioncomment-1296896
