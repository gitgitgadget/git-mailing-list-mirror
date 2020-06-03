Return-Path: <SRS0=EE6k=7Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1DDC433DF
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 00:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA0942067B
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 00:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tffFmsd1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgFCAM2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 20:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgFCAM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 20:12:28 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D73C08C5C0
        for <git@vger.kernel.org>; Tue,  2 Jun 2020 17:12:28 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id w20so447149pga.6
        for <git@vger.kernel.org>; Tue, 02 Jun 2020 17:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x63iBLhKW0OQTEnRVaBFYFJxgeaXK82YzsoSLv3Gnhg=;
        b=tffFmsd179RLK/7U4DHaVrjcwdMy4sRucH33gaAI21wMV7U52VBV0V5CZAFgxMz8U5
         DI1zL5n/nZGs/yIUUmfbWTM69X3b6oRc65cDBwqBXu7hT7Kif2w1fmDj07ZtFKgA0uo9
         Nx7qhhQFw2UziQrdyeMA84NGAlbzXSCWVim4Zhew+ncPhpgfs4w19PpU2G3rv+VaqHA/
         T0dT9wpt94BiQf7Le9VOQfb7EOxGdkX9amjFtoOSXHtcWSMaV0yviZbppPhyT83xDdBm
         B03Rupk1MMujUqtkOtfIdSwnuP/SPfl8ApBOlc6lP9pvpvkwO7ABu0pQMLzRW8rHXDMf
         xAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x63iBLhKW0OQTEnRVaBFYFJxgeaXK82YzsoSLv3Gnhg=;
        b=cjdBjmnZovZYg7S/k1AbPuHI8g6+RhkggZDPU2co0aGru+aKOrTxcatSI6c24Zk6we
         5d/gJSCsh6Y3Vo1HVDu14KPaX76RvEZGd6togD8ELygHtYSVK6zupl7jCa3XuHVBA+h3
         RPwcqkCUo4MA7EaPAzKCN2IToaA53F3o44i8pUzl8P/Zw9APIxbaedmoGvHSP9KSmE0f
         wirSSB8F6RK2KIrBjiaWE9HR2VwQq9kWucj7gFiuKkiEp7hXY9XCp2j0naRFX5cuvVmu
         DfjVARNq8sw3rBl7MgT868TpJbXZahz3VWnxFOxu0KGN5OTn23S75GHFphKRGS8BNk8f
         Hy/w==
X-Gm-Message-State: AOAM533gdJbBCt4W0x7uUSqAnKRnVj1qovFxRAaYtX4tex0SFG0GHBp0
        qBTsVS14MYkKJ0KedtTMACM=
X-Google-Smtp-Source: ABdhPJw0BHRY15WkwTCmQue5vJPv0kACe1iHUr3E6VTmXgoh6FQ41Ga33q5b6G8Ra9ohruoLB1yO9A==
X-Received: by 2002:a65:6703:: with SMTP id u3mr25716728pgf.179.1591143147624;
        Tue, 02 Jun 2020 17:12:27 -0700 (PDT)
Received: from localhost ([2402:800:6374:cd6f:3908:64aa:a24d:1be1])
        by smtp.gmail.com with ESMTPSA id cu9sm175754pjb.28.2020.06.02.17.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 17:12:26 -0700 (PDT)
Date:   Wed, 3 Jun 2020 07:12:25 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>,
        Johannes.Schindelin@gmx.de, chriscool@tuxfamily.org,
        christian.couder@gmail.com, git@vger.kernel.org,
        kaartic.sivaraam@gmail.com, liu.denton@gmail.com,
        sunshine@sunshineco.com
Subject: Re: [GSoC][PATCH v5] submodule: port subcommand 'set-branch' from
 shell to C
Message-ID: <20200603001225.GB2222@danh.dev>
References: <20200523163929.7040-1-shouryashukla.oo@gmail.com>
 <20200602163523.7131-1-shouryashukla.oo@gmail.com>
 <xmqqzh9ls622.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzh9ls622.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-06-02 10:58:45-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Shourya Shukla <shouryashukla.oo@gmail.com> writes:
> 
> > +	 * though there is nothing to make less verbose in this subcommand.
> > +	 */
> > +	struct option options[] = {
> > +		OPT_NOOP_NOARG('q', "quiet"),
> > +		OPT_BOOL('d', "default", &opt_default,
> > +			N_("set the default tracking branch to master")),
> > +		OPT_STRING('b', "branch", &opt_branch, N_("branch"),
> > +			N_("set the default tracking branch")),
> > ...
> > +		OPT_END()
> > +	};
> > +	const char *const usage[] = {
> > +		N_("git submodule--helper set-branch [-q|--quiet] (-d|--default) <path>"),
> > +		N_("git submodule--helper set-branch [-q|--quiet] (-b|--branch) <branch> <path>"),
> 
> 
> I notice that we gained back -d and -b shorthands that was
> advertised but not implemented the previous rounds.  It is a bit
> curious that we are adding these short-hands that nobody uses,
> though.  

I think a day will come, when all git-submodule functionalities will
run by calling git-submodule--helper.

In that day, we will use current git-submodule--helper as the new
git-submodule.

To me, it'll be less noise to just gs/--helper// from this file and use
it as the new git-submodule, instead of changing the OPT_* all over
places.

Or is that a complain for missing some tests?

-- 
Danh
