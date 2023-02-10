Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A68C636D4
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 19:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbjBJTuc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 14:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbjBJTub (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 14:50:31 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AFFFF2B
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 11:50:03 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id p26so18564360ejx.13
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 11:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OAQ1ebVnxrxLpmq8vtAe2HLJX+oflGhLoZBvgv1oQkk=;
        b=mp7BP5URDeWEsEgCYWCXLp1fpyIhuKzTGWyxwH7IUK+BzUpj2xafUBeQ6qThuqevlT
         M3IAhps8BpEVfQW+C3+GddGmlT7m0Av6Holn34wnDyzDF7GdSczKKP0shAJTa4gfk9kF
         AiFAvslrMaoJ8SMgNi0iFiJNguygJ8p74HVWtnOWMcSmF7Oxf8Keny50snogTFNm0DwV
         8dAlXEg4DVsL3wqO/mi+VBFilD3RVW0hd7rTG4XXfvdKUWlpP7c05GvQryVGMHjAkuYK
         E0Fc/L/cZHB1ULlv9cbTwDsAoQOuXohLBC9eWPjS5oq7PH2wXX9cWNY1NHSV6ZxYVIcx
         /N4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OAQ1ebVnxrxLpmq8vtAe2HLJX+oflGhLoZBvgv1oQkk=;
        b=jdnA8ZCKt20U5yK8xlZln4L5Lkr3ol82kYmR+OD3iX0SHO0Qp+cahfT5fP4xvE5Oxw
         HJe3StLyFgquD1fI/aLeCP/DNn9xitvcvh6tKCZd3CNGMtBodGUUm3afxh+fDfgggPtE
         W4m8AsroY+zrfb/ezdVfToxlIBUssWbOIjAX3le3y9vLT0Cp0CHccRIfnYNaPeONsPt9
         DBCVHwC7n1c6zlRd9O2PQkWm3osUC6LdFEXlwZkknTB41aTOOqwTrsCdIupVncF81ItM
         kBH86YtSLMrpWgGe+wqgLAwbfhFS9mgpV/ntIUKn58K/HzxTo6Bo8FXlzSKvDA0SL4tx
         Thqw==
X-Gm-Message-State: AO0yUKVTiAkxdRIt1gjrtHUffxbHzHtsysb2aq1EPvog9sIHvVN1eGxR
        rvemPwiQAnmMhidMnqr+26bdCeW2iYdveZys
X-Google-Smtp-Source: AK7set+8rTXgVlryzbD80KZziowr6GoaC7OK4jNQu1O6dtXI3TRm8WOotJI46WgNvtlv5MTc/O5SZQ==
X-Received: by 2002:a17:906:3a8e:b0:881:ad59:97f5 with SMTP id y14-20020a1709063a8e00b00881ad5997f5mr19895722ejd.2.1676058554241;
        Fri, 10 Feb 2023 11:49:14 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id mv9-20020a170907838900b0087bd2ebe474sm2771859ejc.208.2023.02.10.11.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 11:49:13 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pQZOT-00251h-0o;
        Fri, 10 Feb 2023 20:49:13 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] test: make SYMLINKS prerequisite more robust
Date:   Fri, 10 Feb 2023 20:39:11 +0100
References: <xmqqwn4sq73f.fsf@gitster.g>
 <230209.86k00rzqsz.gmgdl@evledraar.gmail.com> <xmqqbkm3ppn8.fsf@gitster.g>
 <xmqqk00pjuli.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <xmqqk00pjuli.fsf@gitster.g>
Message-ID: <230210.86o7q1uwqu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 10 2023, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>>> I wonder if something like this is in order?
>>>
>>> I don't have much to contribute on that front, but this is really
>>> missing some "why", this worked before, why is it failing now? Do we
>>> have any idea.
>>
>> Your guess is as good as mine.  I do not do Windows.
>
> This morning, I notice that those CI jobs I ran last night that
> failed with "whoa, windows tests are somehow reporting that symlinks
> are available but not really" issue the patch in this thread were
> attempting to address has passed even for branches like 'master' and
> 'next' that do not yet have it, and it seems to be because you
> re-run these failed jobs.
>
> Whatever magic you used to fix these failing tests, thanks.
>
> Do you have an insight on why and how these were failing?  The patch
> in this thread was a band-aid without knowing why all of a sudden
> "ln -s x y && test -h y" started passing (while compat/mingw.c still
> says readlink() is not supported).  If we know that such a breakage
> is not expected, we can drop this workaroun, which would be great.

I'm not Johannes :) But as I noted upthread this failed when we went from:

	Download action repository
	'git-for-windows/setup-git-for-windows-sdk@v1'
	(SHA:cbe017cd7ae39629bf4e34fce8b1ccd211fec009)

To:

	Download action repository
	'git-for-windows/setup-git-for-windows-sdk@v1'
	(SHA:848609620edfa4c2fc64838b85fbe19e534236ee)

And now our passing "next" has:

	Download action repository
	'git-for-windows/setup-git-for-windows-sdk@v1'
	(SHA:a8e2a23eb07129d628ff6f9d5f11047b0662aeba)

If you then look at that range in that repository you'll find the
release includes:

	https://github.com/git-for-windows/setup-git-for-windows-sdk/pull/595
        https://github.com/git-for-windows/setup-git-for-windows-sdk/pull/5=
96
	https://github.com/git-for-windows/setup-git-for-windows-sdk/pull/597

The release notes for the last of those then has:

	"Fix issue with symlink restoration on windows".

Which from some looking around seems like it might be the issue we've
been seeing, it's this commit & PR:

	https://github.com/actions/toolkit/commit/b2d865f18051b214475dae41766e9970=
fd68ca12
	https://github.com/actions/toolkit/pull/1291

And following that rabbit hole leads to Johannes noting that this (or a
related change) was breaking GFW:

	https://github.com/actions/toolkit/pull/1291/commits/2867e318d4d0de11b10a2=
887fb29dcf713559a71#r1098571737

So I think we can drop the workaround, at least as far as fixing the CI
breakages goes.
