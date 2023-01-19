Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F39C004D4
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 15:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjASPiO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 10:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjASPiL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 10:38:11 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C433C829A2
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 07:38:02 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id vw16so6627712ejc.12
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 07:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9j4qHUdzy8ccQ99JCZfe07VNYqZJ4q8yx0NCobvCzek=;
        b=qgseGCEOfu7XAHPKgokyDuJgOl7vRN+SdRGrPuVIC9wQpMWE9IfrJxE+cs0f2jSPca
         UeEHhNdk//tkBvb3ig4stzamW8U6KUQDa58Vu973pkrWzpHLZK+T27zm4vg7BvEWVVT6
         RCEdekAIF+9ZCu4VMQJ3Tkj6DTxmTZq3jDcgcFTtItBbng4C4PIPwKbyDdajabwPFF1M
         ru2j7qgh+IHSJ6zPJ88B6YE9Fe4buBqNpzpIxlwyP644Hd32YAqv0j5659twGRQOeLIQ
         UGWinrC2SMgWYbsoThZqdVFu64VlYH0icmdHKUsQgUn9v7qLFzXKzqJA1IFOglnKbGu8
         XzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9j4qHUdzy8ccQ99JCZfe07VNYqZJ4q8yx0NCobvCzek=;
        b=THiyFkZJu0ZOYDcPFMKncli01wwsM0H8IK1kqErQxNYisMt8YoAPMX5mW6Ws8tkTLo
         f6yp+9D7vjhzVcH8Ol5sinEmymAuSvbLz5DeFoQe0qj4DYaH5f/TzS97rgfLogCE97l1
         lGGGr7nE0kfQq6Nty04lLYzf/iLwohlqEFaqt0GYng8R6DB9TsjtM+h7l9xZd2qAp+fS
         cnO84f6tN1q4+0tEjsJFISFLgpK3k9uO/Sm7V6bZxBd96GYQ2A+J6vTMd+v2smLqKE8I
         fPKsjR1ZfFU3fQSJzlMpuaaANP2/lxH4q9tnRwolw4CTUjxPjR6B0DyfoMoTL2g3MFkp
         yekw==
X-Gm-Message-State: AFqh2kpSTNixI9OWbRj8AM1ZSqtTY7WIIu5fhNhcEAj70pZ6DRPXZ+lX
        4EhIyCOMdb/nQucsGykq4ZY=
X-Google-Smtp-Source: AMrXdXs1O0QE5h9qhMeFQjPwbMGjeXUNltn/ZtmobCzO4W33g8DqMGoR/G0DaPzCW09WFlc32JVVJw==
X-Received: by 2002:a17:906:8d08:b0:86f:e30c:72c1 with SMTP id rv8-20020a1709068d0800b0086fe30c72c1mr13120829ejc.8.1674142681085;
        Thu, 19 Jan 2023 07:38:01 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id lb25-20020a170907785900b007c00323cc23sm16417526ejc.27.2023.01.19.07.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 07:38:00 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pIWzH-003KZZ-2v;
        Thu, 19 Jan 2023 16:37:59 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v8 3/4] worktree add: add --orphan flag
Date:   Thu, 19 Jan 2023 16:32:32 +0100
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
 <20221220023637.29042-1-jacobabel@nullpo.dev>
 <20221228061539.13740-1-jacobabel@nullpo.dev>
 <20230107045757.30037-1-jacobabel@nullpo.dev>
 <20230109173227.29264-1-jacobabel@nullpo.dev>
 <20230109173227.29264-4-jacobabel@nullpo.dev>
 <e5aadd5d-9b85-4dc9-e9f7-117892b4b283@dunelm.org.uk>
 <20230114224715.ewec6sz5h3q3iijs@phi> <xmqqo7r0ijdv.fsf@gitster.g>
 <20230118221745.wovefwx6vhcm3zzk@phi>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230118221745.wovefwx6vhcm3zzk@phi>
Message-ID: <230119.86zgaev8ko.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 18 2023, Jacob Abel wrote:

> On 23/01/14 07:09PM, Junio C Hamano wrote:
>> Jacob Abel <jacobabel@nullpo.dev> writes:
>>
>> >> 	git worktree add --orphan -b topic main
>> >> 	git worktree add --orphan -B topic main
>> >
>> > I am hesitant to add these as they break away from the syntax used in
>> > `git switch` and `git checkout`.
>>
>> Not that I care too deeply, but doesn't it introduce end-user
>> confusion if we try to be compatible with "git checkout --orphan
>> <branch>", while allowing this to be compatible with the default
>> choice of the branch name done by "git worktree add"?  "--orphan" in
>> "git checkout" behaves similar to "-b|-B" in that it always wants a
>> name, but "git worktree add" wants to make it optional.
>
> Yes. I think it's a fairly minor degree of confusion but I agree that it adds
> potentially unneeded confusion.

I think this topic is ready to advance as-is without Phillip's upthread
suggestion (<e5aadd5d-9b85-4dc9-e9f7-117892b4b283@dunelm.org.uk>) to
allow us to combine --orphan and -b and -B.

I also think that UX suggestion is sensible, but if we do that we
shouldn't just apply that to "git worktree", but also change the the
corresponding "git switch" UX, on which this new "git worktree --orphan"
is modeled.

I don't think it's worth it to make the UX between the two inconsistent
in this regard, so if "switch" doesn't learn to do this we'd be better
off with not making "--orphan" a flag.

But if we are going to make it a flag let's have both support the same
sort of invocation.

Therefore I think this series is ready as-is without this proposed UX
change. We should first support the same sort of invocations that
"swich" already supports.

If we then want to change the UX later we should change it for both, not
leave the two inconsistent.
