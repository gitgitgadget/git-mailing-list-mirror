Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F89C433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 07:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6CDF2082F
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 07:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIAiJWNY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgFPHGu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 03:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgFPHGu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 03:06:50 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B68C05BD43
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 00:06:50 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id p18so13436999eds.7
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 00:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pf2ysKcD90ZaSdZFftauSErLSlJ1qiPvvgGJTJkZlwk=;
        b=SIAiJWNYSQVD/ws3SJLF8a1Tc7xenXWVlgA09AEy657FL+HSKSIZ8nkFypHIMLDOwK
         ya2f7/kbHSlm1Cwn1GV3ke4LKR3v16bChju9jg02KxV09aHKOnR6AFc70yiMUBHEL28J
         NTL4JF+LNaYEPL2aOg/S+IO2M4iljsCUXhvmUprPLHa8rchSDj9AObayQJ8KgX0KhdT2
         RQloJAMzQrnbTHOggvhvDxUYwGZMxm5sqibp6m965YKK1Oyd/IiyNKd/J4mnfQSSz+T5
         E3o1OfD/6vvFeDfTqbr/z5M4JBOgLyy0QCk1QTFErwr+yi5GE8dlPGc/3btVbFgV22Fq
         rBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pf2ysKcD90ZaSdZFftauSErLSlJ1qiPvvgGJTJkZlwk=;
        b=i3v5TcHYh/9qY3PvP8IXzHy6BGYD613l/hp6p3A3m+sSijquXvZd2oAeJPrNFSFb97
         Z8wtoADrZxYz9cVuCxIoeV+xeTedHTV5If/k1Elk+xVAbDTCLvSo1ypHWUpteqi6gSGR
         5dt9Mzt7fmiTPG4t9zrXmnhpNyE/6GrTz2xUgBfuasxR8j5PuaWj4SPAyHjEKdn15Lps
         sAP+oePZMD+jiodTywkKmrMxstRlbaNXvh5bcR74J32LEN9Bjx136Ykinc1y9alAemXs
         5/R7JUmnroST6rtjBUk1jnWTZYSx9QOcl9dhidSCE8ejPMiND2Y6kLNU3LJESRcrnTRd
         IKew==
X-Gm-Message-State: AOAM530JhM9mQ4incden4JrGIyMpPLvYyrWZERKKSNIPgDF0BAaU3MDx
        kEkkJNEKPHji+tmv3S72TfM=
X-Google-Smtp-Source: ABdhPJxYf54YmQgx6MNmf8OnUezs6wxyTudhfx/KpaF7UYfI/ylbcE3dBfhgdwfQMi56fJL10LB9hw==
X-Received: by 2002:a50:af25:: with SMTP id g34mr1283567edd.85.1592291208853;
        Tue, 16 Jun 2020 00:06:48 -0700 (PDT)
Received: from szeder.dev (62-165-236-99.pool.digikabel.hu. [62.165.236.99])
        by smtp.gmail.com with ESMTPSA id ew9sm10565250ejb.121.2020.06.16.00.06.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jun 2020 00:06:48 -0700 (PDT)
Date:   Tue, 16 Jun 2020 09:06:45 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Son Luong Ngoc <sluongng@gmail.com>
Subject: Re: [RFC PATCH v1 0/6] stash: drop usage of a second index
Message-ID: <20200616070645.GF2898@szeder.dev>
References: <20200505104849.13602-1-alban.gruin@gmail.com>
 <20200615152715.GD2898@szeder.dev>
 <20200615215020.GE2898@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200615215020.GE2898@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 15, 2020 at 11:50:20PM +0200, SZEDER Gábor wrote:
> On Mon, Jun 15, 2020 at 05:27:15PM +0200, SZEDER Gábor wrote:
> >       - Should we even allow 'splitIndex.sharedIndexExpire=now'?
> >     
> >         I believe, though haven't confirmed, that it can cause trouble
> >         even without using an alternate index.  Consider the following
> >         sequence of events:
> >     
> >           - Git process A reads '.git/index', finds the 'link' extension,
> >             and reads the SHA1 recorded there that determines the filename
> >             of its shared index.
> >     
> >           - The scheduler steps in, and puts process A to sleep.
> >     
> >           - Git process B updates the index, decides that it's time to
> >             write a new shared index, does so, and then because of
> >             'splitIndex.sharedIndexExpire=now' it removes all other shared
> >             index files.
> >     
> >           - The scheduler wakes process A, which now tries to open the
> >             shared index file it just learned about, but fails because
> >             that file has just been removed by process B.
> 
> Confirmed.
> 
> To help reproduce the issue, this diff adds a strategically-placed
> controllable delay between reading '.git/index' and reading its
> shared/base index:
> 
> diff --git a/read-cache.c b/read-cache.c
> index b888c5df44..5a66e9bf4b 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2319,6 +2319,9 @@ int read_index_from(struct index_state *istate, const char *path,
>  	else
>  		split_index->base = xcalloc(1, sizeof(*split_index->base));
>  
> +	if (git_env_bool("GIT_TEST_WAIT", 0))
> +		sleep(3);

We don't even need this sleep() call ...

>  	base_oid_hex = oid_to_hex(&split_index->base_oid);
>  	base_path = xstrfmt("%s/sharedindex.%s", gitdir, base_oid_hex);
>  	trace2_region_enter_printf("index", "shared/do_read_index",
> 
> 
> Then this test creates the above described sequence of events:
> 
> test_expect_failure 'splitIndex.sharedIndexExpire=now can be harmful' '
> 	>file1 &&
> 	>file2 &&
> 	git update-index --split-index --add file1 &&
> 
> 	{
> 		sleep 1 &&

... and this 'sleep 1' command.

> 		# "process B"
> 		git -c splitIndex.sharedIndexExpire=now \
> 		    update-index --split-index --add file2 &
> 	} &&
> 
> 	# "process A"
> 	GIT_TEST_WAIT=1 git diff --cached --name-only
> '
> 
> ... and fails reliably with:
> 
>   [...]
>   + GIT_TEST_WAIT=1 git diff --cached --name-only
>   [ ... trace from background commands removed ...]
>   fatal: .git/sharedindex.818f65852e7402f236aeaadd32efdbb62291aa75: index file open failed: No such file or directory

Flipping the test to 'test_expect_success' and running it with
'--stress' almost always fails within 2 seconds.


> >         This is similar to the issue we have with 'git gc --prune=now',
> >         except that 'git gc's documentation explicitly warns about the
> >         risks of using '--prune=now', while the description of
> >         'splitIndex.sharedIndexExpire' doesn't have any such warning.
> >     
> >         I think that 'splitIndex.sharedIndexExpire=now' should be allowed,
> >         for those who hopefully know what they are doing, just as we allow
> >         'git gc --prune=now', but the documentation should clearly warn
> >         against its potential pitfalls.
