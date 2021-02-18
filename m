Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA64BC433E0
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 01:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC23C64E45
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 01:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhBRBeU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 20:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhBRBeT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 20:34:19 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91306C061574
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 17:33:39 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id c3so677152qkj.11
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 17:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hWAMP0/V5kJdf9j0qpnL9riLMLea6wvQL53J8ob8Qrs=;
        b=Y+8BR2nwC+L1C4+/hS18IR4ntAHfOXD0WvMULJq9O9YT1oi+QfbsGRW21SUysc3IMY
         e1w1JRAvyaxD+CIvMrHyTKBON69SL60gz+1tFP3ppTx4Hs3gqweSJP20U4q2bhXUnAUS
         hcFkBaQtiFiT2hjy9O7tEIa0ZVopjlKk13DbF//A2kruf4KO91XJmnfXm5q28ctKCwPS
         UhWaQZ1+l04n2ROiNF9DXxnK2WOsk+ndFm30J8NPwW23yHDJhI3RVHsYEhiwzHUEsm1e
         PVcCvWSJDkA0Xd5YiX9GQIFWS3wsqidaJkHllkfqpeK1bP8oPRf/ndqfBRXC9tJi4mv9
         QvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hWAMP0/V5kJdf9j0qpnL9riLMLea6wvQL53J8ob8Qrs=;
        b=kqZa51vmOZgjKaqKg23gq1Qpo4ZN8P94n+PFPviFuW0b+40NSg3E8jzSOIn8ES9MVF
         1Dtr2tC5r3EdiJqr7IradqKVyQukQX4k4Web8FwTMwqkoNLySimijeT82y8UKM8HLPWL
         cRt7uEBkACIr+wd798HwfztMK7etwOnwyAd7ODeK1mHU3FdMLBKABPzlzWGG1fauYX4G
         Q+KArZmaAv/Btj2kWN+BoJBkJorN24yIyMvUr1g1ltM2XRicel9bGCzhTN3US5cceQWa
         bSWyzTXoKsI3wzshAS0pQm0NI/0iv4QHYrtpCnxNkvwnkOcrZMYxwvrL3xY9OLupVmRD
         fkOg==
X-Gm-Message-State: AOAM531ffh679PHC4GjVYtPLBkb7CXMqTsmdJCciI5IsWJk0B/nCQhnH
        dVJ2AmwyOEJUZU8/ZRhypwdptA==
X-Google-Smtp-Source: ABdhPJzq7C5HWVvFZ6417L22v74SklYxxy3RX2ZrMSg9g+J+d5aQ+O9iqAR4vc7PhNkrMn2qGeG7Jw==
X-Received: by 2002:a37:9dd2:: with SMTP id g201mr2165193qke.138.1613612018733;
        Wed, 17 Feb 2021 17:33:38 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id c7sm2426108qtc.82.2021.02.17.17.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 17:33:38 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, newren@gmail.com, stolee@gmail.com
Subject: Re: [RFC PATCH 1/7] add --chmod: don't update index when --dry-run is used
Date:   Wed, 17 Feb 2021 22:33:30 -0300
Message-Id: <20210218013330.7491-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <xmqqa6s2jrl9.fsf@gitster.g>
References: <xmqqa6s2jrl9.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 17, 2021 at 6:46 PM Junio C Hamano <gitster@pobox.com>
wrote:
>
> Matheus Tavares <matheus.bernardino@usp.br> writes:
>
> > `git add --chmod` applies the mode changes even when `--dry-run` is
> > used. Fix that and add some tests for this option combination.
>
> Well spotted.  I hope we can split this out of the series and fast
> track, as it is an obvious bugfix.

Makes sense, should I send this as a standalone patch, after applying
the suggested changes?

> I by mistake wrote error(_("...")) in the snippet below, but as a
> bugfix, we should stick to the existing fprintf(stderr, "...") without
> _().  i18n should be left outside the "bugfix" change.

Hmm, when I read your snippet I thought that because this is a small fix
it wouldn't be bad to include the internationalization in the same patch
(with a "While we are here ..." note in the commit message). But are
there other reasons why it is better to do this as a follow-up step? 

> > -static void chmod_pathspec(struct pathspec *pathspec, char flip)
> > +static void chmod_pathspec(struct pathspec *pathspec, char flip, int show_only)
> >  {
> >       int i;
> >
> > @@ -48,7 +48,8 @@ static void chmod_pathspec(struct pathspec *pathspec, char flip)
> >               if (pathspec && !ce_path_match(&the_index, ce, pathspec, NULL))
> >                       continue;
> >
> > -             if (chmod_cache_entry(ce, flip) < 0)
> > +             if ((show_only && !S_ISREG(ce->ce_mode)) ||
> > +                 (!show_only && chmod_cache_entry(ce, flip) < 0))
> >                       fprintf(stderr, "cannot chmod %cx '%s'\n", flip, ce->name);
> >       }
> >  }
>
> This is a bit dense, especially when the reader does not know by
> heart that chmod_cache_entry() refuses to chmod anything that is not
> a regular file.
>
> Even when dry-run, we know chmod will fail when the thing is not a
> regular file.  When not dry-run, we will try chmod and it will
> report an failure.  And we report an error under these conditions.
>
>         if (show_only
>             ? !S_ISREG(ce->ce_mode)
>             : chmod_cache_entry(ce, flip) < 0)
>                 error(_("cannot chmod ..."), ...);
>
> may express the same idea in a way that is a bit easier to follow.
>
> In any case, that "idea", while it is not wrong per-se, makes it as
> if the primary purpose of this code is to give an error message,
> which smells a bit funny.
>
>         if (!show_only)
>                 err = chmod_cache_entry(ce, flip);
>         else
>                 err = S_ISREG(ce->ce_mode) ? 0 : -1;
>
>         if (err < 0)
>                 error(_("cannot chmod ..."), ...);
>
> would waste one extra variable, but may make the primary point
> (i.e. we call chmod_cache_entry() unless dry-run) more clear.

And that's easier to read too. Thanks!

Also, in a following patch, should we make chmod_pathspec() return `err`
so that we can do:

	exit_status |= chmod_pathspec(&pathspec, chmod_arg[0], show_only);

and have the chmod error reflected in `add`s exit code?
