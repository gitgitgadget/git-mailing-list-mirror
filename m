Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FEAC433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 20:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbiEZUd7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 16:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiEZUd5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 16:33:57 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC18AFAFA
        for <git@vger.kernel.org>; Thu, 26 May 2022 13:33:56 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7D9BE193872;
        Thu, 26 May 2022 16:33:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NKAuu1tyHMSV
        bME0JJ98Q+y89rqiJ65NdBS2J6/5MK4=; b=MaLGZFFReQvgHEivQS1z6Oky8/Nw
        mw7PC9OICE5gMbVVbpaDTCoynaATUYfyniS0UOvOdOOSwPYWv9CZgMkAVWBspbC0
        IbX1Kw1Nl8l67/jmfvZktcnxiaBcQ7VMpm0kFiGErjwcf8MNgYYMOZ5H2UHQRCBS
        iPdRzBnicxIoqhU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 75D47193871;
        Thu, 26 May 2022 16:33:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 22C35193870;
        Thu, 26 May 2022 16:33:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH 1/3] rebase.c: state preserve-merges has been removed
References: <pull.1242.git.1653556865.gitgitgadget@gmail.com>
        <0a4c81d8cafdc048fa89c24fcfa4e2715a17d176.1653556865.git.gitgitgadget@gmail.com>
        <220526.86bkvk7hoo.gmgdl@evledraar.gmail.com>
        <19baf95d-67d4-d7ed-72a6-96d098171d3a@web.de>
Date:   Thu, 26 May 2022 13:33:51 -0700
In-Reply-To: <19baf95d-67d4-d7ed-72a6-96d098171d3a@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 26 May 2022 15:02:29 +0200")
Message-ID: <xmqq5ylsxccw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 27BFB60E-DD33-11EC-97CA-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>>>  		OPT_SET_INT_F('p', "preserve-merges", &preserve_merges_selected,
>>> -			      N_("(DEPRECATED) try to recreate merges instead of "
>>> +			      N_("(REMOVED) try to recreate merges instead of "
>>>  				 "ignoring them"),
>>>  			      1, PARSE_OPT_HIDDEN),
>>>  		OPT_RERERE_AUTOUPDATE(&options.allow_rerere_autoupdate),
>
> Hidden options are shown if you use --help-all instead of -h.
>
> OPT_SET_INT_F always sets the struct option member "argh" to NULL.  The
> string changed above is the "help" member, not "argh".

Good points.  I do think it is OK to say REMOVED in case --help-all
asks us to show everything, even though I wonder if we can leave it
there until we remove the "support" of noticing the user asking for
a now-removed feature.

>> So there's no point in changing this string, nor to have translators
>> focus on it, it'll never be used.
>>
>> This series shouldn't fix the general issue (which parse-options.c
>> should really be BUG()-ing about, after fixing the existing
>> occurances. But For this one we could just set this to have a string o=
f
>> "" or something, only the string you're changing in 3/3 will be seen b=
y
>> anyone.
>
> What is the general issue?

I am afraid to ask, after having learned to be worried about those
large rearchitecting projects =C3=86var talks about X-<.

> Anyway, the new help text explaining what the option once did is a bit
> confusing.  It would be better to focus on what it's doing now (nothing=
)
> and/or why we still have it (for backward compatibility), I think.

Do you mean that we should say "this option used to do such and such
but it is now a no-op" after "(REMOVED)" label, instead of the above
"this option does such and such"?  I think "(REMOVED)" is a strong
enough hint that lets us get away without saying "used to" and "but
it is now a no-op", so I can accept both.

Or do you mean we should say "(REMOVED) for backward compatibility,
does nothing but errors out"?  I would be less in faviour, then.
Those who are curious enough to ask --help-all would find it more
helpful if we said what it used to do.  Otherwise they wouldn't be
asking --help-all in the first place, no?


