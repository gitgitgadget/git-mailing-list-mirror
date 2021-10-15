Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E18FC433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 16:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C16E604DB
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 16:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241263AbhJOQZp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 12:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241225AbhJOQZo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 12:25:44 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D945CC061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 09:23:37 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id ls14-20020a17090b350e00b001a00e2251c8so7625379pjb.4
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 09:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+BxQ98OnvkGcEm/XOoCAFjAPjRUtJnkhxBEFdJ4pVYk=;
        b=mYBpHw8o6vfzbDPY4J8VxDOQirrJsfTcqTWPQevQb/T86N6b7NR7+2t9mE66RrlBYn
         mdDMaRi1mDtP2r7xwFwVcRULMsXbsPRFN42TyDB4IL+JHXMSXREL8bVw4de0lB919XNR
         Xk0+ouXV44X/dMe5B2mpfqd5gA/ZS20eygbrL7qHMOk/QlBHh+CVWUvd5/KRK2FqunsR
         tPI5mra9qcdfyFUO9YJK9KjKuqzhrmn3P2WwM9XOg78/r/ca2uBxoO8Z2mrfhbZsOGVn
         QEITcaT+WtLoLwBamHMgKTV5dWRtNaAHWZQm9JhiCtFk90vCWXpxkanyWPe1X1MlI7dK
         8WHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+BxQ98OnvkGcEm/XOoCAFjAPjRUtJnkhxBEFdJ4pVYk=;
        b=I13EE+t4R53SGImwm7/0FOYKaUWLBGwrcOvW0+xUoSKl0EOrnHbkLSBGFrdjC1iZ0J
         c5RIs9CZ0+mAzcoT990EdhMP6RCfGjOl2th66iJnHpkr/LTHkfJijiTyxa3GZqLO0oh1
         WSSERq4LtyX3HpEFXVN6xB0VcUeXy7dCsHPOl2h1JiY1A4FkSEqrDiSItcNW41BsKf8Z
         93EJA4kXR2k69XjvUI5Az0G6WdGvdNDbc1HvHkFGIcd47AGsCEQmRT1YT1GEYqcdpNrz
         4zeNMtgzqU9A1Y3eQ52yG2mc4+32/wfc6i9S2D7Qgyp4QP1snfvi70b+YGYg7lGBQtU8
         fKSg==
X-Gm-Message-State: AOAM531+bNcK1p5Uw079SgniVS/uDmeRbiROdR50IiYkXt7dHtKgB8HY
        0ky9CyxNwq8iV8Xp/244mAtfYCLPmgyKlw==
X-Google-Smtp-Source: ABdhPJxPsgXGGPA6kdMoLhKHgR+u0HCiwYF6Cpee+mxaqKxSDNIoPAsGDVR1DUMLBg5Od5+jqep2pw==
X-Received: by 2002:a17:902:7e01:b0:13f:7f2e:753e with SMTP id b1-20020a1709027e0100b0013f7f2e753emr9933718plm.88.1634315017063;
        Fri, 15 Oct 2021 09:23:37 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cc2f:afb0:ab09:f218])
        by smtp.gmail.com with ESMTPSA id lb5sm5465056pjb.11.2021.10.15.09.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 09:23:36 -0700 (PDT)
Date:   Fri, 15 Oct 2021 09:23:30 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 00/13] hook.[ch]: new library to run hooks + simple
 hook conversion
Message-ID: <YWmrAuUeO38Tf/W+@google.com>
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 12, 2021 at 03:30:25PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> This series is part 2 of an incremental restart of the greater
> "config-based hooks" topic by Emily Shaffer that I've been helping
> with. See [1] for part 1, and [2] (search for "mark2") for a summary
> of parts to come.
> 
> This goes on top of the "ab/config-based-hooks-1" topic that's already
> in "next" and marked for graduation to "master".
> 
> In this topic we build upon the skeleton hook.[ch] library and build
> infrastructure added in part 1 and add a hook running library and new
> "git hook" command.
> 
> The new "git hook" command is (for now) only for the benefit of
> in-tree non-C programs that need to run hooks, and this series
> converts git-send-email and git-p4 to use it.
> 
> At the end of the series we remove
> "run_hook_{le,ve}()" from run-command.c, as we've migrated all its
> callers.
> 
> What we don't do is convert any of the more complex in-tree hooks that
> require input on stdin such as "pre-receive" and the like, that's in
> later parts once this lands.
> 
> This series is approximately patch 6-20/36 of the previous 36 patch
> ab/config-based-hooks-base topic. A range-diff to that v5[3] is
> included below.
> 
> The changes since that v5 are rather trivial, they are:
> 
>  * Formatting changes to reduce the diff to parts that come after this
>    (which Emily & I were juggling at the time), and re-flowing some
>    overly long lines.
> 
>  * The new test is now marked for SANITIZE=leak testing, with the new
>    test facility I've added recently (and which just landed in
>    "master"). They all pass, the new API doesn't leak.
> 
>  * I rewrote some of the git-send-email.perl code to avoid
>    de-duplication and hardcoding (just using intermediate variables).
> 
> Things to focus on reviewing:
> 
>  * This should all be pretty solid and well tested, but the git-p4.py
>    part in particular I've never tested for real (not having access to
>    p4), and think Emily hasn't either[4].

Correct. I seem to remember wanting to give this a test and not having access
to real perforce to try it against. 

> 
>    The relevant patch looks trivially correct to me[5], and I've tried it
>    out in the Python REPL. But if any of the CC'd people active in
>    git-p4.py development could give it some end-to-end testing that
>    would be much appreciated.
> 
>  * Both Python and Perl code now calls the in-between "git hook run"
>    command rather than calling hooks directly. Will this behave
>    differently due to any special behavior running via a git built-in
>    adds?
> 
>    I vaguely recall a third-party "git-foo" program breaking in the
>    past when invoked as "git foo" but not "git-foo", due to git
>    squatting on SIGINT, but none of that should be relevant here
>    (we're not starting a pager etc.).

I would be very surprised, assuming that we invoke 'git hook' in the same way
that those Python and Perl scripts invoke other 'git whatever' commands...

That said, once we invoke a user hook, all bets are off as far as "we're not
starting a pager or anything". A determined user could find a reason to invoke
a pager, editor, whatever during a hook. I'm curious to know more about this
remembered breakage.

Last time I looked at the range-diff; this time I'll look at the individual
patches, instead.

Note: I looked at a bunch of these offline, so sorry for the sudden
ingress of mails today ;)

 - Emily
