Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC03C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 14:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4DDC20866
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 14:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyCWLzhf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgHNOle (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 10:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgHNOld (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 10:41:33 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61C4C061384
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 07:41:33 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mt12so4499614pjb.4
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 07:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lgHSVfpwdaqF8P/VHhJNxjrCu/fEEC4SDJOMvFaPNKA=;
        b=lyCWLzhfMtKK/0YoDViiwAGj4M20hKc4MAT40LXIB1jQvEVrhWQTApnspE8bRsCNFF
         LBqjONcthoTcaHqN8RcA5DtfMzKZ1iVxNj+0BxJsBdobk6tWWgcRaXbUNcWRu3+aLEpJ
         NrFW/OD38m/49CwthnI2/ZdUxHDAyO7MtPDuD7HaZsYnsn89TgjFtZgoO1sZIDo91PP5
         LcmGHr6cjbtZUP48ggdhz0NfrtuxLYzXhJ/8Sb4TGzCOrjFiizLvhFi7koUdWX/lWvbQ
         ke+3JEqSH1DUSNe9YMvHzqGhNgGXTa3OXN9bpNmF9HnaS9Th6wBl5fLPF/8bANZwfgGb
         Zfxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lgHSVfpwdaqF8P/VHhJNxjrCu/fEEC4SDJOMvFaPNKA=;
        b=WqIwD3sOfrnodOwbtWXp5aynXZ0hM0YA0EC4urL/WWFmifK9iCnnld24zH9ODOZFQF
         Y3t0dZ/T1HmebG9nOyojWHjjJZjZ7NdrtJw0oPJSXyTH+8DoVOcebGTu+M6qU8nHwt17
         2dISVlGZsejZ37xlcPyRLXUrLZL1IVdLLJxeTyHOKh87yIyBv5Bs/80hkfacYwDb54jB
         g3OmbXDo09K8pZpsB6MrMOhkEHlKf2JwXMVexbZi8LxUIPXB2MZdOq7mybN03qD8p1j2
         T4wls0Cstlg+ZR9hULGHiPJq9wUQSrRDmLHyPnTKX6gTgnMTeg62OAhFvnhZof6/bxPK
         0ycg==
X-Gm-Message-State: AOAM5338j7fb8a+UFs9o5uw3TyJ7gbl+B2FyjNzXtwgJgo787F73u0sp
        wKhOh6AJh+WCZBfoaZfI1mo=
X-Google-Smtp-Source: ABdhPJyRpCNbAM4Cx5DyYvYPhFpNQ5qOyVLdm1pRcsu+th/w1y9cMaPQ7lv8JHFLT9Y0Ss2sjW7KtA==
X-Received: by 2002:a17:90a:bc41:: with SMTP id t1mr2426841pjv.181.1597416092959;
        Fri, 14 Aug 2020 07:41:32 -0700 (PDT)
Received: from konoha ([45.127.46.174])
        by smtp.gmail.com with ESMTPSA id a17sm9589110pfk.29.2020.08.14.07.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 07:41:32 -0700 (PDT)
Date:   Fri, 14 Aug 2020 20:11:26 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     kaartic.sivaraam@gmail.com, christian.couder@gmail.com,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        liu.denton@gmail.com, me@ttaylorr.com
Subject: Re: [PATCH v2 1/4] t7401: modernize style
Message-ID: <20200814144126.GA137865@konoha>
References: <20200805174921.16000-1-shouryashukla.oo@gmail.com>
 <20200812192737.13971-1-shouryashukla.oo@gmail.com>
 <20200812192737.13971-2-shouryashukla.oo@gmail.com>
 <c70f7bb5d1289f5318da7b99e41cf5828a451174.camel@gmail.com>
 <xmqqd03u4hpl.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd03u4hpl.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/08 09:46, Junio C Hamano wrote:
> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
> 
> >> @@ -16,12 +16,13 @@ add_file () {
> >>  	owd=$(pwd)
> >>  	cd "$sm"
> >>  	for name; do
> >> -		echo "$name" > "$name" &&
> >> +		echo "$name" >"$name" &&
> >>  		git add "$name" &&
> >>  		test_tick &&
> >>  		git commit -m "Add $name"
> >>  	done >/dev/null
> >> -	git rev-parse --verify HEAD | cut -c1-7
> >> +	git rev-parse --verify HEAD >out &&
> >> +	cut -c1-7 out
> >
> > In any case, I believe we can avoid the 'cut' altogether in both places
> > by doing something like this instead:
> >
> >    git rev-parse --short=7 HEAD
> 
> Ah, I missed the fact that this was a helper function and most of
> the error status is discarded anyway.  For example, we still run the
> rev-parse even after the for loop fails.
> 
> If the focus of this test script were to ensure that rev-parse works
> correctly, being careful to catch its exit status might have had a
> good value, but for that, all the other operations that happen in
> this helper function (including the "what happens when the loop body
> fails for $name that is not at the end of the argument list?") must
> also be checked for their exit status in the first place.
> 
> Since that is not done, and since testing rev-parse should not have
> to be part of the job for submodule test, the net effect of the
> above change has quite dubious value---it clobbered a file 'out'
> that may be used by the caller.
> 
> Doing "cd" without introducing a subshell is a bit harder to fix, as
> test_tick relies on the global counter in the topmost process.  It
> can be done, but I do not think it is worth doing here.  Most of the
> users of this helper function call it in var=$(add_file ...)
> subshell anyway (so test_tick is incrementing the timestamp
> independently for each caller and discarding the resulting
> timestamp).  As a NEEDSWORK comment added in the series says, this
> script may need a bit more work.
> 
> I agree with you that the split of "rev-parse | cut -c1-7" into two
> statements and clobbering 'out' is a bad change---that part should
> be reverted.  The style change on 'echo "$name" >"$name"' line is
> OK, though.
> 
> Thanks.

Understood. I will revert the change. Though, what Kaartic suggested, to
do a '--short=7', that will be okay to keep right? Something like:

    git rev-parse --short=7 HEAD

This way we will not need a 'cut'. This change goes as a separate commit
obviously.

