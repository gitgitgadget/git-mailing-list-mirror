Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E650C433E0
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 21:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED89164F4B
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 21:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhCHVG0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 16:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbhCHVGS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 16:06:18 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00809C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 13:06:15 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id o11so11564038iob.1
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 13:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OGDfsZU5Yi4zE+nxnnxEETM6G/1NYE+UrbnA2y5JqCc=;
        b=i1W7EIqVdR2Fq30E0mQw9NguH4vGaD2v83NYjmMF6KAspaDNEiIIHTxbEqDrrQVKhg
         Fko+IOU5KTvI5ge0sZwFhPMBl8GRikm1qK212c1tG+QPuZXIrZOMTAwUtNsUy06b9iFg
         23G+1F6XV4ct3ohNyXfTt5FVO8tv1unthms2SnhjHsbWTb2DlDIgisWwW3tO9F2c6MiN
         qOfPYDBwQskWi7ugrjxAuXJ41XsWmVdrLBbfuKgFYbm/JcktRVDmJs42WArMpNepfgwx
         DgXkAAu2eq+IDIK454BDJjCiPTp85+3HanRn+gVMGc2QboA+sQoDmjQenxgiMz+OxXzF
         LN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OGDfsZU5Yi4zE+nxnnxEETM6G/1NYE+UrbnA2y5JqCc=;
        b=aRuLtmNyLqyn+T6lG+ULEbSecZXaxbZcRzwM963WcP5GRYyo4RZ1QI85Hazpus0QA7
         qEqMyQCt0lhWE2msKTlQLIchJFzXMEQyJqqOUICvrEUWBWMsv178d4Fs+Q4jCxhyj46j
         9vtOQXIungGeRzaCx+XjDkLYUxl+UpMp9MVW2Fh8xSPuORKjpUGfmAdL9+Kb5QELHnlF
         byCClK3AKouc8ed9/ozAoF32FZqaPRVI6aRCJ0Cgr2Dxfs6uoUjvdOOzn8g55r+IGZcF
         oe61NZi8WsAARwS7LpeUrVaeb1MK+RL1zp+q6jXD5R2AMpHP8WudqUAwzrKEZwkIJJ5b
         DNwQ==
X-Gm-Message-State: AOAM530OKHwBmodS966zrmamV99f//3AsZ5MiBpXtrxS3ekQY74O1iDP
        mRCbZtD93EOt0CbfxAS7e8Qfhw==
X-Google-Smtp-Source: ABdhPJzBaV0pJ6Sz53gZZVmRiz0yfK9FhvuzP/HwTHaof0P+m5ngu176Xub0jvgMPmMTizIkh6V/6A==
X-Received: by 2002:a5d:9b18:: with SMTP id y24mr20033641ion.24.1615237575515;
        Mon, 08 Mar 2021 13:06:15 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:d4a3:1166:858b:6d61])
        by smtp.gmail.com with ESMTPSA id h23sm6393689ila.15.2021.03.08.13.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 13:06:15 -0800 (PST)
Date:   Mon, 8 Mar 2021 16:06:11 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Fabien Terrani <terranifabien@gmail.com>, git@vger.kernel.org
Subject: Re: remote.<name>.merge missing from the git-config man page?
Message-ID: <YEaRw5x5hnh9RRyM@nand.local>
References: <CAOuwed4HJLTgk48Fre5vGYjYanqD6hu8yZM73CpcAmF1ajiTnA@mail.gmail.com>
 <xmqqlfax7dya.fsf@gitster.c.googlers.com>
 <YEZwY0721KvQNkK+@nand.local>
 <87pn092yja.fsf@igel.home>
 <YEaI5JIobsbtBQO1@nand.local>
 <87lfax2xat.fsf@igel.home>
 <YEaM7ruZCvaQQbPI@nand.local>
 <87h7ll2wiz.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h7ll2wiz.fsf@igel.home>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 08, 2021 at 09:57:56PM +0100, Andreas Schwab wrote:
> The configured upstream is the value of branch.<name>.merge, isn't it?
> That would be the name of a remote, not the name of a branch.

Right; the '<name>' in 'branch.<name>.merge' is your local name for a
branch, but the value of that configuration is the remote's name.

> Andreas.

Thanks,
Taylor
