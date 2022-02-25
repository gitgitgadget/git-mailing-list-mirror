Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5128FC433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 16:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237367AbiBYQsK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 11:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243580AbiBYQsA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 11:48:00 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5117B43AD3
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 08:47:22 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id x5so8197384edd.11
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 08:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=963oFqnL3BSg6nKqz5WeGF4jNNOEm48WDZCnb/uiUnc=;
        b=BnCF59ln6ISaQYouHYXcP1/6aI9g0yegtksDSGGh1YZFquTv4N50cR9bFoawbohT1g
         X74vb8Pig6VKgWQ76+fgmw2RyZ0OVKRb/IrTC8xJigfYqmd7UXvGPOSFjjHkDJnJmvvD
         0kJ3odm8Gz171hKCaFKX7YhmMdCDVMXnoNpBjlnx2st78Q9Oo5TXwbVxKkmyvwu9BYmv
         h5Gr7/nS6Tl2eo26Mj0cT3aJsdnU+R2Mj8EaoEEz5Vj37jMCPJ/veeG1K+YhA709tosU
         EPk3gFfMQnJWMK5vgGEOtK2heGC0VD+pe4mvxEgucqNO1r21COhOh6IrP2pgp8eni7x2
         oS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=963oFqnL3BSg6nKqz5WeGF4jNNOEm48WDZCnb/uiUnc=;
        b=AhDMZYuYtAVK7zeTxOpp2Xt0LSeXG9GVdLi/p9VvYIowsQCuKcOA8EFmfr7EjA2vdk
         P3exDm32MM0+OeHj1K7n5QG9uQS01ntRUUgmqmEyNW25uLn4BJJDywQQjtn8ZmNXrlVn
         bTc7q/mqG05Pv/uvi5e1mcbtoGWHReUHKVe8sZWoOy9a/JF09KfLqvtQD1sxJNBRKaFg
         s4BkT041h64gpLG4JsczPT6gtwpJ+HZKZXARwGQXE2/X42/TFt4fXSWSvjXvzkXFnuuC
         O8XRTSXwWkYATnhfUiCOji2nNHGdVHuxJloS6LLyukJnrBZ/cgltl4Cxdv9uA73iym9D
         p3gw==
X-Gm-Message-State: AOAM532OqQ/UfU2+5fkrLXFxaEh0qIAUPW6XSvkos5FwdbDdLOnskv4v
        aLwslL/8wPS+YttZ4XnlC4w=
X-Google-Smtp-Source: ABdhPJyEhkR/qdlbeu40wjHSvZAoJuta0FzaEyrHIFXPo2bQIO4gJ/P19fPoxfd7hJcGIzaghYvWtA==
X-Received: by 2002:aa7:cf93:0:b0:40d:e8eb:1dd2 with SMTP id z19-20020aa7cf93000000b0040de8eb1dd2mr7964338edx.441.1645807640691;
        Fri, 25 Feb 2022 08:47:20 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id cf10-20020a0564020b8a00b00412b19c1aaesm1564270edb.12.2022.02.25.08.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 08:47:19 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nNdkV-000etC-29;
        Fri, 25 Feb 2022 17:47:19 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 00/14] Finish converting git bisect into a built-in
Date:   Fri, 25 Feb 2022 17:44:10 +0100
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
 <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
 <xmqqo82xs1ue.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2202251700110.11118@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <nycvar.QRO.7.76.6.2202251700110.11118@tvgsbejvaqbjf.bet>
Message-ID: <220225.86mtie7v1k.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 25 2022, Johannes Schindelin wrote:

> Hi Junio,
>
> On Wed, 23 Feb 2022, Junio C Hamano wrote:
>
>> [...] the parse-options bit I am not sure about (read: I do not have a
>> strong objection, but I do have to wonder if there is a better way to
>> achieve the goal) [...]
>
> After spending a lot of time to try to make it work, I realized that it's
> in the name of `parse_options()` that it's not a `handle_subcommand()`
> API.
>
> So yes, I agree there is probably a better way (and e.g. `git bundle`
> and `scalar` would benefit from it, too): designing a proper API for
> handling subcommands.
>
> That's safely outside the scope of the patch series, of course.

I think SZEDER has some out-of-tree patches to do that, for what it's
worth.

But it's not emit_usage_info() either (at least not directly), and we
also use it for that.

So this seems like a distraction from the feedback I provided on your
patch.

Which for one is that due to bugs in the conversion things that emitted
usage errors before are now silently accepted.

And that whatever we do to make things *easier* for
bundle/stash/commit-graph etc. when it comes to this, doesn't explain
why you feel the need to introduce yet another pattern of doing this,
when the existing "handle subcommands" built-ins do it rather uniformly,
and AFAICT there's nothing in the "git bisect" case that's special
enough that it wouldn't be served by pretty much copying that template.
