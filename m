Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3936FC433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 01:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbhKWBPM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 20:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhKWBPK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 20:15:10 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F67C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 17:12:03 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id x6so72610487edr.5
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 17:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=KzYFO5YDzNlZSeLSIpU7v9B2O1Cw6ORU5YmW9E2eDMo=;
        b=jTYKHbOq7auFhJDlwxJpLoBdA7HySrC4GF9LhQXOmj4RKy96NB074tWO+6rWQPzzoS
         rN+ZcCv9xWxPKPyfg2J7F15Gvr+h7KXSbXsjY+Kb5nEfmnYKDgu04vCepdCeRLnPCDta
         JtA/apunkugutE2itFM+kKsdTw6Qf0NkGQu3a0aNjeSRV3tH7YbbYHZ/JX3sa4ZSBJR1
         8k76ua7UF2JEHBEndQrGu3OXdbFxseZN1UvbPFQOJPxWtlhPZmhzlc7Cd7sdhGoJ6xHU
         d4cehdNAQkBOIrio7310TE/dhEgcvnCE+yCWavyRbcTswVK0/A/oOP2Lcc6wK/kjwAn8
         9gPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=KzYFO5YDzNlZSeLSIpU7v9B2O1Cw6ORU5YmW9E2eDMo=;
        b=VYTER1Pzx8xf3wAtksqoW98V3ybZCxRe+0Hjn2BToV5c0IVvkfhlQBb076c+Au6GoN
         ycf59G5uOZCZgMNSKsptICuGsgtfOrwutuUXhPohx139jhwA2OqbTXdhBmzDczE0uij4
         6vWTNzn6JQBhfXOHfKUBtmz7SeUCl3oYHy01m5HwMEbTne0hsT75GHok0N8D8oS/1kMh
         tE08W5AD33Rns03lwxxjU1VWMpj0n/fH0pyn6/gk6RkIeKh1arVt6uMbx+WfMsYflJy/
         h/kyKTNy9OB1HKQxx881fDGeUDAKoyzTaZQ2zho8umlh6wnzSB+EzTusiB38/FBgyb6T
         bXbQ==
X-Gm-Message-State: AOAM532arB1ICF+dHDD8UyVbs1wjpsamp59LMCVTl4pmy4tBS9ZKLEhL
        j4bFsey1Vtyx3lsVdVUnj2yNwLz9FMKcWA==
X-Google-Smtp-Source: ABdhPJwG2Y17KNtFbvT6GWTB5T6rN6mDGQrJtNbsmbuZyH6hw7mrUbkiS3RExIaLyiudgper9h9jVQ==
X-Received: by 2002:a17:906:d20c:: with SMTP id w12mr2152672ejz.521.1637629921922;
        Mon, 22 Nov 2021 17:12:01 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id y15sm4842029edr.35.2021.11.22.17.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 17:12:01 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mpKLo-001Fq1-VQ;
        Tue, 23 Nov 2021 02:12:00 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        congdanhqx@gmail.com, peff@peff.net
Subject: Re: [PATCH v3 1/1] ls-tree.c: support `--oid-only` option for
 "git-ls-tree"
Date:   Tue, 23 Nov 2021 02:09:05 +0100
References: <cover.1637567328.git.dyroneteng@gmail.com>
 <6c15b4c176b7c03072fa59a4efd9f6fea7d62eae.1637567328.git.dyroneteng@gmail.com>
 <xmqqczmsf2d2.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <xmqqczmsf2d2.fsf@gitster.g>
Message-ID: <211123.86tug3wu8v.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 22 2021, Junio C Hamano wrote:

> Teng Long <dyroneteng@gmail.com> writes:
>
>> Sometimes, we only want to get the objects from output of `ls-tree`
>> and commands like `sed` or `cut` is usually used to intercept the
>> origin output to achieve this purpose in practical.
>
> "in practical" -> "in practice".
>
> That's true and that is exactly this plumbing command was designed
> to be used.
>
>> This commit supply an option names `--oid-only` to let `git ls-tree`
>> only print out the OID of the object. `--oid-only` and `--name-only`
>> are mutually exclusive in use.
>
>     Teach the "--oid-only" option to tell the command to only show
>     the object name, just like "--name-only" option tells the
>     command to only show the path component, for each entry.  These
>     two options are mutually exclusive.
>
> perhaps?
>
> The above leaves "mode-only" and "type-only".  I wonder if it is a
> better design to add just one new option, --hide-fields, and make
> the existing --name-only into a synonym to
>
>     git ls-tree --hide-fields=mode,type,object $T
>
> which would mean we do not need to end up with four mutually
> exclusive commands, and anybody who wants to only see object names
> can do
>
>     git ls-tree --hide-fields=mode,type,file $T
>
> Note: the above uses the terminology in the OUTPUT FORMAT section;
> if we want to use "name" instead of "file", I am perfectly OK with
> it, but then we should update the documentation to match.
>
> Come to think of it, I think "--show-fields" may work even better
> than "--hide-fields".  We can use it to get rid of the "--long"
> option:
>
>     git ls-tree --show-fields=mode,type,object,size,file $T
>
> would be equivelent to
>
>     git ls-tree --long $T
>
> The field order may need to be thought through, especially when "-z"
> output is not being used.  We may need a rule to require "file" to
> be at the end, if exists, or even simpler rule "you can choose which
> fields are shown but the order they come out is not affected" (i.e.
> "--show-fields=mode,type" and "--show-fields=type,mode" give the
> same output).
>
> I am OK if we started with "only a single field allowed" and extend
> it to support multiple fields later (until that happens, we cannot
> emulate the "--long" output, though).  Then we do not have to answer
> two tricky questions, what to do with the output order, and what
> field separators are used in the output.

All of which (and more) would also be addressed in an obvious way by
just supporting --format as I suggested in
https://lore.kernel.org/git/211115.86o86lqe3c.gmgdl@evledraar.gmail.com/;
don't you think that's a better approach?

As noted in
https://lore.kernel.org/git/211115.86mtm5saz7.gmgdl@evledraar.gmail.com/
we could start by simply dying if the format is not on a small list of
formats we handle, i.e. not implement the strbuf_expand() change to
start with.

A --show-fields and --hide-fields seems like a rather elaborate
interface in lieu of just having a --format.

You'd presumably then want a --field-seperator and
--name-field-separator (we use SP and TAB for the two, currently), so
we've got N option now just to emulate what a --format would do for us.
