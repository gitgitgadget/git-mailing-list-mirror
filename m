Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8544C43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 21:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5562080C
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 21:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="oS44zGJ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731098AbgCaVyB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 17:54:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36196 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgCaVyB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 17:54:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id c23so2649995pgj.3
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 14:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tv2hqFA1rEH5XHsNUXNPErcXjSVxXaNenlg9nvlYQ0M=;
        b=oS44zGJ1hVV1HUIUvDIhBZYuC44/7DHA6wTZkmtJaO2Cjc1zazWVM0Bpud4xAtrtau
         gBs+RxjJcRV2RQCtLKFzq3Hb8HYZFLTkXHE9SpEyPmlsuJrS5xAG3O92pZw5n75iCLZa
         SE3JFpE0uN/kkOt31Gb40AZmF2gjzSeCtcptSTYsxeFfzmLmImMnLUZmRPdPYAWoTSH1
         WwNC6QZe1C6ztKWIt9a/x1yqVpRuzm7lFHSBzff14VWjJZgSvz9qcEgqbP92dKYLeHAz
         k83t7khezw67FUaO17rNQH6yCzPZ+7OxOv59w2k3EaFtG/11pR3xQmTVbtezGS4SSYh5
         ukJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tv2hqFA1rEH5XHsNUXNPErcXjSVxXaNenlg9nvlYQ0M=;
        b=ZyVPn/khI9R8GTY209rCRbGKcGt+zzvyt0OvQHHpjcdLyrSmJBMMSEFrohTN1oK2Ue
         51GPpryiXhgPvNhOoGBR0OrJk3ze45JDo82cDzoz1VMZgpGc2ltR6Jz07qpcmPH+MKqN
         8i+lfscVi+P44c4YWvrXH+ScfmSTbQJHeZAV/ZOYYupKKFwmP14Mv90yoXIJSSxKFejL
         VljrWbMSj6rbT8Xo11bvIrrtZs5EZFv9xVYepU6O4qa/b7hIwPFMmWgA/TGApll2tGw4
         4jbcD6OBq9k/16/2bwErBIc8gyUeN/w4619uRzSi2QRQ7ODE2T9aSdiOml2Yn4Qgjmc6
         CalQ==
X-Gm-Message-State: ANhLgQ2CNvL4DlGuMXM/u0zaXM9ufUl5AoCCX11RUZ+wQlVflhQqiP1F
        4LlMVs8X5wWA+qk/4cY4KKf6Og==
X-Google-Smtp-Source: ADFU+vs1dygAlhI5cfEvapVSGFEeHNp/7i/XH4N6iX4ibj5JBXx4wuRKXaLCwGiBsZEfk2ePdNHzYA==
X-Received: by 2002:a63:5f91:: with SMTP id t139mr20346785pgb.119.1585691638444;
        Tue, 31 Mar 2020 14:53:58 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id q61sm74343pja.2.2020.03.31.14.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 14:53:57 -0700 (PDT)
Date:   Tue, 31 Mar 2020 15:53:56 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] doc: log takes multiple revision ranges
Message-ID: <20200331215356.GC95875@syl.local>
References: <pull.590.git.1585429894378.gitgitgadget@gmail.com>
 <xmqqd08wc5bd.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd08wc5bd.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 28, 2020 at 06:34:14PM -0700, Junio C Hamano wrote:
> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Philippe Blain <levraiphilippeblain@gmail.com>
> >
> > `git log` accepts multiple revision ranges, but makes no mention of that
> > in its documentation. Currently readers have to go to the `git
> > rev-list` documentation to discover this useful feature.
>
> I have a mixed feeling about this change.  Surely you can write
>
> 	git log   v1.0..v2.0   v4.0..v5.0 -- Makefile
>
> and you can explain that the command appears to take two "ranges",
> but I do not think we want to encourage it to those who do not
> understand what the above actually *means*.
>
> Specifially, it does *NOT* list commits between v1.0 and v2.0, or
> between v4.0 and v5.0, that touch the path Makefile.  In other
> words, you didn't really give two ranges with the syntax.  What the
> A..B notation means could be called a range, only when it appears
> alone.
>
> And we have *no* intention of changing the semantics.
>
> "A..B" is a mere short-hand for ^A B, and it may appear to be a
> range, but "A..B C..D" does not make "two ranges".  It still merely
> is a short-hand for ^A B ^C D, and if C reaches A and B (in the
> above example, v4.0 is very likely to reach both v1.0 and v2.0), it
> means the same thing as "C..D", i.e. "git log v4.0..v5.0 -- Makefile".
>
> So I have a mildly strong opinion against the change to the synopsys
> and the short-help; it is a bad change that does not help users.

I second this opinion. I think that reading:

  [<revision range> [...]]

is very misleading. It guides the reader to think that they can specify
multiple ranges, but does not provide clear guidance about how multiple
ranges are interpreted. I think most readers will naturally assume that
the interpretation is "take the union of each provided range", but this
is not the case as Junio points out.

> If there are not sufficient explanation on the equivalence between
> A..B and ^A B on "git log" documentation but there is one elsewhere,
> adding a reference to help users learn is very much appreciated,
> though, and I initially was hoping that the second hunk of this patch
> was such a change, but it appears that it is not (it just adds the
> misleading "you can have more than one" without making readers aware
> of what it means to write "A..B C..D").

I think the documentation is probably clearer as it is. Having this
extra explanation about the difference between the two doesn't guarantee
that it will be read, so it may just be adding additional complexity
that isn't warranted ;).

> Thanks.

Thanks,
Taylor
