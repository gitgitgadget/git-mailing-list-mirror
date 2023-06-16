Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E8DEB64D7
	for <git@archiver.kernel.org>; Fri, 16 Jun 2023 23:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbjFPXOu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jun 2023 19:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjFPXOt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2023 19:14:49 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739503A8B
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 16:14:48 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-30fcda210cfso928595f8f.3
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 16:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686957287; x=1689549287;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+BUsSMRbVw7XjjGI/rLcP256EOBmczMPWQ5OY0UEI0U=;
        b=raykAt12aQKY6KepimJrR9XB3vy7sVEdhsp8yKYemUGV5Zs6UnsAX4UZXt0eRArZ1D
         BkKKKJmmI1VMHg7ynGwOBiDMnlN7BGNeXxZyO2RbJBqlbHsUnbnNXUlEz/YUxAlJyPY1
         X6cEjaI/KfFUhpplqLqBe8eMru8plEyRaq26kXK2L5HtbeCvMaUyUQJ5ijN4Q/vA42kg
         alIQFxu7ZIkM6rjT+PLYUBdcwgKlIlFOhEs3X5zYM6kWjByP/LUaVADo+njP71I4cneH
         a1PvuP+rpcqnEtIIPwl1mB+ch/3P3Wsp0AS3SQzb0yDrkzP8sa3tFCANDaIwwVcTkMsm
         EPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686957287; x=1689549287;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+BUsSMRbVw7XjjGI/rLcP256EOBmczMPWQ5OY0UEI0U=;
        b=aI30quMs2cZERGY+IIOFrU2HAe8dTWSrKadc/TO2cRa7Yh5+teiAhHPIlhM0oNfNfO
         Wyf/S1F4pf26KYIAiUU8kM8CtNRFyORNz/m2gdjlU+JRxEq1qJqQ/EFY/QkJ+Hm2y6Hy
         1cFnzVmr7UqB9kRO4Wv+2vhx2bnmIEZgMy22T3ts3y/wEKPIKghkFhY5lecpoxTnN/eD
         OtZF7CsXSQTCULK9Yq0ExgL9lkn6a6ObxdH1H5YUnueVEmC6sdAdcwU6p+g74Sbdkm3B
         Bbu0VfZS7UmXwdEEtizb4APOdb6uWvQpXd28ssGEsXFLMIa19TJB/rppWmWimlq/tGC5
         zrPg==
X-Gm-Message-State: AC+VfDzrypdsks37MwsZkOO/kq9xyEplMCWPjmQTrVjuVf8yCfo0tysa
        6MPf5z/+getpEnXFcbziYPC6U3C/xTY=
X-Google-Smtp-Source: ACHHUZ4j+Hm5ifOmYioQsmWGqMvlLOP6Ure/niCaP4Mjyly0Gwe321LcIqCvPk+D1QviGojUIiq+1g==
X-Received: by 2002:a5d:5272:0:b0:30f:c6a9:5df2 with SMTP id l18-20020a5d5272000000b0030fc6a95df2mr2598664wrc.35.1686957286565;
        Fri, 16 Jun 2023 16:14:46 -0700 (PDT)
Received: from [192.168.2.52] (151.red-88-14-53.dynamicip.rima-tde.net. [88.14.53.151])
        by smtp.gmail.com with ESMTPSA id q18-20020a05600000d200b0030e5da3e295sm24704886wrx.65.2023.06.16.16.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 16:14:46 -0700 (PDT)
Subject: Re: tests: mark as passing with SANITIZE=leak
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
 <20230612040651.GK306352@coredump.intra.peff.net>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <4e25776e-a490-091f-6f43-7f8f8413bf7b@gmail.com>
Date:   Sat, 17 Jun 2023 01:14:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20230612040651.GK306352@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/6/23 6:06, Jeff King wrote:
> On Sun, Jun 11, 2023 at 08:29:09PM +0200, Rubén Justo wrote:
> 
>> Each of the commits (except 11/11) fixes a leak.  They have no
>> dependencies on each other.  As a result, they can be reordered.
> 
> Thanks for a pleasant read. I think each case is correct, though I left
> a few minor comments. Some of them are things I think are worth
> including in a re-roll. Others are things that we _could_ go further to
> refactor for clarity, but I am OK if you want to stay focused on the
> minimal leak-fixes.
> 
> -Peff
> 

Thank you for your prompt reviews, and sorry for my late responses.

