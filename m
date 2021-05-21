Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5789C47076
	for <git@archiver.kernel.org>; Fri, 21 May 2021 18:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFCBE6135A
	for <git@archiver.kernel.org>; Fri, 21 May 2021 18:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238104AbhEUSDD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 14:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbhEUSDC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 14:03:02 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F1EC061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 11:01:38 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so18759300oth.8
        for <git@vger.kernel.org>; Fri, 21 May 2021 11:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=dwUy51RI93UVyN9+7ZoXoAM3rf0+2yCKLV/AZcaNlLY=;
        b=hGhf37/CX7oPWydji0lNgeUlE74SuxPZuR6HDEYHQ/UatfpurSx9A0cCpN9nhoYuON
         cKjEATKXw+3D7eHj6pzBSDs1gWPCqPkoefCcPPm8KUbPQTt7qo5dHBqlAQTxhDeaP5P3
         2Ui4d31pF5SOcxdtMCX7Uekif6mQgMI0MQ3t89W6JOpp0jb0PcV6+tCPLLfXmcbcjAEZ
         hTLVhZy3l8RSs2jw0675AF/yMIxSwocBMp/k4QmIgN5sFefdeXpp8XzzO7W2KKs9nWPR
         d8+hwv6iC9uzb9BPw7X8Z7VA9JqR6uddaXJ/ponn2TAzgtEi0EjLoZY9GQt8Psh6xboP
         4AiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=dwUy51RI93UVyN9+7ZoXoAM3rf0+2yCKLV/AZcaNlLY=;
        b=kl9Uks4nb1sGpqRbKU1mXYcRoE5DyznJ9TEKfg5fhTeqNpTm3ari10mb0Gzr9S4pPv
         HDMLGTaXhJNAKQVbd920Qe6HuZ49Cnte6/CyRxyf5lNvoo0JwX7XejzAvmQlxukhN2ob
         i+7S7rPMeTPEr6qIcbZY1M42zYBoE6Aa1cAq8uCDARViFEEnnIefxNZYyeAkJfHVqpQK
         +V0c84UJf5Mc9oRoU+lP4GSpq63CVMoXhe5L7c9DmybOVetJAiJWQVpIzo8nFDQhNnA4
         XBSBUNi8aOhZAW0zDvNT065vQGe913dzdBbVi+hBbbq2ckMyyX7EdSmLN+4k8iUyZPfi
         IO5A==
X-Gm-Message-State: AOAM530kxJjZO399uv7s5x6qdi9iOHQn/OUyfK8QpKxnaYuTjCtDWqNY
        nouS0qcRno1ceLeR1aOcLy0=
X-Google-Smtp-Source: ABdhPJwP/Yp6gUyxaM1BT9YUE0HBdahlLPTSKENjVo63L7U+8cpEta8X87wpAdzN7YNpwSotl06x7w==
X-Received: by 2002:a9d:34d:: with SMTP id 71mr9310115otv.336.1621620097651;
        Fri, 21 May 2021 11:01:37 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id w66sm1278027ooa.37.2021.05.21.11.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 11:01:37 -0700 (PDT)
Date:   Fri, 21 May 2021 13:01:35 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Leah Neukirchen <leah@vuxu.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Message-ID: <60a7f57fe3301_5503920831@natae.notmuch>
In-Reply-To: <YKdy5jhHgG2who27@coredump.intra.peff.net>
References: <20210520040725.133848-1-felipe.contreras@gmail.com>
 <842221d6-51c4-e08a-4299-c4efb8bf1dcb@gmail.com>
 <xmqqbl94smjb.fsf@gitster.g>
 <YKdy5jhHgG2who27@coredump.intra.peff.net>
Subject: Re: [PATCH v4] help: colorize man pages
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Fri, May 21, 2021 at 02:06:48PM +0900, Junio C Hamano wrote:
> 
> > Phillip Wood <phillip.wood123@gmail.com> writes:
> > 
> > > On 20/05/2021 05:07, Felipe Contreras wrote:
> > >> We already colorize tools traditionally not colorized by default, like
> > >> diff and grep. Let's do the same for man.
> > >
> > > I think there is a distinction between 'diff' and 'grep' where we are
> > > generating the content and help where we are running man - I would 
> > > expect a man page to look the same whether it is displayed by 'man git
> > > foo' or 'git help foo'
> > 
> > ... as long as the user chooses "man" backend, that is.  And I tend
> > to agree, but that is our expectation.
> > 
> > If we added this new mode of driving the same "man" but with
> > different environment variables exported to tweak how "less"
> > behaves, and taught it to builtin/help.c::exec_viewer() and
> > builtin/help.c::man_viewer_list, that might become more palatable in
> > the sense that we can view it as feeding the same manual page to
> > this another "man" that behaves differently from the plain "man",
> > just like we can feed it to "woman" or "konqueror" to get a different
> > view.  So those (like you and I) who expect a man page to look the
> > same in "man git foo" and "git help -m foo" can keep using our current
> > configuration, while those who want yet another variant of "man" output
> > in addition to the current "man", "woman", and "konqueror" can choose
> > it and get "colorized" output.
> 
> I still don't understand what we gain by making this a Git feature,

What do we gain by making `git diff` output color?

> Why would we do that versus saying: if you want to change the colors in
> the tool that Git calls, then configure the tool?

Once again... How?

> If you like to see colors in manpages, why not configure "man" (either
> by setting these environment variables all the time, or by triggering
> them in MANPAGER)?

Let me try that...

  MANPAGER="less -Dd+r -Du+b -Ds+m" git help git

It doesn't work.

> If those configurations are awkward to trigger via man (e.g., putting
> escapes into termcap variables), isn't that something that could be
> improved in man? And then it would benefit everyone who uses man, not
> just Git.

Sure. In the meantime let's make `git help` output with color just like
`git diff`.

Cheers.

(and good luck convincing a GNU project of anything)

-- 
Felipe Contreras
