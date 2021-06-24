Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF08C49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 23:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED3A9613AD
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 23:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhFXXoL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 19:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhFXXoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 19:44:09 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B8EC061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 16:41:49 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso7457954otu.10
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 16:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=fdQWgh8u4qt9EEq+HbDy9lxiUHUOMGppjq5fdHoLu1M=;
        b=PE6+brn9AXABXCj40h/YYSVrx03RnREunuweowMojIQ9553TEHsG4Fr3HDQ3wYCXzV
         rhOzbGhE156VIrUTXJEwGp2SE5Kx45VoJF48N+eYBy5UG2DMnlJA5aymJ6ULj/5H3mDV
         5lKrXFCcTDkMRHPNSQ4lWtL8vht1e44z5T7Uy2bNUDOJj/VeR3rCEUpUlQta0955BH8T
         d9+1z49NDrAL/2gLvRuyySqW5sOr1LlR7diNkOwzQzP6wG4Gtz6H7ZNR4yAl43kawiPV
         XKa26ZEoB2dqQHrqIyfgbyLyFpnjp9k2NUvUut6eknnS1BOLlHLIHsdAThmCNeNnsWu+
         eWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=fdQWgh8u4qt9EEq+HbDy9lxiUHUOMGppjq5fdHoLu1M=;
        b=U78/HSAByj8Kkc+Q37FLdaT2UGEI6ZhBqPhkNTINUxUm0SMNUVE4T4+Q/OoihKPkH9
         5z6YOcd1+Qx7mb6zJXM9kLPCQGcQMcadRLZdZynVvuhCrPBoebAAYc8SGAB1jp2g2UXC
         PGQLZOHakETbHW/fR8WgxfdjGranCxOF6dJXUJBbhg2Fi8S2DUDHXotbMUeI0oewMpKd
         Qw7WHgG89g/PZoGQRqroIKW6BEVJ0Jrd9luA4Aw4yS/mZZIhAf6kLsudAUYK5wxy30GO
         H7BZeIhP0VeNh7uWwbsivq7K+JoBDTU1m4F5GoWIoXNAFtWbYZjkrfKk+AwpeMdy4gnk
         1XQQ==
X-Gm-Message-State: AOAM531tHaM0SFqCjuti6r6cUcOs+rwLlRVjLImqHdVyEyRWSa79wWRi
        rVEAMGSGNH0kSlz2zY4maKg=
X-Google-Smtp-Source: ABdhPJyz3M30tndrua+GEH5IPs2f8BNBSyaJbwGSrbDpw5lgtIEe0seiPgqXxa17lQ43QMbBp82EkQ==
X-Received: by 2002:a05:6830:245c:: with SMTP id x28mr7082297otr.169.1624578108621;
        Thu, 24 Jun 2021 16:41:48 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id j13sm941608oie.27.2021.06.24.16.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 16:41:48 -0700 (PDT)
Date:   Thu, 24 Jun 2021 18:41:46 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Message-ID: <60d5183a9e34d_3a20208b@natae.notmuch>
In-Reply-To: <93084036-804d-4c52-2836-42efd5deba1c@iee.email>
References: <20210621175234.1079004-1-felipe.contreras@gmail.com>
 <20210621175234.1079004-2-felipe.contreras@gmail.com>
 <b4e612ba-21c7-3bef-d113-0f070449cd87@iee.email>
 <60d49748b8538_2fb2082c@natae.notmuch>
 <c2170f74-b93b-599b-1fb4-45b013c7bff1@iee.email>
 <60d4d75e7622c_242620854@natae.notmuch>
 <93084036-804d-4c52-2836-42efd5deba1c@iee.email>
Subject: Re: [PATCH 1/2] doc: pull: explain what is a fast-forward
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley wrote:
> On 24/06/2021 20:05, Felipe Contreras wrote:
> > Philip Oakley wrote:
> >> Hi Felipe,
> >> On 24/06/2021 15:31, Felipe Contreras wrote:
> >>> Philip Oakley wrote:
> >>>> On 21/06/2021 18:52, Felipe Contreras wrote:
> >>>>> --- a/Documentation/git-pull.txt
> >>>>> +++ b/Documentation/git-pull.txt
> >>>>> @@ -41,16 +41,41 @@ Assume the following history exists and the current branch is
> >>>>>  ------------
> >>>>>  	  A---B---C master on origin
> >>>>>  	 /
> >>>>> -    D---E---F---G master
> >>>>> +    D---E master
> >>>>>  	^
> >>>>>  	origin/master in your repository
> >>>>>  ------------
> >>>>>  
> >>>>>  Then "`git pull`" will fetch and replay the changes from the remote
> >>>>>  `master` branch since it diverged from the local `master` (i.e., `E`)
> >>>>> -until its current commit (`C`) on top of `master` and record the
> >>>>> -result in a new commit along with the names of the two parent commits
> >>>>> -and a log message from the user describing the changes.
> >>>>> +until its current commit (`C`) on top of `master`.
> >>>>> +
> >>>>> +After the remote changes have been synchronized, the local `master` will
> >>>>> +be fast-forwarded to the same commit as the remote one, therefore
> >>>> Perhaps s/be fast-forwarded/have been 'fast-forward'ed/ ?
> >>> No, there's multiple steps:
> >> My key point was to 'quote' the fast-forward term.
> > fast-forward is an English word [1], there's no need to quote it as if
> > it weren't.
> 
> You appear to be arguing that your "explain what is a fast-forward"
> (subject line of the patch) doesn't need, within the patch, to explain
> that it is about the term "fast-forward", being used in a Git specific
> way...

When you are trying to explain the meaning of a word it's generally
better to not use that word in the explanation. For example if you are
trying to explain "recursion", but you use "recursion" in the
explanation, that kinds of defeats the purpose.

So yes, in the sentence "the local `master` will be fast-forwarded to
the same commit as the remote one", the verb "fast-forwarded" can easily
be replaced with "advanced" and no meaning would be lost.

The meaning of this "fast-forward" verb is the same as when you
fast-forward a tape, and is not git-specific.

-- 
Felipe Contreras
