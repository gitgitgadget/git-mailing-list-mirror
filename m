Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B95C47076
	for <git@archiver.kernel.org>; Fri, 21 May 2021 17:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7103613C8
	for <git@archiver.kernel.org>; Fri, 21 May 2021 17:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbhEURz7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 13:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhEURz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 13:55:57 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A0FC061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 10:54:33 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id d25-20020a0568300459b02902f886f7dd43so18771425otc.6
        for <git@vger.kernel.org>; Fri, 21 May 2021 10:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=pFJ701Qz5pOh9BZP54wMVQPHkjxxJwIEAABitfcu6qc=;
        b=D9jIBLNEY7JIHxG+bu2k3+RuGqj9ibRKGs4q+CgxdnjRQwRqOVf1V5JH8M/qJmUUAa
         bsInXD+V4OcgeNkrwhPwnE3AukQ6OwHCu+A+VWxPTpEubIZ96Q+4aWP92QRRWeFnBbuH
         hlmjrb/W1n2bZ/6bGvmaBRPF/KiGBVPXGKGfqTMz3+nLldm5XBJfmhCfV+C5sxT85m3m
         /fsvCMAQhsq3tE5mMnFp5+QhDyJdXTcFFj8NZ4IVKG3WxrAlRNjMLCUBxBPXU+MxZu6J
         +IxLQ/j53cB+AHelFpZ8zuauHSmbX6210vri1ahMRwk+0Ln+evBO/iPHL3AIhmCAsD01
         i/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=pFJ701Qz5pOh9BZP54wMVQPHkjxxJwIEAABitfcu6qc=;
        b=DPeaeXJd+Q+PU2m5/m5VMW3sAzkuf74rjRMqp5iyk2slmEJSwvC03Mv8mHrKcuBeSx
         va/1+6wD/u3ptubY1KsQ9KcT1WmBdCnbY6XE4lgcgOn1n5s/ScmhN2m+NQ4MDPQ3BJTW
         OuYsyWhYts+semlSKQmvqeNWVxTfd/EfW8snHVEN8IT0A7ie69LkZGGzASGg2vQ3Ui2g
         xh7/7VhSetdtIT/vxN2uJUqy6Tff806fB2HOcOX32onsDU+dKOo18e7f3swOVSTnY29v
         unOifaGgqd9a4M+w5TxE0KWZHgCGzIpFysmDOH6aW4wlxU2lth3RaN13hhrO7iFvajw1
         73+g==
X-Gm-Message-State: AOAM532fWQKgl8Zb5CFudaSTIQz92puW+80CRiYabR0WB6egIAyQ6J7F
        VW42njn9T0En7Yv0MtlYpEc=
X-Google-Smtp-Source: ABdhPJzB4+5c8KR/h9eDUYl3j1YWvHtzX5pwLIY/6623u/j99WjdPb7SdgzueTln/SeZDVlLZ1/Lkw==
X-Received: by 2002:a9d:6242:: with SMTP id i2mr9184119otk.273.1621619672786;
        Fri, 21 May 2021 10:54:32 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id h9sm1291649oor.16.2021.05.21.10.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 10:54:32 -0700 (PDT)
Date:   Fri, 21 May 2021 12:54:30 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Leah Neukirchen <leah@vuxu.org>, Jeff King <peff@peff.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Message-ID: <60a7f3d6c55e3_5503920844@natae.notmuch>
In-Reply-To: <xmqqbl94smjb.fsf@gitster.g>
References: <20210520040725.133848-1-felipe.contreras@gmail.com>
 <842221d6-51c4-e08a-4299-c4efb8bf1dcb@gmail.com>
 <xmqqbl94smjb.fsf@gitster.g>
Subject: Re: [PATCH v4] help: colorize man pages
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> > On 20/05/2021 05:07, Felipe Contreras wrote:
> >> We already colorize tools traditionally not colorized by default, like
> >> diff and grep. Let's do the same for man.
> >
> > I think there is a distinction between 'diff' and 'grep' where we are
> > generating the content and help where we are running man - I would 
> > expect a man page to look the same whether it is displayed by 'man git
> > foo' or 'git help foo'
> 
> ... as long as the user chooses "man" backend, that is.  And I tend
> to agree, but that is our expectation.
> 
> If we added this new mode of driving the same "man" but with
> different environment variables exported to tweak how "less"
> behaves, and taught it to builtin/help.c::exec_viewer() and
> builtin/help.c::man_viewer_list, that might become more palatable in
> the sense that we can view it as feeding the same manual page to
> this another "man" that behaves differently from the plain "man",
> just like we can feed it to "woman" or "konqueror" to get a different
> view.  So those (like you and I) who expect a man page to look the
> same in "man git foo" and "git help -m foo" can keep using our current
> configuration, while those who want yet another variant of "man" output
> in addition to the current "man", "woman", and "konqueror" can choose
> it and get "colorized" output.

So... "mancolor"?

> By the way, this new round mentions NO_COLOR, and while I think it
> is good idea to teach git to honor it, I think it does it at a wrong
> level.

Other people have already mentioend the FAQ [1]:

  It is reasonable to configure certain software such as a text editor
  to use color or other ANSI attributes sparingly (such as the reverse
  attribute for a status bar) while still desiring that other software
  not add color unless configured to.

At whatever level it's chosen it shouldn't blatantly disable all color.

> Each ui driver that is optionally capable of coloring its
> output shouldn't have to care,

But they do have to care. The purpose of NO_COLOR is not to disable all
color, but to disable annoying color.

https://no-color.org/

-- 
Felipe Contreras
