Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322A3C433EF
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 17:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238186AbiAJRXR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 12:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238139AbiAJRXR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 12:23:17 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42FCC06173F
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 09:23:16 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id w16so56375774edc.11
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 09:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WcbqyXGrWCdA8FDU8LfLIwPsTOGSyQmNKM1EH92rqkk=;
        b=DR9MDzhRgqvMArGdY3YdKunXfSp5YhpleLmhd/e0+/pnswIDQjcd0IklVM3uDRlD0h
         H7bmZ1XMBYS5ngB91D4qkQf1i7Zwym+tEfUR0xM/2IdQH1LOCI0WF5YIXb24wqBKXGNf
         OLaX1KvddnM90tho7spPnVTZOw1kWeo3shsYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WcbqyXGrWCdA8FDU8LfLIwPsTOGSyQmNKM1EH92rqkk=;
        b=DzoybrxU9fFRRG0vsFbhWZQje5bL2xb7zRgseGtDN0VXwUjtmclR7WRhEHouMQlGu7
         5I1aAp7BzTOCPy5rPl+xms26YoJCj3rbDptJVUCbmC+pb3qjeMifbOT63pBOkrfnHTDI
         qRb3ysmfDbp4CFzUVCg9OMLFJhyGxyef8tLB36BkImabMfDhr3Cou25hdgxwdkwtWHqx
         hAfzY995PK5YHdeO7NQao6NkvSepHjKnNiq3DBqfirKjURRN7GdTIgtMcvCob88j0lFy
         53Q4TRg3mAkowu4HUuCyTv3Mx2+2JSyPqeE6/J6UyxEAy9v2bmstgv/eXj9pkvLaY1kM
         e0Cg==
X-Gm-Message-State: AOAM531jHY0px9F1R17NfxetGnR++6FayKLzCGHMQ25475RsNudvNd3T
        yFl7KtjGiHYIm3FKBSNAe0sWfR83mfFpwXnZlRs=
X-Google-Smtp-Source: ABdhPJzlyS3Y30kK8ae3pxxYv7bfBrRe8me2IrxWwpI394Xqtqv3nJbFHo6cI1kXHwyEX8LBrTOtyA==
X-Received: by 2002:a05:6402:27cf:: with SMTP id c15mr650151ede.344.1641835395104;
        Mon, 10 Jan 2022 09:23:15 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id cw6sm1042980ejc.32.2022.01.10.09.23.14
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 09:23:14 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id w26so3401414wmi.0
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 09:23:14 -0800 (PST)
X-Received: by 2002:a7b:c305:: with SMTP id k5mr405961wmj.144.1641835393905;
 Mon, 10 Jan 2022 09:23:13 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=whXPxWL7z3GiPkaDt+yygrRmagrYUnib7Lx=Vvrqx2ufg@mail.gmail.com>
 <YdxqshqXB/+ApOn2@nand.local>
In-Reply-To: <YdxqshqXB/+ApOn2@nand.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Jan 2022 09:22:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg8yGxwtv-Ggqbh7qqWGHbjiDCVARXdhOzxjCpMg=e0Rg@mail.gmail.com>
Message-ID: <CAHk-=wg8yGxwtv-Ggqbh7qqWGHbjiDCVARXdhOzxjCpMg=e0Rg@mail.gmail.com>
Subject: Re: git ssh signing changed broke tag merge message contents
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Fabian Stelzer <fs@gigacodes.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git List Mailing <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 10, 2022 at 9:19 AM Taylor Blau <me@ttaylorr.com> wrote:
>
> Yes, 02769437e1 appears to introduces an inadvertent use-after-free.
> I'll write up the details and post the patch shortly, but an easy fix
> is:

Ack, that seems to fix it here for me from a _very_ cursory test.

Thanks,
               Linus
