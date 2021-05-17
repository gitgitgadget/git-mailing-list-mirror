Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887F2C433B4
	for <git@archiver.kernel.org>; Mon, 17 May 2021 21:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 613BE6113C
	for <git@archiver.kernel.org>; Mon, 17 May 2021 21:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237650AbhEQVHB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 17:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234755AbhEQVHB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 17:07:01 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9B5C061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 14:05:44 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id i23-20020a9d68d70000b02902dc19ed4c15so6826530oto.0
        for <git@vger.kernel.org>; Mon, 17 May 2021 14:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=gksr61ia1Zh3tvycMS297ZxR0dzyzKLg2lIkRpH7pHw=;
        b=GntTbYGlevnQnpa6pXg7o5BS7Bl4L2Nid7cHR8NfGsXauc1QgUot/MWnkUhL3UdYDn
         Suec+u1JBcGaPfs2mLkgE+AfXMiFo2JnhLMePxbupGEEJeKGY5G3TZGB96nP+mK0IiSH
         rWID6UzKgZJ6UQViOTNdjWHDh/pwCGGQXmaPH3AX5oJg+5LGXhd1rxYZxXApBynwmYxj
         t+wpJF/ypwYa/QUi6EA6ju58Bbl7LybgHOSzBcsSMOP9Mn3tubDLQSImjQfqBziJJxRK
         kbGgMMsLJg2TPpzz+Mu++yD8HAt40Wwh/iAfm/YvPbIPwbG+Gh8zTqfZU0nwAOKZavOv
         vCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=gksr61ia1Zh3tvycMS297ZxR0dzyzKLg2lIkRpH7pHw=;
        b=N13ec7QJ6qegYWtiv5nJ2yEAtSCntDLPdpBXkbNgg6qHppsdET0RE9JOjO0f6MsEpF
         ZvyeA+pJDlXVcEJ97hb1gZI4HcQeXQqgHSFMf1pecorVMRYNZwvqQsjdODbee6XtWla9
         ZqC7IgTH14LASc7bxbvb5SaIkV56RIGDI+/37lHWgD1ja8w67t1QWL7tppSAV48j1a7Q
         GkjjfZbwaXcIejZbmZG5YatVjvn6ivrWusB+2a9hiMDyB9EAHE/AIbdJDIqzak7VRbTQ
         oabpamydE4ADJ2q8GzVz9AKYvEqnSYf9xmogwm3hqtD37eR+QQO3jBEH2BBzG4VCHkJs
         nc3A==
X-Gm-Message-State: AOAM533N9a4dnfZcmNQJZWs9byNmm/lR7dU8wYEZXoCmTz8f1nGC9m+l
        LxnAfmBYy5QCr0MgFKZAZ2QtOjwvxEcE0w==
X-Google-Smtp-Source: ABdhPJxvPHhypDLOun7kxjCo2hbIPBdLG4RMBg3TC4wBLmKJBXkfzzf3IOOu669nJprM/oILXhIuQw==
X-Received: by 2002:a05:6830:12d6:: with SMTP id a22mr1287132otq.66.1621285543793;
        Mon, 17 May 2021 14:05:43 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id g11sm2995088oif.27.2021.05.17.14.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 14:05:42 -0700 (PDT)
Date:   Mon, 17 May 2021 16:05:41 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Richard Hansen <rhansen@rhansen.org>
Message-ID: <60a2daa57d8a6_13c370208f3@natae.notmuch>
In-Reply-To: <xmqqpmxp6u13.fsf@gitster.g>
References: <20210516203736.1098072-1-felipe.contreras@gmail.com>
 <xmqqbl993irp.fsf@gitster.g>
 <60a245a927c62_126333208ea@natae.notmuch>
 <YKJZt4vFECoLZhc2@coredump.intra.peff.net>
 <xmqqpmxp6u13.fsf@gitster.g>
Subject: Re: Re* [PATCH] doc: glossary: add entry for revision range
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > I agree that if the purpose is to be illustrative, using shortcuts like
> > "an empty endpoint means HEAD" is not helpful. And likewise for "@"; if
> > you need to have "revision range" defined, there is a good chance that
> > you don't know about shortcuts like "@" either.
> >
> > So I would prefer something more explicit (whether it's "mybranch" or
> > "end" or "HEAD" or whatever).
> 
> Perhaps.  Being illustrative for common use case is also important,
> so I do not mind teaching "missing endpoint at either side defaults
> to HEAD" early.

A glossary is not a place to teach (anything other than the definition).
It's supposed to contain glosses (brief explanations).

You don't find a complete recipe when you look for the definition of
"recpipe". That information belongs elsewhere.

> If "missing" endpoint is disturbing, the description can be fixed to
> stress that they are "often but not always" given.

This is unnecessary information.

If we teach that then we also have to teach that the starting point is
not always given either (`..mybranch`). And where does it end? We would
have to teach that `mybranch ^master` is yet another form of a revision
range, and so is -1.

That's what gitrevisions(7) is for.

> >> > Especially since most people are downstream consumers, I'd
> >> > suggest using `origin..` or `@{u}..` here.
> >> 
> >> Nobody uses "origin" (what does that even mean?), [...]
> >
> > I guess I'm "nobody" then, because I use it all the time.
> 
> Oh, I'm nobody, too, and so are many others ;-)

That depends on the definition of "many". My guess is that it's less
than 1% of users (probably 0.01%), and for me that's not many.

If you google for `git remote "set-head"` there's barely any
information. It's basically all online man pages.

I don't think anyone can argue it's not obscure.

Cheers.

-- 
Felipe Contreras
