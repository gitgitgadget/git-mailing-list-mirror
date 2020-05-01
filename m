Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D18C4724C
	for <git@archiver.kernel.org>; Fri,  1 May 2020 13:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 068E520708
	for <git@archiver.kernel.org>; Fri,  1 May 2020 13:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4MODxTA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbgEAN6C (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 09:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729368AbgEAN6A (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 1 May 2020 09:58:00 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAECCC061A0C
        for <git@vger.kernel.org>; Fri,  1 May 2020 06:58:00 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mq3so2326904pjb.1
        for <git@vger.kernel.org>; Fri, 01 May 2020 06:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=849EmoMMWPR8YLYtjxTxRe38B6v2ukSbLEbYW3JbtAw=;
        b=k4MODxTAGvSuTuW87iADxGw7/Jv+mZTPr+6jeWd2GkMafhylKpMTcdHIgyL3F0wiG6
         M1KP9hEdPopN1gy93j8IpnA8fgVCwEDLMzpocuuRMCBPlKu9aQy3HHbL/ua9FVMxtIIq
         ksvpZvFKgpMzqUeTStrVU0JIcmP9JLKlx5riZdY+FpHmlqRkUIAnXCbDzwmeWvbW5/fF
         wvblNZapNzVXh1qoiiCkej0pLJm3Qwo6vR+M4R1pZofkTqWHWHwKuSN3OhWmL/IlXiID
         LN61riJB5FYOSVGFfQ6h+E2wt+aoZv0FnzqU4b1AfyN8P/TFgYfXLCUqWq7c3brPoB6Q
         OC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=849EmoMMWPR8YLYtjxTxRe38B6v2ukSbLEbYW3JbtAw=;
        b=By81RRtxX+0cpgdxLaaHoyq0//YL8jnBa6rFqNor9SC5/Ssq3Q5KH2ITZ3INU/hdJa
         I/Nb36qsURkndtBeDA3GXys7AJXfEmLzQQ4BH0+AuLXCTI3hKXB/C+3ryK4ViVztYK63
         F1NMzua4tBM/DxmTPrfUnZwjg+yLJWrUNavY+oWUQ3gT5xgvs9G8ICpiDFDWVeOActlN
         xFKmj7ED1Dk2dJzhui8NuTZJPMO6KlXgmfZEO7+VOk0NPS2xankiD1yzfFybUFG+J7sg
         Kbl0sJFDXzYO9bkic7giuRcFV3boDfdjTj6487Swi902er90bMskxkdQL8XFjBLarZhx
         dZ9A==
X-Gm-Message-State: AGi0Pub57HkRHgGIEUlydJ/jtQ50V2EXyNnFiOBt2+BB/M1/xGESawKq
        HL1X+DslGy/Um0S9Q6I2LpE=
X-Google-Smtp-Source: APiQypK/OWADKPd9UJ6NgXUR51ZeG2kimoTM7tn/WKkJZeHaiW2CSfJRDGPmtu4mexSeLrXv9f3AKA==
X-Received: by 2002:a17:90a:f313:: with SMTP id ca19mr4704658pjb.7.1588341480088;
        Fri, 01 May 2020 06:58:00 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id d2sm2408152pfc.7.2020.05.01.06.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 06:57:59 -0700 (PDT)
Date:   Fri, 1 May 2020 06:57:57 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, jrnieder@gmail.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v9] credential-store: warn instead of fatal for bogus
 lines from store
Message-ID: <20200501135757.GF33264@Carlos-MBP>
References: <20200430011959.70597-1-carenas@gmail.com>
 <20200430160642.90096-1-carenas@gmail.com>
 <xmqq1ro4sp1p.fsf@gitster.c.googlers.com>
 <20200501003041.GD33264@Carlos-MBP>
 <xmqqimhgph3z.fsf@gitster.c.googlers.com>
 <CAPUEspiD10bYsCDoHM6PJdidyofNadJL0bexjiNNZCXNU+Ay_Q@mail.gmail.com>
 <xmqqees4p6mb.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqees4p6mb.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 30, 2020 at 10:27:24PM -0700, Junio C Hamano wrote:
> Carlo Arenas <carenas@gmail.com> writes:
> 
> > PS. should we really do the warn even in store/erase operations as a
> > followup or is the warning not useful as is, and probably then all
> > operations should be quiet (as Jonathan suggested originally?) and we
> > could do warn (and maybe fix) in a different change (maybe adding a
> > fsck command of sorts)?
> 
> Yeah, I think I like the "no warning, just ignore" much better.  The
> implementation I suspect would become a lot simpler, right?

sure, it will be basically the version that Jonathan suggested[1] on
top of yours and that I included in v4 but that was missing a SOB.

Jonathan,

would you want to submit it formally?, IMHO better if with base (from pu): 
272281efcc (credential-store: document the file format a bit more, 2020-04-27)

it might be still worth including some of the test cases, so I could do it
instead too; but let me know what would be your preference otherwise, as they
will need to be wrapped, probably better than on what became my confusing
attempt to save everyone's time with the v4 series[2], and that was made
obsolete by Junio's creation of jc/credential-store-file-format-doc.

Carlo

[1] https://lore.kernel.org/git/20200428052510.GA201501@google.com/
[2] https://lore.kernel.org/git/20200428104858.28573-1-carenas@gmail.com/

CC: trim to avoid spam, probably long overdue
