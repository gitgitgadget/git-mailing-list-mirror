Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E86BC6FD1C
	for <git@archiver.kernel.org>; Sun, 26 Mar 2023 05:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjCZFBr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Mar 2023 01:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjCZFBp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2023 01:01:45 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F05D83FB
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 22:01:44 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id ew6so23212429edb.7
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 22:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679806902;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v0GSZVPeNjXWAVtnX5RzR+EEeeSDYUps7/yrjWh7QTs=;
        b=WF+WIAaafoqZn70smdoG/8hxfBQRsPruBArhI3xslJZt5Ju68O/zT9F1R2gth/Wm8K
         g6tMC9C2g1wG/Z7kgsyvkP66BK88a1wD6y7Y+eAlE4o1+XUqAlZhezJ1Mqia0D1FHzRF
         OzKWNV5b3tQvVF6R8cv4JchngA7EUu1CAskW9tv37UtkrNWHuNacUJhRAKG3lgVtQP+b
         mDguBa9vWCCY+lIPKiTWFlVUZhl6MWxt+2du7sHLtm2NY2r7mvKPnvkGyf2tociSdaZ8
         GxhxQdGW5rgTPQw/caERcCsZKI3WS6T9zA6JV73FRqxGidP/Xf4YPwk6viFzqoQPK/cg
         CRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679806902;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v0GSZVPeNjXWAVtnX5RzR+EEeeSDYUps7/yrjWh7QTs=;
        b=D6eC0/Z+1kwNqEmm4Q/IcwvaMcqjfQ+ou0UDln1d/gLP3drOnzQ01nQjUMV7Zghieg
         RqsXgBQ3WD9m0qT/Plo57THA9cxDSOBCwGtqoUEjBnAZYEfOw+TFJTH5z+C30T8z///z
         wGpZV3owE5SNGqxka/6ms+5NG1ajxxTJTQ4KbLihEIyEXmhtrfoI7lRn9GCh2QbCfPYM
         dZaqLxtta4xp/wMOxnvnFaC528fFfbldmsZOL8aW9Q4aU5BfSU/h/rDkFItCIntQZFaS
         brODWonHjJF/KNNdBorjN7jhLoEVi21OTbmqoc0rdb+m5opHINyMn3bSBaThI15DS0Dj
         VGXA==
X-Gm-Message-State: AAQBX9dnlMwcKJVQFn0KXmOjAKHbxrESm4ZMvN5Syxofz04D3MTB0bzq
        nVhlUOdcotdDpTW8vyiUZNY=
X-Google-Smtp-Source: AKy350ZJoTRMHXvfEEh7S7loFs+h79PCzFhwuOERqMgB3GVCpv8FJcodSu9b/e3Gnv05cCiAD4ljnw==
X-Received: by 2002:a17:907:c01a:b0:932:3d1b:b69d with SMTP id ss26-20020a170907c01a00b009323d1bb69dmr8653075ejc.47.1679806902393;
        Sat, 25 Mar 2023 22:01:42 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id g19-20020a17090613d300b00931db712768sm12397672ejc.4.2023.03.25.22.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 22:01:41 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pgIVh-004J9w-1u;
        Sun, 26 Mar 2023 07:01:41 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 15/17] cocci: apply the "revision.h" part of
 "the_repository.pending"
Date:   Sun, 26 Mar 2023 06:59:46 +0200
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
 <patch-15.17-c8ff241844a-20230317T152725Z-avarab@gmail.com>
 <kl6l8rfoe4qr.fsf@chooglen-macbookpro.roam.corp.google.com>
 <kl6l5yase416.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <kl6l5yase416.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <230326.86ileow1fu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 22 2023, Glen Choo wrote:

> Glen Choo <chooglen@google.com> writes:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason         <avarab@gmail.com> writes:
>>
>>> diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/=
coccinelle/the_repository.pending.cocci
>>> deleted file mode 100644
>>> index 1190a3312bd..00000000000
>>> --- a/contrib/coccinelle/the_repository.pending.cocci
>>> +++ /dev/null
>>> @@ -1,14 +0,0 @@
>>> -// This file is used for the ongoing refactoring of
>>> -// bringing the index or repository struct in all of
>>> -// our code base.
>> We can't go so far as to say that we've removed all implicit references
>> to "the_repository", though, since we still have functions that
>> reference "the_repository" in their implementations. But, I don't think
>> this ".cocci" file would help us with those cases anyway, since this was
>> targeted specifically at functions/macros that were passing
>> "the_repository" to functions that accepted a "struct repository" arg.
>
> For these implicitly-the_repository functions, (e.g. git_path) we'd
> presumably refactor them into repo_* versions and then apply the same
> sorts of changes we did in this series? I guess we'd make those changes
> in contrib/coccinelle/the_repository.cocci, so we don't need the
> *.pending* one.

Whether we add it to a "pending" or not is just a question of whether
the migration is done right away, or left for later.

> On that note, I'm curious what contrib/coccinelle/the_repository.cocci
> is doing for us after this series. By definition, all of the macros have
> been fully migrated, so they're all a noop.

I left them for the benefit of any in-flight conflicts, or semantic
conflicts with out-of-tree.

I.e. in such a case you'd keep the other side, then apply the cocci
rule, and the result is a semantically correct merge of the two.

> Would this slow down `make coccicheck`?

A bit. It doesn't slow it down by much, as these rules are the simplest
to execute, spatch can skip the file if the relevant tokens aren't found
in it.
