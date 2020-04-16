Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C444C2BA2B
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 22:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 513FA221F7
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 22:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b00ea62Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbgDPWrP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 18:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbgDPWrO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Apr 2020 18:47:14 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9643EC061A0C
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 15:47:14 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d17so604751wrg.11
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 15:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dVe21dydQPtfSQerWN2h79Z4A6clNRwzmruE+2UQRYM=;
        b=b00ea62QYdKWH8mrUhZH0c43DyygbQFg44uA4mRS68advXQaskSipyTMSSwfgmjjTZ
         8m237rPNy4lc25r6oboVCUZrBZi0IYSb7pn6hmrPSM51MKSwFrD0xh3Lh1Q68m2OQN6d
         7sqxorlGeLRx+0OW3EtWVr+neEwEKl9W4mCHhHfcNlwKGgD+UPl+eHR1zxIQ7/EqP879
         1KOYxJYGbpZVUJq6TLEyAU+9JTQpcuZu/AG50mQagBo7wJFmBM0RwZckj88E5l8Z+FBO
         cgZEWojn1n1uwW4tLWbQDRwE2ecTkVYm5Je/mwHDNf0uQo1p/6jAYkUrxW5BttC9ss1D
         qmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dVe21dydQPtfSQerWN2h79Z4A6clNRwzmruE+2UQRYM=;
        b=LLE+RA7EcX6zbL+i/EQ8W+D5/CHTNKdkvz/HdwbWuuC4o612WcqblIy0QSxOGK7yUv
         hjZafV80f14pRo3mU6CQFbRZWJ+pV8Ma8A2CFTSSmFZnTYRjYumwk8e2STFM9fUFjoV2
         7HRLfPfLN7tFaNURe9ikbBIGJf/s1aqface3Tdh4Wc8Ha/hIZ/XBnUPKrk2uJPjISZ3T
         PU/IbEkBGuclFTQrSS6coh5VMv4mroUFh3dYhMEMj3+GgAESowNev06UU4ZpUNESb2o2
         YVZlecSrXNTWQp0g6bnKpcVJknf+2I2WtDsZp9Wa1X0VuVM70HF9tEKe1E/0fRrD03fK
         BaXg==
X-Gm-Message-State: AGi0PuZ2PJi8vb56SfKPvbcdcbb6HuZC2nz8LIS8qsxiP10d+IbV4lSr
        a2J0I5oEoEIk9SdppdL/xFzIIGdhrrs++g==
X-Google-Smtp-Source: APiQypLV3oCeycMi1Jiyxg8EdAwJW0Fc978CFSXSEemhzkGwmkX9APBVFyrCEgEK9UIUXCK00e5P8w==
X-Received: by 2002:a05:6000:128d:: with SMTP id f13mr533188wrx.241.1587077231893;
        Thu, 16 Apr 2020 15:47:11 -0700 (PDT)
Received: from doriath (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id v131sm5438239wmb.19.2020.04.16.15.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 15:47:11 -0700 (PDT)
Date:   Fri, 17 Apr 2020 00:47:08 +0200
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2020, #01; Wed, 15)
Message-ID: <20200416224708.zr4dlrz4hpaqsz2s@doriath>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Fri, 17 Apr 2020 00:36:29 +0200
References: <xmqqr1wo4alb.fsf@gitster.c.googlers.com>
 <20200416211208.xqnnrkvcl2jw3ejr@doriath>
 <20200416213009.GA1721147@coredump.intra.peff.net>
 <xmqqh7xjxeew.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqh7xjxeew.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From Junio C Hamano, Thu 16 Apr 2020 at 15:18:47 (-0700) :
> Thanks.  In any case, they already are in 'next', so please update
> incrementally.  In an early part of the development cycle of a topic, we
> tend to avoid building a topic from a horribly broken state and fix
> things up with pile of "oops, that was wrong, and here is a band-aid"
> patches, but once the patches become reviewable shape, the remaining
> "issues" tend to be the ones that are not found without careful reviewing
> and thinking things through, and it often is easier for later history
> inspection if the fixes are separate.

I am a bit confused because in next you picked both the original patch
fixing the fallback to default %(push:remoteref) behavior, and the new RFC
patch fixing triangular workflow (which has not yet been reviewed). But
your argument seems to indicate you would have preferred two separate topics.

That's indeed why the patch I sent today drops the triangular workflow
patch for now.

I think this is my fault, I should have sent the RFC patches fixing the
triangular workflow which you picked (along with the original patch
reviewed by Jeff) in a separate thread, so there were no risk of confusion
(which was increased by the fact that my cover letter for this indicated
version 4 while the patches were actually version 6).

The triangular workflow patch is not quite correct in the sense that it
does not handle (yet) all cases, but on the other hand you could argue that
this is indeed better than the current code which is always wrong in the
triangular case.

Sorry I did not catch this sooner :-(

-- 
Damien
