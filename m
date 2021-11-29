Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE38CC433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 23:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhK2XpG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 18:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbhK2XpB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 18:45:01 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4409DC061574
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 15:41:43 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id r25so13563595edq.7
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 15:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=AF6ggVhTObUBNde7EkbOYQLbKyKydAs+tr2OKO6edzE=;
        b=ktysx6EIV7DIFZy+rf2O2jql04+SwMiFgwtojoHfpzW94xqJNkzXRYb2873EgNNDPl
         WuMa6JCWSRbE2UFlKZMUFeSDWqDwk98+eDKxTwYRMzgkeGuFNLC2pHxThaNX8UavVTlX
         ZEkgPF/7XieEVGfE+isqUnQFDrI5a36B0AjIr7ay5Nrqa4f8K4NxhPIJgczJqjdSUJml
         KRHqaxP39h4uihSH47AhAdcT27BOjxngTWugBr19HhysE3vACwhNue6uD5B7I9Lc11+K
         Ho56XGS2J8cCgn6b/YfcS/CGtKQ0yOfiVaX2BNIItuFFZyK8Ng8g2exId2hCCuprbJd7
         yoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=AF6ggVhTObUBNde7EkbOYQLbKyKydAs+tr2OKO6edzE=;
        b=d5OMGALpi2XaVBxb3D79Q4mKRWjDJPc5Ag8/4oOu3MRJUE7iJ/itAFtHzSHpzTBzPw
         g8TBK78msL1SIPplGgDZEwTJPIiHCSgSQXBTm6D+AkreGgNdiWZkxLfGf8sHaTg7i8Ww
         ubW+Z6WBU8IHvwbs1pK4RkIFmW9fUm53E3sjzjxPC/zpBbiC1FW6j8xMuDwpWNnge8ru
         1JDJY1kMrkZVQTcyc9GqyYTtLBGMQ14pvP80rJBjOXS6XOf1EK99sbSEGPyrC4NOhPcO
         6uiXCdxIJXpBM9mBQ4uy4fitAXbPwteOK6wAThrXPnHTJpNjhnovPCfv1kCubx7momFH
         pWBw==
X-Gm-Message-State: AOAM533FSfxcoDcx1wZPdWfLeznmwrpVoPovDg9KtaLyJoq7Z1ioy4lx
        Eppn4v3KCCnxQXDpP5TvVOPvvIFbnDm6EA==
X-Google-Smtp-Source: ABdhPJyR4Za7RAkEyfTYZlghAbefWSU+ZNd/d5uTD49O2OnKf+PJ9MJ7zcXY8kPB3K5TLg76EKw1pg==
X-Received: by 2002:a17:906:2ed5:: with SMTP id s21mr62352786eji.30.1638229301813;
        Mon, 29 Nov 2021 15:41:41 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m6sm11458085edc.36.2021.11.29.15.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 15:41:41 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mrqHF-000sK5-05;
        Tue, 30 Nov 2021 00:41:41 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 0/5] Inspect reflog data programmatically in more tests
Date:   Tue, 30 Nov 2021 00:28:39 +0100
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
 <pull.1145.v2.git.git.1637855872.gitgitgadget@gmail.com>
 <211129.86czmjgtfd.gmgdl@evledraar.gmail.com>
 <CAFQ2z_OioNmOP+_VvP71DTDqkaVLZg01yx5QVNo+mVGXxsUJ9Q@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <CAFQ2z_OioNmOP+_VvP71DTDqkaVLZg01yx5QVNo+mVGXxsUJ9Q@mail.gmail.com>
Message-ID: <211130.86r1ayedhn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 29 2021, Han-Wen Nienhuys wrote:

> On Mon, Nov 29, 2021 at 11:14 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> > This helps for reftable support, and will help if we want to reconsider
>> > under which conditions reflogs get created/updated.
>>
>> Having looked at this in a bit more detail than last time
>> (https://lore.kernel.org/git/211123.864k83w3y4.gmgdl@evledraar.gmail.com=
/)
>> I applaud the goals, but to be blunt the specific approach just seems a
>> bit backwards to me.
>>
>> As noted in that message I have patches to tweak the "verbose" mode to
>> be backend-independent, which as we see from your series is one thing in
>> the files backend that consumes the "message" and assumes things about
>> newlines.
>
> In v2, I went with Jun's suggestion, and left the newlines alone, just
> trimming them in refs/debug.c .  I think that makes most of your mail
> irrelevant?

To whatever immediate problem you're trying to solve? Probably. I'm
mainly pointing out that we can make some of these APIs nicer & a bit
more abstract from the details of the file backend.

Or, as is the case with "ident" v.s. "committer_name/committer_email" in
these reflog callbacks no existing caller actually cares about that
format, so if/when we get to that reftable integration (which seems to
have the two as seperate fields) splitting those up in refs.[ch]
probably makes sense.

>> Perhaps reftable is capable of just handing the underlying code pointers
>> into the mmap()'d file, so we could even skip all (re)allocations? Or if
>> not, that certainly seems like a sensible thing to anticipate in a
>> backend-independent interface. We could do that in the file backend if
>> we were a bit smarter and used mmap() instead of the
>> fopen()/read-in-a-loop pattern.
>
> It sounds like premature optimization. Reading reflogs is not usually
> a performance sensitive operation. Also, if you hand out mmap'd
> pointers, how would the reftable storage code know when it is safe to
> close and munmap the file?

The same way we do the fopen/fclose lifetime now, i.e. you could rely on
them for the iteration, which seems to be a common pattern in code that
needs this.

I was aiming more for the lack of premature optimization there,
i.e. instead of byte-twiddling things by injecting \0s we could just
have char */size_t offsets (as noted elsewhere), which would also nicely
allow binary storage formats, if those formats happen to have an
embedded string. Is that true of reftable?
