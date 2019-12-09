Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC101C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 11:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C6B42077B
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 11:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p0kXBKkY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfLILKk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:10:40 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37757 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfLILKk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 06:10:40 -0500
Received: by mail-ed1-f66.google.com with SMTP id cy15so12323808edb.4
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 03:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jqh1rJHe8/zVA5DlsE6/04F3dUs5PMfnyvnCn650XNc=;
        b=p0kXBKkY/a3LMOvWOkZqU4M+EyoMnvMT6E6/QeUC7l6XL3jB6vdRdmoez477lILL6M
         UEe/AuX9S2KfwpCilfjqSdEagK6IYRSzS8YmHYARHlBLHiYmuPalolXYOwsuNmLkdN7y
         VJgFYs3Mf8Il1oYWyA9S2ZSrUb2wszyH8y1PSpbj+SY94pXz4KfkDT4F6rMxtQIrvdbJ
         wGKQcXbB7iZn1CeESJj9WYeGr2syYFTpnvuekmnTS2Bn9xKLNyBg74OF2TJuXcAIuQV9
         7zVbr8skaRQ0p1uEeh7HnLWfcH60eZVJq08bR1+SOvk5GmgJgUx2t5q5cm0Phvl8fYid
         LKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jqh1rJHe8/zVA5DlsE6/04F3dUs5PMfnyvnCn650XNc=;
        b=lR2pQhfBo5dyqijwU0DwZMYpAaXbmLngAiXdD0q0xq7dJPbHiyJSI76APAF6pDCvd/
         CbDULtEe0PTduLeafScxm1sICrcTvzGNS2rLGDsS9euiNAKkc4GMt3hjmh/8zEVMrPDk
         VPZNGM01Jky7NaIN9N45v+eZhURS+fQ95bGtsPd4wZBDUkOkfxmEDxOdiR5fM+QVNopN
         RR/ZHdF59mZc/AKzXxjA88hxML18RTzvCz4XM1y/6gadhVzL/MleObkHyGyd5zdsYY4+
         MVyijkOj8uRIL8mejHac9lb0jpvLPSga2Cz639ibRtPtbYhL2hRLduLFPR5tnHJ6lWmF
         Tnmw==
X-Gm-Message-State: APjAAAUNM3m3106H/GJ7LTIqGS3bj6FZTOJD7r2pj4nbCNUnpLFnDyjJ
        cbM/uGg0f1SNGT8Jx+qUlWz3TAPTV4Y9xvlTh9g=
X-Google-Smtp-Source: APXvYqx4Ix2sRZnuLZKRa3Rd2a9ujiFEPkadJV45M7BUhyVG7eykPCrZkWulZ2q4XYP/aKUmFLA86hYAPzt8TQWv5zQ=
X-Received: by 2002:a17:906:2505:: with SMTP id i5mr31017866ejb.18.1575889838307;
 Mon, 09 Dec 2019 03:10:38 -0800 (PST)
MIME-Version: 1.0
References: <20191209084022.18650-1-mirucam@gmail.com> <CAP8UFD2C0uh+e_tH2H=z2RqDwSC7SEu-JoBx3z2KefVND8OqYQ@mail.gmail.com>
 <CAN7CjDCU=BPA3n6aDEPEzV8VK=JtYFn5_3CbqYrc5Zpg79m5jw@mail.gmail.com>
In-Reply-To: <CAN7CjDCU=BPA3n6aDEPEzV8VK=JtYFn5_3CbqYrc5Zpg79m5jw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 9 Dec 2019 12:10:26 +0100
Message-ID: <CAP8UFD1ExQ=hmLK8Sakceh8h9uytF+rVpC_YX3ze0M2LMU+2cw@mail.gmail.com>
Subject: Re: [Outreachy] [PATCH] bisect--helper: avoid free-after-use
To:     "Miriam R." <mirucam@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 9, 2019 at 11:36 AM Miriam R. <mirucam@gmail.com> wrote:

> > > Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > > Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> > > Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> > > Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> > > ---
> >
> > Here (after the line starting with "---") you can add comments about
> > the patch. One useful comment here would be to say that this patch is
> > a new version of
> > https://public-inbox.org/git/20191208172813.16518-1-mirucam@gmail.com/
> > which itself has been sent previously by Tanushree
> > (https://public-inbox.org/git/64117cde718f0d56ebfa4c30f4d8fe2155f5cf65.1551003074.git.gitgitgadget@gmail.com/).
> >
> Ok, I'll resend another one (v2) adding this comments. :)

It's not a big deal, but there was no need to resend another one, as
the comment is there only to help reviewers with extra information
related to where the patch comes from. It will not appear in the
commit that will be made from the patch (using `git am`) and I already
gave the information about where the patch comes from in my reply to
the patch.
