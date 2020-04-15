Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9F8C2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 22:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 636452076D
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 22:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GkWzRX/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbgDOWtB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 18:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgDOWs7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 18:48:59 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6C1C061A0C
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 15:48:58 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id i3so678969pgk.1
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 15:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NEJoI5eWuMtmBOKENDv+Z+vrxwX/iX3XErVPFUQAWDE=;
        b=GkWzRX/k8ww65BJMEW8eovB+gjH0Z7ueu9gTJaZhMma/+Hk7nRTJxE1xAInNqgNqRw
         PNu2kOcVONNHS2JEpoVivHsRbYmaebg//kSc6qWyOq3c0YeTXatHlo9DoNfWkkd8suqa
         uvutx4KcXjUs9SB4k/XADib3sOlwyfQPgg3pPuEoOG5lFORa5gt9+VI2w5JJe4L7BQR2
         3yjsIfAqLTqimSeAuxiUx0jsO8TfyyDNoI44vFE2lk+Wuf0nYzqkrkudd3FxaTFaB+jG
         zz+N97Q6dDaEyLvolvRW5o3G/o7pf9pj/wpAAbX2qyNWkAEHIcQpQkgNp7EYZTuw6U76
         gCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NEJoI5eWuMtmBOKENDv+Z+vrxwX/iX3XErVPFUQAWDE=;
        b=fW28qnPfJn1sp6CP3DXGVSlZozQzgRSm7mI0C4fZVFVS8HRE1AzZ7CEdM2ADX+BoPm
         BI89KaWWN+ra62OyKsgar91W/efuGCslqSroWNVSXBfmE293RIxpHBuTHqdby/xrMMKw
         h8cRXSey+WSqjdrtIXJmDvRgr4zAODb5JHtblO3c187H9XqAJ3RZfcSwD608BGQu9M2n
         fOBPxMqspSI0B/v9eQ8tQpqETL6J/HXNeczGPenzVag+wnJesomCj9ZWLL1JnPM3Jt9h
         A/cj7YPOHoR/VYld6CO/3vQ0J1g9TXmcnz+wScSHJgRGq4y4yxzENEHl2ttx/qVtGNem
         4FzA==
X-Gm-Message-State: AGi0PuYhzpUhfMRO6ilsWMfiDt2tCeBKscv5nFhPVxvhBik6Jm6JDt47
        hGksqpqEQLFJgsccMUaKaxN+WQ==
X-Google-Smtp-Source: APiQypJCH9+GTi2wqjBQwDD3LrkaIvtwUTNBbUK5EsildVDVJNfHy3wm2/XY7Kwz73aZ8N1/VzqKuw==
X-Received: by 2002:a63:4f06:: with SMTP id d6mr9279682pgb.280.1586990937146;
        Wed, 15 Apr 2020 15:48:57 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id r24sm11091497pfh.1.2020.04.15.15.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 15:48:56 -0700 (PDT)
Date:   Wed, 15 Apr 2020 15:48:52 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>, git@vger.kernel.org
Subject: Re: [TOPIC 2/17] Hooks in the future
Message-ID: <20200415224852.GC24777@google.com>
References: <0D7F1872-7614-46D6-BB55-6FEAA79F1FE6@jramsay.com.au>
 <20200312141628.GL212281@google.com>
 <xmqqeetwcf4k.fsf@gitster.c.googlers.com>
 <20200407230132.GD137962@google.com>
 <20200407235116.GE137962@google.com>
 <20200410213146.GA2075494@coredump.intra.peff.net>
 <20200413191515.GA5478@google.com>
 <20200413215256.GA18990@coredump.intra.peff.net>
 <20200415034550.GB36683@google.com>
 <20200415224244.GB3595509@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415224244.GB3595509@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 15, 2020 at 06:42:44PM -0400, Jeff King wrote:
> 
> On Tue, Apr 14, 2020 at 08:45:50PM -0700, Jonathan Nieder wrote:
> > >>> And it doesn't leave a lot of room for defining
> > >>> per-hook-type options; you have to make new keys like pre-push-order
> > >>> (though that does work because the hook names are a finite set that
> > >>> conforms to our config key names).
> > 
> > Exactly: field names like prePushOrder should work okay, even if
> > they're a bit noisy.
> 
> A side note:
> 
> Here you've done a custom munging of pre-push into prePush. I'm fine
> with that, but would we ever want to allow third-party scripts to define
> their own hooks using this mechanism? E.g., if there's a git-hooks
> command could I run "git hooks run foo" to run the foo hook? If so, then
> it might be simpler to just use the name as-is rather than defining the
> exact munging rules.

I did envision that kind of thing, or at very least something like
`git hook --list --porcelain foo | xargs -n 1 sh -c`. When I saw
Jonathan's suggestion I wondered if using the hookname as is (pre-push)
was not idiomatic to the config, and maybe I should change it. But I
would rather leave it identical to the hookname, personally.

 - Emily
