Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AD0C49361
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 17:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5228E61206
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 17:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbhFSR3c (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Jun 2021 13:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234900AbhFSR3b (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jun 2021 13:29:31 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C634C061574
        for <git@vger.kernel.org>; Sat, 19 Jun 2021 10:27:19 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id v17-20020a4aa5110000b0290249d63900faso3355488ook.0
        for <git@vger.kernel.org>; Sat, 19 Jun 2021 10:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=81wysXdHtK/VwpeuyMCIQyoHlhhR7VmyrNkRhhJqmnA=;
        b=Hdj3TLfKeHOiRx/D091Kw5smS2WiYq7mGcLLI8tHCp9N6KOC9NS4lYXY8GyvhnqeyK
         3aqPhSFgHV9SRMA4Os7AVRF13hypoT8gsyCIhk51tILJrrB2PfCAaE2nsBrzo18wTS/P
         RxRukDkIbAg3kwG97s1xzgaDl9c3t8ou/SVwS9h1lSMXQfrZOzcQmU8L7/q6XpPijePB
         1X2tzWvrKTOo1HeOJgj2rwSaeaIpXpUfyvhgBiNn9iYpiZ7aF3krRrkTbkdRczyL1G3O
         si+1gCUiCvMGK9s0xx6zJtVN/IignICJoL1kLvWEIwJbcD3kvJrQly80u2hQdo9+9XWo
         od6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=81wysXdHtK/VwpeuyMCIQyoHlhhR7VmyrNkRhhJqmnA=;
        b=l8uJfPtNIALP7Wiro4jVNLXVN6tT2biTx/7Ir0WO6Uccbht3f9d6gwRhf15R6V0eBj
         WrVeJtMdHtC/7u639d49y8IG1ySuveL58J6xLLv6A9FOXmCV99rq6FCe8S8Z+Qd+JbPM
         VqZrzWjd9YXvhh5cI0Yjv6S8v5atgJ+SOEh+kFSWbgc+nNWKkEZyOu1NLcD8CX65nPD2
         FsJcK/7mS4ZnLZaM/st25eE9nX8bQeDo9uBioj9JLqzHP09/Dnw+nY5YVHANdeqTzkZl
         bwsBDTgNG9skF8wgjrViC8xDwOqnD1PFusNkbKldcZ9rMD2W19Rg8i87OlzvD6yOCaWY
         TP1A==
X-Gm-Message-State: AOAM532S6g8mGskOXu4Smn6ypMU11eXXDpeHFVkvTHf3F4QPsBSuwpNJ
        t8HdprHOwXULG2yq2maewsNqhKhPBy7O1g==
X-Google-Smtp-Source: ABdhPJxBfYvnt3KN+COT5K+URcfFrjFmA+jRJ5M0snYuiuTKCcIqNzDfulAX3ZGK1TKzhRuVeh6SEQ==
X-Received: by 2002:a4a:ea43:: with SMTP id j3mr14252538ooe.10.1624123638825;
        Sat, 19 Jun 2021 10:27:18 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id s28sm2583532oij.12.2021.06.19.10.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 10:27:18 -0700 (PDT)
Date:   Sat, 19 Jun 2021 12:27:12 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Message-ID: <60ce28f025b09_cc2b120896@natae.notmuch>
In-Reply-To: <xmqqmtrmjpa8.fsf@gitster.g>
References: <xmqqr1h1mc81.fsf@gitster.g>
 <YMvhoXVBoO08ziI1@camp.crustytoothpaste.net>
 <YMvofq5aSryQzpZQ@coredump.intra.peff.net>
 <xmqqmtrmjpa8.fsf@gitster.g>
Subject: Ignoring valid work
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
> > Hmm. I'm not sure if that's a good resolution here. I do think many
> > people were positive in moving in that direction. If there's a
> > contributor that people have trouble working with, I'm OK giving up on
> > possible contributions they could make, even adaptations of their work.
> >
> > But if by working in an area they poison it for others (because there's
> > no desire to work with them, but no desire to step on their toes) that
> > doesn't seem like a workable long-term strategy.
> 
> You may lick a corner of a piece of cake and think that it would
> repel other people enough to leave only you to consider eating it,
> but no, in this project, you aren't allowed to lick a Makefile and
> claim that you own it.

I wonder who might have attempted to do that in your view.

In reality have I have never attempted to do anything remotely close to
that.

> Also, if some contributors get too annoying to be worth our time
> interacting with, it is OK to ignore them.

But do you have a valid reason? Or is it just petty personal animus?

Talk is cheap. Code is what speaks.

I'm doing valid, useful, and substantial code.

It is the project that suffers from ignoring it.

Ignore me all you want, but the code doesn't stop being valid.

https://lore.kernel.org/git/20210618203057.790320-1-felipe.contreras@gmail.com
https://lore.kernel.org/git/20210618215231.796592-1-felipe.contreras@gmail.com

-- 
Felipe Contreras
