Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84574C433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 05:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E74461924
	for <git@archiver.kernel.org>; Tue, 11 May 2021 05:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhEKFEO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 01:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbhEKFEN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 01:04:13 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7817BC061574
        for <git@vger.kernel.org>; Mon, 10 May 2021 22:03:06 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso16533002ote.1
        for <git@vger.kernel.org>; Mon, 10 May 2021 22:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=mUigiVsUyIucYQ6/VIZ7pZtwzl5d8e/GDqwsQ7Iu+P0=;
        b=dw/iQKe2Gj4cG8aZxDR24GsOFIcCrlc4hbu0KN64WgtDNj35+nqE1ElgRP3OG7thWt
         Os80eYv7l/9c+h5lUtqEKbC48cPVr4pA/AGP0KQoyDMZ/WghWxnjJMOBq2XDJoPv2277
         pRmWNEb64KW9hLqEKrvwjrDbzA6T/omO/QUrhdOelvyqboxIu/Yk/AgqeNYn/bgUTumS
         MWMcbjves3ia5/JhMFuhghEvU5jinLtQwjn/jrEGZOqAJoQ72SK3aXX6bC0qeMvzOmpQ
         r3KVVrqFcYV/hcVgHVN9PkdgZkXtgJknJ1AD3mf4jr+trN30BXPF4ReEUm9f0KyKRcgR
         eXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=mUigiVsUyIucYQ6/VIZ7pZtwzl5d8e/GDqwsQ7Iu+P0=;
        b=S9LlLizfxHLYemlO+LPTVd3yWLZdsRmV/c9zLM8z9HdDZLAolaC2YrzXAxCQrk/BOF
         pIqieS4TkRyclIyDF7rbQxMW7cUIGe7CHTVxhDhSL61zKB2NU8dcEaOf45Hlzh6K0lFo
         tJR2Vb/jlQHQ0noMfZC75DkFMNvnwTUmZeI93FZIHWUdtf/4ImKBb2PWjMPnfyIbg06j
         sahd4xuBfk1wQtmWiUqjrngvDtSyluLljeV7NR5OQ+XPhSJObcqqaB4ZTW4tVXBI7HOp
         9DcoOvKXqPJH6vwrFEqeapoJQoBOEe7KXYcsociDvJDar2qKZ9SF/+GbIRo/b1LdT5V5
         p+Qg==
X-Gm-Message-State: AOAM532D789olWqYsIF95gq5c0ZBWjmHWSDdb70y3kuVWns4FEevlE2Y
        JuP6jcxrvw3gER14hkChM/U=
X-Google-Smtp-Source: ABdhPJw6Nb3sa1KbJYLPWFBIzQbWwYdGXHSfxPjC2ouUm40BvDuOE9Y2stnUlua6RMpD7gk8rod+EA==
X-Received: by 2002:a05:6830:1e6e:: with SMTP id m14mr24252145otr.215.1620709385758;
        Mon, 10 May 2021 22:03:05 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id z4sm3525063otq.65.2021.05.10.22.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 22:03:05 -0700 (PDT)
Date:   Tue, 11 May 2021 00:03:03 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Firmin Martin <firminmartin24@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>
Message-ID: <609a1007ec851_5b0e1208e5@natae.notmuch>
In-Reply-To: <YJUAmUJiHmJRQBMj@generichostname>
References: <20210506165102.123739-1-firminmartin24@gmail.com>
 <60949be8613c1_8c2220882@natae.notmuch>
 <YJUAmUJiHmJRQBMj@generichostname>
Subject: Re: [PATCH v1 0/8] format-patch: introduce --confirm-overwrite
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu wrote:
> Hi Felipe,
> 
> On Thu, May 06, 2021 at 08:46:16PM -0500, Felipe Contreras wrote:
> > Firmin Martin wrote:
> > > Currently, git-format-patch, along with the option --cover-letter,
> > > unconditionally overwrites a cover letter with the same name (if
> > > present). Although this is a desired behaviour for patches which are
> > > auto-generated from Git commits log, it might not be the case for a
> > > cover letter whose the content is meticulously written manually.
> > 
> > This is one of the reasons I never use git format-patch directly, but I
> > use a tool on top: git send-series[1].
> 
> It seems like everyone has written some sort of tooling on top of
> format-patch at this point. Taking a cursory look at your tool, perhaps
> a feature like `--previous-cover-letter <file>` might provide most of
> the functionality that most tooling that I've seen gives.

If that worked correctly, maybe, but not for my tool.

Some of the features still missing:

 * List of people to cc
 * refs of where the branch was in vX
 * Automatic rangediff
 * Storing other metadata like last Message-Id

> Perhaps this option could parse a cover letter from a previous version
> of a patch and use it to populate the next version number, In-Reply-To,
> cover letter subject/body, To/Cc lists and maybe more. I think that
> extracting the information would be pretty easy but designing the UI it
> in a non-obtuse way would be pretty challenging.

Where would you put the Cc list for example?

> > It would be nice if git format-patch grabbed the text of the body from
> > somewhere, and even better if git branch learned --edit-cover-letter.
> 
> Well, you're in luck! I wanted the same thing a couple of years back so
> I implemented the --cover-from-description option[0]. It allows the cover
> letter to be populated by the text given in
> `git branch --edit-description`.

I did see --cover-from-description and thought of making use of it on my
tool, but I thought it only updated the subject of the cover-letter. Now
I see --cover-from-description=subject does exactly what I would want.
Nice! Although I've no idea why that option is called "subject".

My only comment is: why doesn't --cover-from-description do something
useful?

Cheers.

-- 
Felipe Contreras
