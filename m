Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0904AC433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 21:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiANVDr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 16:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiANVDr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 16:03:47 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E3EC061574
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 13:03:46 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id o6so38462311edc.4
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 13:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=qfm2cRaNLSCiuHW1qasGlf0WYpMCpfUspahxcrFXS08=;
        b=DDUi0r4vaENLGAL/Wd6Tn18941xwnY1V+i86C5zFbrgGM3EEUzoSLkY5yenTLuauNH
         WDg6Fyeqkb9ewvDliLMcjwLNtFZX2LDUXDfxVGJQbzW1mj06xUP+EHGSX4QOUZy8vUH5
         gP6KmaBW2zbVbiqrIdRwiQqsiipLkGtuKcSzWxZpf4XL2Qy+4wcevfvglwy+t7fFpSqf
         ptdSfgg6EdFSAwB3vNLAN0tAh4heYzcAgyDO35+jVzljE22tnZNYeEgTdEmnoPFx4Fg6
         ZnAobhKjb+0E740hXy1uZEjlyDThXBavPZoQuZhllcW37MYEByHyPSd2ipOYpdUOPjmU
         /mVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=qfm2cRaNLSCiuHW1qasGlf0WYpMCpfUspahxcrFXS08=;
        b=ibFQcVsqX1jEpIraM2tXL4tpQsy8ugzZY5H6m0rugQEiDHWzEKjwIn2Xk4qgfJpUYk
         5UsXSEHTl77bPB6dIAlNB+qVH9JMxFYgom9QqQ3vThPvq7Ecctlf+xdKdpE8QYIFsd3z
         ipkciC8kuAck8BmfZIBLQW7kD63j/Fgex2B5qVBrhCA+l/BcKbHT+SomylT0+ps9EIh5
         lqKbB49bbpEaD/7oFpQXgNYmSo6liBnY+sAw7rLzN8OrW7fzK4Q0iiFdMDyHes4x6Pgv
         jDmFnUTOLQJJ91IZ3Rblc94iqzolQnZL7nqUih93TEKvGF+m/8jNdQaCgqm6BFw9nOTU
         YncQ==
X-Gm-Message-State: AOAM5319zYZCIyH8iED+llw/fHZ7ZVJhmq4EHhY0vXb7k8mAn3CKGHH4
        HL4vtaOVtj1f8tzXyDO9bJ1sA897g2IQOg==
X-Google-Smtp-Source: ABdhPJyqvIeh0nx45fdrUk6AQsyGJpfB2aBFeJTeunFgUwqlf/SQHU5IC+vZvEBSEpDd38/oBzffcw==
X-Received: by 2002:a50:9549:: with SMTP id v9mr10666770eda.335.1642194225017;
        Fri, 14 Jan 2022 13:03:45 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u14sm2642195edv.92.2022.01.14.13.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 13:03:44 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n8Tjb-001FSF-Ev;
        Fri, 14 Jan 2022 22:03:43 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [RFC PATCH v1 0/1] ls-remote: inconsistency from the order of
 args and opts
Date:   Fri, 14 Jan 2022 21:57:33 +0100
References: <cover.1642129840.git.dyroneteng@gmail.com>
 <xmqqfspqeun5.fsf@gitster.g> <220114.867db2rs0n.gmgdl@evledraar.gmail.com>
 <xmqqbl0eaw2e.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqbl0eaw2e.fsf@gitster.g>
Message-ID: <220114.86y23iqbbk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


nOn Fri, Jan 14 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> We have multiple commands that are in GNU-fashion loose about whether
>> you provide options first before no-option args, or after. E.g. we
>> accept both of:
>>
>>     git push --dry-run <remote> <ref>
>>
>> And:
>>
>>     git push <remote> <ref> --dry-run
>
> Yes, but I consider that a bug that we cannot fix due to backward
> compatibility issues.
>
> That is why my preference is to encourage users to stick to the
> POSIX way in gltcli, just like we recommend "stuck" form of options
> its parameter.
>
>> But when GNU came around its option parser was generally happy to accept
>> options and args in either order. E.g. these both work with GNU
>> coreutils, but the latter will fail on FreeBSD and various other
>> capital-U UNIX-es:
>>
>>     touch foo; rm -v foo
>>     touch foo; rm foo -v

This is only an approximate list, but:
=20=20=20=20
    $ git grep -C3 'parse_options' -- 'builtin/*.c'|grep -c PARSE_OPT_STOP_=
AT_NON_OPTION
    16
    $ git grep -C3 'parse_options' -- 'builtin/*.c'|grep -c -F ', 0);'
    101

The GNU-like behavior is far more common in our codebase, and I think
it's less surprising if commands work the same way for consistency.

I manually looked through the PARSE_OPT_STOP_AT_NON_OPTION cases, and I
think this is the only one that's using it for no good reason. The
others (e.g. "git config") would become ambiguous or error out as a
result.

> Yes, among the harm GNU has done on mankind, this is one of the
> biggest ones.  We shouldn't waste our engineering time to support
> more of them in our tools.
>
> As long as users stick to the recommended "dashed options first and
> then args, among which revs come first and then pathspecs", they
> will be fine.

I find it quite useful. E.g. if you typo a command or forget/want to remove=
 an option:

    git push origin HEAD --dry-run

You can just (under readline) do C-p M-DEL, instead of the equivalent
navigating back a few words, or having to use more advanced readline
features like ^--dry-run^^ or whatever.

Anecdotally, I've been surprised by the amount of regular terminal users
whose readline skills pretty much and at using the arrow keys to make
command corrections. I think this GNU UX decision has probably saved
several accumulated man-lifetimes by now :)

