Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9CBC63697
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 13:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B652E2080A
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 13:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KswIJt/L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgKSNhJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 08:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbgKSNhJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 08:37:09 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59811C0613CF
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 05:37:09 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id l2so5323787qkf.0
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 05:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=KMNuSdydlR1zdS37T3iZ3M9d9ov2DPdxaVDAZQmLOZ0=;
        b=KswIJt/L7Nqm8QJFhEhQzuApxw5cQlx425364GCt9gJIQPIaVTLSaeWJumXHT4Frgh
         PQuhBF/HENogtb7fmpNAJA8eUUOd9gcxQEyeSczBLeImfPA7SKIzC6rMm1qFPybP9D9s
         x8MrZquTfy5KnPVX3EoXRMliSMG1Xh9n/qpG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=KMNuSdydlR1zdS37T3iZ3M9d9ov2DPdxaVDAZQmLOZ0=;
        b=EH4q/MEGzZzlvTl7DhATRnEWNbBhmPIUxr2i3dF13YjbYoTIVaWfLvVF6VRUJKJge0
         WqsiGf7E2iOXYmCRcTcpz+/enGxPzObc5vSpzwRRRLrAABO+vWwQmEyp93FX6lZfPSSE
         i5acFJwlWmKSqBqtAXIf3ZneZmh3ysMsp61nQzyvGQF64aAxbjPDZqtcs5VWft0GVaxs
         juOEMMClH4VVJ0BfkAciZlHv6jT8Nkf6Ua+WPfb3kgofNlnCrywqs3xKdm2GgInKJKYt
         KN7Z2+uigT0gBUWKofvGf8+ImnqnfPk3wnZU1r/g5i0SAXsSOlB5IE53EK47wW6FfjO3
         Cjdw==
X-Gm-Message-State: AOAM531ffmFAev4fJ5YXP1Lh3Die4Y22O6x7Jl/4YBbOR6ozW6cvgC2D
        KcvygjOmxE6NG4zEG8Tj0SH7uA==
X-Google-Smtp-Source: ABdhPJykbWwe1SwwJRm02G3TzO7zE5eNzz7nZBwDYRwNtrsqWbJlALoaUK7a92LR2oWP784MbPyjJQ==
X-Received: by 2002:a05:620a:62b:: with SMTP id 11mr11491281qkv.229.1605793028426;
        Thu, 19 Nov 2020 05:37:08 -0800 (PST)
Received: from chatter.i7.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id i52sm19069018qtc.3.2020.11.19.05.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 05:37:07 -0800 (PST)
Date:   Thu, 19 Nov 2020 08:37:05 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Brandon Casey <drafnel@gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Lukasz Niemier <Lukasz.Niemier@kobil.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Don Goodman-Wilson <don@goodman-wilson.com>
Subject: Re: The master branch rename, and avoiding another v1.6.0 git-foo
 fiasco
Message-ID: <20201119133705.7q7yghymvvo7zeq4@chatter.i7.local>
Mail-Followup-To: Brandon Casey <drafnel@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Lukasz Niemier <Lukasz.Niemier@kobil.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Don Goodman-Wilson <don@goodman-wilson.com>
References: <CAMP44s3BJ3dGsLJ-6yA-Po459=+m826KD9an4+P3qOY1vkbxZg@mail.gmail.com>
 <20201113010107.GL6252@camp.crustytoothpaste.net>
 <CAMP44s1U1FevS7NrAYxvgVyzfR5tnD9-+BbPdw5bKnaNHkyD+A@mail.gmail.com>
 <20201113051408.GA3985404@mit.edu>
 <CAMP44s3AeESm7VBKbar0ir_Py35g99ZW6bNX_=AK4N=OFkcrdA@mail.gmail.com>
 <20201113145802.GB3985404@mit.edu>
 <CBC2DBAA-A409-49CD-B932-AC82D3C20D55@kobil.com>
 <20201115034649.GC3985404@mit.edu>
 <CA+sFfMfWrSMKAogg-5dsaO_beXUV-JCBLBPeLZ5g_0jGqsom8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+sFfMfWrSMKAogg-5dsaO_beXUV-JCBLBPeLZ5g_0jGqsom8Q@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 18, 2020 at 05:02:59PM -0800, Brandon Casey wrote:
> > This *really* is not hard; which is why I am starting to suspect
> > people are really kvetching because their objections are really more
> > about the woke/anti-woke aspect of the "master" -> "main" migration
> > --- and they are using *think* the children^H^H^H^H^H^H^H users as a
> > rhetorical device.
> 
> So we're changing the default branch name from "master" to "main"?

To my knowledge, there are no concrete plans to change anything at this 
time. All recent work was to remove any special-case treatment of 
"master" as the default branch name, so people are free to use any 
configuration they like.

> For what purpose?  What problem are we trying to solve?

People want to be able to use arbitrary branch names.

> Is the word "master" now going to become a taboo word that we're all
> afraid to say?

No, everyone is welcome to use it if they like. It has perfectly 
legitimate usage cases -- for example, some of the staunchest opponents 
of this terminology continue to list their "Master of Arts" degree on 
LinkedIn.

> Isn't this all a little silly? What's wrong with the term "master"?

It is misleading in the context of git, because it implies that a branch 
carrying that name is in some way special compared to other branches 
(e.g. like "trunk" in the SVN world). In reality, the "master" branch is 
just a branch like all others (and can be missing entirely or have junk 
in it), so it really shouldn't be called "master".

> It's a well understood and commonly used term that denotes
> "authority", i.e. the master branch is the authoritative branch.
> People sleep in master bedrooms. Universities have headmasters and
> award master's degrees. Skilled people become master craftsmen and
> give master classes (e.g. master plumber, master diver). Recording
> artists master a track. Skilled chess players become chess masters
> etc.

Exactly, thank you for illustrating my point. In all of the above 
situations the word "master" is used to indicate some kind of 
distinction. If all you have is a single bedroom, it would be kinda 
obnoxious to refer to it as "the master bedroom," eh? :)

-K
