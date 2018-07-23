Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F5481F597
	for <e@80x24.org>; Mon, 23 Jul 2018 18:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388056AbeGWTw7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 15:52:59 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:51024 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388018AbeGWTw7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 15:52:59 -0400
Received: by mail-it0-f49.google.com with SMTP id w16-v6so296373ita.0
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 11:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WWu73BijW58ADimHyTBSq05SXHl4WqL6577sByhe9C8=;
        b=Tc2sv3W+aD5EdjTMWDaDGhsbyITY51saToEGHXlEboRGukp64uSrG0V20aDJyP83ju
         grpvGj4nFq08tciTsOpdPbPptYxTYsJZo2S1zFnlVXoxaICs0rPezmDR0w16+LnaZu03
         hrqONaoEjVeQnuEroZjO3tWWJdu4xqzUOKXkv4V0g4bCfeSUQOlUw7Or4cet+kFTvaZf
         v5p6T8VJ6CCrPcCnKGO8QtVjqZrPk5swVMGf+bhq62rQn/3aQW6ByWNfEtiu96+Jp1MY
         zzwv1Js5AmnNEzdYucwsUlWBmTy44V//ApkiYr+Erki/m8uraqARNKFC7dAgTxFxdtWt
         Ek1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WWu73BijW58ADimHyTBSq05SXHl4WqL6577sByhe9C8=;
        b=jjdHK4//1OVqUt6Fft7QfHTvvNcExHJbmNqa49mzVZjEmHW7XcSohiPgcNVce7dvAT
         RvG4aDLGS/qgZTUKvT08GR1VNW3j68GTYVlv8yachGhm2lRbtgV2TXs2aeupn4mHUshT
         pHQmtKbbdBhMujNXXzTbT2c8lmzFC6XFpzBVLfCDr+wc4jopJ4nqDK7ylroEHBgClZ9U
         0aOQYuSsEps5agtryfr4uTImKUe5Xz0FPiGK9X6lWs1VpklEU7Xsq+sivsQxr0EBnTjk
         lrDsf9Rg7/EtyodzsTan2yxTPr81Em2SNuF2EtMvHHJRkJTJZigYARdjOg+4phbWrZtc
         eDgg==
X-Gm-Message-State: AOUpUlHRxQgXSVDyCHUG07JJBft7c5Mv+Lqv64V8Xc2mIF2X6sqIDsvo
        Rwgh3vjLc2vC+o7JtvTE5N7viG6bCHCpVQsrYmg=
X-Google-Smtp-Source: AAOMgpdCGnXH3h5//afPiU7tiL7t3mac3D20OnoSUvsbMxBcz+sveeH4DZEZK90BwXZGIdMRo7IbSUfnjRvetSZhTM0=
X-Received: by 2002:a02:c50b:: with SMTP id s11-v6mr12810580jam.61.1532371825806;
 Mon, 23 Jul 2018 11:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180720153943.575-1-pclouds@gmail.com> <20180722080421.12887-1-pclouds@gmail.com>
 <xmqq8t617rqv.fsf@gitster-ct.c.googlers.com> <CACsJy8BskYdANe9HnuLj8sqa8hRqzSAQ+q11C8faJ-YBtA3Xeg@mail.gmail.com>
In-Reply-To: <CACsJy8BskYdANe9HnuLj8sqa8hRqzSAQ+q11C8faJ-YBtA3Xeg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 23 Jul 2018 20:49:59 +0200
Message-ID: <CACsJy8Cex0Uby-eBRBqc_ScZd=EnCV6e0ZuaZEmopGkrvhrBzQ@mail.gmail.com>
Subject: Re: [PATCH v2] pack-objects: fix performance issues on packing large deltas
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 23, 2018 at 8:38 PM Duy Nguyen <pclouds@gmail.com> wrote:
> I will have to study the thread dispatch code more to have a better
> answer, unfortunately.

Well.. I thought I would need this weekend for this, but a quick look
and ll_find_deltas() suggests that what we're doing is safe. At least
you and Jeff are way to familiar with the delta window concept in
pack-objects. So in multithread mode, we have a big list of all
objects, then the list is cut in N sublists and each is owned entirely
by one thread. Each thread then can slide a window over this sublist
to search for the best delta.

Because of this partitioning, if trg_entry is being processed now, it
will not be accessed by any other thread. It's owned by this thread
and will be accessed again as src_entry when the next entry becomes
the delta target in the same thread. As long as we don't access
objects of another thread (and my v1 violates this) we should be ok.

At the end of ll_find_deltas() though, we have the "stealing" stuff,
but it's protected by progress_lock() already, outside try_delta() so
we're sure nobody is updating any object_entry when the stealing
happens.

I will double check again this weekend just to be sure.
-- 
Duy
