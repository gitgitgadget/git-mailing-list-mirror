Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B53C38A2D
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 21:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbiJZVdA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 17:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbiJZVc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 17:32:57 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D309143A71
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 14:32:53 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id o2so6296041ilo.8
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 14:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0xiiopsrGK50h4/V2X5tZ9V7eGV5bv+fZ5ykhRzEdCA=;
        b=GuS7elJZwgqaUgJqIOlbznLERvvPA94kHcPzuqy5q+N1PyHm/sh090n18P6Gijknm0
         uMEOG1bLwDtYSFQPqKp2MYqbPW7M6xph0iqmHtUcs279V6rbwlKIAWbL2Ym+CqyaPOvM
         E+cFx/ECq0p9TJe9NU2svKzmuVCFmNJfuymANSJx69ocnDomu4welyT6zmwtN3m6jH9m
         4VdUotpU89WgB4bSBNax0CXGGMndqtpZTaWI7rMETxKcwNfT0lwplxf/vhGI69xevwr5
         EQ6cs9x95akWRa5nKZaQT7weE1FMQHktfyE8wVp2cuavIUqjRhaXM6XGM3OBJZL0TX50
         Zi5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xiiopsrGK50h4/V2X5tZ9V7eGV5bv+fZ5ykhRzEdCA=;
        b=cRalWwDsZiM/uxW10v0l1si5eM9GAUfsu8gBhr8xuajp0/WKPV1ymzswXbvjEmywbL
         xRkfqrL9VB4hhsYoaXsRWfkwtODHoFspKMhbLJh58nraVQIKnXU+xxM0N8esiRd9GMPk
         RIWr/AEGXBznvhSiJ/uKMprqNhXEgmoyjsqpLXYHjTIc07uWdpXWubMiuRWKC1nh+HqT
         +W0SbQPsXaZi2nrXexN0k7lk2Vz2a4GlLaCW4SqOf5ijXcsb7i8DF8/OpMiJkzULMybD
         ykSl69vOyx8GsmhRPbwH2AnvNuTVloaXS1tZ0J40Nnk9vfBbs3mpT+Gn2PNkvh3hxoyu
         s9sg==
X-Gm-Message-State: ACrzQf0n1w9wCluQ8iBEHFZdCoyksBPLuAHDR6pZiiQfmpNeNuzT7XTx
        GhcAR1FLqoeAwU/dLu0YzHPqItPU8basQP9b
X-Google-Smtp-Source: AMsMyM4qpif4sCbIvdFuf3miFy9EF4rUkGnOLjNn8stdrAjzQza9fEKUarJWD5zwNdiiNhDYC7OicA==
X-Received: by 2002:a05:6e02:b47:b0:2ff:cb5b:8052 with SMTP id f7-20020a056e020b4700b002ffcb5b8052mr12063937ilu.101.1666819972919;
        Wed, 26 Oct 2022 14:32:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y22-20020a02ce96000000b00374bf3b62a0sm2390232jaq.99.2022.10.26.14.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 14:32:52 -0700 (PDT)
Date:   Wed, 26 Oct 2022 17:32:51 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v2 2/2] config: let feature.experimental imply
 gc.cruftPacks=true
Message-ID: <Y1mng9cqAyEqQIQM@nand.local>
References: <cover.1666815209.git.me@ttaylorr.com>
 <eb151752b8de355ac334507e57dc95aadc9ef2bf.1666815209.git.me@ttaylorr.com>
 <xmqqfsfaffs1.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfsfaffs1.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 26, 2022 at 02:15:10PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > diff --git a/builtin/gc.c b/builtin/gc.c
> > index 243ee85d28..5a84f791ef 100644
> > --- a/builtin/gc.c
> > +++ b/builtin/gc.c
> > @@ -42,7 +42,7 @@ static const char * const builtin_gc_usage[] = {
> >
> >  static int pack_refs = 1;
> >  static int prune_reflogs = 1;
> > -static int cruft_packs = 0;
> > +static int cruft_packs = -1;
> >  static int aggressive_depth = 50;
> >  static int aggressive_window = 250;
> >  static int gc_auto_threshold = 6700;
> > @@ -593,6 +593,10 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
> >  	if (prune_expire && parse_expiry_date(prune_expire, &dummy))
> >  		die(_("failed to parse prune expiry value %s"), prune_expire);
> >
> > +	prepare_repo_settings(the_repository);
> > +	if (cruft_packs < 0)
> > +		cruft_packs = the_repository->settings.gc_cruft_packs;
> > +
> >  	if (aggressive) {
> >  		strvec_push(&repack, "-f");
> >  		if (aggressive_depth > 0)
> > @@ -704,7 +708,6 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
> >  		clean_pack_garbage();
> >  	}
> >
> > -	prepare_repo_settings(the_repository);
>
> It is curious why we had this call so late in the sequence in the
> original.  This is well past what can be reasonably called "start-up".
> We have locked the repository, we may have daemonized ourselves, we
> may already have packed loose refs and pruned reflogs.  Was that due
> to somewhat lazy thinking that the next line is the first one that
> requires the repository's settings already prepared, I wonder.

The latter. The general practice I've observed with
prepare_repo_settings() is that it is supposed to be called lazily, just
before the first piece of code in a particular file that is going to
read the repo settings.

Since the function is a noop on any subsequent calls, we can afford to
be over-eager placing it around.

So it would have been equally OK to duplicate the call, but it's
unnecessary since the first call is entered unconditionally from within
cmd_gc().

> > +refute_cruft_packs_exist () {
> > +	find .git/objects/pack -name "*.mtimes" >mtimes &&
> > +	test_must_be_empty mtimes
> > +}
>
> Hmph, not "assert_no_cruft_packs"?

Heh, sorry :-).

> One thing missing is a test for the escape hatch for those who opt
> into the experimental world when gc.cruftPacks feature is broken.
> IOW,
>
> 	git -c feature.experimental=true -c gc.cruftPacks=false
>
> should allow them to opt out of gc.cruftPacks.
>
> Other than that, looking good.

Indeed, thanks for spotting it. I'll send a reroll with the additional
test.

Thanks,
Taylor
