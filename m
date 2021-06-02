Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFFFC4708F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 19:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9D5C613E9
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 19:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhFBTeb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 15:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhFBTe3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 15:34:29 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFB6C06174A
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 12:32:46 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id i12so2690286qtr.7
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 12:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=px0jLQOEcjkYz4wGRwUY5jFygIlUrOEvuaCEt0PASq4=;
        b=Vjw+TdvWB2Z5Ps+JbLxl6PEp3S1GZfJv0pwFUks+pMAJXZT9Vur3pvvZjElLU1NoIA
         /e706Fx92uqF134zUieRUYaZvyvT0YACy/B9cAsicqYoNopQI79TxxdW5N0kLIgHKZ8l
         C1opOwKVjJiv4gRB2eIOhPavTv+CVxZ1IwxkyY3pki6LvhtbmHtGJvlmNNQCFVhVce1S
         Q4WZCZQj0ji3kPsu1qJdyz5qXqRttbzT7aaOYSDie+sS0zERY1wstoXf690aN6L+vp9h
         Y/E1EquEeyfB9gdZCUnOxoi6NqF2VzQxZjYlaYg6l/XWj6ostawqE1m+TR54tiU7ifJO
         zCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=px0jLQOEcjkYz4wGRwUY5jFygIlUrOEvuaCEt0PASq4=;
        b=kbvuwSCRNm+OBDM4LI418AfA91GMw6h4q0hJasz2jY4SzizPLbHT3exQkNk1Rp0tJ7
         SxO7st5qYW3OdQ1GtbnAxfKmW07kCJPC6sOI7dL2hcjVzS4WTD4Mmxaxuvh1/OE0lCor
         dVW7ME43mjMEwyyTJ3AdaekHoWldeOKmEMQZcek8rTypPQ01ud1Ebijs92STcIshcuta
         xQA+pnufZirb9Cfa1wF5/Jn8Ivy46Q7dKX60PSgrZa6u9y8lTZhqP1NibcRrsUJD/ifu
         vZHrclmtDLct/r7867sYZ58zZwqRmMp+cti52lsHH2eCfMyFEzbEujlc8E1hOU8yMOU8
         a66g==
X-Gm-Message-State: AOAM533cX5+bvw9TbVnZREvztfmZNaTUdm7D88pnf/wjAtk604XT4VPi
        6gD4o/8SkdnbvssMMfq6+bZJR8k/+fJrbE98
X-Google-Smtp-Source: ABdhPJxy4LLFiLIw9K2GIx7tD4Zyeu8x8FTRRcroSB3Zd1aZ+gJ7qqP4NDN7McZK3+ExC1DtaD82oA==
X-Received: by 2002:a05:622a:92:: with SMTP id o18mr25910901qtw.342.1622662365398;
        Wed, 02 Jun 2021 12:32:45 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:9178:81cf:a7f0:8e5d])
        by smtp.gmail.com with ESMTPSA id u186sm500686qkd.30.2021.06.02.12.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 12:32:45 -0700 (PDT)
Date:   Wed, 2 Jun 2021 15:32:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.32.0-rc3 - t5300 Still Broken on NonStop
 ia64/x86
Message-ID: <YLfc2+Te7Y3UY+Sm@nand.local>
References: <002701d757d8$1a8d9dc0$4fa8d940$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <002701d757d8$1a8d9dc0$4fa8d940$@nexbridge.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 02, 2021 at 01:52:44PM -0400, Randall S. Becker wrote:
> I'm happy to help figure this out but need some direction. I don't
> know the pack-object code.

Is the failure consistent, i.e., that it occurs every time you run the
test? Not knowing much about your platform, it would be helpful to have
a bisection showing where this breakage first occurs.

Thanks,
Taylor
