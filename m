Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D7FC433DB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 21:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E71365250
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 21:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbhCIVOo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 16:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbhCIVOk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 16:14:40 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E66FC06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 13:14:40 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id p8so31782926ejb.10
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 13:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=FvDB4pEF8pYpVk2mr2yCtTltRgnCX5wlc5Wyj/ljow4=;
        b=kIeREpa8LC1lnO3db55bG28IeFzWN/QbEIQd43bW1eUWpG4yc/nm89iMTD5y8TOQn3
         qMYKAcs3kVfuCZ5k9LqCnGPCxEc7Z8kvBJf36kmEHVehodpyl3PH/CwvCs0cZCYYCrwr
         Aph9GaHZQMYEZ5CJaY0yoBAV504siHCXhAxDPBQKlUQv3JUKvgsnSUC0Pqgpl5RRSUnR
         1yZAaMF58jDEOEBw+VBaho7G1SbcrHwD8DZg71jVRoYrDMmbn5v+Kh1dnFMc+M5hZD8X
         8OzCrHMHgDYJ/BKCmjdJBKZ5FQ7Gl6ZdFhvtV1Xu6tCB4kgwMwY3xoBk9EpI+VKwfksX
         Tszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=FvDB4pEF8pYpVk2mr2yCtTltRgnCX5wlc5Wyj/ljow4=;
        b=Ted/gkhVe+EBj16DKaNBG6ILje1gBnijZXziPTPpgnS9d02eBdN2W1R+Uupo3XBxrb
         RnucDit87Uegjvw0nYLPkTdSNz8OL2SZIVku3RqPH6gUyxSabhseUWgUhgIo8fj1tUJ1
         1SubFR0wStzbEbvXmTUK1FKIB+fBj5GD0nQUt3pdg5tyGiB6+kR+7QmjpI3t33I5yIm3
         o5xgNNhgw4jtkSB5bE3MElY9Zk/1OIHdGFgg5rRMhI1mc4jF7+11TQysw69IY1au4Zp8
         sD0XSc28C/jf+QaP6iR4I9Wrk4oQuatAiZyg2JdUdO1duyQrCdkDbortD6ax8cA9Gbd3
         HkKA==
X-Gm-Message-State: AOAM533wre8XZOeLHLCaMvKL0qqcWougmd1kAwDQgBq4ullwT/08yfRn
        tINqyZ2logCmAXVVR2ihdAXHP8BHeFEHtg==
X-Google-Smtp-Source: ABdhPJwbKbJw/ID6TokVJ1T4fkQPwDhYuyg1uNDzUgKTeCqelEPpnDH1gh1QdvMCFI5+KmPlYtTU6A==
X-Received: by 2002:a17:906:7c43:: with SMTP id g3mr49072ejp.210.1615324478706;
        Tue, 09 Mar 2021 13:14:38 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id gj13sm8529599ejb.118.2021.03.09.13.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 13:14:38 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     David Turner <David.Turner@twosigma.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: slow object packing during push
References: <38b99459158a45b1bea09037f3dd092d@exmbdft7.ad.twosigma.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <38b99459158a45b1bea09037f3dd092d@exmbdft7.ad.twosigma.com>
Date:   Tue, 09 Mar 2021 22:14:37 +0100
Message-ID: <87eegohvwi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 09 2021, David Turner wrote:

> I have a large, funny repository that has very slow pushes unless I
> set pack.usebitmaps=false to false.

Good to see you on-list again! :)

