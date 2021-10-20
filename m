Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9F6C433EF
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 12:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03C6461355
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 12:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhJTM4c (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 08:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhJTM43 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 08:56:29 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EACC06161C
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 05:54:14 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id ec8so26148169edb.6
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 05:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=WOh3OPLcPNZNvaoBVnwWdePh8HUV6EeBNlQhkvYHSw8=;
        b=H2fpQImlL3QJqdRQqykNdlcSKZd7/ZI36WJofnzp6awU/gkgzLXTtIgvTfd+OfGtty
         yjvXDnWGnB0fbXbsV2bJhkt8bJ8pQWHzElkI3Dt8OiwxwM/pg9iN9DO8DatMMCew5enw
         BY7Zjd7i5NCDWpLGxJsFHxH1WjU84mGiyzLymtxokfEFzXKfL+TZ3vxVwefb74lVkDDd
         JCyN6fhlnt0Qvql4iVIVHNgy5gqnitIanhtY1TmcuOHTMRYX7yH3jCl09fI+tBBqCv61
         fk1WtMK9ycwKYbWqDEVSTLUtV3IJlUGwmwL95fg4hO2nFuFwG6UKVTiV4xE8kj1SBbDs
         CNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=WOh3OPLcPNZNvaoBVnwWdePh8HUV6EeBNlQhkvYHSw8=;
        b=y/dXYtxeenoXIFp7Zlk4yXI6IAteuSrnAHL6XSL3IKqh/H+VLGpdtfSp+MoVCacXbk
         lXLTmqffA0sjv+rsgDZ2OZY/1si/4nnWKInppA3NUbVmbeCBi1nIVthaW1d6bvsdgNK3
         MvctFvC0wovbWY0A4upwLbNUoJvTniy4efQkUpSzNOmYMSKmX/OFT7ShMMmdCj7NWBdR
         pl4SIx52qnvXu3csiSXrsPG93i2opT+jI0VXCS+YlCHUmDCAE+7FjoFEJT7VPT66Cb6r
         JKPKCaET4byDi6uUFpKGiKVha1k4EqkXq0clsBE53eXgM4HeURUvQAJythep1zTsJ0zZ
         UF5g==
X-Gm-Message-State: AOAM5329Ascfdn4H5bhG3mme5SKkLe7/B+nOZkBSwWOs5CovOLcTMijG
        hpxc2Pti64u/fouAng6E+L49czD9RmQYhQ==
X-Google-Smtp-Source: ABdhPJyQ+Kh/tz4KBmBjdmimUzQ+CzoJVL7JTWPnyyr8b7M1RZgSHQPCNkoFp3wIIaTh1vGm+y+VrA==
X-Received: by 2002:a17:906:4950:: with SMTP id f16mr44759442ejt.297.1634734450122;
        Wed, 20 Oct 2021 05:54:10 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s16sm1205580edd.32.2021.10.20.05.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 05:54:09 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mdB6e-000iAP-H7;
        Wed, 20 Oct 2021 14:54:08 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] for-each-ref: delay parsing of --sort=<atom> options
Date:   Wed, 20 Oct 2021 14:30:42 +0200
References: <xmqqv91uw5dl.fsf@gitster.g>
 <YW9EP5UNX0f+eOke@coredump.intra.peff.net>
 <YW98+Lj9xVsR9u9Q@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <YW98+Lj9xVsR9u9Q@coredump.intra.peff.net>
Message-ID: <211020.864k9boo0f.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 19 2021, Jeff King wrote:

> On Tue, Oct 19, 2021 at 06:18:40PM -0400, Jeff King wrote:
>
>> > @@ -86,8 +86,6 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>> >  
>> >  	packet_trace_identity("ls-remote");
>> >  
>> > -	UNLEAK(sorting);
>> > -
>> >  	if (argc > 1) {
>> >  		int i;
>> >  		CALLOC_ARRAY(pattern, argc);
>> > @@ -139,8 +137,13 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>> >  		item->symref = xstrdup_or_null(ref->symref);
>> >  	}
>> >  
>> > -	if (sorting)
>> > +	if (sorting_options.nr) {
>> > +		struct ref_sorting *sorting;
>> > +		UNLEAK(sorting);
>> > +
>> > +		sorting = ref_sorting_options(&sorting_options);
>> >  		ref_array_sort(sorting, &ref_array);
>> > +	}
>> 
>> I wondered at first about pulling this UNLEAK() down, but it's because
>> you move the "sorting" variable itself into the smaller scope. So this
>> makes sense (and calling UNLEAK() before the pointer is set is perfectly
>> fine, since it takes the address of the auto variable). It is a shame
>> you can't just ref_sorting_free() afterwards, but we don't have that
>> function yet. And adding it is way out of scope here. :)
>
> Actually, I think I was wrong here. UNLEAK() will look at &sorting, but
> it will snapshot its data at the time of the call. So it won't do
> anything when the variable doesn't yet have a value.
>
> You can demonstrate with:
>
>   $ make SANITIZE=leak
>   $ ./git ls-remote --sort=refname .
>
> which will complain. Bumping it down like this:
>
> diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
> index 1e6017cdaa..a94a220256 100644
> --- a/builtin/ls-remote.c
> +++ b/builtin/ls-remote.c
> @@ -139,10 +139,10 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>  
>  	if (sorting_options.nr) {
>  		struct ref_sorting *sorting;
> -		UNLEAK(sorting);
>  
>  		sorting = ref_sorting_options(&sorting_options);
>  		ref_array_sort(sorting, &ref_array);
> +		UNLEAK(sorting);
>  	}
>  
>  	for (i = 0; i < ref_array.nr; i++) {
>
> clears it up. Note that there are other similar "leaks" (e.g., if you
> give a pattern in argv[1]) which should be punted to another topic, but
> I think you'd want to deal with this one since you're moving the
> UNLEAK() around.
>
> -Peff

With or without your change Junio's patch still makes t0016-oidmap.sh
fail when applied on top of master under SANITIZE=leak, it passed
before:
    
    =================================================================
    ==3448774==ERROR: LeakSanitizer: detected memory leaks
    
    Direct leak of 16 byte(s) in 1 object(s) allocated from:
        #0 0x7ff5c1c8ab45 in __interceptor_calloc ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:76
        #1 0x5614d26ac4e5 in xcalloc /home/avar/g/git/wrapper.c:140
        #2 0x5614d26186b0 in ref_default_sorting /home/avar/g/git/ref-filter.c:2676
        #3 0x5614d26187c9 in ref_sorting_options /home/avar/g/git/ref-filter.c:2707
        #4 0x5614d24e21c3 in cmd_tag builtin/tag.c:527
        #5 0x5614d2407a89 in run_builtin /home/avar/g/git/git.c:461
        #6 0x5614d2407e98 in handle_builtin /home/avar/g/git/git.c:713
        #7 0x5614d2408105 in run_argv /home/avar/g/git/git.c:780
        #8 0x5614d24085ae in cmd_main /home/avar/g/git/git.c:911
        #9 0x5614d24ef3d8 in main /home/avar/g/git/common-main.c:52
        #10 0x7ff5c1a06d09 in __libc_start_main ../csu/libc-start.c:308

I.e. the leak from ref_sorting_options() via ref_default_sorting() is
new in this commit for those codepaths.
    
