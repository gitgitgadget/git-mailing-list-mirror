Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD6EC433EF
	for <git@archiver.kernel.org>; Sat,  7 May 2022 04:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445493AbiEGESH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 May 2022 00:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355747AbiEGESF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 May 2022 00:18:05 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767496E8D8
        for <git@vger.kernel.org>; Fri,  6 May 2022 21:14:20 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y21so10684678edo.2
        for <git@vger.kernel.org>; Fri, 06 May 2022 21:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5xlymaQxtSmDwkpyOAe7Xr5K9PuBnlMImAsAoV7SXqk=;
        b=EizCISHQbhmgFWV2PyCzQBYgveBxmLVv+PzEavvCbFcojOGHoBnuKPpimULBFjRyPA
         e4t/s0yP98Z8gxcKiCWNvHEjGw7G0Y6JXPdlfJmXIZTyACR5MQDs3B6hoH1Ze1Lvwoac
         YreBeH/Nxm0LHiwgvLoMOW496xpgLTI8DSjUJU3lOSxuMFtYMvreQusHHc8NV+nVGTh6
         z7EVaVhKY+D40Si1vb+0fqAxPsRfwHXAub3rx4ZGFiaQduhGzrjePQSIEMNXwBCD9KFq
         UPClh6xQk9/juCGrOhm3VyUEhJUpvfIlxuH0oiTfEswt1PR5Q1G/cOsnpy6yU10yHDM8
         PEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5xlymaQxtSmDwkpyOAe7Xr5K9PuBnlMImAsAoV7SXqk=;
        b=jQugvZJlu55Gx3FIeJEaJA/BfAp62+kFmi5GJb6Gf4wHXUoMJGRJDRaPbcu31jFftl
         d197RyciVbzvIiNjHhtr4S/aqsD/YiJ9onnFdBh7o1hSU58nXPvh1CWEieZU8Y1TUM73
         vziQemV4DY93L3CfzcMzpNChGryX/1f9SfkihUcKrGNmskUDPSSkQdGsy53Xm4pvJt4P
         KAEWN79zfzvDufbFrv4gJDBa9LKFsqdodm5svxRZKW4MmKQFqLApR3966umfJJgl6xMd
         nizRftPKptiR/VQixM/ZMqbk9Be1uE8Hd+BeisvObmsqU5r4KjaL7BW1LDb6oEbP2ZaJ
         +JUg==
X-Gm-Message-State: AOAM5317KQCt8qhAHOzvzZUiDA1ZmK7xzB7K3rBLC/FA9t+NLjpG3cDn
        J7N6REpkzBwxZq3eImtUbF3bxe/ZIi3RmL4TH6Rkianb
X-Google-Smtp-Source: ABdhPJyvvMMCKT1Ce5FshQih4cX3F+7R5a0wQBy55G9lI98YqtqkWCrXXQIIQVdmhn8I+LaLxqI0bEjpz9zGlIz80PA=
X-Received: by 2002:a05:6402:1bce:b0:425:bfaf:f20c with SMTP id
 ch14-20020a0564021bce00b00425bfaff20cmr7138551edb.359.1651896859099; Fri, 06
 May 2022 21:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <YnOQmVFVRuqnanMi@pflmari> <YnSWgDdxgm+XWiLt@nand.local>
 <YnT19KB2XkBrJOLQ@pflmari> <xmqqv8uioc7p.fsf@gitster.g>
In-Reply-To: <xmqqv8uioc7p.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 6 May 2022 21:14:07 -0700
Message-ID: <CABPp-BEb8saqS0awK77y+-3oB1LAOPwOw-2dZU=67wJOKLBS1Q@mail.gmail.com>
Subject: Re: Crashes in t/t4058-diff-duplicates.sh
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alex Riesen <alexander.riesen@cetitec.com>,
        Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 6, 2022 at 9:30 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Alex Riesen <alexander.riesen@cetitec.com> writes:
>
> > Taylor Blau, Fri, May 06, 2022 05:31:12 +0200:
>
> >> t4058.16, which blames back to ac14de13b2 (t4058: explore duplicate tree
>
> That commit talks about "trees with duplicate entries".  Does it
> mean a bad history where a tree object has two or more entries under
> the same name?

Yes.

> We should of course be catching these things at fsck
> time and rejecting at network transfer time, but I agree it is not a
> good excuse for us to segfault.  We should diagnose it as a broken
> tree object and actively refuse to proceed by calling die().
