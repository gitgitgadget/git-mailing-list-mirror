Return-Path: <SRS0=2KbR=CB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD220C433DF
	for <git@archiver.kernel.org>; Sun, 23 Aug 2020 20:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75005206B5
	for <git@archiver.kernel.org>; Sun, 23 Aug 2020 20:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mvt4G1X6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgHWUMK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Aug 2020 16:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgHWUMI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Aug 2020 16:12:08 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18325C061573
        for <git@vger.kernel.org>; Sun, 23 Aug 2020 13:12:08 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mw10so3087223pjb.2
        for <git@vger.kernel.org>; Sun, 23 Aug 2020 13:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ceN9inK4u6VQPQ/e806P2aJ1yK7q4o/QCLuyjMI1o0w=;
        b=Mvt4G1X6twIi7A7/7XMLmsTjo18pqrxQZoEHJgdaYsmrLRTM4qJZ6+MeWfyROuB/lT
         IVSpQULRGtydP+0ZXTm+70950GHF/aPjZtp5lsm9i0UMQ1FZXQ0BXoYR+GTLzYCgaktU
         y61Omw/hUEsFLRQzkK6Sq300zDdax2skHnxuKqAZLkZwq2bY54y/tDDd9vzcQI1nOKjz
         YumhIFAptvEbjErRHngz+owHmJzWQpwyi8EPVfLQcUeQZW/yTQyXCHo12vl7uHSvjvN/
         HzjnDgs/GGSOmxrmgXP62XdDnazd+3zyWUIQXij7zeJm8IFWg9Mqdrg58+t9yapkWqsd
         H5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ceN9inK4u6VQPQ/e806P2aJ1yK7q4o/QCLuyjMI1o0w=;
        b=CUDhZN0Sew0vNF1d3B4fsHVDOOcBqC9yf1uY0Q7e5eBg7ETkobPYhHIMKPaqrKtT39
         ruDIN5aMQL0Q/dNJTPtlZv8B8Ojr7fId9WAzdB4xbJqRlIkwHBcCqUUEEFA77qjIXUdJ
         lq7vTfCjeZBEW6w5srLLAK9idtsOERPDn9lK0MetuiEjM8ZpqYglQgo9heJnvrWUAnoI
         6zNLWGTJKT4xZKKoXoXq5TqrFk4sE+a/2T9Tic1UUGmKO8Zf6QmVGyaI6GZAAm2r2n8N
         0Dd2fdWCuDTcp2w68h8qMcLP253KudnFWXdJja6ZPX78pNE0gdf2AhUp4FtTyfoBSDR/
         1BUQ==
X-Gm-Message-State: AOAM5329OIE21Fc1MaJfMvVW5rm8rjxXhJABniWXBVeSGrs/ULDWohcM
        ptkfUzpatbTKALWv9XDSu4k=
X-Google-Smtp-Source: ABdhPJziycVNsvODISlMPzeRT4MyO+++fg2HXn6W7UUD0Pt9B93LEuSRlrvGoVw6RXqgc2k7MnhIPw==
X-Received: by 2002:a17:90a:80ca:: with SMTP id k10mr1971561pjw.86.1598213526817;
        Sun, 23 Aug 2020 13:12:06 -0700 (PDT)
Received: from lwitch-pc ([49.207.137.20])
        by smtp.gmail.com with ESMTPSA id h18sm8905848pfo.21.2020.08.23.13.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 13:12:06 -0700 (PDT)
Message-ID: <450b1ca28419afec12dc81a04f2c1ce6edfb3943.camel@gmail.com>
Subject: Re: [PATCH v3 4/4] submodule: port submodule subcommand 'summary'
 from shell to C
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>,
        Johannes.Schindelin@gmx.de, chriscool@tuxfamily.org,
        christian.couder@gmail.com, git@vger.kernel.org,
        liu.denton@gmail.com, pc44800@gmail.com, stefanbeller@gmail.com
Date:   Mon, 24 Aug 2020 01:42:01 +0530
In-Reply-To: <5b6ed82f3ab58a194bf51c0e2905214f64246ad8.camel@gmail.com>
References: <20200821171705.GA16484@konoha>
         <xmqq5z9ban27.fsf@gitster.c.googlers.com>
         <377b1a2ad60c5ca30864f48c5921ff89b5aca65b.camel@gmail.com>
         <xmqqa6yn93ll.fsf@gitster.c.googlers.com>
         <5b6ed82f3ab58a194bf51c0e2905214f64246ad8.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2020-08-24 at 01:33 +0530, Kaartic Sivaraam wrote:
> On Fri, 2020-08-21 at 12:54 -0700, Junio C Hamano wrote:
> > Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
> > 
> > > So, we could easily suppress it by doing something like this (while
> > > also fixing the test):
> > 
> > Yup.  That is a very good idea.  
> > 
> > Or the caller of verify_submodule_committish() should refrain from
> > calling it for the path?  After all, it is checking sm_path is a
> > path to where a submodule should be before calling the function
> > (instead of calling it for every random path), iow its criteria to
> > make the call currently may be "the path in the index says it is a
> > submodule", but it should easily be updated to "the path in the
> > index says it is a submodule, and the submodule actually is
> > populated", right?
> > 
> 
> Ah, this reminds me of the initial version of the patch which did
> exactly that. Quoting it here for reference:
> 
> +	strbuf_addstr(&sm_git_dir_sb, p->sm_path);
> +	if (is_nonbare_repository_dir(&sm_git_dir_sb))
> +		is_sm_git_dir = 1;
> +
> +	if (is_sm_git_dir && S_ISGITLINK(p->mod_src))
> +		missing_src = verify_submodule_object_name(p->sm_path,
> +							   oid_to_hex(&p->oid_src));
> +
> +	if (is_sm_git_dir && S_ISGITLINK(p->mod_dst))
> +		missing_dst = verify_submodule_object_name(p->sm_path,
> +							   oid_to_hex(&p->oid_dst));
> +
> 
> Note: `verify_submodule_object_name` is now renamed to
> `verify_submodule_committish`.
> 
> That does sound like a sane approach to me. There's not much point in
> invoking `rev-parse` in a non-populated (a.k.a. de-initialized) or non-
> existent submodule but we removed that check as we thought it was
> unnecessary redundant because `capture_command` would fail anyway.
> Looks like we failed to notice the additional `fatal` message fallout
> then.
> 

Here's a link to the start of the relevant discussion, just in case:

https://lore.kernel.org/git/nycvar.QRO.7.76.6.2007031712160.50@tvgsbejvaqbjf.bet/

> Also, I think it would be better to something like the following in
> t7421 to ensure that `fatal` doesn't sneak up accidentally in the
> future:
> 
> -- 8< --
> diff --git t/t7421-submodule-summary-add.sh t/t7421-submodule-summary-add.sh
> index 59a9b00467..b070f13714 100755
> --- t/t7421-submodule-summary-add.sh
> +++ t/t7421-submodule-summary-add.sh
> @@ -58,7 +58,7 @@ test_expect_success 'submodule summary output for submodules with changed paths'
>         git commit -m "change submodule path" &&
>         rev=$(git -C sm rev-parse --short HEAD^) &&
>         git submodule summary HEAD^^ -- my-subm >actual 2>err &&
> -       grep "fatal:.*my-subm" err &&
> +       test_must_be_empty err &&
>         cat >expected <<-EOF &&
>         * my-subm ${rev}...0000000:
>  
> -- >8 --
> 


-- 
Sivaraam


