Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D49C433F5
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 18:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiJESDE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 14:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiJESDC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 14:03:02 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397152DABB
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 11:03:02 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 204so1654816pfx.10
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 11:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9xLpK5ylODhtBkONZ8Bnp3Oji+iGE3jFAbXLzdDSo0Y=;
        b=OcDDm0SqxKwUrtwI3tl+MSru+vLacXRWPpVojhAiMfUbNoI91z+wpUdlNqYidmfUS6
         CfsXVk3WEUj3Ic5B2BJO4vX3LuhDoi5UnyaCdpkp/JsNLhPpkTEFbQESnbYtSeA7MT+v
         E8kJ+oxj5PZCLNfs2/5TirjpVVwVMNkT7lQ/ZY2zRFj3GgeZHOnhzmWD0Vl+RXx2WuL8
         8DjjTlykY39ysET7aSUyIcvQKBiqO5l1+bm+EPmwg4UfVsHAZRwSkX+Lwsmg9GanGk2+
         sFXgAhTVsfNlyJlDMee0oan5Ys46KwDykbbB4SbNAiP+5dmKMQAcASB9U+N8r2iCB7EL
         dBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9xLpK5ylODhtBkONZ8Bnp3Oji+iGE3jFAbXLzdDSo0Y=;
        b=EuYStwnF9z+E/zoDbuLvAVKCNjwVzZ/2rgxem4Xntg+DgAranN+qsPUhab6cS9p1jR
         S2+cu1YLCaA8L7swkM/wScnBwRD+68CklQglPmuRbhAv0rPAVQfF7UI7md/ShK3xZw/p
         riC8qh6nlw3xmoSJa1YNiF/8y8bfmygHi2U5hg8B601CFxFWwjr30llOFxKyZkOGnEqu
         +zwWPvFtk3VQ/C3yo37RIt3LI6KLbwzKVm/rmYdxzzTJ1canY77kK3XYEGlWigSn+Ihu
         hc7UdvNUvDk2vgXuMmR+KT1emOJsg5WEvnMdCVHIPYwg1Zp2sey3sx2+FHWh81SN0TER
         +HXg==
X-Gm-Message-State: ACrzQf1tRof6etb6ctr8xzAyzrAfxBiTjvPU7qtNR335I0u0ozdr3Rhs
        manJ5j+9twz1WfeLpH3rGVA=
X-Google-Smtp-Source: AMsMyM5sOnGNDN8otQgJFhPU8EXMfjUet4+cNcuLjALgWmvPO3IyoPno5oE6RyzEGIkUfpiRIQzkNQ==
X-Received: by 2002:a63:64b:0:b0:456:f61d:7041 with SMTP id 72-20020a63064b000000b00456f61d7041mr847186pgg.445.1664992981615;
        Wed, 05 Oct 2022 11:03:01 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id l16-20020a170902f69000b0016c5306917fsm10885646plg.53.2022.10.05.11.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 11:03:00 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 6/9] trace2: convert ctx.thread_name to flex array
References: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
        <6492b6d2b989e08bb539fff3ffe5bdf50fa0a195.1664900407.git.gitgitgadget@gmail.com>
Date:   Wed, 05 Oct 2022 11:03:00 -0700
In-Reply-To: <6492b6d2b989e08bb539fff3ffe5bdf50fa0a195.1664900407.git.gitgitgadget@gmail.com>
        (Jeff Hostetler via GitGitGadget's message of "Tue, 04 Oct 2022
        16:20:04 +0000")
Message-ID: <xmqq7d1eqhbf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Convert the `tr2tls_thread_ctx.thread_name` field from a `strbuf`
> to a "flex array" at the end of the context structure.
>
> The `thread_name` field is a constant string that is constructed when
> the context is created.  Using a (non-const) `strbuf` structure for it
> caused some confusion in the past because it implied that someone
> could rename a thread after it was created.  That usage was not
> intended.  Changing it to a "flex array" will hopefully make the
> intent more clear.

Surely, "const struct strbuf name;" member would be an oxymoron, and
I agree that this should follow "use strbuf as an easy-to-work-with
mechanism to come up with a string, and bake the final value into a
struct as a member of type 'const char []'" pattern.

I recall saying why I thought the flex array was overkill, though.

You have been storing an up-to-24-byte human readable name by
embedding a strbuf that has two size_t plus a pointer (i.e. 24-bytes
even on Windows), and as TR2_MAX_THREAD_NAME is capped at 24 bytes
anyway, an embedded fixed-size thread_name[TR2_MAX_THREAD_NAME+1]
member may be the simplest thing to do, I suspect.

If we were to allow arbitrarily long thread_name[], which may not be
a bad thing to do (e.g. we do not have to worry about truncation
making two names ambiguous, for example), then the flex array is the
right direction to go in, though.
