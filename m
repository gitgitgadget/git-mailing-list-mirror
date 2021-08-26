Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A738AC4320E
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 22:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BB7D60FE6
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 22:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243764AbhHZWhV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 18:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbhHZWhU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 18:37:20 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F89C061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 15:36:33 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y11so3954606pfl.13
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 15:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OxSYkSq5nyJv+qzRmcR/bmLsIFQq3PgfqHuwLYdodqM=;
        b=tixss+S4fyeIcL5tkWPY/Kx0r5EXXz7oP+kZYspM8CPV9ilqCG6H26k2uHrmdFXXaA
         QMpeqVIf+fbiDstxlBo4Jdsm8b/okUcNexBjV8IHeghZpzYdsCzlVWVYFBQnFuIARMSG
         scMyCkpiCHvq0k6cHu+2/T6dL3jMIC4QCNin8NsqQT18Xx7qqkdPZJqS0HGihzNYGKFQ
         N9lx0tHjMmgkKydRT6x/Qj+9i33MkcLsKPqPh7dsYxRtL2kXRC9I5cOME/Sjd2Zno+3+
         qPR1lKF7jHHxh7Bw5Pk5IkE5Uh1Hm4tQhekTtgfEVDnNBjtS+jSKUpkmAQryr83RYX14
         V87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OxSYkSq5nyJv+qzRmcR/bmLsIFQq3PgfqHuwLYdodqM=;
        b=cN2h9Zx/cRKBn8UqaLKSyICaVlTHKW703siDblX26E5biGdbsaMkD6NefswHC5AeI5
         dasOFviahAy9KLf0ZrU9J4eWgdlZY3UaDNIE1n/49dG+MpKdWUsitPYBZ+CIWUS1E5n+
         qJ5ixUUm0ozaEqjFrhSgv7VAbrqv1D+CTirMPrLX5IGREN7QniaW+V27AwEyIFqBId6H
         cx5f+ppdtklZeZOeYv9uCdkneHmmzwAKIUrdq5oWkEsCjBwhEktvRPcCPEAyRLSMnPIH
         hvjxJLVqUZzYMA+LrxB+ZmQ/bMQcuABf+Gt0UXE6MbdUH9lgF+PXHSDY1Mkx8R2ZGrkC
         OH+A==
X-Gm-Message-State: AOAM53202DNuawgaSiL4JTWk9qKkrO0u3fZ66WHC7jnHElcamqU55mCr
        eZzoroak1wvWi8uqNi8PdXLQg39JtuRIQQ==
X-Google-Smtp-Source: ABdhPJx+02Od5WdJE8ib52CFY8ju/B4sYkce4P7MtfVkjQrJKt2+gKuBE0sa0uN/GVrXgWYuvi5scA==
X-Received: by 2002:a63:4614:: with SMTP id t20mr5227944pga.372.1630017392418;
        Thu, 26 Aug 2021 15:36:32 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:c1d9:3a1d:fe59:b07a])
        by smtp.gmail.com with ESMTPSA id q4sm3619399pjd.52.2021.08.26.15.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 15:36:31 -0700 (PDT)
Date:   Thu, 26 Aug 2021 15:36:26 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/6] hook: allow parallel hook execution
Message-ID: <YSgXarfqwQVmO8Af@google.com>
References: <20210819033450.3382652-1-emilyshaffer@google.com>
 <20210819033450.3382652-3-emilyshaffer@google.com>
 <87wnoaevbe.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wnoaevbe.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 05:01:09PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> On Wed, Aug 18 2021, Emily Shaffer wrote:
> 
> > -'git hook' run [--to-stdin=<path>] [--ignore-missing] <hook-name> [-- <hook-args>]
> > +'git hook' run [--to-stdin=<path>] [--ignore-missing] [(-j|--jobs) <n>]
> > +	<hook-name> [-- <hook-args>]
> 
> As an aside I wondered if it shouldn't be [[-j|--jobs] <n>], but grepped
> around and found that (x|y|z) means a mandatory pick of x, y or z, but
> [x|y|z] means that, plus possibly picking none, I think.
> 
> So this is fine, just something I wondered about...

Hm, I guess I hadn't see [x|y|z] (or paid attention to it). Anyway, yes,
I think [(-j|--jobs) <n>] is probably most correct here: "entirely
optionally you can provide a jobs arg; but if you do it must start with
-j or --jobs and it must contain a number". I guess you could also say
[-j <n> | --jobs <n>] but that might leave the reader to consider
whether <n> has a different meaning in each? Anyway, doesn't matter
really, and thanks for completely nerd-sniping me ;)

> 
> > +-j::
> > +--jobs::
> > +	Only valid for `run`.
> > ++
> > +Specify how many hooks to run simultaneously. If this flag is not specified, use
> > +the value of the `hook.jobs` config. If the config is not specified, use the
> 
> s/use the value/uses the value/
> 
> Also we usually say "of the XYZ config, see linkgit:git-config[1]", or
> something to that effect when we mention config variables. Perhaps we
> should do the same here.

Done, thanks.

> 
> > +number of CPUs on the current system. Some hooks may be ineligible for
> > +parallelization: for example, 'commit-msg' intends hooks modify the commit
> > +message body and cannot be parallelized.
> 
> Not something that *needs* to happen in this series, but I wonder if we
> shouldn't have per-type config here too, so users could force it even
> for those hook types if they want.

Yeah, I'm happy to implement that later when someone complains... ;)

> 
> > -#define RUN_HOOKS_OPT_INIT { \
> > -	.env = STRVEC_INIT, \
> > -	.args = STRVEC_INIT, \
> > -}
> > -
> >  /*
> >   * To specify a 'struct string_list', set 'run_hooks_opt.feed_pipe_ctx' to the
> >   * string_list and set 'run_hooks_opt.feed_pipe' to 'pipe_from_string_list()'.
> > @@ -111,6 +113,18 @@ struct hook_cb_data {
> >  	int *invoked_hook;
> >  };
> >  
> > +#define RUN_HOOKS_OPT_INIT_SERIAL { \
> > +	.jobs = 1, \
> > +	.env = STRVEC_INIT, \
> > +	.args = STRVEC_INIT, \
> > +}
> > +
> > +#define RUN_HOOKS_OPT_INIT_PARALLEL { \
> > +	.jobs = 0, \
> > +	.env = STRVEC_INIT, \
> > +	.args = STRVEC_INIT, \
> > +}
> > +
> 
> Ditto earlier comments about whitespace churn, i.e. I can just move this
> around in the base topic, so the diff here is the change/addition, not
> also moving things around.

Nah, I think I just wasn't paying much attention to where it goes. It
makes more sense to put this by the 'struct run_hooks_opt' decl, I'll
move mine instead.

 - Emily
