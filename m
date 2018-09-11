Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C8941F404
	for <e@80x24.org>; Tue, 11 Sep 2018 04:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbeIKJ0p (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 05:26:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32798 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbeIKJ0p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 05:26:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id s7-v6so11580251pgc.0
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 21:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iGPX+OJRfxuo4VLSim1xNPpGDcWT/xeo3agr5Lvv0Jw=;
        b=swN91IkeFzm8DNjQG4x1hg+x2KsC61Nx2Jym04cONsFmjNqk8fClkt3vzR3KEx0Qyf
         d+GBt74LLVe42RHjkkQVOwDJq/4ww8kUnYVBq3oG2X8T7spYjC102qQefwVaiJm57WH8
         VnpgWwnr03Tz2kYF9umoORGQDi9DftOabWbAwUdzcn2qwoWkp81cHgjtmF+ucZZ9ImD6
         kfQSIMukezNnlbwDi98u0CMQTTQZeDmv1ZmkarY/9wyUg1Gou/hTD+X7WIm8acGYl+HS
         j3KpCRPtlJ5AdN1aKtAbcKMt/Dpv6a0oHBywK2u1Ck6TCFvO9CNq3osOs5gW7u690dKG
         9TwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iGPX+OJRfxuo4VLSim1xNPpGDcWT/xeo3agr5Lvv0Jw=;
        b=g/QGQr3Xhtji9JF0gUgK5BeZanbH7+2ToZ2kxreJKPyIP8hqrIMOsDKcmRF+//qi6n
         7VkdaX3IXI7vS98iO87dfoA7fcPhbMU7qFfBrgvY3v7Oh4cx0RDCVl+UpDI1FPjJg6O7
         Wfb0sMoVNpONMycBRFlJ5eUOyZSgC6wVK4SOT2ACSrdZMdeXKMb5wv+sbVUs7cCq84ul
         j5pQT50BG71S/wWKjxREmAh0ojnJi89zVuq38Ew3tMS//uSXhKnk9Fndw/bb5E5CIQvN
         iEobMUAAXN67Mx8t9tXrpxbTHZaOmPnz7BkVGRbgEuz3UZQJXTif5NalomqyYN7WZRK0
         or9Q==
X-Gm-Message-State: APzg51BVSv85fR/j5GPSn2lSIr85fKr0o+GGFgDrdegTfm4h28cao2fX
        3oOasljsy16I9sJDKCUCYrg=
X-Google-Smtp-Source: ANB0Vdb0gDAGCQNdG0gCP6MLQEMKvR39zFaTPb168EDwYC+UZ0vZ8GYYcg3IwwbTWLJFWogu1EADvA==
X-Received: by 2002:a63:3642:: with SMTP id d63-v6mr25686698pga.231.1536640162349;
        Mon, 10 Sep 2018 21:29:22 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id a192-v6sm28537339pfa.124.2018.09.10.21.29.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 21:29:21 -0700 (PDT)
Date:   Mon, 10 Sep 2018 21:29:19 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Max Kirillov <max@max630.net>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Jelmer =?utf-8?Q?Vernoo=C4=B3?= <jelmer@jelmer.uk>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>
Subject: Re: [PATCH] http-backend: treat empty CONTENT_LENGTH as zero
Message-ID: <20180911042919.GE20518@aiede.svl.corp.google.com>
References: <20180910052558.GB55941@aiede.svl.corp.google.com>
 <20180910205359.32332-1-max@max630.net>
 <20180911034227.GB20518@aiede.svl.corp.google.com>
 <xmqqo9d4r7j2.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo9d4r7j2.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> RFC 3875 (the CGI specification) explains:
>>
>>    The CONTENT_LENGTH variable contains the size of the message-body
>>    attached to the request, if any, in decimal number of octets.  If no
>>    data is attached, then NULL (or unset).
[...]
>> But that specification was written before HTTP/1.1 and chunked
>> encoding.
>
> RFC 3875 is from October 2004, while RFC 2616 (HTTP/1.1) is from
> June 1999; I presume that 3875 only writes down what has already
> been an established practice and that is where the date discrepancy
> comes from.

Yes, CGI 1.1 is from 1995.  More details are at
https://www.w3.org/CGI/.

[...]
>> Fortunately, there's a way out.  Use the HTTP_TRANSFER_ENCODING
>> environment variable to distinguish the two cases.
>
> Cute.
>
> I'm anxious to learn how well this works in practice. Or is this a
> trick you know somebody else's system already uses (in which case,
> that's wonderful)?

Alas, I came up with it today so I don't know yet how well it will
work in practice.

I can poke around a little tomorrow in Apache to sanity-check the
approach.  Results from anyone able to test using various HTTP servers
(lighttpd, etc) would also be very welcome.

Thanks,
Jonathan
