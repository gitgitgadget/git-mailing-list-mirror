Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9690220248
	for <e@80x24.org>; Sun,  3 Mar 2019 01:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfCCBWM (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Mar 2019 20:22:12 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36588 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfCCBWM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Mar 2019 20:22:12 -0500
Received: by mail-wr1-f67.google.com with SMTP id o17so1715694wrw.3
        for <git@vger.kernel.org>; Sat, 02 Mar 2019 17:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=J409pW7LrrVqC5L36yPUKdGsHGksnehNENTo1dxZp8I=;
        b=gYRlZUsEaYMVamRgsKB8OKTmjfuCV5Y9Xb+L93oA8ZcPNdd687pXeAQsjjo0Cp0J/L
         9hpUkKLl1bXCzKLAYQDOvn1nWliqbeua79XPhOmNFkcnAZm211GMJK7ftZDT3p4fQyOS
         DGtiUCmLCDnB8hMHIj9lOS6W/8icBcJIel712xr3BH8dmwTPVmgTF+cADifNuXJdntgM
         aswUh0A7XpUc2Iz2aeIOWFpH2u/EyQZjb9207f8YEtN5Lx3iM1BE386zC7J7UCQ75/0J
         TW4SDW1i2BFzmh3eYshsW8v0INHh1nGkj9HWOZkwKWADsJZ4KNkqsr9Me5yfL8xMXYXr
         kH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=J409pW7LrrVqC5L36yPUKdGsHGksnehNENTo1dxZp8I=;
        b=dV1Nve09AnRCTHMcZst6RKePEP5n5yGFfrLpR/xcyLb073VfmwRDYvEh+DinTja9gX
         aK43WfCVOcwNEnYT8pcKav0X/Vox0QpUW3L7qF6XUSLGEyIeYiQItCf6pftPGrvUbaBO
         CkzfZ3V9hwP4JDRCit+fckYgXHCBcl0OHFRPh4vOFSV50b4WubcThWA8M6LmPcBdXNyU
         bGvOQ4QTyVN95LNgKiwVBsGCqpYbPkHlwqiqYt9zMOkBms1RSDNavODiieUcX1UlxrUi
         x5c4YUgIR/0u9oWGproqk4cB0AlFcnMvvWbfponZJOy4o890/UyKB3Xof0+M8cUkaU1x
         J5/A==
X-Gm-Message-State: APjAAAXk3SXk/VAbQxpjnlaz5rKSO6Am5mHdxIaoodg3o5qfQSN17Ftl
        SBJHMdHkq0yXARgCZCmEHYY=
X-Google-Smtp-Source: APXvYqxlJAvWZxYKsLtyAR35lUxAthax9dIcd7er1kOm94UvUVns9Y4A+ULiviqc0ES/YpIIEtMBeA==
X-Received: by 2002:adf:fd07:: with SMTP id e7mr8705082wrr.175.1551576130123;
        Sat, 02 Mar 2019 17:22:10 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x6sm3476626wmg.0.2019.03.02.17.22.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Mar 2019 17:22:09 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGg=?= =?utf-8?B?w6FpIE5n4buNYw==?= Duy 
        <pclouds@gmail.com>, Git List <git@vger.kernel.org>,
        hi-angel@yandex.ru, Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v3 1/1] worktree add: sanitize worktree names
References: <20190221121943.19778-1-pclouds@gmail.com>
        <20190226105851.32273-1-pclouds@gmail.com>
        <20190226105851.32273-2-pclouds@gmail.com>
        <20190227120859.GB10305@sigill.intra.peff.net>
        <CAPig+cRJZBvwsptPOzx3oPSOnt6+uGLoyOr_JbUnku4kdSwdgA@mail.gmail.com>
        <20190227160457.GA30817@sigill.intra.peff.net>
Date:   Sun, 03 Mar 2019 10:22:09 +0900
Message-ID: <xmqqmumc4uri.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I agree that sanitize_refname_format() would be nice, but I'm pretty
> sure it's going to end up having to duplicate many of the rules from
> check_refname_format(). Which is ugly if the two ever get out of sync.
>
> But if we could write it in a way that keeps the actual policy logic in
> one factored-out portion, I think it would be worth doing.

Yeah, I do too.

In the meantime, let's call v3 sufficient improvement from the
current state for now and queue it.