> First, a description of the repo: it's about 175GB, and was created by combining about 40,000 smaller repositories.  Historically, these repos were submodules of one meta repository[2].  I have stitched together the submodules, and this is the repository in which the stitching was done - that is, it contains all of the objects from the smaller repos, plus all of the objects from the meta repository, plus the newly-created trees & commits for the stitched repositories.  As new commits come into the meta repository (which have gitlinks to new submodule commits), we fetch from the meta repository (8s - it would be 2s if we were fetching into a normal clone without all of the other stuff), and the submodules (up to 10s per and embarrassingly parallel). Then we stitch (~0s), and push to the stitched "unity" repository (~2 minutes!!!).  The entire repo fits in RAM (yes, all 175G) and is in fact in the disk cache (I prewarmed the cache before testing anything).  
>
> The vast majority of the time appears to be spent in git pack-objects, and in particular in the stack trace in [1].  If I set pack.usebitmaps=false, the push only takes 10s.   This seems like pack bitmaps are a severe pessimization for my purposes.  This is true even immediately after a repack (that is, almost all of the objects are in one giant pack, except the newly-fetched ones).  I also tried setting up pack islands - one for each smaller repo, one for the stitched commits, and one for commits from the meta repo.  I'm not sure if this is necessary, but it's definitely not sufficient (my current config has it turned on, because I didn't feel like repacking again after testing it, and I tested it before testing pack.usebimaps). 
>
>
> [1]
> #9  0x000055d849183bfe in traverse_trees_and_blobs (ctx=ctx@entry=0x7fff2de42a80, 
>     base=base@entry=0x7fff2de42a30) at list-objects.c:344
> #10 0x000055d849183d2b in do_traverse (ctx=ctx@entry=0x7fff2de42a80) at list-objects.c:388
> #11 0x000055d84918408f in traverse_commit_list_filtered (
>     filter_options=filter_options@entry=0x55d849544e80 <filter_options>, 
>     revs=revs@entry=0x7fff2de43f00, show_commit=show_commit@entry=0x55d8491a7830 <show_commit>, 
>     show_object=show_object@entry=0x55d8491ac920 <show_object>, 
>     show_data=show_data@entry=0x7fff2de42b50, omitted=omitted@entry=0x0) at list-objects.c:421
> #12 0x000055d8491a8c1a in find_objects (bitmap_git=bitmap_git@entry=0x55d84a41cd40, 
>     revs=revs@entry=0x7fff2de43f00, roots=0x0, seen=seen@entry=0x0, 
>     filter=filter@entry=0x55d849544e80 <filter_options>) at pack-bitmap.c:603
> #13 0x000055d8491af68d in prepare_bitmap_walk (revs=revs@entry=0x7fff2de43f00, 
>     filter=filter@entry=0x55d849544e80 <filter_options>) at pack-bitmap.c:1004
> #14 0x000055d8490b1983 in get_object_list_from_bitmap (revs=0x7fff2de43f00)
>     at builtin/pack-objects.c:3294
> #15 get_object_list (av=<optimized out>, ac=<optimized out>) at builtin/pack-objects.c:3373
> #16 cmd_pack_objects (argc=<optimized out>, argv=<optimized out>, prefix=<optimized out>)
>     at builtin/pack-objects.c:3739
> #17 0x000055d84903ed19 in run_builtin (argv=<optimized out>, argc=<optimized out>, 
>     p=<optimized out>) at git.c:450
> #18 handle_builtin (argc=7, argv=0x7fff2de45320) at git.c:700
> #19 0x000055d84903fd96 in run_argv (argv=0x7fff2de450a0, argcp=0x7fff2de450ac) at git.c:767
> #20 cmd_main (argc=<optimized out>, argv=<optimized out>) at git.c:898
> #21 0x000055d84903e8ef in main (argc=8, argv=0x7fff2de45318) at common-main.c:52
>
> [2] https://github.com/twosigma/git-meta

Without having carefully re-read it, I believe this issue is the same as
what I reported here in 2019, and I think you'll find the resulting
discussion intresting:
https://lore.kernel.org/git/87zhoz8b9o.fsf@evledraar.gmail.com/

Having skimmed it, I think you're probably omitting that this is a bare
repo you're pushing from, and thus you're running into the combination
of repack.writeBitmaps being true by default on bare repos, and
pack.useBitmaps being true everywhere (but having no effect by default
unless you have a bare repo, unless you manually make bitmaps blah
blah).

One of the semi-conclusions from the above thread was that we mostly
turned this on thinking that bare ~= server that accepts pushes, and
bitmaps are known to be worse (but not always!) for when you're pushing
*from* your repo.
