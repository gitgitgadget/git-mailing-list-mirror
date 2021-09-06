Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD21C433F5
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 01:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74E0660FE6
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 01:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238431AbhIFBE2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 21:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238374AbhIFBEV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 21:04:21 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21920C061575
        for <git@vger.kernel.org>; Sun,  5 Sep 2021 18:03:16 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u14so10080520ejf.13
        for <git@vger.kernel.org>; Sun, 05 Sep 2021 18:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=elHbXz4IDVNfZnFRFi+emYfmWEjtDLJCX8sgnX0icxQ=;
        b=PF4xFOsuYrWDHvLDNLiQFBBBgcqA+hawb9e67NAyyeeKsnF0XbqbevCwh0MJT8PfsF
         E+aZouv3GoE/xwOyjl0OZ+XZ1JqWm/SG5HmK+YSFWyFso3MkqTvQQPfcRpCXD4fhV9C5
         J8j6H28oAkNkHl+59vPZT3tiYnCPQDIgGl1/MHxj1BW/+EEwRn1e8NI2kLc0985URPop
         x0dngGyi7WcRpeOsDZEIE68ldjJnAqRfldVuR4S9cClJqiaoRcKVz5l/mMbXyahzjM1h
         LDw7D5C9xsGE2avzggrILM+DyyRHUi3u61UdmB3wbZWtWQ6GHdTDSPfbwGqAxgn6d9XD
         PWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=elHbXz4IDVNfZnFRFi+emYfmWEjtDLJCX8sgnX0icxQ=;
        b=LadSqFeor/5LvJk5QeEePoNom7UsGhT1h68UpEDKwtEX1yPgBX9J00qkTgTk4HeeCS
         Gpl2uNWMBVexNhp8VH8GE4GheljhR/m04F+e9L64BUR9AE7KWdodTOEBRJJdF2FwusSJ
         xmQAcr+pqjLy632XhjQFxAiSy33VUuw4bUDApPIuzoUhVF+cO9Y+ctzI9d46rBy1lbNT
         xZnGX0T/nPloqH8R3/lOI5IJBb0KOIw1l/Cfoj7bvA7zoMid6D1/z2jOZYyzOgP5ujKo
         fZVfDj1F1ijDiEFLpZ0uJVil9ArPqyigx2Atxj5A7P08uzhv3EdmYto/T8d/9oaVHM4w
         Zojw==
X-Gm-Message-State: AOAM532Tg0lsH3HNQxn/AgHOjOnsIfH6yxZ1n29nxCELH97OKsEoWQ5T
        XncoqXp42M8Q0mvvUraMlprVhlZagm+QCw==
X-Google-Smtp-Source: ABdhPJyAPHhPFMM5zeq2M90AmzIR+4CrZOmvhE6+GsvsL25lm46wjPPUb1toD5fFzhKaGUc2n/LTpQ==
X-Received: by 2002:a17:906:30d6:: with SMTP id b22mr11423920ejb.442.1630890194656;
        Sun, 05 Sep 2021 18:03:14 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k6sm3544178edv.77.2021.09.05.18.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 18:03:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 11/15] scalar: allow reconfiguring an existing enlistment
Date:   Mon, 06 Sep 2021 03:01:03 +0200
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
 <13056f02018542f8143e4933fbe180a0a9f77004.1630359290.git.gitgitgadget@gmail.com>
 <874kb6xbf9.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2109031750291.55@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <nycvar.QRO.7.76.6.2109031750291.55@tvgsbejvaqbjf.bet>
Message-ID: <87bl56plbi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 03 2021, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Tue, 31 Aug 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>>
>> On Mon, Aug 30 2021, Johannes Schindelin via GitGitGadget wrote:
>>
>> > This comes in handy during Scalar upgrades, or when config settings we=
re
>> > messed up by mistake.
>>
>> > [...]
>> >  		const char *key;
>> >  		const char *value;
>> > +		int overwrite_on_reconfigure;
>>
>> If you make this a "keep_on_reconfigure", then ...
>
> I do not think that this would be a better name, or that renaming this
> field would do anything except cause more work for me.

It would also result in more readable code, i.e. why add boilerplate ",
1" to a boolean field in this case if every single setting is set to
"1"? Doesn't it make more sense to invert the variable name & save on
the verbosity?

>>
>> >  	} config[] =3D {
>> > -		{ "am.keepCR", "true" },
>> > -		{ "core.FSCache", "true" },
>> > -		{ "core.multiPackIndex", "true" },
>> > -		{ "core.preloadIndex", "true" },
>> > +		/* Required */
>> > +		{ "am.keepCR", "true", 1 },
>> > +		{ "core.FSCache", "true", 1 },
>> > +		{ "core.multiPackIndex", "true", 1 },
>> > +		{ "core.preloadIndex", "true", 1 },
>>
>> You won't need the churn/boilerplate of adding "1" to everything here,
>> but can just change the initial patch to use designated initializers.
>>
>> That along with a throwaway macro like:
>>
>> #define SCALAR_CFG_TRUE(k) (.key =3D k, .value =3D "true")
>> #define SCALAR_CFG_FALSE(k) (.key =3D k, .value =3D "false")
>>
>> Might (or might not) make this even easier to eyeball...
>
> To me, it makes things less readable. There is an entire section with the
> header `/* Optional */` below, and I want this list to stay as readable as
> it is now.

Yeah, I think those macros are probably less readable too. I should have
phrased that as a "one could even...", but just the smaller change of
avoiding the ", 1" everywhere seems worthwhile.
