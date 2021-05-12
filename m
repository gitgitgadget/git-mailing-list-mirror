Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A37EC433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 08:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCE88613C0
	for <git@archiver.kernel.org>; Wed, 12 May 2021 08:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhELIOe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 04:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhELIOd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 04:14:33 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0583CC061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 01:13:24 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so9676701otg.2
        for <git@vger.kernel.org>; Wed, 12 May 2021 01:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=2ow9sS5S4gnoHA518e3ecf0HRT+GrZiuybgRAWKoXP4=;
        b=aowityKpWn9nw79c1tuNu2pBbcKzbCRflHXqwbANw2AwemXFxnkp+eJQjeYfS4vQ+j
         EeK2A/T7Z5rbvCHcKjMq+5tTV/UYPMcUIm0wYMXJcm/2eLj9WCdQgrJN4vjAjoBIkKcg
         TU++2o75eZUbWYBgy0hcMMfDwW0gtAAtodFbb0np+em5Bu0jXS1DamTYieBRzi2anwgm
         2DpWZHdOv4+Zp8eCBwl9X0VWOF1R8p2yQGS1p7KOZyoczL5BWNbNHLSjDRA/hKxK7Lbn
         UGyAw6qWQPITKpuQrqqk/i4oFbksGiEIpZwPFVGOt5O7AWmlv49Znho5Qq6RmQpSl7J9
         PUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=2ow9sS5S4gnoHA518e3ecf0HRT+GrZiuybgRAWKoXP4=;
        b=rggvUZ+N8YxXgZfuHJCsEA5Dp5Lkv0RLixfGwZOhotTI8eZpAncuAnZmItuiNKfUpf
         0CGNJVRudvaWfl/6XuyvhEkTUxpfZviL/x7in+8MmqAKkD0uhFLymt3p0KmUK3jGXnO0
         1t+3WiPU/uzE1ZnZKQaYarXFRWBBN1LMlupmGSPbn/U/Ov6/P05+Z478E8qP1XmHw1R6
         VsHRV9InCLVipCBelD+Ce4zZxiQa7RMh/eD0CNE5TQ/zIbdZr7qumAvUZq9b28ZOWuso
         i7xdG8XlH+xbcPnd0PXLr0fCwPceIe2aVQkcecqPHsk6X6iiFLogZvZ5C4hG8axnIAph
         QomA==
X-Gm-Message-State: AOAM530ovlO+y/0Y387hdjb/mdpKgkOZh0pTvd/xPhA9g4bEXA1qdLC2
        LNv8E+XEo7j+7Oyhs1nW573iNpuL7jFBtw==
X-Google-Smtp-Source: ABdhPJwdYJ6wpHS9gx/S6VlfrQKaTTzJis0AmR0izshteQgA3rUr1TOHKA44Hyz4QaF2hte9L/6jPg==
X-Received: by 2002:a9d:600d:: with SMTP id h13mr3045080otj.259.1620807203338;
        Wed, 12 May 2021 01:13:23 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id y205sm2652933oie.58.2021.05.12.01.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 01:13:22 -0700 (PDT)
Date:   Wed, 12 May 2021 03:13:21 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>
Message-ID: <609b8e214e1b6_6e4e92087e@natae.notmuch>
In-Reply-To: <xmqqtun8fncl.fsf@gitster.g>
References: <20210512064128.15411-1-bagasdotme@gmail.com>
 <xmqqtun8fncl.fsf@gitster.g>
Subject: Re: [PATCH] INSTALL: note about make man with Asciidoctor backend
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
> 
> > "make man" can now be also done with Asciidoctor's manpage backend
> > instead of asciidoc+xmlto.
> >
> > Update INSTALL to reflect that.
> >
> > Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > ---
> >
> >  This patch is based on  "doc: add an option to have Asciidoctor build
> >  man pages directly" series by brian m. carlson [1]. It can be added
> >  to that series.
> 
> It's not like "can be"; it would not make any sense to queue this
> patch before queuing those two patches below it ;-)
> 
> Not everybody with Asciidoctor can do the "man" without xmlto; they
> must have recent enough vintage of Asciidoctor, or they need xmlto.

This is something yet to be determined (I will investigate).

It's likely that they *can* do `make man` without xmlto, but perhaps
they wouldn't have a perfect output (yet to be determined).

> > @@ -201,6 +202,11 @@ Issues of note:
> >     use Asciidoctor (requires Ruby) by passing USE_ASCIIDOCTOR=YesPlease
> >     to make. You need at least Asciidoctor version 1.5.
> >  
> > +   You can also do "make man" using Asciidoctor's manpage backend in
> > +   place of xmlto by passing USE_ASCIIDOCTOR_MANPAGE=YesPlease. Version
> > +   2.0 or later is highly recommended, as these version properly handle
> > +   apostrophes.
> > +
> 
> Hmph, I wasn't closely following the previous discussion, but is the
> apostrophes the primary reason why anything below 2.0 is not usable?

"Not usable"?

I haven't been able to reproduce the original supposed problem, but even
if true, the man pages would be quite usable.

(not beeing able to copy-paste chunks of code from a man page with
apostrophes can't be hardly considered "unusable").


Either way, more work is needed to figure out what's going on.

Cheers.

-- 
Felipe Contreras
