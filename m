Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68581C433E0
	for <git@archiver.kernel.org>; Fri, 15 May 2020 17:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4490C2070A
	for <git@archiver.kernel.org>; Fri, 15 May 2020 17:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVQdPO1X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgEOROd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 13:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726144AbgEOROc (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 15 May 2020 13:14:32 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8ECFC061A0C
        for <git@vger.kernel.org>; Fri, 15 May 2020 10:14:32 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id b8so1249295pgi.11
        for <git@vger.kernel.org>; Fri, 15 May 2020 10:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MqCVj6VQyE8BzSFNqpQRhpA+I/IuFkrwGmgS0YPZHEM=;
        b=qVQdPO1XDmKGvsK/iXITS/5kBGKoiKwjoH9+nCB9YiaxqFHHqZFQa6Uo8gTpbZj/dB
         y30+bDHZlMuZSGUEZhGQFcdE4IT5RlLQCZSCe8DGJ2dLCA/+TvYEst4N5HlbJdNpv4Nx
         jo+nCtPygqXHozLnbYL8fipeWDVvqN3CfYAHtIHmQLDSQx5M+yEYaCGa3U5hybA/Cb33
         woVW8M582btjr5aj83Ge5ry0OQ1339AtitinRfdKnbY1W3npV7GnOcjaVHxA2KSef4pA
         z9xYF6j1b/7MzfsGMELdfbDgGPF6Sk4tv/ps9VugWIGRRymYx77liNDbC0FjD5kPa+TP
         dY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MqCVj6VQyE8BzSFNqpQRhpA+I/IuFkrwGmgS0YPZHEM=;
        b=AopQYDnhXrl4zM9VGVUYi6YcedTjgBVe7lDjYLaSvSMrvvn1nDtiCpFtxzc4raXinT
         86GMG9x3MyCcwiMiPA1SRUnoQRDHYFVx4S3ZG1gHjVPx5Gjslm7dL9eVc0SGgeZAOjdA
         9YMyL8o/epEVadlvBsylqT1UoKGUUFog6lb46+F9Mn6KQulxJr5fYhEt3qmnC5kyz3qO
         OxwSbW3jK2xHm3hHr3g1cqIRgGacbsTHO8ptk1bs93LDGEPjIe7QRIUQxRrN0vMEGIWk
         M90uI42TGBBkNLUy1DueJt5GkZknqasGqlFw/NXAMlUOKFw3sQd/IAqUwA0bdYH4whEp
         TYPA==
X-Gm-Message-State: AOAM531cVcbH+xJKq6NRc564MaYSpuh3I9ROho4REFBPJxhDidPauF1h
        Rd0qjmrJItLbUMshUnZYAGZjEHg3
X-Google-Smtp-Source: ABdhPJx+xQqwAbMQezAxiJdhXu2qrkuJXK8UWfdaBGTrXmRCuIksjinP3uGsIvT4FRou7KRggvevlA==
X-Received: by 2002:a63:e62:: with SMTP id 34mr3595152pgo.300.1589562871833;
        Fri, 15 May 2020 10:14:31 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id z13sm1214304pfj.153.2020.05.15.10.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 10:14:30 -0700 (PDT)
Date:   Fri, 15 May 2020 10:14:28 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org,
        congdanhqx@gmail.com, johannes.schindelin@gmx.de
Subject: Re: [RFC PATCH] t: move metadata into TAP test description
Message-ID: <20200515171428.GC61200@Carlos-MBP>
References: <5b373748-d986-1aec-670f-7ac1502e7052@gmail.com>
 <20200515150041.22873-1-carenas@gmail.com>
 <880ded78-21c6-9310-6c5e-422f6a63ad47@gmail.com>
 <20200515154539.GB61200@Carlos-MBP>
 <xmqqlfltm9b5.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlfltm9b5.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 15, 2020 at 09:50:38AM -0700, Junio C Hamano wrote:
> 
> At this late stage in the cycle, would it be a safer change to
> revert the whole thing, I wonder, rather than piling fixes on top of
> fixes to the initial breakage?
> 
> 303775a2 (t/test_lib: avoid naked bash arrays in file_lineno, 2020-05-07)
> 662f9cf1 (tests: when run in Bash, annotate test failures with file name/line number, 2020-04-11)

will also need:

  676eb0c1ce (ci: add a problem matcher for GitHub Actions, 2020-04-11)

Carlo
