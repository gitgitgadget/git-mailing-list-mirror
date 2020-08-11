Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE07C433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 12:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F00720838
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 12:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OehuRBqz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgHKMHd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 08:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728899AbgHKMH0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 08:07:26 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430BCC06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 05:07:20 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t10so6708586plz.10
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 05:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mbd+HUKHwGnmaYry6xZY21akCVoFsMy8vGk2Hh2jvF0=;
        b=OehuRBqzqdSxQJiRjqU9QQQeDZNwKDRNRksTutUhFkzCCBcokpINplMOgJSRShxe7d
         Swl3k58IeIcjnAAv67xT65hWWRrIoY2BnZ/rPMTQqbkRrX+++t0XbKj6fNosomwyPKVq
         wdO241HXuy+7TLycOwJ+1I/Mln+wRjAFNG3zhaU2lnpdlD1WqKVUEDJCPvZkeV5CVDTj
         +tX0fiHpGX9NhrKBlTxTpPxe+0PlSEpPsPukJ6VJtjT5UdsZpTZWi8aEvH4ieIEZ+MyB
         1zPr1ee8ad4AnHLmRglH4ZjsCaUEyksFmYrUHaTMAAU43PvpDYW9EArdyX2KatGWPF49
         IObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mbd+HUKHwGnmaYry6xZY21akCVoFsMy8vGk2Hh2jvF0=;
        b=tsbcBviCPqX9WJZfl3WAkiPJio7s9tOVKGaGBsXUgieVee3RNW7UAIivDNazJRGDvJ
         c+WQS+CTr7CwnAXZQ3IbsCuDe+zV41y2LIWOUIdpZMWmMnsufejA+QfasedDnusz69pE
         4Ffk7rp1NDbEauqjh+w5DNRsau5A9uD5/rNJZiGj/aOyms4F9cL8LvG4xpn7vd/S5yLq
         DzmPX4GE91vpKd4qRzBWSu8QOq9uwXl+ebSra+V/9znKIiq7O7XVotEbWhYUwMHlG6Gw
         idpFTa3SwLV6fnKDMrp32wbLEFqUf2eyZ6gFEMQsdpQ/dzYDZ8pWecRTZboIDuQvOB3X
         0zbw==
X-Gm-Message-State: AOAM530/L3JUMkjp5h2v2rQ3ZieainNqJw8hd5nDOP86hwaOG8OOxWeF
        dZYJH8qVryQvAgSUQdrzWw1+PCeI
X-Google-Smtp-Source: ABdhPJyunGMN7bkAp6WuiZktxUcrLC0IXT8xW5JNwjvo+2XIE5NFVuSo5+D4w624M6+CFvvrnCzGwQ==
X-Received: by 2002:a17:902:7404:: with SMTP id g4mr613888pll.242.1597147639622;
        Tue, 11 Aug 2020 05:07:19 -0700 (PDT)
Received: from localhost ([2402:800:6375:ea17:7ad5:df16:a252:473b])
        by smtp.gmail.com with ESMTPSA id s125sm28482723pfc.63.2020.08.11.05.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 05:07:18 -0700 (PDT)
Date:   Tue, 11 Aug 2020 19:07:17 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] extend --abbrev support to diff-patch format
Message-ID: <20200811120717.GE17119@danh.dev>
References: <cover.1596887883.git.congdanhqx@gmail.com>
 <xmqqd03zej8w.fsf@gitster.c.googlers.com>
 <20200810100038.GB37030@coredump.intra.peff.net>
 <20200810123148.GB17119@danh.dev>
 <xmqqy2mmcz1e.fsf@gitster.c.googlers.com>
 <20200810152705.GA61606@coredump.intra.peff.net>
 <20200811003359.GD17119@danh.dev>
 <20200811052226.GA82699@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200811052226.GA82699@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-08-11 01:22:26-0400, Jeff King <peff@peff.net> wrote:
