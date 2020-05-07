Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C018C38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 16:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AD792145D
	for <git@archiver.kernel.org>; Thu,  7 May 2020 16:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="xw6H2axL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgEGQmK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 12:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725949AbgEGQmJ (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 12:42:09 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AC5C05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 09:42:09 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id t11so3060547pgg.2
        for <git@vger.kernel.org>; Thu, 07 May 2020 09:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WnAuWUqZ/uFR1EktNjAnm3Za0jVmQXwiudbfKMPsIpE=;
        b=xw6H2axLorAZWhdZRA/j/RvwQ186RhxUstcJFo041BzILSmGRxeS0FT0/gnD54T6Ld
         MH1kBnAoXNoSAAzhoCB1hOG3RDxjV7xMkl3q9gpQcQf2uGhP7z6KQ0ElMEexkVdu5FMO
         tW/1g6CNm6RuIc5zd5sfQ9OZ8dIiczpLDNPvgirbRknyfMBy8c5kwNZUOHhLO8ARZqo3
         +HeTzQ1bOIOLQ6AfpPLxfhr4t2fXXV6C4MNe4y5tT+JCxpg8vVXngZS8UdTQ2Dg8w6GL
         KmOeEwxLwakmBiaFoyQddPm9UxDU4DKnUJ3L5Xv1w0XbFuXWXJ+Qd+YVFVUQlPHaoz8O
         6SoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WnAuWUqZ/uFR1EktNjAnm3Za0jVmQXwiudbfKMPsIpE=;
        b=ro8spdE+M3+y7+9vW7Rzg01ogsrrkp1K0DwbZXaGEGvXg//i78wdZrc72mp8/ca90q
         Pk1OBUJQd6mp4eHZbdNG2aEt+vKvLOOLUUN2IQIoW1aDS/FoPFK0Zt2RNm/O5x4PI4g+
         S9qi7wyrPnEDrIznjRbZPJJF1Y+wlXnhvtdfcshf7sMdzZCjCOVlgBHhSBqOHKr2pN7W
         r5Z22+YGbfovQtyFWVymX09ygw2V0raZ4VBKEAgwFDfXC5P/eXj0/zWqNoRByLVtn2tm
         v/zNwLKVh/qu07cLV3AK6NQXD99wUq4mSU36Skwf+Tm62A8XCk4CpxTWbNVbO2ebsIQ4
         mfyw==
X-Gm-Message-State: AGi0Pua2sKQ9TFZN1Rh+knCIlR9sgr+nbeSmuzWyMzuH3bU6cCCPGSTB
        Wml/zV8ZD4iW2pMEI9iZCDpTMA==
X-Google-Smtp-Source: APiQypLwA42oszjuZRAMiSQv8sWI33jrxhiD5VllChAMjWOwQPxO2PZuqmkMeaO/+hrN67VO1AayZA==
X-Received: by 2002:aa7:958f:: with SMTP id z15mr14040922pfj.10.1588869728962;
        Thu, 07 May 2020 09:42:08 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id w125sm4019898pgw.22.2020.05.07.09.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 09:42:08 -0700 (PDT)
Date:   Thu, 7 May 2020 10:42:06 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC PATCH] upload-pack: fix filter options scope
Message-ID: <20200507164206.GB26677@syl.local>
References: <20200507095829.16894-1-chriscool@tuxfamily.org>
 <20200507113624.GA3027470@coredump.intra.peff.net>
 <CAP8UFD3AqUGrE2W3Qg_+z6HnobmRpOEyNEdspmDPGggKUqyK+w@mail.gmail.com>
 <20200507144710.GA3063766@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200507144710.GA3063766@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 07, 2020 at 10:47:10AM -0400, Jeff King wrote:
> On Thu, May 07, 2020 at 02:32:39PM +0200, Christian Couder wrote:
>
> > > A client who does this is stupid and wrong (and I didn't check the
> > > protocol spec, but it could very well be violating the spec). So I don't
> > > think it's _that_ big a deal. But it would be nice if all of those
> > > globals got moved into upload_pack_data, and both v1 and v2 just used it
> > > consistently.
> >
> > Unfortunately as I discuss a bit above 'struct upload_pack_data' is
> > not used by v1, only by v2. I think making v1 use upload_pack_data
> > might be nice, but it's a separate issue. So I am tempted to just
> > improve the commit message, adding some information from you and from
> > this discussion, and then re-sending.
> >
> > Another intermediate solution would be to add filter_options to
> > 'struct upload_pack_data' for v2 and to use filter_options directly
> > for v1.
>
> I think we do want the v1 path to use upload_pack_data in the long run,
> just to keep things less confusing.
>
> But if you don't want to go that far now, I'd strongly prefer the second
> option, pushing v2 towards how we ultimately want it to look, and
> plumbing a local variable through v1 paths as necessary. Or perhaps just
> renaming the global to filter_options_v1 or something, so that v2 code
> paths aren't tempted to use it.

I would be very much in favor of that direction. Thanks for CC-ing me on
this thread, since any changes here will obviously create merge
conflicts on my end when I send the "configure allowed object filters"
patches.

> -Peff

Thanks,
Taylor
