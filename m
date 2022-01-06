Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B761C433F5
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 01:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344061AbiAFBI5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 20:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240018AbiAFBI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 20:08:56 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139D2C061245
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 17:08:56 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id z9so3260325edm.10
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 17:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eGA9BeMJUEROBQ1dZJqrqysqs+EE7tXZ2RiVjK9ffYY=;
        b=iEtayGRoPeal8H5hKRNLfb/acH1j1TFVV7jK/FM7lPj46B+LLt8IrgyArTPHbcQjbp
         NkL8vkqIxH9oo93q1a5kGVYOCv/YCjmXv/9H/jvV+yLLfkJQkft5D9Z+rHaLog2Hef/S
         GrLKO/w+/IcNVW/u6SiBhe4ITOtvuyueX4nL1RWKauGdRThk//R9nPo4m/rYEzoJp8st
         WGGIlnECkpFMCXu0kDpl+D3kooNm+zNR2a7Oqp/soIvxZwXb7Wx6kMvoYR48oUKJDj44
         n/UqskHOPTd64Q5OM/7q77YdGMkIhcD9GZeVPonwYZgFpPJNcE0eRE3Q8oCNwRlCLh0C
         sMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eGA9BeMJUEROBQ1dZJqrqysqs+EE7tXZ2RiVjK9ffYY=;
        b=0XIl4E9D5fSokSq/eJElkHcN6Nn13xh9ZvtQVV9UoNaI2NT4/7fDkQAsy2z/n+Vr5n
         DThDA9V+3/M14sozDOBVm5bo0TTMRJnQtDwwtcJJpMWbiOSuWrZLqm7/tZzyQQVDv/CV
         AbTr4P/MF4NXKekXuj5samVJuma8JHrPHCIIXFtoy9Mw4cIrUXGFH93PEJhiVS39xwrv
         Bpc6FhJMaBPP6pD/LQEsb9d9LinXs7Blxbug/+SbFu8JoIGX/Mu4URR/bdtCMSoCF/ns
         bFES9lYjBslM9SuRrlUdT+BVMaq5jK7RaXCX1SIN1uIwCo1loREoZNsyOLUIjHH9jAs2
         sREA==
X-Gm-Message-State: AOAM533gGjXMo+Bzek5C3IfT7kx/ZI4jrCiB7z/ns2LUSAbzoCG8hARk
        sL6rPY/WSqp4c+1u+gdyYehpwpykod1GE/RKx2gUNrlsBLA=
X-Google-Smtp-Source: ABdhPJwg17gxJYeMzzEEqBNYZQY3cfpReaqPlBbIW6ogGGnBWwRWLzLMega/ckKzbnZVgsvLJMngf3fdlB0Rsyj/1NQ=
X-Received: by 2002:a05:6402:350b:: with SMTP id b11mr55976354edd.228.1641431334522;
 Wed, 05 Jan 2022 17:08:54 -0800 (PST)
MIME-Version: 1.0
References: <29f0410e-6dfa-2e86-394d-b1fb735e7608@gmail.com>
 <xmqqsfu1g64s.fsf@gitster.g> <CABPp-BH5woi6KY7OBpnsS-M2EmgLHii9zs8rSwrgcPFkOAvn_A@mail.gmail.com>
 <xmqqbl0pg3s7.fsf@gitster.g> <CABPp-BFfuDMQXCZg_5YXQLaPtc9nyrJaq8J6VEDVsaiEMeeZMA@mail.gmail.com>
 <xmqq7dbdg1k6.fsf@gitster.g>
In-Reply-To: <xmqq7dbdg1k6.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 5 Jan 2022 17:08:43 -0800
Message-ID: <CABPp-BF=-1aZd=nFHF6spo7Ksa7f7Wb7ervCt0QvtNitMY=ZBA@mail.gmail.com>
Subject: Re: Bug report - sparse-checkout ignores prefix when run in subdirectories
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lessley Dennington <lessleydennington@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 5, 2022 at 4:17 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Are you possibly confusing pathspecs with gitignore patterns here?
> > (Or am I?)  Or are you suggesting that sparse-checkout be modified to
> > accept either gitignore-style files or pathspecs and handle both?
>
> Much closer to the latter (actually, removing ignore patterns, and
> make the subsystem work with pathspecs).

Oh, interesting.  That'd at least suggest you're also happy to get rid
of the ignore patterns in this subsystem if we find a feasible
transition plan to do so.  I'll keep that in mind.  :-)

> > I have never liked that gitignore-style patterns were used for
> > sparse-checkout, but it has always seemed a bit too late to change it.
>
> Perhaps.
>
> > Ever since Stolee introduced cone-mode, my preferred strategy for
> > fixing the gitignore-style patterns problem, assuming we are allowed
> > to do so, is to deprecate if not kill non-cone mode.  (And in the
> > meantime, I'm just doing due diligence when I mention non-cone mode in
> > my reviews.)
