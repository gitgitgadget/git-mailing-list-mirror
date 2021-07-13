Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7FAC07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 18:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D11B361026
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 18:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbhGMSaw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 14:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhGMSaw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 14:30:52 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6C6C0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 11:28:00 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id v1so34465332edt.6
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 11:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=lqfyalCXShFdoMyy4Lyaxjb3pEejf4ordJlc9iGWN1s=;
        b=Q5ECCILgSma25myh0iJBEDeAztVE/EBCWKymr4tGSY37UND0hxV1xjcdAYSrISfIew
         NiX7STLwNC2z7hiuAMWLn4tdq/1cZgIKkJUE2Bk4aC0wTM9oF+hEDp6LOtJmZ4mRbQbN
         2q/lsFGgwi1YAhaC0wLpJqQx7L4oDZQkPlSzjKHtUmvl8KrBtBgm30VKjFKfER0MWgCF
         ZKEtdnUbTcu9HPZNanryaJB4LsBwV4/E/pf/gBQHVU2nyyHlzJPJZq6oOKl8fb156R45
         iJjkxA5AFjmbwaG4wM/CJDNb5wsmvmVmUQGd4inVDBP+G5Bfhlksy7p8JgKy/XDyMFnp
         P4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=lqfyalCXShFdoMyy4Lyaxjb3pEejf4ordJlc9iGWN1s=;
        b=lCDkty4eiJnurvmNYADK3XVpTnt3bhSIVMDZpqmz0IsxHrDwCZCUE4AIVBYmWBVUIv
         F2C5YGBu9OHgR9snNoubnQ1D94d1p7nOdyGxiN0Z5vSNPsPuQk9p4YbvThUlKFYPfLl8
         vVRu3d5DuVNi2v/8BxIWy18yCxlAkf8g9fuo58/PYh0zY21fbWIKD9leXG9LYFRDdYBz
         fnuBo0Q2I9E1vSJCGTvT4eZgLADxpu5vhn6mD65cBz+acXSfPtd5RpvETROzoc+gp9nV
         +q2H//5gcXUS9ErOnfaj7kalxz7AW5NCn2QhQ+gzgt6XjdYxjSBC04XSLFQPShorZsIk
         QG5g==
X-Gm-Message-State: AOAM532ujHrypfy8f3wgWVXwpVr13oUuA2kMUTVPvV2aEB/5d0Efc6Zp
        mhf7HdNfq1RoPGrlK/iqk3rZCP/5opyd7g==
X-Google-Smtp-Source: ABdhPJwb0fvJfhxwdtNndK1OOjCHxSda+myTWj9rd/g3yqKxnPhROZV1WAY3Byv0vAGSWXrb8iQ2cA==
X-Received: by 2002:a05:6402:193:: with SMTP id r19mr7601701edv.104.1626200879083;
        Tue, 13 Jul 2021 11:27:59 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id f22sm4172733edr.16.2021.07.13.11.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 11:27:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v6? 00/17] refs API: get rid of errno setting entirely
Date:   Tue, 13 Jul 2021 20:26:06 +0200
References: <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com>
 <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com>
 <CAFQ2z_M7FzR6HEea2Xj-j=LiTsjQvpGJc+h+D+GgU=ZEkWm50A@mail.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <CAFQ2z_M7FzR6HEea2Xj-j=LiTsjQvpGJc+h+D+GgU=ZEkWm50A@mail.gmail.com>
Message-ID: <87h7gy2hn1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 13 2021, Han-Wen Nienhuys wrote:

> On Sun, Jul 11, 2021 at 6:30 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> After starting a review of v5 of Han-Wen's where I was coming up with
>> squashes-on-top I continued with it and saw if I could get rid of
>> errno setting entirely in refs.
>
> thanks for taking this further! Is there a place where I can pull this
> code (applying patches is bothersome).

I've got it pushed to avar-review/pr-git-1012/hanwen/einval-sideband-v5
at https://github.com/avar/git.git :
https://github.com/avar/git/tree/avar-review/pr-git-1012%2Fhanwen%2Feinval-=
sideband-v5

> It adds resolve_refs_unsafe_with_errno() to the  public API in refs.h,
> and I think it has an ugly signature, but I suppose it's better than
> having the output be implicit through the global errno variable.

Yeah it is a bit ugly, perhaps we should just end up using the old name
once there's no callers of the old one?

> I read over your patches, and they seem OK to me, modulo small
> comments I posted.

Thanks, don't have time to look it over in detail now, will reply later.
