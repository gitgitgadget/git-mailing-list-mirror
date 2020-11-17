Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55949C2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 19:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF6AC24631
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 19:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H9Ps0et2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgKQTS4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 14:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgKQTSz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 14:18:55 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AD4C0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 11:18:54 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id b3so10754923pls.11
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 11:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+c+5cIlaeX2JQgx3WCHQTbW4Dyy8Va7g6TiSNmtHnmo=;
        b=H9Ps0et2RP3kT5I3ZdHs3mIVTG2JsmaPgcIFLERUjtPY9dEpPrPjgA9YUdsPn5UQhp
         j4XFnwaM9wqDj168h1mlWnfV4QcBvUjtQgZGYqYhRuWYziYZK7gUzchPyKC1vmAZoHy3
         nX1h12fKKN/kpYGXPdGd25RZzGA4vCsuzy+USRwVI93B8Ct9vxgu6SEDrGwPlE2UqsaB
         ek6FSOPOeLuhb7GkiUpEj/6I4v1I1Uh43trogOrN+N9kKdT+HOsZ18h2c2b3CbRDy6Dj
         b8TvXE1Gd+Pw6NaEZeM3uygEdtn7WtwGxOMH1jH3VXWeaH6G8nujIhlILmlWTYH24qEy
         KbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+c+5cIlaeX2JQgx3WCHQTbW4Dyy8Va7g6TiSNmtHnmo=;
        b=q+ToiSSBTsq25LJAfUzpQH8uixK2QlLxyObNv++j24ZuubyhiZcxS9F3O8eSaB4VCI
         Yx3U3VNsrzMFKkLYFl4lLfFNq/o36VcU08cJLf83wWcd3Oif8/wongOQJALIuXjHHuUa
         nJa6sSJGnuTd5yu+oyAT88rn4xUzOuBRSckczIlgx+u4UwTFzuc9f7pj5ObgCF8xC2B1
         y6z2VUTGovfta5X3iHoeA5GVLQ6sJ+On6rTvNx6JL/uMACc3ECF7tOeQb5B6hqmDgDXS
         juCgjovPvcMbzoCY3srFupARuuoJcEBRPsGl9+TbutQvYZNEVzn3Fja5Ee9m7KLI0D9S
         ilmg==
X-Gm-Message-State: AOAM530zduKw6tFIppitrXBhVqdSKL/l3Yw6KPiayfR+8bILZ1Zts6Ab
        ycjNLJPLFgsD1Z9rb4vRBnC6FQ==
X-Google-Smtp-Source: ABdhPJy/Ib8vkmwLbTjthSh4dzjRV3cxdRO/GzvNb99Fmv+j+Bt/ICmGcbunzCeIta6TT4Sb3EffKw==
X-Received: by 2002:a17:902:d302:b029:d7:e416:f665 with SMTP id b2-20020a170902d302b02900d7e416f665mr999092plc.45.1605640732834;
        Tue, 17 Nov 2020 11:18:52 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id w15sm6161369pgi.20.2020.11.17.11.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 11:18:52 -0800 (PST)
Date:   Tue, 17 Nov 2020 11:18:47 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: ds/maintenance-part-3 (was Re: What's cooking in git.git (Nov
 2020, #02; Mon, 9))
Message-ID: <20201117191847.GA2551484@google.com>
References: <xmqq7dqu9jwh.fsf@gitster.c.googlers.com>
 <d0123439-236c-1a62-294b-a3373465eadb@gmail.com>
 <20201116235642.GA15562@google.com>
 <xmqqh7po7r3w.fsf@gitster.c.googlers.com>
 <20201117010709.GB15562@google.com>
 <29212864-ab96-5757-cbfb-f5621a43f8d8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29212864-ab96-5757-cbfb-f5621a43f8d8@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 17, 2020 at 08:56:16AM -0500, Derrick Stolee wrote:
> 
> On 11/16/2020 8:07 PM, Emily Shaffer wrote:
> > On Mon, Nov 16, 2020 at 04:40:35PM -0800, Junio C Hamano wrote:
> >>
> >> Emily Shaffer <emilyshaffer@google.com> writes:
> >>
> >>> Because 'git maintenance unregister' spins a child process to call 'git
> >>> config --unset maintenance.repo <cwd>', it actually fails if "cwd"
> >>> contains a POSIX regular expression special character:
> >>>
> >>>   git config [<file-option>] --unset name [value_regex]
> >>
> >> Good find.  And it is even worse that value_regex uses ERE, not BRE,
> >> which means even an otherwise innocuous letter like '+' cannot be
> >> used without quoting.
> > 
> > I should have mentioned in the first letter than Jonathan Nieder was the
> > one who made the jump from "this is breaking in the buildbot but not
> > locally" to regular expression metachars. Credit where it's due.
> 
> Thank you for finding and reporting this bug.
> 
> Can I at least have a short moment of griping about anyone putting
> regex characters into their directory names? ;)

In this case the directory name contained 'git-2.29.2+next.20201112' -
so I'll leave it up to you to decide ;) ;)

> 
> >>> You can demo it for yourself like so:
> >>>
> >>>   git init repro+for+maintenance
> >>>   git maintenance register
> >>>   git maintenance unregister
> >>>   echo $?	# returns '5'
> >>>   git config --list --global
> >>>
> >>> I see two paths forward:
> >>>
> >>
> >> 0. Quote the value_regex properly, instead of blindly using a value
> >>    that comes from the environment.
> 
> Pulling the subcommand from my test enfironment using GIT_TRACE2_PERF=1
> I see the following quotes being used:
> 
> git config --global --unset maintenance.repo "/repos/new+repo*test"
> 
> I'm guessing that what we really want is to _escape_ the regex glob
> characters? This command works:
> 
> git config --global --unset maintenance.repo "/repos/new\+repo\*test"
> 
> The only place I see where we do that currently is in
> builtin/sparse-checkout.c:escaped_pattern(). Please let me know if
> you know of a more suitable way to escape regex characters.
> 
> >>> 1. Teach 'git config' to learn either which regex parser to use
> >>> (including fixed), or at least to learn "value isn't a regex", or
> >>>
> >>> 2. Don't spin a child process in 'git maintenance [un]register' and
> >>> instead just call the config API.
> >>
> >>> I'd suggest #2. The config API is very nice, and seems to have a simple
> >>> way to add or remove configs to your global file in just a couple of
> >>> lines. If there's a reason why it's not simpler to do it that way, it's
> >>> my fault for missing the review :)
> >>
> >> My short-to-mid-term preference is to do #1 to allow a value to be
> >> spelled literally (i.e. remove entry with _this_ value, and add this
> >> one instead), and optionally do #2 as an optimization that is not
> >> essential.  I do not offhand know how you can make #2 alone fly
> >> without doing some form of #1, as I think the same value_regex that
> >> ought to be ERE to specify entries to be replaced needs to be used
> >> under the cover even if you use "config API" anyway.
> > 
> > Ah, right you are - I had figured the regex parsing was done earlier,
> > but it indeed looks to happen in
> > config.c:git_config_set_multivar_in_file_gently. Thanks.
> 
> So the "real fix" is to allow a command-line option to 'git config'
> that makes the "value_regex" parameter a literal string? Of course,
> this would either require wiring an option down into
> git_config_set_multivar_in_file_gently() to treat the string as a
> literal _or_ to escape the input string in builtin/config.c.
> 
> Am I understanding the intended plan here?

That fix sounds like something I would want anyways - the ability to
choose the regex style just like we can for 'git grep' (and I think for
other tools which I'm having trouble finding now).

 - Emily
