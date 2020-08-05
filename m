Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30FCC433E4
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 19:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C00E92250E
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 19:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gR3AZMGi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgHETtI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbgHEQzk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 12:55:40 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A21DC001FC4
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 08:37:54 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id h8so24485613lfp.9
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 08:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9FfCXNwBxiE9hVGMig+HdI31Kd4rkFIzImEZG6WKSPY=;
        b=gR3AZMGi8E4JpfuzQE++Lgm5OFanz0N3iS5mFAnE69j+LppKTKCrpnHYmxBT65H551
         pK4+4OOrPPDv3Ra98jW9T/vbAclx9oDyeYtvdh1tj/aMNo0pSy+NjvVSzFt4Ad8yyTFb
         xMd124vY0UqQ9nOpwQ3Au37Ao413v1UCCfxD6AvmQ1aCUk1bTVqCHidbqLlHFdpFtqnB
         jlvtOwEiGDL4KqYpYKC4jsfyQe8+Xi60Y3AB79T0vd16G9Y+cWzMGsI0M9K9pwRNmBfB
         NIjiFj8+y+fEXdu0NHb/Z6PjQldXiZOTt4lggESotaPICW9Oo7lJtvI/ZEa+4qMhwqGh
         7DLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=9FfCXNwBxiE9hVGMig+HdI31Kd4rkFIzImEZG6WKSPY=;
        b=VJT4o0ePwVieGlx4vh0yFJIF+AdMhTyjrJxQoLC3Bbayw9VLjCzi+HeRgItuylTIvv
         baiw4wW3nRUWqfFTvmKSUKrabi7MWdiPLwb8zGV+Um2lRilPe5SA+gzqIO8PcbB9RNnO
         0vS3yrurwA9Le0xinzb7KkWHPyqevVguZEkTk7zdiu0kBh4mpMcofh/lylNO3JqqdonV
         INIYiQWPSPonpyeX8DdgBBLmDFDP4X+PAGupZhVZnqiZC/dnbnYlzLbQtelFeG+W1uzR
         lzHN1OnDmbMUxQ0Ji03gPWUGiFrlmJvlM7K0FQrqtSuGNZ9UUTR0ND0/T8iA4nP+Dqza
         vEwg==
X-Gm-Message-State: AOAM53156WCFiBHkpQvoRaN2hYncDPieS4C1j84kYvbmlA0rUIQm75Pd
        wJcPab/Zj1zP8KYXsx4FpPc=
X-Google-Smtp-Source: ABdhPJzeolBs72ZImfaeFA8VJE0CAYuCt0Y4NJ272pq9FHbrYFTXuMPADlPgaUXHi7Eo3QDYvIokSA==
X-Received: by 2002:a05:6512:3b7:: with SMTP id v23mr1892990lfp.10.1596641872972;
        Wed, 05 Aug 2020 08:37:52 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id s22sm1013805lji.122.2020.08.05.08.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 08:37:51 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
References: <20200728163617.GA2649887@coredump.intra.peff.net>
        <20200729201002.GA2989059@coredump.intra.peff.net>
        <871rku3soc.fsf@osv.gnss.ru>
        <20200731230858.GA1461090@coredump.intra.peff.net>
        <87mu3drynx.fsf@osv.gnss.ru> <xmqqsgd5rlwi.fsf@gitster.c.googlers.com>
        <87o8nrybnb.fsf@osv.gnss.ru>
        <20200803180824.GA2711830@coredump.intra.peff.net>
        <874kpi47xj.fsf@osv.gnss.ru>
        <20200804195830.GA2014743@coredump.intra.peff.net>
Date:   Wed, 05 Aug 2020 18:37:51 +0300
In-Reply-To: <20200804195830.GA2014743@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 4 Aug 2020 15:58:30 -0400")
Message-ID: <87k0ydp0hc.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Aug 04, 2020 at 08:50:16PM +0300, Sergey Organov wrote:
>
>> Attached is rather minimal incompatible change to --diff-merges that'd
>> allow extensions in the future, to get out of urge for the discussed
>> changes. I'm going to follow-up with actual improvements and I'm aware
>> it lacks documentation changes.
>
> Thanks, I like the direction here. Definitely it would need
> documentation, but also tests (probably in t4013 alongside the ones my
> series added; in fact you'd probably need to adjust my tests for the
> non-optional argument).

I turned to tests, and found that I have a doubt about the test
you've added:

git log --no-diff-merges -p --first-parent master

In modified tests, I'd like to move --no-diff-merges to the end, for the
test to be less restrictive:

git log -p --first-parent --no-diff-merges master

It should change nothing for now, but it will allow us in the future to
get rid of mutual dependencies between in -m and --first-parent in favor
of --first-parent to imply --diff-merges=1. We then will need to
override the latter by subsequent --no-diff-merges:

git log -p --first-parent [--diff-merges=1: implied] --no-diff-merges master

In this case your original test:

git log --no-diff-merges -p --first-parent [--diff-merges=1: implied] master

would fail, as implied --diff-merges=1 then wins.

Then I'm going to add a copy:

git log -p --first-parent --diff-merges=off master

to check that this form works as well.

What do you think?

Thanks,
-- Sergey
