Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0348FC49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D903B613C3
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbhFXTH0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 15:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbhFXTHZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 15:07:25 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EB1C061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:05:05 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so6683005oth.9
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=OXVDWg1nD6J2xlqvARE8tD1xakx9QCJdkHWE3Kw5geA=;
        b=com6EUQ4ZK1Blrqailk0xHkw5sBC6KK6rLkNOlP8OQO7qcqMXPf4xSzt3p3+5ftZsf
         9ffoezBo0uHhle9fVuQ41u9LZU4jTUGQVxofKKDm9Zr7FOpXEwJjOT4KApMLZyNJ82FB
         wHiFq/uzsLPjdqvACOOYNsKtWsHkW+mBSmD61sN4hSFLRfCcjBjDBalSejoJVQoYBh0W
         FnRNOrzdekVlui+QNw961Bp0PLrhh2d+sSdKklHLDFZWV5InnSMX/oeTchXnct8L3XfA
         EvPXLSsWxv7PbrHXXW0N0Qq4ZwkkCO4i6lAWXwo2EjdGYblV1vhakbDtYoD/1nlhdKjl
         8j+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=OXVDWg1nD6J2xlqvARE8tD1xakx9QCJdkHWE3Kw5geA=;
        b=EtuGrPeWBKYOLOSwAGAOUeWHWxOwhOIhZ2nU18HGMnVXAsipAA0bau0/7gfT6QrPQl
         7+fUB43v8C6l11It34rYFRoP7zAVsfXOikfswQT2MwbFAPFDR9ufuBrw11XO06Z29iJe
         4583EnDXg9FWK66jAU4I9PijGNO14aXiWAYPaLWpZvj/tXLjavnyk+12OeCiJ0D8KTHf
         wEjhwKWWuqaDggyE0N8vGtDV3fYIC2ulf74iFFQvhBUc8kdb1PG6+XuejDMxww/SaT4b
         oFB+c75JW1NAgx7AWGKqu8hcN9qvmZDGpnLGfIKURd6FyFJBwmtEmrQKftvtHr5cPsJd
         u5ag==
X-Gm-Message-State: AOAM533vzUeEAoiLyxvSJ94HvGypxbSnHUcpQu0QqRVKKmaH/7JzG5iz
        jsJhW74GrNOS7piw+PZu7JI=
X-Google-Smtp-Source: ABdhPJwd4LErHbXq9YOq5m7u98kitDqI52PNnPEWUOuywoQuCr2bvenXxnign5DHjS4+d9Z7wQbtmA==
X-Received: by 2002:a9d:585:: with SMTP id 5mr6183133otd.12.1624561504507;
        Thu, 24 Jun 2021 12:05:04 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id 24sm798493oiz.26.2021.06.24.12.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:05:03 -0700 (PDT)
Date:   Thu, 24 Jun 2021 14:05:02 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Message-ID: <60d4d75e7622c_242620854@natae.notmuch>
In-Reply-To: <c2170f74-b93b-599b-1fb4-45b013c7bff1@iee.email>
References: <20210621175234.1079004-1-felipe.contreras@gmail.com>
 <20210621175234.1079004-2-felipe.contreras@gmail.com>
 <b4e612ba-21c7-3bef-d113-0f070449cd87@iee.email>
 <60d49748b8538_2fb2082c@natae.notmuch>
 <c2170f74-b93b-599b-1fb4-45b013c7bff1@iee.email>
Subject: Re: [PATCH 1/2] doc: pull: explain what is a fast-forward
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley wrote:
> Hi Felipe,
> On 24/06/2021 15:31, Felipe Contreras wrote:
> > Philip Oakley wrote:
> >> On 21/06/2021 18:52, Felipe Contreras wrote:
> >>> --- a/Documentation/git-pull.txt
> >>> +++ b/Documentation/git-pull.txt
> >>> @@ -41,16 +41,41 @@ Assume the following history exists and the current branch is
> >>>  ------------
> >>>  	  A---B---C master on origin
> >>>  	 /
> >>> -    D---E---F---G master
> >>> +    D---E master
> >>>  	^
> >>>  	origin/master in your repository
> >>>  ------------
> >>>  
> >>>  Then "`git pull`" will fetch and replay the changes from the remote
> >>>  `master` branch since it diverged from the local `master` (i.e., `E`)
> >>> -until its current commit (`C`) on top of `master` and record the
> >>> -result in a new commit along with the names of the two parent commits
> >>> -and a log message from the user describing the changes.
> >>> +until its current commit (`C`) on top of `master`.
> >>> +
> >>> +After the remote changes have been synchronized, the local `master` will
> >>> +be fast-forwarded to the same commit as the remote one, therefore
> >> Perhaps s/be fast-forwarded/have been 'fast-forward'ed/ ?
> > No, there's multiple steps:

> My key point was to 'quote' the fast-forward term.

fast-forward is an English word [1], there's no need to quote it as if
it weren't.

> And then (if suitable, with appropriate grammar corrections) indicate
> subtly that 'nothing actually moved', we just moved the post-it note
> showing the branch-name on the DAG [hence the confusion about timing] ;-)

A branch is a "post-it note", moving the post-it note is the same thing
as moving the branch.

Both the "origin/master" branch, and the "master" branch moved. So I
don't know how exactly "nothing actually moved".

Perhaps you meant no commit was created, and therefore the DAG didn't
change.

Maybe instead of saying "creating a linear history", "representing a
linear history"?

[1] https://www.merriam-webster.com/dictionary/fast-forward

-- 
Felipe Contreras
