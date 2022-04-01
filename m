Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8833C433F5
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 10:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345188AbiDAKtu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 06:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345182AbiDAKtr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 06:49:47 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF029269A7E
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 03:47:57 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id yy13so5036559ejb.2
        for <git@vger.kernel.org>; Fri, 01 Apr 2022 03:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ZFSOJt0h5wTqlK9v08Oz7HA2GPHTwqhVCx68hN4mE5k=;
        b=SThFbWfrFRVnMcybab2moZdN6tQTDdYRRd0LYzp+f7q4Y2KZPJmNogeJWVzCsWCiwF
         +mQmWi46luzStEbYO3qKKwMLKDffu5VkOpXS/UxuFSSrvxBg8DhmfCfKrgRnRT8xFZ/p
         zQNZbi1IIyQtJFipwDjazTs45rV33l1vavQf5+RMGua52nq+nMfxs4EK60pzBfQwBvai
         Sd/tANPtwGlR3hftQjDSQggnTWSgNGzfw8n6tiEJraMDJ+8YczmeYN0V1/B22IJmi7li
         TxrdjhZ2bblLMLWix3u9ltSZy/6jacEEPx+PhWXjkBhayYTFTVOMVj114YrbOfiMIEfj
         cN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ZFSOJt0h5wTqlK9v08Oz7HA2GPHTwqhVCx68hN4mE5k=;
        b=dM/FnmeU3dOL8P64XJkZIrJF7gr63EIz6ly2t8shKF0FLszrpEQZd+VlE3YAjEGRsb
         KEy8ZPluQRqllViZgKZvLjQRueH3s9ZUlyXISxLi5TqQ8TG0zl6BVfRD1swQFNhZgnq+
         Fhu7qxHt1G0TY3ula/tpDrM6Qhe3jA/Fz8doQjEyOER9zYEooNWp4BeOexFmD+Sh4YfK
         0NucizsagJpk+jPdgEK3PQCCXKj+tNnxbjTIZYEwNVfxj9NtBB0MWWwBo3WDyEM91ub0
         g2qLbpeBF27imqHtvqlhFillnSSIG97fOAfFp1jX8B7SQInI9a6x/9FZ5zRM7pxLA6HX
         66LQ==
X-Gm-Message-State: AOAM532TZxOVIbX3h+w5f/YhIV87TYPk+YgwGbdyVcYSEDGzgPPAUNd3
        Nv4PJKL6jPsB2JtEG2ralRA=
X-Google-Smtp-Source: ABdhPJxQaeG5bPlU2fLAWOSmxzEuTPIKicR/LhAR4Yap9ko3C6z4bk/6Zjqav2JOmVQOTy8jculLSA==
X-Received: by 2002:a17:907:1c20:b0:6e4:b753:93fc with SMTP id nc32-20020a1709071c2000b006e4b75393fcmr5185496ejc.363.1648810076371;
        Fri, 01 Apr 2022 03:47:56 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b12-20020a056402278c00b004195a50759fsm1036031ede.84.2022.04.01.03.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 03:47:55 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1naEot-0012JQ-8K;
        Fri, 01 Apr 2022 12:47:55 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 09/27] revisions API users: use release_revisions()
 needing REV_INFO_INIT
Date:   Fri, 01 Apr 2022 12:31:07 +0200
References: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
        <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
        <patch-v4-09.27-2f4e65fb534-20220331T005325Z-avarab@gmail.com>
        <xmqq1qyh25a5.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq1qyh25a5.fsf@gitster.g>
Message-ID: <220401.86h77dnkpw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 31 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Use release_revisions() to various users of "struct rev_list" which
>> need to have their "struct rev_info" zero-initialized before we can
>> start using it.
>>
>> To do this add a stub "REV_INFO_INIT" macro, ideally macro would be
>> able to fully initialize a "struct rev_info", but all it does is the
>> equivalent of assigning "{ 0 }" to the struct, the API user will still
>> need to use repo_init_revisions(). In some future follow-up work we'll
>> hopefully make REV_INFO_INIT be a "stand-alone" init likke STRBUF_INIT
>> and other similar macros.
>
> I do not think we want to leave such a misleading paragraph to
> future developers.
>
> Yes, We may want to move some of what init_revisions() does to
> REV_INFO_INIT(), and for that, it helps to start using greppable
> string REV_INFO_INT early rather than { 0 } to ease such transition,
> and that is what we should be stressing, instead of ranting "it does
> not do anything, so why are we stupidly introducing a name, instead
> of writing { 0 }, which is what amounts to it anyway?" without
> explicitly saying so but hinting with words like "stub", "all it
> does is", and "will still need to".
>
> Is that some kind of passive-aggressive thing?

No, I'm not trying to be a dick. I'm just confused, sorry :)

I.e. I didn't grok what you really wanted from that REV_INFO_INIT
pattern in the beginning, and I largely draft my commit messages as a
way to adequately explain things to myself.

The "stub" and "not sufficient (yet!)" part of the docs is a (probably
too leaky) artifact of having (after the whole thread about
REV_INFO_INIT started) gotten that mostly working as a "real"
initializer.

Which I figured I'd submit at some point after this lands. The grep.c
case was quite tricky, but the rest look pretty easy, I just didn't
finish them.

I can re-roll & omit this entirely from the commit message, and the
API docs.

I just thought, and still think, that it's worth drawing the API user's
attention to the fact that unlike most stand-alone *_INIT macros this
one isn't sufficient to be up & running with a "struct rev_info".

Which isn't the case with {STRBUF,STRVEC}_INIT, CHILD_PROCESS_INIT,
STRING_LIST_INIT_* etc. etc., i.e. if you've used any of these:

    git grep -h -o '\S+_INIT;' | sort | uniq -c | sort -nr

You're likely to expect them to "flow" a certain way when it comes to
initializing the struct on the stack, but this one will be a bit of an
odd case while repo_init_revisions() is still required, which seems to
me to be worth explaining.

But not enough to argue about it, so whatever you'd prefer...

> You cannot use get_revision() even after calling init_revisions(),
> and still need to use setup_revisions() before hand, but that does
> not mean init_revisions() is not doing its job.  It may be
> implemented as the zero-initialization right now, but it misses the
> point to put a stress on the fact that it doesn't do much now.

I don't think it's broken, having gotten most of the way towards
rewriting it to be macro-init'd there are some tricky edge cases where
we might always need to call a function to fully initialize it.

But per the above I thought it made sense to explain that this
particular *_INIT is a bit of an odd case if you've gotten used to other
such macros.