> On Tue, Aug 11, 2020 at 07:33:59AM +0700, Đoàn Trần Công Danh wrote:
> 
> > > Yeah, that's what I was getting at: if you care about robust
> > > machine-readability, then the full index is the best solution. Reading
> > > between the lines, I think the argument may be "using --full-index is
> > > too long and therefore ugly, so people like the short-ish names but with
> > > a bit of extra safety".
> > 
> > My argument was people can either easily fetch the patch via HTTP like:
> > 
> > 	curl -LO https://github.com/git/git/commit/eb12adc74cf22add318f884072be2071d181abaa.patch
> > 
> > or take it from a mailing list archive, bugzilla, instead of
> > cloning a full repository. With those options, we can't say,
> > "we prefer full-index, please send us the patch with full-index
> > instead".
> 
> OK. But then how would they use "--abbrev" in that case? I.e., isn't it
> too late at that point (especially in the mailing list archive case) to
> do change anything in the formatting of the patch?
> 
> Maybe I'm confused...
> 
> > > There's an extra challenge here, which is that you have to convince the
> > > sender to use the extra --abbrev option, even though they themselves
> > > won't be the ones running into the problem when applying.
> > 
> > Not really, since the sender tree is usually larger than the archived
> > tree, their abbrev is usually long enough, and the receiver will use
> > --abbrev to lengthen their abbrev to reduce the noise instead.
> 
> Now I'm doubly confused. If the sender has the larger tree then they'll
> have the larger abbrev. So what's the problem?
> 
> Going back to re-read your earlier responses...So...this _isn't_ a
> problem within Git itself?

Correct. It's NOT Git's problems by any mean.

> It's only about people trying to compare
> textual patches byte-for-byte and seeing different index lines?

Yeah, it's about people trying to backport patch to old tree.
Fixing conflicts, and try to compare to old patch to see if they have
made any errors.

Because conflicts resolving is complicated.

> 
> If that's the case, then it seems to me that the byte comparison is the
> problem here. If I have:
> 
>   index 1234abcd..5678bcde
> 
> and
> 
>   index 1234abcd87..5678bcde65
> 
> those should be considered equivalent to see if two patches are
> plausibly the same. And I think tools like git-cherry, etc, would do
> that (and we provide git-patch-id for that purpose, too).

Yes, git-patch-id is very useful tool.

There're time that half of the patch can be applied cleanly with the
exact object names.
Another half needs to be fixed heavily, (maybe removed). git-cherry
and git-patch-id couldn't cope well in those situation.
That condition is true if there's a major change to source tree.

> > > Yeah, I certainly don't mind the extra flexibility between "full" and
> > > "default" for "index" lines. I do wonder if people want to configure the
> > > abbreviations for those lines separately from other parts. I don't know
> > > that I've ever particularly cared about that flexibility, but the fact
> > > that they were set up separately all those years ago makes me think
> > > somebody might.
> > 
> > I don't think people particularly care about the index line (and to
> > the extent, its length) that much, since the default is number is
> > actually a minimum number, if Git can't differentiate object with that
> > number of characters, Git will show a longer object names anyway.
> > 
> > I think most people scripts will put a regex for:
> > 
> > 	/index [a-z0-9]{7,}\.\.[a-z0-9]{7,} [0-7]{6}/
> > 
> > Or even:
> > 
> > 	/index [a-z0-9]+\.\.[a-z0-9]+ [0-7]+/
> > 
> > For the former case, we could change the code in 2/2 to set the minimum
> > default to DEFAULT_ABBREV instead of MINIMUM_ABBREV?
> > 
> > For the historical case that users put both --full-index and --abbrev
> > into there scripts, we still keep our promise to not break their
> > script by always respect --full-index, regardless of --abbrev.
> 
> I care less about scripting (as you note, anything consuming abbreviated
> objects has to handle longer-than-minimum names anyway), and was more
> wondering whether anybody really cared that:
> 
>  git log --abbrev=30 -p
> 
> kept the short index lines (e.g., because they're easier to read). But
> I'm having trouble coming up with a plausible reason somebody would want
> long object names in earlier lines like "Merge:" but not in the patch
> index lines. And already we respect --abbrev for --raw, so it's not like
> the diff code isn't already affected. Making "-p" consistent with all
> the rest of it is probably worth doing regardless.

Yes, I think this is the easier to accept argument.
I've gone with that in the resend.

-- 
Thanks.
Danh
