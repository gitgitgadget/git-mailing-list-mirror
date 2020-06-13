Return-Path: <SRS0=iF2w=72=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF4BC433E0
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 14:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5628C2078A
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 14:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dje1XeAd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgFMOjg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 10:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbgFMOjf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jun 2020 10:39:35 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47A8C03E96F
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 07:39:34 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id g28so11799082qkl.0
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 07:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wmonBU8nxoZpJx8gEf62N60GEB8pDlEZIcymsbNNLqY=;
        b=Dje1XeAdK3PzcObfYebI7Z4UBg6hzoV/tTPFj8oZtzG6BnaYiuWFkA4UYuf3QpOjQ9
         L6WjUvrhXKfY1MNg7zBS0g+txqZ6NlRrXbSIvOuxrNGH1FrjM4ifMp/LGuEZFgYOtWDT
         TvalztQ5GGooNFiWIcy44LJCB1Z4s07+fFozGpBpZERP3eL+VtsOYyO2UyAzfS0U1wVj
         nBXS6gENkzaBZ1YoqunEvk+saGNHSZj0iMW5O4gBLQ59ArbsjkUdqVWbtv/K9I+OkkNh
         /T0VE75i66iS1xx2JBpCRk02Ykeh+OTlE0RSfrapsoSdAfWrLetA9AQ+bKO1NbysDe5L
         IXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wmonBU8nxoZpJx8gEf62N60GEB8pDlEZIcymsbNNLqY=;
        b=ZoolJgv6MLzSadeX2uug9l5jfnKfCR84JEnB6ZKLaJuk6srdfiCvmalMVZsMSmNkOz
         TtzzhecisPICHb2QcHVI/+XkmA18kp31c+0zn+z1j2AJhQw/ezpUg0cFbreMyWy7WEVk
         fahqytjWtaWRpbSH7x5eNzhwpL012AWNo+RNuTdfXcsnAhtqJuOG3gc6playd+VQkwY0
         krP8HjtWG2zra6y4NYnwsAjtq84TKjOytli96PJsMsby3C0qYHT+ii69wqc+xR6MKolZ
         hw9Zh2A6fqWqcGLlUJBWVssRswtTnbUpc81FkWyjOajdouySqvzJyZCJxd5ngteELFdM
         oMkQ==
X-Gm-Message-State: AOAM533xbEvvrQL5otInhQ7ysoJJp0UeIugeEsaT+lTfTRDzjtmudhCJ
        3gEiQHXr2dJ980YM9CqqORGgBV5WjZ0=
X-Google-Smtp-Source: ABdhPJzDG4xCwmcTtJE3nRDVuoLs7bNbVJXV8O1YfbodVLjfElcpMgZMyCoA3DIkea999Xzx9hmKBQ==
X-Received: by 2002:a37:ecc:: with SMTP id 195mr7307763qko.469.1592059173931;
        Sat, 13 Jun 2020 07:39:33 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id c186sm6585793qkd.102.2020.06.13.07.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 07:39:33 -0700 (PDT)
Date:   Sat, 13 Jun 2020 10:39:31 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH] pkt-line: extract out PACKET_HEADER_SIZE
Message-ID: <20200613143931.GA730181@generichostname>
References: <7e803a2ba9458ce35c657e67323edfe4409205ec.1592055716.git.liu.denton@gmail.com>
 <20200613142306.GA4680@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200613142306.GA4680@danh.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 13, 2020 at 09:23:06PM +0700, Đoàn Trần Công Danh wrote:
> > diff --git a/pkt-line.c b/pkt-line.c
> > index 8f9bc68ee2..245a56712f 100644
> > --- a/pkt-line.c
> > +++ b/pkt-line.c
> > @@ -87,43 +87,43 @@ static void packet_trace(const char *buf, unsigned int len, int write)
> >   */
> >  void packet_flush(int fd)
> >  {
> > -	packet_trace("0000", 4, 1);
> > -	if (write_in_full(fd, "0000", 4) < 0)
> > +	packet_trace("0000", PACKET_HEADER_SIZE, 1);
> > +	if (write_in_full(fd, "0000", PACKET_HEADER_SIZE) < 0)
> 
> I think the magic number 4 is easier to follow than some macro
> PACKET_HEADER_SIZE defined elsewhere. Because reader may judge that is
> the size of "0000"
> 
> How about (this ugly code):
> 
> 	packet_trace("0000", sizeof "0000" - 1, 1);
> 	if (write_in_full(fd, "0000", sizeof "0000" - 1) < 0)

Chris Torek mentioned something similar off-list:
> This seems sensible, but at the same time, the string literals must
> have the right size.  For instance:
> 
[...the diff above...]
> 
> So if you're going to do this, it might be a good idea to replace
> the string literals "0000", "0001", etc, with defined values as well.

Between the two suggested approaches, with your approach, it's
immediately obvious what the values of the packets are but, on the other
hand, with Chris's approach, we can consolidate the "magic" string
literals together into a definition in a single-place.

In this case, the strings don't seem too magical and I think that the
people on this list are generally against over-abstracting and would
consider it more readable to leave the literals in place. (If this were
my own project, I'd take Chris's approach, though, since I try to avoid
bare literals like the plague.)
