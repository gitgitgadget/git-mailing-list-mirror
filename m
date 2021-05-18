Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D7DC433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 05:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCC1A6112F
	for <git@archiver.kernel.org>; Tue, 18 May 2021 05:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238972AbhERFVY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 01:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbhERFVX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 01:21:23 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83611C061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 22:20:05 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id u19-20020a0568302493b02902d61b0d29adso7619269ots.10
        for <git@vger.kernel.org>; Mon, 17 May 2021 22:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=0n8L6tBaSFydH8wlIeGkQoIiw9pTQNYBPh0V3E2Fjo0=;
        b=Ql1ZtRogq8q0N3lfoo6b+Gq9WF1bAtQ9kqer2a51euK11jafPL81hPj5FAybjnNpyY
         XOAvDb31TNEBc/ZwkKoC4PLtGXHZUTFO8ySCm4KL96clSmu+Rk1N5hlP6pqdm6d0dNaD
         rGMimm3+/c0p1M5jaK1KecmV/UxkyeTT+og7ZYYn26F39nfThsPGz5a1X9buydGUPnrO
         rUQGyWEJ6m9l4ClA/RsXGS6Sfx4iQFxn+H/Pr2O9GAhExr5O4swHyM/ytYPlKXMdF5tN
         C5xiUafoLbLaCmt0VATGB5s3xCjmNETx/MV+YqIXaCmfWZolpRI3ImcW0Fjq0dtGlG0a
         09sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=0n8L6tBaSFydH8wlIeGkQoIiw9pTQNYBPh0V3E2Fjo0=;
        b=XE2cYwvT5SAyZaOggZG0vkG3Mc/4OvGDpDe+6TFoE9jjbquObswohnTTLi5lB78YT/
         bdB/8YPiXI+163xN5I7yAxSH5D+ESKtwZYRzaXuT4AgdGCuo1I46Wdsk3mfiCQ6bRU+Z
         67+1U1vmp5F66h6mYBOCLxyI6/tO4XHiV9gJLRbddntGPKjA2jcfyKSde3t5QhYuuyE2
         NCUgpB4q0SYpkyyvk7b3cFhgMo4107K7vhSGEcGepnMYrm5Vzq2rBSdKWtHvoIeM3026
         WIsYg5HoUjPgquNebe1bEWy1Chvg3YvuGd+bmXxGu6f6qADA4NWKeWD6gOHri3djxut4
         mlOw==
X-Gm-Message-State: AOAM532/+dHw/bGQdaj7+YHLASn5e6EZPaWZ6a0cOhXuwUq/PiO/OPmv
        YUUq+w5WdmfBzIlegiaI+XY=
X-Google-Smtp-Source: ABdhPJy9OEyzAG6aRbw6mh9ejmNEDeHM2HG1ub8UBYpiG60/IRo9dBPu4WnP2Gum+M5jgXzZIhYHqw==
X-Received: by 2002:a9d:664c:: with SMTP id q12mr2782895otm.76.1621315205003;
        Mon, 17 May 2021 22:20:05 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id v19sm157895otk.22.2021.05.17.22.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 22:20:04 -0700 (PDT)
Date:   Tue, 18 May 2021 00:20:03 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Richard Hansen <rhansen@rhansen.org>
Message-ID: <60a34e834f208_14d1bc208e4@natae.notmuch>
In-Reply-To: <xmqq1ra44ul5.fsf@gitster.g>
References: <20210516203736.1098072-1-felipe.contreras@gmail.com>
 <xmqqbl993irp.fsf@gitster.g>
 <60a245a927c62_126333208ea@natae.notmuch>
 <YKJZt4vFECoLZhc2@coredump.intra.peff.net>
 <xmqqpmxp6u13.fsf@gitster.g>
 <60a2daa57d8a6_13c370208f3@natae.notmuch>
 <YKMhqZNhamnKqWfi@coredump.intra.peff.net>
 <xmqq1ra44ul5.fsf@gitster.g>
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
> >> If you google for `git remote "set-head"` there's barely any
> >> information. It's basically all online man pages.
> >
> > Why would people need to use "git remote set-head" most of the time?
> 
> I somehow thought Felipe wanted to say that there is nothing but
> manual pages that mention the command and, "look how useful set-head
> subcommand is, here is how you use it" blog posts are not seen
> because nobody uses 'remote set-head'.
> 
> I do not quesiotn the frequency count of set-head, but I do not
> think the lack of mention of set-head leads to the conclusion that
> nobody uses "git log origin.."; there is a leap in logic.

I did not say that is the only evidence to lead to that conclusion.

But it is evidence.

> As you said below, "origin" is there without need for set-head,

Only sometimes.

> so the lack of enthusiastic advocate for set-head does not mean
> anything wrt how people find "origin" useful.

Yes it does. Contrary to popular belief absence of evidence can be
evidence of absence. If I walk around Central Park for half an hour and
I don't see any elephants, that's evidence that there are no elephants
in Central Park at this very moment. It is not *conclusive* evidence,
but it is evidence.

Just because the evidence for $x is not sufficient to prove $x doesn't
mean there is no evidence for $x.

-- 
Felipe Contreras
