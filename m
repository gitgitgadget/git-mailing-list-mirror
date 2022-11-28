Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88198C433FE
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 18:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbiK1Sql (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 13:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbiK1Sqk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 13:46:40 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217E1D132
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 10:46:39 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id gu23so9972364ejb.10
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 10:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z8CJequXtXME+4FCxAkCO/HPKxi1P5nFJbM22KqzT7Q=;
        b=pvcAqd5gKQJG5RIaCLszozeDbeKeB3lCorMrTPeeW7yGaJHehCSMDXmW0hLVfV1pnY
         YItQZnKeuVWnMiDYoY+boKtLG4OXRtygylVnoshicoJ5jY+po66cqwj2B9WA2Cz0ScYD
         RlEn30rX0OANoPILiDcU7QR5I6MD8ZAaMO44HjlWfKAw85UAD2V8uBWISSxk9cXv0BQl
         SuIuR8qQUzuxqdDM7zZwnn+4dZ1WLDp4X6BDfShkf7BlpITDr5i/0mdbUiIUFzIS0XDm
         D7z8kUSxhDnwh8NDE2ayM1QqTzL1i4MGCwTRif+IBiyjZzsZIzYaCTLxd60dQIoidc8W
         +e2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z8CJequXtXME+4FCxAkCO/HPKxi1P5nFJbM22KqzT7Q=;
        b=CFHOhKNE3BwKt3JARC/LaMDlyRUmuJSzZFv8NkrCxdk4LgT36WCFP8KtHtZ99PtH8A
         8WTAjnCi/j+6EpmvupKGJxxrloysFVfYHNytoE8IrVvUni3n8QjqBHPOktTlefshVGxL
         UZZ+mjvOATgV+BxNp4ZINsUwoDmlM1WcOWak+eCtmVoX96P1SJbo+6PTH8nwEpPrfQgX
         kHQ93Ipx5Ul3PIEPS9b8+/3bZYl4jGdgk9WdBm5XmyJtrVg83K+9bQhIVv5l2JPBrZHw
         J+4z9Av0b4Z3Mb2zCbPX4GAvE1MrOtKLsVKC0JDNxM+I0+JnhROm6x77MomaB8Vh4oR9
         4nvg==
X-Gm-Message-State: ANoB5pnjnVrhCEK6cqRZ+JchGPyk1BQYKyzKlJ/AbEpem+V2sOY6GE4C
        n5/J4vQ/jMtL2xe8s555jM4rARCzFH54rQ==
X-Google-Smtp-Source: AA0mqf61ujXP2PZnNWX0JQ+uk6EPwKv1PnuJHs89BeVcesySjQ3ff0bRn6IpD65AXcX9ipW6qJZY8g==
X-Received: by 2002:a17:906:ee1:b0:78a:efde:b84a with SMTP id x1-20020a1709060ee100b0078aefdeb84amr44998253eji.744.1669661197570;
        Mon, 28 Nov 2022 10:46:37 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id hb14-20020a170906b88e00b007c0688a68cbsm1216813ejb.176.2022.11.28.10.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 10:46:37 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ozj9I-001Ext-25;
        Mon, 28 Nov 2022 19:46:36 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] Revert "pack-objects: lazily set up "struct
 rev_info", don't leak"
Date:   Mon, 28 Nov 2022 19:32:29 +0100
References: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
        <d19c6cb4-611f-afea-8a14-5e58d7509113@web.de>
        <f5779e19-813c-cda9-2f84-9fe58f745e89@web.de>
        <xmqqv8mz5ras.fsf@gitster.g>
        <d10de9b5-e5ff-18d6-d950-1d090d87b113@web.de>
        <221128.864jujmhgp.gmgdl@evledraar.gmail.com>
        <c5aeb93c-763d-3eae-0150-15f6ca675319@web.de>
        <221128.865yezkule.gmgdl@evledraar.gmail.com>
        <59431916-9f55-d0f4-da54-e7369803eb4c@web.de>
        <2488058d-dc59-e8c1-0611-fbcaeb083d73@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <2488058d-dc59-e8c1-0611-fbcaeb083d73@web.de>
Message-ID: <221128.86o7sqkjcj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 28 2022, Ren=C3=A9 Scharfe wrote:

> Am 28.11.2022 um 16:56 schrieb Ren=C3=A9 Scharfe:>
>> The problem is "How to use struct rev_info without leaks?".  No matter
>> where you move it, the leak will be present until the TODO in
>> release_revisions() is done.
>
> Wrong.  The following sequence leaks:
>
> 	struct rev_info revs;
> 	repo_init_revisions(the_repository, &revs, NULL);
> 	release_revisions(&revs);
>
> ... and this here doesn't:
>
> 	struct rev_info revs;
> 	repo_init_revisions(the_repository, &revs, NULL);
> 	setup_revisions(0, NULL, &revs, NULL);  // leak plugger
> 	release_revisions(&revs);
>
> That's because setup_revisions() calls diff_setup_done(), which frees
> revs->diffopt.parseopts, and release_revisions() doesn't.
>
> And since builtin/pack-objects.c::get_object_list() calls
> setup_revisions(), it really frees that memory, as you claimed from the
> start.  Sorry, I was somehow assuming that a setup function wouldn't
> clean up.  D'oh!
>
> The first sequence is used in some other places. e.g. builtin/prune.c.
> But there LeakSanitizer doesn't complain for some reason; Valgrind
> reports the parseopts allocation as "possibly lost".

Yes, some of the interactions are tricky. It's really useful to run the
tests with GIT_TEST_PASSING_SANITIZE_LEAK=3D[true|check] (see t/README) to
check these sorts of assumptions for sanity.

> I still think the assumption that "init_x(x); release_x(x);" doesn't
> leak is reasonable.  Let's make it true.  How about this?  It's safe
> in the sense that we don't risk double frees and it's close to the
> TODO comment so we probably won't forget removing it once diff_free()
> becomes used.
>
> ---
>  revision.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/revision.c b/revision.c
> index 439e34a7c5..6a51ef9418 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -3055,6 +3055,7 @@ void release_revisions(struct rev_info *revs)
>  	release_revisions_mailmap(revs->mailmap);
>  	free_grep_patterns(&revs->grep_filter);
>  	/* TODO (need to handle "no_free"): diff_free(&revs->diffopt) */
> +	FREE_AND_NULL(revs->diffopt.parseopts);
>  	diff_free(&revs->pruning);
>  	reflog_walk_info_release(revs->reflog_info);
>  	release_revisions_topo_walk_info(revs->topo_walk_info);

At this point I'm unclear on what & why this is needed? I.e. once we
narrowly fix the >1 "--filter" options what still fails?

But in general: I don't really think this sort of thing is worth
it. Here we're reaching into a member of "revs->diffopt" behind its back
rather than calling diff_free(). I think we should just focus on being
able to do do that safely.

WIP patches I have in that direction, partially based on your previous
"is_dead" suggestion:

	https://github.com/avar/git/commit/e02a15f6206
	https://github.com/avar/git/commit/c718f36566a

I haven't poked at that in a while, I think the only outstanding issue
with it is that fclose() interaction.

I think for this particular thing there aren't going to be any bad
side-effects in practice, but I also think convincing oneself of that
basically means putting the same amount of work in as just fixing some
of these properly.
