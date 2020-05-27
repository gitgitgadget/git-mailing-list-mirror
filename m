Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308C6C433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 19:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D0512088E
	for <git@archiver.kernel.org>; Wed, 27 May 2020 19:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sxhOa3vi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgE0Tl5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 15:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgE0Tl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 15:41:56 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39004C05BD1E
        for <git@vger.kernel.org>; Wed, 27 May 2020 12:41:56 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x6so11727761wrm.13
        for <git@vger.kernel.org>; Wed, 27 May 2020 12:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jS+/LmXPNQRbTbzj8P+2Q8WCws4atcQJbyc9qyr7ZcY=;
        b=sxhOa3viYVHiSWGFo7KpEB3UzWVEVnEdZKjj4YHuLrzHPJnTyVjNPW0ppwK3/Z2F8E
         rNE2b5SxyliXAKVTciHHInVqKMDXKwcv8/43bYUqteG9wx7z03p2bUWfBlC3O8devazH
         iTMBZhrSp7x2+8jomAf1jz8xkGE4u0r2iBpGRJN7fzjBnVqD8ezyvw2JNhv4ex6YEyvq
         bKTghPvuSQzShZiV9ErwXMlom0t9XupUnoH16LJ0dldoHz4SMKfQiUIadrkQAi+nIBhc
         z4nY6fbNZlq47OzDJ6DUl+S+MLPS4YDEJfFSveSs2InB4dlWa8mG3eOxIECABbSbiLnL
         hfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jS+/LmXPNQRbTbzj8P+2Q8WCws4atcQJbyc9qyr7ZcY=;
        b=i5NNvuuLaclU+KU4voFbF3RIP3V8Ci5MSZ09DSTgi+peCZm/nhgUFaC7YA1rYIkfZN
         nVzNoCexN+bUhAgld55hFgFACDPujOY5XdJMJdKwVSNq9G4u7ENfD2CWsrCWwsQ9cGgp
         7R6A25NLLvFJv4v3C1RAo6haVSKsZEw1hzzpie+Nl10kKtCWOGAXRQJnF2F6v7xBpCLV
         raX4e6rFBzodPEwH3e0llyUnMwbswtrmJx1IayBx07bMYDgZJAfQ+TkTkf93AOBOdMiS
         5KHomxJmoVqlJjMjefTmFd5pBuqitRDRY1/33ESFoSSlEYYbP+IMoAoEs/RRYO7mG9sE
         bpJg==
X-Gm-Message-State: AOAM5328kulxqLfcNORqqx17MZxiZtUSQpkQ3faBlGYxtD5c8Q80rTQV
        19C62h8fSVXYJ3gEluQVPBx1mBbEJNyK+xg2vinvyVQZ
X-Google-Smtp-Source: ABdhPJw4cawR9n135402Mqk/8U8mhTlyIOJI7zV668CCy2AugGHpNrCjUhC6ri67nS/TCUvQjvpmMF4rZCW/+ucQyJU=
X-Received: by 2002:adf:b34e:: with SMTP id k14mr26498328wrd.109.1590608514908;
 Wed, 27 May 2020 12:41:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200527113831.3294409-1-jacob.e.keller@intel.com>
 <20200527113831.3294409-3-jacob.e.keller@intel.com> <xmqqimghl0ft.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqimghl0ft.fsf@gitster.c.googlers.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 27 May 2020 12:41:43 -0700
Message-ID: <CA+P7+xoTJzsV=NbWeWs+fbdgETXwqUs0T9MToBbrGJ0EA-bFcA@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] completion: improve handling of DWIM mode for switch/checkout
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 27, 2020 at 11:03 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
> > This new logic is more robust, as we will correctly identify superseded
> > options, and ensure that both _git_switch and _git_checkout enable DWIM
> > in similar ways.
> >
> > Add several tests which demonstrate the new expected behavior. Note that
> > some of the git switch tests are marked as failures because the default
> > git switch completion with --guess is sub-par as discussed in a previous
> > commit. This will be fixed in a future change.
>
> "as discussed in a previous commit"?  1/9 does not mention --guess
> at all.  Perhaps this is an unintended damage due to rebasing?
>

Yes I originally had a patch earlier in the series which just added
test cases, but I later moved that into the patch that fixed the
tests.

> In any case, up to this point, the log messages are a bit
> frustrating read, primarily because the author has spent too much
> time on DWIM and expect everybody understands exactly what he means
> when he says "DWIM mode is enabled", while a reader in me keeps
> asking:

Right, I thought I had an explanation of this somewhere but it appears
to have been lost while re-ordering and re-wording.

>
>  - what refs get included when I type <TAB> without DWIM mode?
>
>  - what extra refs get included when DWIM mode is enabled?
>
>  - under DWIM mode, do certain refs (that would be included without
>    DWIM mode) stop appearing in the completion?
>
> and without getting any answer to them.  Perhaps the proposed log
> message for [1/9] can be made a bit more robust to cover it?
>

Sure, I'll look at what I can do to make this more logical.

> Thanks.
>
