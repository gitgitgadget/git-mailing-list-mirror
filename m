Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8B1C83004
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 22:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7780D208E0
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 22:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Dnn2sk4U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgD2WQQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 18:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726481AbgD2WQP (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 18:16:15 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526B5C03C1AE
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 15:16:14 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n16so1695439pgb.7
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 15:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Uty8Tqqz+VsKemZqeVlu3pPfo15gxEQNvFaMQR9YkRs=;
        b=Dnn2sk4UGMm6d383+b8TPYBb/PxeWpuRADPQ5wwxh8v9xo2OC6yljDAhmpC5Us6aRI
         BuOup7a8+rMUvhIhXjMlBGdfC6+evs4BaH01Ue9NtR0NN7/lm+zpzdIcdTg+I/i7NydJ
         /5z5bq7cNfoymeqndwPytqJ9Rif8k6TqT1dcc0lB5t7kXHpeFxOFm8v2wEEOFeIBpauc
         hr1xb1I4WV1JAHWS5ifKdSejYVya/8VD/q+0beQjpH0B3e0p4JkdhBPfNphzPWOc+Nvs
         V22mX52z0KnpvEWlpQMzU0YyWJer+xh6SqDtlhTHAWh+53sYsWS1gqyMwbKJ0FHf1s9R
         L/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uty8Tqqz+VsKemZqeVlu3pPfo15gxEQNvFaMQR9YkRs=;
        b=VZB+T2IQ3ssCaVlD2ftIptqeHrbNp129cVhUqIQtw29A/Hpg3srnlN0SWAYLHoF42l
         7mi0rUntKaimvorhwmzIBWZuMuX4ROB/M5jf70VbxD1aj4BaK9oX0a07132P1/KBnrl+
         NsCaCRb8yhlAl5RXE0OrCgLaIt/pajFfmqj/mQLPod5+7MeIgkZUi6MGNClHKbG1h1qO
         vvQMygcLAt2VyzMY2yiJC2I7y4VWaDmX6fUduH7dcix4/D2k3/jSq2PJQ+tnnTDaDEas
         gkhAQAog5+SJgrWSaB0rqP1w/azitY1MVF4pwfksiGz9QbLranUOL1wib58T9xLGoNlm
         rBSg==
X-Gm-Message-State: AGi0PuaV0zm5D7jlBmEvTDEYqgcyQdwhEOAN6BK9iNLfxl+Q7053cvbY
        cPRsdK87wHoziM2PjdyD8YtCoQ==
X-Google-Smtp-Source: APiQypKVMIwccJ8gi4cQYYcJCAG7+kVIC3eLuFSNoeiaSEvnCEh+A0fV4I6prG2PbkG4GEUpU7CDBA==
X-Received: by 2002:a63:b649:: with SMTP id v9mr301282pgt.402.1588198573618;
        Wed, 29 Apr 2020 15:16:13 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id b16sm1827935pfp.89.2020.04.29.15.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 15:16:12 -0700 (PDT)
Date:   Wed, 29 Apr 2020 16:16:11 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Johannes Sixt <j6t@kdbg.org>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Re* [PATCH 0/4] t: replace incorrect test_must_fail usage (part
 5)
Message-ID: <20200429221611.GA12776@syl.local>
References: <cover.1588162842.git.liu.denton@gmail.com>
 <20200429195035.GB3920@syl.local>
 <90edb162-e035-bdb7-a2d2-ffc6bd075977@kdbg.org>
 <xmqqblnaufyt.fsf_-_@gitster.c.googlers.com>
 <20200429214906.GA12075@syl.local>
 <xmqqy2qet02d.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy2qet02d.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 29, 2020 at 03:10:50PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > To me this seems a little overkill, but it may not be on environments
> > where an extra subshell incurred by 'test_might_fail' might be overly
> > expensive.
>
> It comes from the same principle as "we are not in the business of
> catching segv from system tools---don't use test_must_fail on
> non-git commands".  Adopting the convention happened quite some time
> ago and that was why I checked if we failed to document it.
>
> What I wondered was if it is overkill to document the convention; if
> the convention was overkill is not a question at this point.

Ah, fair enough. Thanks for a patient explanation.

Thanks,
Taylor
