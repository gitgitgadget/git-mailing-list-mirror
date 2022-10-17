Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F52AC4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 11:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiJQL0d (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 07:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiJQL0b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 07:26:31 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D464B49F
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 04:26:30 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ot12so24214153ejb.1
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 04:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GaLRvoD6BMb+QSr1Z/CL8FBYYjNukvaj5VyZWlxaJA8=;
        b=EPLBx0hgH/4BTUyGowCeDZT4NLexBx6vHqLHLPcDxurENCbE1pdTlLvcmnwgCy7XNJ
         U/o7Tvu+/I5kknrQ2A+6NnhXj6lWuUZwRDEBQvkFOnqVSV0pAivkiQnQWWGFlYdhdbuu
         KdgVmU2qIbOVITPc9Ot/ZR72YdL61UjuNNoCC3y1QS9xkrRUY38Lm104khpKAUkBsS0J
         AQrimp1Ah5Ul60Pv+03NQQ3lMfemPTryMr8E9vw78C11w+85XTRJhzRLki7JxY5Gxmlf
         9WOdYqmU0tnc8rA63Aokotcn6nCWvwPp+VnTA/RdoK7RBHcKM+x6GIEsA9qYGrJ1r2VM
         /Cbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GaLRvoD6BMb+QSr1Z/CL8FBYYjNukvaj5VyZWlxaJA8=;
        b=ontIKiF2OUiAiyi56XU8SGS2lPtWGMiFnZ/S2ZzkIBjwpJBIVP+j+nLvxQFD3hKFYK
         5jKhuLBkAM7NIhKtzRqCsc9urEmHRsJZmCXEq10oKBHKu4iPC2Ngn7ce/QXlvAQp8GuJ
         DxiiHVnUs57T6/kQEaXpHRMEISbPuFKyfLjXtIIWaLic5kTy+0CSqUePnYLK1eKLZeiy
         TljyERnaDRmgsslQdmeq15FS+BzIMoHkEwD9CeuH9swLjreDyy2x6JfL9+JKV9+tFIXP
         V1vqiJizxqExLNwzpa2nQko9RAUwTuOMBDyWqQbzoYs8d9z2RLJa+8uI8irqJEFmzKc7
         wQBg==
X-Gm-Message-State: ACrzQf215gE+1O3tBvujDCj2myYqRGlqk7x32Q1bmdP3tFAaYVzxNUhI
        PA3PNwX8QiyjjKuFNwL0s48=
X-Google-Smtp-Source: AMsMyM6iW1LX7H//RPT41QQ7geg7v43ecvyiA9i9qRWIPmJaVIcpINuscb32IYNExxlx9M8pvYAvBw==
X-Received: by 2002:a17:907:75f1:b0:78a:f935:647d with SMTP id jz17-20020a17090775f100b0078af935647dmr8164614ejc.587.1666005989264;
        Mon, 17 Oct 2022 04:26:29 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id p18-20020a17090653d200b0073dd1ac2fc8sm5910382ejo.195.2022.10.17.04.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 04:26:27 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1okOGI-005QQp-25;
        Mon, 17 Oct 2022 13:26:26 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3 6/8] rebase: factor out branch_base calculation
Date:   Mon, 17 Oct 2022 13:23:25 +0200
References: <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
 <pull.1323.v3.git.1665650564.gitgitgadget@gmail.com>
 <2efbfc94187d9f0968e5b670c9152651cd8f1a5b.1665650564.git.gitgitgadget@gmail.com>
 <221013.867d13ldzm.gmgdl@evledraar.gmail.com>
 <c0213afe-658d-8562-3d2a-9e254c742730@dunelm.org.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <c0213afe-658d-8562-3d2a-9e254c742730@dunelm.org.uk>
Message-ID: <221017.86tu42k7x9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 17 2022, Phillip Wood wrote:

> On 13/10/2022 20:21, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>> +static void fill_branch_base(struct rebase_options *options,
>>> +			    struct object_id *branch_base)
>>> +{
>>> +	struct commit_list *merge_bases =3D NULL;
>>> +
>>> +	merge_bases =3D get_merge_bases(options->onto, options->orig_head);
>>> +	if (!merge_bases || merge_bases->next)
>>> +		oidcpy(branch_base, null_oid());
>>> +	else
>>> +		oidcpy(branch_base, &merge_bases->item->object.oid);
>>> +
>>> +	free_commit_list(merge_bases);
>>> +}
>> I wondered if this could be a bit shorter/less wrap-y
>
> Where's the wrapping?

Sorry about being unclear, I meant (but completely failed to get across)
that you seemed to be pre-declaring the "merge_bases" to avoid wrapping
the "get_merge_bases()" line.

But reading it again maybe it was just copied as-is from the
pre-image. In any case as we're moving this to a new function maybe a
fix-up to make it:

	struct commit_list *merge_bases =3D get_merge_bases(options->onto,
							  options->orig_head);

would be marginally easier to read, as we never use that NULL-init
(which again, is also an issue in the pre-image).

Anyway, if you want to keep this all as-is that's fine with me.

>> with shorter
>> variable names, anyway, I see it's code copied from above, so nevermind
>> in advance... :)
>
> As it is copied it is easier to review leaving it as is I think.

*nod*
