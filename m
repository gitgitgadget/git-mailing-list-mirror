Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAB1C636D3
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 21:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjBFVcf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 16:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjBFVcd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 16:32:33 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772431BF4
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 13:32:32 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id sa10so7766322ejc.9
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 13:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0qhAR9LezjAx6D9BBqV840BQkhtVCs2fe1c0c9eczE4=;
        b=SogCR6qHXYaK3hGheVft9A7KS6CU0/ngpCXpKMKj0BaSWphIMvrLeYr6601gsneeA0
         ZiuAowAe++1esCBmszlJRMB7ZlyvEnRBRfgIT5dT3IDf1AIdXMaeu/uHoocJIKDAYTes
         tNqKXGxVl02NCMOiHsmCGWS7K1XzoFejMnUioPHh8cvbiG/fQYkkSYxH9vOxp8nlYDrs
         1p7N16W7qwbLeCugZ2AidhepElMhbf+rSRYSrTglwriblEvfxCn4RYsvwDkxiuhS4VGT
         tMz/dCB/n/t3Tt25mQXLSW+ZSm1Iw9oCmPZcy3AYIsbRWF+W9BWdfnap7sBd8UJFY8dS
         XvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qhAR9LezjAx6D9BBqV840BQkhtVCs2fe1c0c9eczE4=;
        b=3vsQli2yzXuHIbuJ3qOiHMV5LxZoEL10+DCvwhTiX4VMiblLDmiGnadoOsz9x4hhm4
         8tEokLRcTbkkbqbkgA0NiSB6M+Qj/KKF2v/KpGXJWpCJyFg6Chh8PN3KGZqieqcbvE2b
         upB/UTga5bsuXOtk5GeigiQbpx9eRrsLOuszYK//uzeojMsMtNAc9c21/slOHzu44CY1
         twoL5quqTsRPuUc/Sg7IzekAAEUiuh0PtAAKs4jNvIGuGinD/XVOxUBEbZhixllDhmaI
         kZc+zNv4Mx+pFhrvTBSTsJuJgFjhPwdQd1lmeyHVkKSkIEIbqifJlqZOA6fArmhbeCTg
         8cow==
X-Gm-Message-State: AO0yUKVAc12dguXDcBeBPHAfCoDTqWr2zGAlGs2VaUZZorYdaysuu3RW
        /Wwj5SHQPnT7WyuSg4ZGuJArZxZD06VYUqGi
X-Google-Smtp-Source: AK7set+sDMp2VinOx6BI246AqEV6K59KZVuB6lc7xNy36NC2j7YlHgCAdiewl3UHcXL5LtdJiuuTMA==
X-Received: by 2002:a17:906:746:b0:854:6e3:2388 with SMTP id z6-20020a170906074600b0085406e32388mr920431ejb.12.1675719150674;
        Mon, 06 Feb 2023 13:32:30 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id uz12-20020a170907118c00b0084cb4d37b8csm6002749ejb.141.2023.02.06.13.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 13:32:29 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pP96D-000WzL-0M;
        Mon, 06 Feb 2023 22:32:29 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [PATCH v8 0/3] Enhance credential helper protocol to include
 auth headers
Date:   Mon, 06 Feb 2023 21:59:24 +0100
References: <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
 <pull.1352.v8.git.1675711789.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <pull.1352.v8.git.1675711789.gitgitgadget@gmail.com>
Message-ID: <230206.86357i5vki.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 06 2023, Matthew John Cheetham via GitGitGadget wrote:

> Updates in v8
> =============
>
>  * Drop custom HTTP test helper tool in favour of using a CGI shell script
>    and Apache; avoiding the need to implement an HTTP server.
>
>  * Avoid allocations in header reading callback unless we have a header we
>    care about; act on the char* from libcurl directly rather than create a
>    strbuf for each header.
>
>  * Drop st_mult overflow guarding function in curl callback functions; we're
>    not allocating memory based on the resulting value and just adds to
>    potential confusion in the future.

I just had some nit-y and other trivial comments spotted on a
read-through, but with the caveat that I'm not too familiar with the
credential infrastructure this looks good to me.

I'm rather neutral on the whole question of whether we eventually ship a
httpd in-tree, but I think the v7 to v8 clearly demonstrates that
whatever we do there, this topic is much improved by having that
question un-tangled from the credential improvements here.

Thanks!

