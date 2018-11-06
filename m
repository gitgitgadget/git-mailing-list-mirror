Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6D9E1F453
	for <e@80x24.org>; Tue,  6 Nov 2018 05:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbeKFOjS convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 6 Nov 2018 09:39:18 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44292 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729016AbeKFOjR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 09:39:17 -0500
Received: by mail-qt1-f193.google.com with SMTP id b22-v6so1318696qtr.11
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 21:15:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HnTnZgZLVGRx4QZFuNrQ4snWpga7hdJPnlgYJsSHDe4=;
        b=eudQZrVFXoFXpADLG0VBkVTpA0X0hl4OlXT9rkjYJDphPQu7qztNAhTlhOvW2acvz2
         18Gb6ztOCRfD+AUK7aF7MMhg/NGDKGB4kkBz6nCY8jGPYiothVLxdLsDPBcDdP+J/QrT
         Fyfm+RTaA7SPU0Ar3RxDqOpaKxYupJEP6Jgpf3PkZpim7X168tRRkwWThiq2A+QtxTel
         uHeAZIg75IZzgfgiVqGJ96mJoBmoj7x5EN5BnBc1hQT8PViAepNZ/epomOARDe8HUqSG
         9w/Ns8fg/g8Xbxa5PnkWrtKyBs1Gwa6LqLfdJpUIi/WILlsPcDeRc6NopnjrsINkyFRb
         B0Gg==
X-Gm-Message-State: AGRZ1gJpgV9J8x6hgddX5VOd5F5xTz2jYOLt9OPrkjJheG+vgIGM224I
        P3oOdHXPQHv2ykrGvxi2pSC9GzOzI/KO9VVuHO8=
X-Google-Smtp-Source: AJdET5dF180gS6Oxj1bst0OFg6vg9tCafKro9+QyyYAlgMoBOJH54qXKAVvvFdycRHkSv4qsJtWh7B77YG4jhzOQYqc=
X-Received: by 2002:ac8:27c8:: with SMTP id x8mr3488235qtx.352.1541481352773;
 Mon, 05 Nov 2018 21:15:52 -0800 (PST)
MIME-Version: 1.0
References: <20181105200650.31177-1-avarab@gmail.com> <xmqqva5aet72.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqva5aet72.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 6 Nov 2018 00:15:40 -0500
Message-ID: <CAPig+cR85-7wMYCGGFoRT3jSQzQmda_84Ox1kF6roa5j-1XZ0Q@mail.gmail.com>
Subject: Re: [PATCH] range-diff: add a --no-patch option to show a summary
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>, lucas.demarchi@intel.com,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 5, 2018 at 11:17 PM Junio C Hamano <gitster@pobox.com> wrote:
> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> > This change doesn't update git-format-patch with a --no-patch
> > option. That can be added later similar to how format-patch first
> > learned --range-diff, and then --creation-factor in
> > 8631bf1cdd ("format-patch: add --creation-factor tweak for
> > --range-diff", 2018-07-22). I don't see why anyone would want this for
> > format-patch, it pretty much defeats the point of range-diff.
>
> Does it defeats the point of range-diff to omit the patch part in
> the context of the cover letter?  How?
>
> I think the output with this option is a good addition to the cover
> letter as an abbreviated form (as opposed to the full range-diff,
> whose support was added earlier) that gives an overview.

I had the same response when reading the commit message but didn't
vocalize it. I could see people wanting to suppress the 'patch' part
of the embedded range-diff in a cover letter (though probably not as
commentary in a single-patch).

> Calling this --[no-]patch might make it harder to integrate it to
> format-patch later, though.  I suspect that people would expect
> "format-patch --no-patch ..." to omit both the patch part of the
> range-diff output *AND* the patch that should be applied to the
> codebase (it of course would defeat the point of format-patch, so
> today's format-patch would not pay attention to --no-patch, of
> course).  We need to be careful not to break that when it happens.

Same concern on my side, which is why I was thinking of other, less
confusing, names, such as --summarize or such, though even that is too
general against the full set of git-format-patch options. It could,
perhaps be a separate option, say, "git format-patch
--range-changes=<prev>" or something, which would embed the equivalent
of "git range-diff --no-patch <prev>...<current>" in the cover letter.
