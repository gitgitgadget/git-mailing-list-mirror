Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC91C54FCB
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 23:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E47A20781
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 23:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="StkUlLUz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgDXXOM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 19:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgDXXOL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 19:14:11 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3985C09B049
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 16:14:09 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id o15so5372034pgi.1
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 16:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+iKjbzHCiTXqCMleIyTqdg2kf21QswuqMC4VAxayalA=;
        b=StkUlLUzUFRvpJy3OQWBZG2EkjTX0+CSYoNbgUIBYeIgeypMGwi4CArCGybcfuZoJx
         wCzeE3kDnKY4nLkj+ImP3kek1iHqpaB+X2vNc+8q+4GvUoY1ObAOb1XRcyqrkX29p0SK
         KahbzmSB27knqp/k9rD0jtvxqIkNtxRn20c+0X+znNhzrE7P6Mv/2MSc0WVSiiecbglV
         Qq4Ua1mAkErHFkqEXq84stAnEYVMGunZh+MNunsPZrX3NmcQe7uaLxS0xqYEmKA/PIEO
         SngYVtBC4y9hHKa2t62c6vei5nLeB1l/PgaubkVtBQxQeSIZSRZ2/Zz+9OsHtrBqaNgW
         0luA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+iKjbzHCiTXqCMleIyTqdg2kf21QswuqMC4VAxayalA=;
        b=AuWVAxjFHco6B8wuecf1Uptv66oMbWsT/7hxzekPCC7R0lNBVekoTdWsjG9nz8PQv2
         sGIoeaQtJPvpmA8O2jDXIIsV5214D/pprQEAPFT7+hvWmfiq4D5qrkrvGQsJxKa3jixf
         xJG8cw/hYswoSg7soMMar/crZKWes1Y7T/dQZVGuGEf0PSy8BBvtVxut6cqll7nBXK1W
         i9r1LvAcbmphDtAlJUvwx3zTBEf7q4rW5GO+09h0Wzp9quElJ6xmiqMl04zfHwQZoEIO
         TAkWuzyoNn7efCTPZrJF37hDkeKDLMxBZrf8ON6gwevboUTJSUf/mZ71BNQzBgwTsT+m
         r3iw==
X-Gm-Message-State: AGi0PuYecJvrTs8Wt88+i7FMMMbcUbzGjJeEKYQtodgE0Lj93STgrYm6
        nIZHerj4yo7Xsz8mBN+beENyhQ==
X-Google-Smtp-Source: APiQypK8Er6JPawScn1RXtflU1XAVhlS/eJ1Z0+mif1m0kzf0GDPVZFfFu5sMeMQfGn5zBcZ3SG7qw==
X-Received: by 2002:a63:5009:: with SMTP id e9mr10985131pgb.381.1587770048382;
        Fri, 24 Apr 2020 16:14:08 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id c10sm5833368pgh.48.2020.04.24.16.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 16:14:07 -0700 (PDT)
Date:   Fri, 24 Apr 2020 16:14:03 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH] doc: propose hooks managed by the config
Message-ID: <20200424231403.GD236872@google.com>
References: <20191210023335.49987-1-emilyshaffer@google.com>
 <20200420235310.94493-1-emilyshaffer@google.com>
 <20200421002248.GC236872@google.com>
 <xmqqh7xdprcv.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh7xdprcv.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 20, 2020 at 06:20:00PM -0700, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > Whoops, just realized this doesn't match the proposal below. Wrote these
> > on different days :)
> 
> It often is a good idea to attempt writing anything in one sitting
> for coherency, and proofread the result on a separate day before
> sending it out ;-)

Agreed for next time :)

I didn't make it very clear in my initial comment that the only problem
here is the code snippets and the difference is very minor - I don't
think it's worth a reroll on its own without hearing feedback about the
rest. Or, to put it another way, if any interested reader said "I'll
wait to review" - don't ;)

 - Emily
