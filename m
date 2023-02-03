Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD837C05027
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 19:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbjBCTeR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 14:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjBCTeQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 14:34:16 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB43E40F4
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 11:34:13 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id z3so4483287pfb.2
        for <git@vger.kernel.org>; Fri, 03 Feb 2023 11:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ahTFqGfKn4WRoFrHwxmIs0+9jBmOzBWxAqA+awBa2sw=;
        b=NTKiowl6XmeBYbseCj5GHY/T10XzCV3yDXzNzaq07D9pmsg3iQbLWIuW9a3U8NwdLh
         plK9OT5yWliClWS315EnLwe/Km0FvoQE9BvUAI0cXpGR+GUHQOb6ApXgukCfmPoo8bRe
         Ixyq16z8i1IeLRGxP0q+cPU2JXLJHB/Cse8XIUfVCe1sA4FuOXrg1HLeA/qVSXgAgssV
         MJE2xHXgDFsTQ30FKL1rpT1seq+xNUlWvjSHcUB4A3SRbCo7lOCrHB5Nb8RZuYyHT4b/
         vGm9oZdFSgtpSoDyrMPR5fIWvYkt2jOtAzwXSbdRlcO+bn+stf4+viqQ/kJkm8SjN5KY
         LFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ahTFqGfKn4WRoFrHwxmIs0+9jBmOzBWxAqA+awBa2sw=;
        b=GKAELDquXOa7N/zTxjsKPYe1noD4WIm5f8eCfQQvGOM8mrezxDr/0Z7RGjInY7NdUI
         h2TJirb/jP/afd70Gx21FVhIpWq1z/VLZGDID6Kl0mcfNaaQxXI++bvzsARRQZDSisOo
         VfQhDqIsR8YF39J9lj6odVGuYTq7rLysyvxON/vpCgfb+IcHS84m9uSWeQHhcPKTd5Cf
         zjXZWalQv5FxRPOwamS9qO/UrFHLKHLNN7UKsaAnlfvCPnplPNPLd0PHSz2hLB6/sXou
         0PM9Jb3RC5QKkgSksTNBa1rJfBon7PRgwf5k9il7P7fxqBXzmjl+IkZR6NdLCPPaG4wz
         mPBg==
X-Gm-Message-State: AO0yUKX0pP1HMyIF0WYRx0CltVyTchLwuTeEx9iJAXZHhWSckaptcJxk
        UtT4YKFnH8qY65SMrS50V6Q=
X-Google-Smtp-Source: AK7set9tT6xh5TtZUdZ65aq+jT9wVw64quPBM0i9CO3iYNlUtfm13SLwUBG3/s19Zr0V1gheGWY+Ag==
X-Received: by 2002:a05:6a00:15cb:b0:590:7735:5384 with SMTP id o11-20020a056a0015cb00b0059077355384mr13144718pfu.23.1675452853139;
        Fri, 03 Feb 2023 11:34:13 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id a77-20020a621a50000000b0058e12658485sm2255352pfa.94.2023.02.03.11.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 11:34:12 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Slavica =?utf-8?B?xJB1a2nEhw==?= <slawica92@hotmail.com>
Subject: Re: [PATCH 0/3] add: remove Perl version of "git add -[pi]"
References: <cover-0.3-00000000000-20230203T125859Z-avarab@gmail.com>
        <Y906yEGFEIglRyVb@coredump.intra.peff.net>
Date:   Fri, 03 Feb 2023 11:34:12 -0800
In-Reply-To: <Y906yEGFEIglRyVb@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 3 Feb 2023 11:48:08 -0500")
Message-ID: <xmqqilgio85n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Feb 03, 2023 at 05:30:01PM +0100, Ævar Arnfjörð Bjarmason wrote:
>
>> After it was made the default we had a next-release regression fix[1],
>> but haven't had any issues since then. Any outstanding bugs in it are
>> something we'd fix in the C code, not something where users are likely
>> to want an escape hatch to scramble back to the Perl implementation.
>
> I'm in favor of dropping the perl version, but note that this paragraph
> isn't quite accurate. There was at least one more regression after that,
> solved by fb094cb583 (Merge branch 'js/add-p-diff-parsing-fix',
> 2022-09-09).
>
> I'd probably leave the final decision on its status to Johannes. This is
> (I think) the last time we discussed it:
>
>   https://lore.kernel.org/git/rsrn5988-37n4-7q45-s1o9-6n40rropp120@tzk.qr/
>
> That was 6 months ago, so maybe it's time now.

Sounds good to me, too.
