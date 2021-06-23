Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E479BC2B9F4
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 01:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDB4961358
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 01:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhFWByv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 21:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhFWByu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 21:54:50 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF119C061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 18:52:33 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id b14so1381403iow.13
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 18:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vOEsMW4OBvxwdCZKr4Y8RmE5+sUnyC+Kx3qprTCga2Q=;
        b=xHfBDX5A/6w2wczUhx3J8V7WnsKzXo7jy6gANPEZh9cvWhqDpVMZnUaXMo7NaSUNxl
         hZ0lrqV23kqZkKFCRDL8d8J2FFet1b3Tk/UuWBQME3w0YZ+hEf6RGNiPndqSypiW/XQ/
         cWxmyWPRjUvl4vSEY3MOddA+ffkP5PumECaDJK/36QuJPBUHreWY/SRAp2Jhyupg5Dgz
         Rt8zm9garF+0vMj6VjYXdUtbDFf30mnYdfriGRzmN+9VZUhx4/U/AIvmddRWJ6+79C5a
         m68oEdQ5icGibUyFx1YVk6sWCGUoeTTdmFiZbp2AuDYD6+Z9YLWfIiiCaUzLVwkw2dDZ
         3ZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vOEsMW4OBvxwdCZKr4Y8RmE5+sUnyC+Kx3qprTCga2Q=;
        b=B718a7h6obJGGCbJhnZgoRcSyaTjydm7QUy73NtF/+wx+5RyyuvEDyfYT6gHLgrlMQ
         8iexKl6SgziFkgPCWep8YrwSakEE2RMOGMbV0i9+mvWbP0hsxWIdVCKVvvWsEj4qEPLM
         kw7DAZVGiIfYp4LVLzOtpRCNKB4OZkfFw0YKN6Cei3urb6Tso/upK4WktuMsVKQC3QMc
         ZsvY9FFkYcpcgIb/13th+UfHBE5S36yDRQ5z3NFTQYgtemefamSJVeuBmyMAWWD6yqqd
         sDWpELnlDKvNYpEZUbvzQeBgQwpHM9d/2ZsGEoLmqM2ZY8ldVy3V/g7jJ/0FVEf51yGd
         xh6g==
X-Gm-Message-State: AOAM5312qq0wwVRfI1Rb6WfHAK/bpefXw9WMGiQ6Mn37lQbo3hz+pg6K
        I7T+H4ZOnMlsd88ukgS8l8WfCQ==
X-Google-Smtp-Source: ABdhPJxcaYNhdW9DHyMlblFBEtXAP8+izIBn6hkmmSFgvEuak32ujN5lChB+kgxcGDz6sdftbbPoXQ==
X-Received: by 2002:a02:9f8a:: with SMTP id a10mr6822854jam.136.1624413153477;
        Tue, 22 Jun 2021 18:52:33 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:827b:778a:e73b:3ade])
        by smtp.gmail.com with ESMTPSA id o10sm8712615ilc.75.2021.06.22.18.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 18:52:33 -0700 (PDT)
Date:   Tue, 22 Jun 2021 21:52:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 6/7] [RFC] entry: don't show "Filtering content: ...
 done." line in case of errors
Message-ID: <YNKT4Fr/LOGnx9/o@nand.local>
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
 <20210620200303.2328957-7-szeder.dev@gmail.com>
 <85ff4cb1-f3e3-4fcb-d9d8-fd294e0df451@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85ff4cb1-f3e3-4fcb-d9d8-fd294e0df451@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 21, 2021 at 08:32:56PM +0200, René Scharfe wrote:
> Am 20.06.21 um 22:03 schrieb SZEDER Gábor:
> > RFC!!  Alas, not calling stop_progress() on error has drawbacks:
> >
> >   - All memory allocated for the progress bar is leaked.
> >   - This progress line remains "active", in the sense that if we were
> >     to start a new progress later in the same git process, then with
> >     GIT_TEST_CHECK_PROGRESS it would trigger the other BUG() catching
> >     nested/overlapping progresses.
> >
> > Do we care?!  TBH I don't :)
> > Anyway, if we do, then we might need some sort of an abort_progress()
> > function...
>
> I think the abort_progress() idea makes sense; to clean up allocations,
> tell the user what happened and avoid the BUG().  Showing just
> "aborted" instead of "done" should suffice here -- the explanation is
> given a few lines later ("'foo' was not filtered properly").

Very well put. I concur that having an abort_progress() API makes sense
for all of the reasons that you suggest, but also because we shouldn't
encourage not using what seems like an appropriate API in order to not
fail tests when GIT_TEST_CHECK_PROGRESS is set.

Thanks,
Taylor
