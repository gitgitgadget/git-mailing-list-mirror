Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D512BC2D0E4
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 10:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A6B120795
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 10:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o41G3Zvh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgK0KdJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Nov 2020 05:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgK0KdI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Nov 2020 05:33:08 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92596C0613D1
        for <git@vger.kernel.org>; Fri, 27 Nov 2020 02:33:08 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id jx16so6307391ejb.10
        for <git@vger.kernel.org>; Fri, 27 Nov 2020 02:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=hhNQpmA+2AR7S/asDVW50lgCHhCyWMFjjjD1w4GHEFI=;
        b=o41G3ZvhVbEQfPHShO+R+PDulUho4iv/pTm6OuB3OC4QzVSb0ryy46YAVca1GduZMb
         BKo53XP/0knzPBqzqbMyIzOJGyiyh5DbVyEdJNqcGHWLAjG+x6tJih7dbZ72PMYJmEHG
         d/py4cd0t9pWF/sIewGiySlPIikDU2YaeOus/DmAyb4cER+uIHUl61P5I7MN4CBBcDZV
         DaxMTsKVpI6eUIt2O1lwkm3G+eo7+lMyae5TjiWuFHw0p8ej6Wvczm4cB6MM0+nnHgsO
         1SSsRbluQYVF0y0O4OoiBFvXy7WJGU6ct8705pKcvmMbyCVpj79eIVuiGO6IFayzqRyp
         KTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=hhNQpmA+2AR7S/asDVW50lgCHhCyWMFjjjD1w4GHEFI=;
        b=OnJCmKJ4Oam1c877y9lieBKC18LOOel2Ah4AN0B/VGo3s2Pp48pVCC6tiimiqwKsoJ
         C+qsFk1SDU32Z3Q3OsBmPEXpKlHChxM/UO71suJlhJZK5AKhIHegHL1TaDbcfYIEM9jn
         D52ne4Rm8nlIffpGUljciCYM9sEHo9VsOgNgFJiJhMn+BBxa1CBasBEBlhBrNqsLg0cz
         T7mWYwi1mwvGQo90oT90S04Ye6PP1MC0WPb2xL1rLkOVWQAK9+Y2cX052QVe93py4oZs
         3qK1c7EatyCxi0n80oS85ID6IKxTah/nS7mtJvjY/ckyOguMEAFVsMWFx6MKYD9/TA1C
         ahiQ==
X-Gm-Message-State: AOAM532DzU53aPE7a85qNbezP02eDbYJZVXBYobUgdB4j54sqb/FR/ds
        k42LJPs+30Z7b5TvH8t9661+FsyNVIldHQ==
X-Google-Smtp-Source: ABdhPJyUntgUKGFhmueNXGKI+bPMJ2AjhT4AF/L+IdB5+yOBSuwdYidjKwBnRhPA5Ho0uhwLStHJog==
X-Received: by 2002:a17:906:4704:: with SMTP id y4mr6768662ejq.449.1606473186873;
        Fri, 27 Nov 2020 02:33:06 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id e12sm4758493edm.48.2020.11.27.02.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 02:33:06 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v3 05/16] reftable: utility functions
References: <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com> <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com> <987d1d186fd68d604268f9a66118b7f276094daf.1606419752.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <987d1d186fd68d604268f9a66118b7f276094daf.1606419752.git.gitgitgadget@gmail.com>
Date:   Fri, 27 Nov 2020 11:33:04 +0100
Message-ID: <87ft4vnl7j.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 26 2020, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> This commit provides basic utility classes for the reftable library.

Re Johannes's comments in v2
(https://lore.kernel.org/git/nycvar.QRO.7.76.6.2010021557570.50@tvgsbejvaqbjf.bet/)
about strbuf.c etc. being duplicated I see that's gone now.

It seems you did some version of my suggestion in
https://lore.kernel.org/git/873625i9tc.fsf@evledraar.gmail.com/ of
factoring out that code, except here:

> [...]
> +#ifdef REFTABLE_STANDALONE
> +
> +/* functions that git-core provides, for standalone compilation */
> +#include <stdint.h>
> +
> +uint64_t get_be64(void *in);
> +void put_be64(void *out, uint64_t i);

It's unclear whether that's an omission, or needed for some reason (is
git.git ever going to have REFTABLE_STANDALONE=true?

The update shellscript is also gone from v2->v3, is that out of tree now
somewhere? How does one test with the upstream code & presumably do some
munging on it to make it diff-able with what's going to be in git.git?

It would be really useful to have that sort of info/summary in the cover
letter between serieses. It's not that I mind e.g. having some of this
REFTABLE_STANDALONE code here. Just having to do archaeology trying to
figure out changes in this rather large series...
