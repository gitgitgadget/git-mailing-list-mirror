Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3448DC433DB
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 02:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1B9E23AC9
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 02:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732141AbhAOCaH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 21:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732136AbhAOCaH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 21:30:07 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB1BC0613C1
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 18:29:26 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id s6so3359781qvn.6
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 18:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=elq1/vsoAEdbSf4DRAlnQsZ1QAwdW0jaO/sT8Uo3jes=;
        b=dgWUWLU5BqxmolqsbBrcp82gqI2tyexCVotMcw0rVQApZFdZ5IfXn72DZMildHwwQ9
         vt/Ie5l11OFECVTXyU9M7yhl7xwqsIHw2yZpIV24oSJOwBxkf6lCT/l9g3KqUj5VgexC
         XHFskKNSllVRh+C64sfA9ID4/7cD1cQoJ2uG4xaXUmDr+roloycj969Z9DH90v8cdnTq
         IwS3/m/l2eA0AHKKHXHh+H5hErDBqUVrkziWrMFnJQCQsOjNTEw+saNULWBBLW5PUkQ8
         3p1/XFhzBHXnYVSrw09Des40XQeOio0Pe40T2zJvtpQ5oG6HX2KLm2lc9yHD0lMebyPL
         SOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=elq1/vsoAEdbSf4DRAlnQsZ1QAwdW0jaO/sT8Uo3jes=;
        b=NjL0Uwg9gTDZOHVaWoaDWmEslwwu3idb0fA18NnVDptwWWPfW2VFy4QM8frej0PJFZ
         KPLrm7owim86HUMTepRdOyExsCD+nN0nzEpVxqCBO1eKJdnt3xf6w+hs7jCVpBFuC6a4
         J2vddXiCRlnLn4Qa8pwfGdcuthHt+sr5a/6rISnFPhNWpUZL0M4lr4IWUSRyNnW7XZo6
         2f/SUh1eCnh6DkaJY5Khu6AitFR+eNgmnce3eb79Bt0b7xo8kaBAv6uVk/HRfccjUyrM
         MTrpHkeq/VrIo64YF0IZAqzE8HrAVY0M63lkxmyVI3Db9PnbFV13V5MXsmjlHI+Bfpx7
         Lu+A==
X-Gm-Message-State: AOAM531NvWQ9blCSIFkB5O27PpvPv/Js8sr8to8OryC6GWwNDfr2GtM4
        mjw/KcERtVV8Q7FuananK6dEDw==
X-Google-Smtp-Source: ABdhPJzne7JwLI9Yg00SW9uf7JEWpJ4DCPtQ3gaoc+mM+To6SPYJp5rkC8WuygB0Tr27TWW7y0VexQ==
X-Received: by 2002:a0c:f14c:: with SMTP id y12mr10006534qvl.23.1610677765953;
        Thu, 14 Jan 2021 18:29:25 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:d2a9:3030:291b:4b4])
        by smtp.gmail.com with ESMTPSA id y13sm4426804qkb.17.2021.01.14.18.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 18:29:25 -0800 (PST)
From:   Taylor Blau <ttaylorr@github.com>
X-Google-Original-From: Taylor Blau <me@ttaylorr.com>
Date:   Thu, 14 Jan 2021 21:29:23 -0500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, dstolee@microsoft.com, jrnieder@gmail.com
Subject: Re: [PATCH v2 15/20] for_each_object_in_pack(): convert to new
 revindex API
Message-ID: <YAD983DhrWGGBMAQ@nand.local>
References: <cover.1610129796.git.me@ttaylorr.com>
 <cover.1610576604.git.me@ttaylorr.com>
 <e7574763513294b71071b032d5cd3aa0976969dd.1610576604.git.me@ttaylorr.com>
 <xmqq8s8wyq5i.fsf@gitster.c.googlers.com>
 <YACcoNY/SiEbBSgh@coredump.intra.peff.net>
 <YAClXle+utN/VnVZ@coredump.intra.peff.net>
 <YACmcG4bNugX3WfK@nand.local>
 <xmqqo8hruef3.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo8hruef3.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 14, 2021 at 06:22:56PM -0800, Junio C Hamano wrote:
> > Much appreciated. This looks good to me (and I have no opinion whether
> > it is picked up on top, or squashed into patch 15).
> >
> >   Acked-by: Taylor Blau <me@ttaylorr.com>
>
> OK, so I'll make this 21/20 and rebase the other one...

I'm happy if you want to apply this separately on top of both series,
since I think we all agree that this isn't strictly necessary to go
forward.

That said, if you do make this 21/20 and the rebase of the second series
requires any intervention, please let me know and I'll be happy to send
out a version myself.

In the meantime, I don't mind if you want to eject the latter topic from
seen while it picks up review. The alternative (keeping it in and
rebasing it forward), of course, is much appreciated.


Thanks,
Taylor
