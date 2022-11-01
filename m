Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF8AC433FE
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 15:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbiKAPxq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 11:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiKAPxo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 11:53:44 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2239DC4E
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 08:53:44 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id y14so38116763ejd.9
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 08:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RWuiiBPKVjCfXht0pdY1UzDc2bCNiPeejs6FMFT8jiU=;
        b=Q3gnLGdtTRj6pTLD/TU8PiFNNgfuZN1oO7F+sEtSWBfHLJAPysWfAMZSUQSsS/lc0J
         8snBbpHqlJGsdqYp2EPuvU61ZGoywfQm0FFsbZL+/Mh5/Z3oldJB0NLFe330oODaXaYm
         buBbFZGWaWe2VgpPVaUihulc+NOB503iSrenYD/58naVEDaSHOkBce10hMUbxSwCKLwv
         NG0amdGCceGw4FtO9P8Paah5o2rGLCauZ1w3wrpfwRLPqKqmnlowSgxVOwZ4y7/32ZyL
         oITSoAYKNWC/85CS1zQo+5RhAY13NUihmN82lovQYQ9cdDuUoQaAep10m6+9eVR39+5G
         kZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RWuiiBPKVjCfXht0pdY1UzDc2bCNiPeejs6FMFT8jiU=;
        b=rX5p5ENcg4a/3IoeDdPMG8NQaMfxH4hrYHLu8EfjyXqQFEPmBBO6bWyf5matqCQHUy
         WpgPyhYFCDedcEJQGv+NuIKyFHmDK0HIawAqi7uKyjSG3pdN69dpCyhzrZ/NLRGkeuku
         X9ssxBonTvGj26sUk2O5YCra4Gi52xAxyXaKrWcjT79wLOx94cRwNgVwdeBfE86rJzkz
         nXu5ls7vShbNMekBXswl8HZ3QRFcm6NBcDtYoXY+yvIYmN0QeCjt0bJSsrQJHl+0uNjt
         RtaJz4RrTLjCDeANhY12qBG3dN2ZRTo41CbpMIt+XXhWqaI7zG1bEiYeFpT1CPKVGmwh
         kgeQ==
X-Gm-Message-State: ACrzQf0k+IKdBrOz+9DaKF71rU3GGW+gOFQ5U/yHSUy1xyQY10tgf9UD
        uwUk6eELDck2Xp+37K1D8k8=
X-Google-Smtp-Source: AMsMyM7X0OfOEvf1+dehWdjKfXyeFMWfsRsjcdMASnJYFB24fgNPpOxZicNE63+HfBjgdor/QSVR+w==
X-Received: by 2002:a17:906:dac3:b0:780:a242:2f14 with SMTP id xi3-20020a170906dac300b00780a2422f14mr18572625ejb.668.1667318022466;
        Tue, 01 Nov 2022 08:53:42 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ec38-20020a0564020d6600b004614fd33789sm4587576edb.18.2022.11.01.08.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 08:53:42 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1opta9-00BOWZ-1g;
        Tue, 01 Nov 2022 16:53:41 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Erik Cervin Edin <erik@cervined.in>
Cc:     Mark Hills <mark@xwax.org>, git@vger.kernel.org
Subject: Re: Consist timestamps within a checkout/clone
Date:   Tue, 01 Nov 2022 16:53:30 +0100
References: <2210311614160.25661@stax.localdomain>
 <CA+JQ7M81t0Lby=sB5GpUzJWakPgbi-ZNiQUL4va0wjDuk4v++Q@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <CA+JQ7M81t0Lby=sB5GpUzJWakPgbi-ZNiQUL4va0wjDuk4v++Q@mail.gmail.com>
Message-ID: <221101.86fsf24qnu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 01 2022, Erik Cervin Edin wrote:

> I have little to add on the underlying issue or non-issue but some
> ideas on how to solve your problem
>
> On Mon, Oct 31, 2022 at 8:39 PM Mark Hills <mark@xwax.org> wrote:
>>
>> ...
>> Indeed, Make is acting reasonably as the source file is sometimes
>> marginally newer than the destination (both checked out by Git), example
>> below.
>>
>> I've never had to consider consistency timestamps within a Git checkout
>> until now.
>>
>> It's entirely possible there's _never_ a guarantee of consistency here.
>
> If your makefile depends on checkout, why not
>   git ls-files | xargs touch
> or if this done in an environment where there's not a fresh clone each
> time, maybe
>   git diff HEAD --name-only --diff-filter=AM | xargs touch
> or something along those lines

I believe you might be trying to re-invent "make -B" :)
