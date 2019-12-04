Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8D4C2D0BE
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 20:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CD782077B
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 20:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RWE6FLR5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfLDUx7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 15:53:59 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:46912 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbfLDUx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 15:53:58 -0500
Received: by mail-pf1-f201.google.com with SMTP id w127so340354pfb.13
        for <git@vger.kernel.org>; Wed, 04 Dec 2019 12:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SgMHx46+e0E7cUSFbwnvlEUjSY0R/am2qWZCDKiDh+s=;
        b=RWE6FLR5xajkWJPtkisBs0iwE5jP8sg8jJhXUrtX5AwwUNyHfexh9D04i53Qg29jeL
         1ZkRX07ruU0rtCotkEvG+QdVNPriXWbDwzKxeOj5k1Tn3XygxzZl1JYpUulxjaRFk5mE
         J4lolAfZWXsgG73D8khGzXmzMrBHTwCsUtJwtcK+eRD30ugOAvQ0+12E0xuIvdDgcK5K
         t9eBfGOx6VWkRuOb4waJZcitDNyvvdLK9eYXOCtpVYpsmNCDZpKhyNK17XZolX9Ikc2F
         LsjmMwPfkU0oEIokUOR8VJXTMEr9yEx1MC4BuMufrlcGMAbKL/vJdyDKL4ogNX9Rh5nA
         j86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SgMHx46+e0E7cUSFbwnvlEUjSY0R/am2qWZCDKiDh+s=;
        b=X4U3nOvnzTJMwU65mGvsPqmQXo8QmE5tRPLlZwdZBOE48xCxdRA6BIonF31bPiXKzc
         hHMCPE2zmqVqrMXfN9Ic6x/N9plMqT3fQQ9G6sODAT+hFyyh+8jUTIIHBUoKargKQURx
         4Bx9DCqmi+C+kOhVE327o2wQDaLazuvOiLK3dScH8UkkUEulBLYMbXFPqRhEp95oGQ3n
         S7b1LBQHWrIstsn5+c1THetn78UIOeulE6UkG3s92UWHzPJoPl1c/laiuMQHjEU1tbeB
         wuUh/7zw53x2w3jbeKNlejQOXmeJMSIl1I20Ny7nkEYtHQw6YUlj9LPwqgDn2Yf/TEPf
         Iq3g==
X-Gm-Message-State: APjAAAU2EocV3H8IS5vhaSB67uJ0W16DycYpJl4cqvZ2ceYwEdGEeyBC
        REX4BgzwwkVSJT0xsNmmq0PzIfJvILGRoFp8AgAU
X-Google-Smtp-Source: APXvYqyjrGfCf06RIrN6yfTT3vkIJOtCaTwaobR04yOsfHyuw6eumeHxZLBFpfVz37P0M7MZjILLv8lnvUa2a7liPG7u
X-Received: by 2002:a63:ec03:: with SMTP id j3mr5716216pgh.212.1575492838039;
 Wed, 04 Dec 2019 12:53:58 -0800 (PST)
Date:   Wed,  4 Dec 2019 12:53:53 -0800
In-Reply-To: <20191203232007.GA30535@sigill.intra.peff.net>
Message-Id: <20191204205353.118168-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20191203232007.GA30535@sigill.intra.peff.net>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: Re: [PATCH] send-pack: use OBJECT_INFO_QUICK to check negative objects
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     gitster@pobox.com, pamarlie@cisco.com, jonathantanmy@google.com,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Sat, Nov 30, 2019 at 09:08:32AM -0800, Junio C Hamano wrote:
> 
> > > Interestingly, upload-pack does not use OBJECT_INFO_QUICK when it's
> > > getting oids from the other side. But I think it could possibly benefit
> > > in the same way. Nobody seems to have noticed. Perhaps it simply comes
> > > up less, as servers would tend to have more objects than their clients?
> > 
> > Makes me wonder how many times we wre bitten by the fact that
> > INFO_SKIP_FETCH_OBJECT does not imply INFO_QUICK.  Perhaps most of
> > the users of INFO_SKIP_FETCH_OBJECT wants to use INFO_FOR_PREFETCH?
> 
> We seem to be discussing this about once a month lately. :)
> 
> There's some good digging by Jonathan in:
> 
>   https://public-inbox.org/git/20191011220822.154063-1-jonathantanmy@google.com/
> 
> That thread is also about this exact same spot, which is why I cc'd him
> originally.
> 
> I do tend to think that QUICK ought to imply SKIP_FETCH. I'm slightly
> negative on sprinkling FOR_PREFETCH everywhere, because the name implies
> to me that we are telling object_info() that we are pre-fetching. Which
> yes, has the effect we want, but I think is misleading. So we'd want to
> change the name of the combined flag, I think, or just let QUICK imply
> SKIP_FETCH and use that more thoroughly.

If we want to make QUICK imply SKIP_FETCH but not the other way around, then
note that we'll have to make sure that we do not repeat the error that
31f5256c82 ("sha1-file: split OBJECT_INFO_FOR_PREFETCH", 2019-05-28) fixes.

As for whether we should do it in the first place, I think that having 2
orthogonal flags is clearer than having 1 that controls fetch
(SKIP_FETCH) and 1 that does both (QUICK) without any that recheck
packed, but I'm quite familiar with this part of the code, so perhaps
I'm the wrong person to ask - we should optimize for the typical Git
developer who just wants to access the object store. Judging from the
frequency in which we encounter this issue (as Peff says), maybe we
should go ahead and make QUICK imply SKIP_FETCH but not the other way
around. (It is also possible just to make both imply the other and unify
QUICK and SKIP_FETCH into one flag - I am not opposed to that - although
read my email that Peff linked to see why bidirectional implication is
correct in one sense but incorrect in another.)
