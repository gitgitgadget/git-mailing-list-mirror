Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310ADC74A5B
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 15:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjC2PtN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 11:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjC2PtK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 11:49:10 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955E24699
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 08:49:08 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id l7so14429429pjg.5
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 08:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680104948;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gcg/J2NwEZHiK4fL2IhN2F57bDwXmZpfxdjSRK6KbXs=;
        b=orC8iu077BivTs7r11gp03GaBxgNS6vLHCFx0V0+LKDJqI6WQIkuvhEOYOb6GqP1Tb
         x7gG1ueL8wnAEtkE6tPADJq9IKWUCcl6YL5VmG6zBjr0gIGwkamTEjIGDVr4kRtnh5oD
         BDiAdr1HeilrL9qe2BAZblCHabopmnk5pjq8WulQTCQo1+LCWDNVV/CuRQCtLyEpZytr
         wGgxpYpfGJsJ9uLMrSspPUy+VNussfE7ub+bV79/BUILf1mZPtZLuTfBKHjwuYDGy12G
         GUW5Yyky0qEYtrUysHM4ck9a2nbJS3eVikUsPMVT7Mfg/GPy36kDD/7Qn66JU29VI7Qc
         RqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680104948;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gcg/J2NwEZHiK4fL2IhN2F57bDwXmZpfxdjSRK6KbXs=;
        b=fULs0OjeqO/pYzrgCeK6kIWvHP7mWOcKj7ma28mRm2as75k51tnWhNCdGD/EUHsV+r
         nf3hxsBCfJMZuiTf0VwOhVe39BUn8+SaDftzIgC66iIP21WdB0iS7U0Tc75H6DGKsSDV
         BR8SlUA9r4KuD4fZXshaSkxwhatPSnumOse6fKHzQvpLoBfyaVXqtCtE4Guk1um6HtSF
         WoyRay+9hMgJwzr5Fui4oONoQBQvZMZvevzjcUR2IMiRDLFRtGwpn42VOukIsRJBSS02
         wERm3jHSOcvJtKKu3H9Qkunn9rGzVZoq98+j5CZI3uWkO1ETWg5K4CJVASb6rdFcSHP5
         ACMQ==
X-Gm-Message-State: AAQBX9doiH8jPgd3FavhgutUoaZEe+OctPtBCWpgoCR6Smqpe1Nsy7iN
        4E9aZd/IUjO6SmX2RCCpbNE=
X-Google-Smtp-Source: AKy350YeuJqvgk1t9myamnVBFPHc036LfmH9VvlrRxMGOPS/NyVs3vzXn7V248L79q3SDrMj2Ftelg==
X-Received: by 2002:a17:902:c60a:b0:1a1:e308:a82e with SMTP id r10-20020a170902c60a00b001a1e308a82emr2093921plr.12.1680104947935;
        Wed, 29 Mar 2023 08:49:07 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id jc9-20020a17090325c900b0019a87ede846sm23185553plb.285.2023.03.29.08.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 08:49:07 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH 1/4] tests: run internal chain-linter under "make test"
References: <20230328202043.GA1241391@coredump.intra.peff.net>
        <20230328202207.GA1241631@coredump.intra.peff.net>
        <230329.86wn2zvo9u.gmgdl@evledraar.gmail.com>
Date:   Wed, 29 Mar 2023 08:49:07 -0700
In-Reply-To: <230329.86wn2zvo9u.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 29 Mar 2023 12:20:00 +0200")
Message-ID: <xmqq7cuzd0cs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Now the comment in the Makefile still says (as seen in the context):
>
> 	# `test-chainlint` (which is a dependency of `test-lint`, `test` and `prove`)
> 	# checks all tests in all scripts via a single invocation, so tell individual
> 	# scripts not to "chainlint" themselves
>
> But as the commit message notes that's not accurate anymore. We're *not*
> telling them to turn off chainlint in its entirety, we're telling them
> to only suppress the chainlint.pl part.

Correct.  To avoid a confusion we saw in the thread that led to this
series, we need an explanation that clearly distinguishes the "exit
117" one and the "script that parses the shell" one.  If we consider
that the name "chainlint" refers to the latter, the script, and
re-read the three lines with that in mind, I think they are OK.  It
would become even clearer if we insert four words, like so:

	`test-chainlint' (which is ...) checks ... via a single
	invocation of the "chainlint" script, so tell ...

> So if you invoke the Makefile with GIT_TEST_CHAIN_LINT=0 we'll still
> turn all of it off, but an invokation of chainlint.pl for the scripts as
> a batch is no longer thought to make the "eval 117" trick redundant.

Yes, I think that is the idea reached by the discussion in the other
thread that led to this series.

> I haven't looked too deeply, but it seems that we should at least adjust
> that comment in the Makefile, or perhaps we should rename this "eval
> 117" thing to be "internal lint" or something, and not "chain lint", to
> avoid conflating it with chainlint.pl itself.

I agree that it would help to clarify that we mean by "chainlint"
the script that parses (or the act of running the script, when it is
used as a verb), and the above may be a way to do so.  I however do
not see the need to come up with a new name for the other one, until
we have a way to toggle it enabled/disabled, which is not something
the discussion in the other thread found necessary.

Thanks.
