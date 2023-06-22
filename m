Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07972EB64D8
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 12:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjFVM6a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jun 2023 08:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjFVM63 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 08:58:29 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543C410F6
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 05:58:28 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-570808d8ddeso69675487b3.0
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 05:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687438707; x=1690030707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nQgwoWRE91aggmT1oa7fxwTmOyz41Ycd0EiuthmjojA=;
        b=meeW3MZJb0lFn8PPQZK+l0WlcsbEOio3SmWVbsH77dj4FTCQeRMdZ6ZTUjDzAC/ZKV
         jhcJqRiwlskUYC7xYvMrcxgViBgAS8U1/MtotW5/g80eP+C7hN2vr0lAHPATKXDapBaO
         mBBJetrIz5XzCoseu4Y9R1uUyhpClHof1TvRdoXO9FhaHZ5PusRpMJrP/2CESieKtvwn
         ld97dDsCVbAuWcp76l1h9UZDL6fe9mbMyVygBzrfLr2UZk94TuGVCZTsvv1vOV/1DY0R
         QUGvwKgRNc6YZEVJVS/2QtB7ivutmv0vGy/fLn/jbR+K1U054OTgv5d6+T42tdxZ9TmK
         9xpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687438707; x=1690030707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQgwoWRE91aggmT1oa7fxwTmOyz41Ycd0EiuthmjojA=;
        b=TM6qvbJ5Ol2C9m00HqtBicJ7Sqj0GoUE1Piea81gxDJCZ8THfTSyQqFlp9VPv3eoQ3
         EITNYaUz8Vf/hGHnbHB7Qh6+cTGPiYkFUVzavG/d0yZTh1R9nw3Ag37Wn2GFHnScqkck
         bqD2IfmbUo3b07umIOkeoVglqFuYXK4aKCLUz6OYg8kaS2phwooSM0xDaaOLHqp9Xu9P
         5m0+eemsLxw8rKd7iUPaoDd4g0UEP5CZI6tUT5Aan7UfVmjyJZQiG3z6sgGd35skM+BN
         /AjDgL836C5s1vZodH4jwAOnTOmV1+K2+zVWH/S0qBZID5UvdOifhC/BrMEm0pG6kfld
         jXRQ==
X-Gm-Message-State: AC+VfDz85U5NLQD4iZjd7TjPLVTkyiGIYssJboWQFygSybG5SIe0gwzI
        yiovjw605+46KwF1sgMHx4tWricS9AulV/2vvYGHQLrV
X-Google-Smtp-Source: ACHHUZ68XvYcQFRpve+tjjM7DDQ/S+hzozFYcxBY1ok+iKT84cj7bpHAzEJ9LeE5bTqGg66gkruLRg==
X-Received: by 2002:a81:9101:0:b0:56d:790:6b2b with SMTP id i1-20020a819101000000b0056d07906b2bmr18021085ywg.46.1687438707513;
        Thu, 22 Jun 2023 05:58:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t132-20020a81468a000000b00565cf40238csm1804138ywa.110.2023.06.22.05.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 05:58:27 -0700 (PDT)
Date:   Thu, 22 Jun 2023 08:58:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 0/3] revision: refactor ref_excludes to ref_visibility
Message-ID: <ZJRFcMR0/f6Olj+Z@nand.local>
References: <pull.1515.git.git.1687376112.gitgitgadget@gmail.com>
 <ZJRBsDq8NI9EInel@nand.local>
 <ZJRDZ7NhyNpTV8jD@nand.local>
 <ZJREYU0daKlmfjhr@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZJREYU0daKlmfjhr@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 22, 2023 at 08:53:53AM -0400, Taylor Blau wrote:
> On Thu, Jun 22, 2023 at 08:49:43AM -0400, Taylor Blau wrote:
> > I am left wondering: why doesn't the rule pertaining to
> > refs/heads/foo/baz show up in the included list? Likewise, what happens
> > with refs/heads/bar/baz/quux? It is a child of an excluded rule, so the
> > question is which list takes priority.
> >
> > Mostly, I am wondering if I am missing something that would explain why
> > you couldn't modify the above example's excluded list to contain
> > something like "!refs/heads/bar/baz/quux", eliminating the need for the
> > include list entirely.
>
> Another potential quirk that I just now thought of: what are the rules
> for what can go in the include list? Fully qualified references only? Or
> can we have patterns (e.g. refs/foo/bar/*). Presumably you'd want to
> have the namespace-stripping operator ^, but not !, since negating an
> include rule seems to imply that it should be in the exclude list.

Sorry for the long chain of self-replies. I think one clarifying point
that I am not sure of yet is whether or not the exclude rules you're
talking about are interpreted as patterns (as in transfer.hideRefs) or
wildmatch patterns.

If they are wildmatch patterns, would it suffice to add the references
you *do* want to enumerate to the traversal ahead of time? There is also
the hidden_refs member of that struct, so perhaps adding negated entries
there would work.

Either way, I think emphasizing the difference between ref exclusions as
it pertains to traversal, and ref exclusions as it pertains to hiding
would greatly help other reviewers of this series.

Thanks,
Taylor
