Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B686201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 22:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933785AbdBVWgR (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 17:36:17 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33338 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933660AbdBVWfN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 17:35:13 -0500
Received: by mail-pg0-f66.google.com with SMTP id 5so2139231pgj.0
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 14:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xc/OkXH9WATmKjZlQuAYeBUHFz5mEUTX5hDlf98Vmms=;
        b=OJwhSCuL8ByCTt3GA6lPJNw7gZJEBiscAHMbMXrCsP2849CTd8t81uRXxTCxAqRCil
         zDX1v8HNXJCkJN7YLjoRb5io5woe0vw2B3r1oVmhwAD+X0ngpkL+7bFOe6kxtfyZfq/N
         as2pHjsYXAP5L7J2KbbQn56Lt0wVzfSifvz5DIBVLVqeR46o5JhPeFC0v9DDCrJdl1Pk
         3XcvjwX0IeaB3Vu/ZmwRyfHJ3G5ytmj7+S1wOYRyrIPdm8EKhKjs4GBwTlLqFNVyyAXO
         058KLs5sxL8ZtMDy5u7tBfafY6y1wNI9/lkmXam9Y8YjHVWz2hFEneRNzU9wFlp5Ssc/
         Fe0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xc/OkXH9WATmKjZlQuAYeBUHFz5mEUTX5hDlf98Vmms=;
        b=U3RyFfCn9vhYSlQfbXE/rZmTQb6QUxqq87QHfdFETu7vxfBKE8atQOrYE4dtXgZmui
         1nWv+1+74vwLEzadT6uscN0A/agDNSBT64c07LIFbRnWifMFpV9ujZGngaxSLAnzv9jJ
         2Kd7cZJ0HxEhUa5+ergFf/IGlpWOCmoGIs+3HdQThi7ZAFz1hxOqJSFPcjKlBrtlewtG
         6V17c+L1mQoe7wlbW6ODNUyvDHnEE3IzT7K8slOBiX7kyeGDv5DZt+7l9RFPL1pwJNE+
         JizHS8lDgBcqraSs+caII2/kB2Lsma+oiadw8S5J33ZG9uT5eJ1At/AdPbe72pGCTqaH
         GnpQ==
X-Gm-Message-State: AMke39k81qeO6frUz05Tr8nPVqgyDTmykDWfZkB/4+0a4tnWgHKh51AOBjesVPd5CkgpFw==
X-Received: by 10.84.213.16 with SMTP id f16mr51432923pli.156.1487802912755;
        Wed, 22 Feb 2017 14:35:12 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:21a0:716b:e013:d129])
        by smtp.gmail.com with ESMTPSA id 202sm5523937pfa.6.2017.02.22.14.35.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Feb 2017 14:35:11 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     David Turner <dturner@twosigma.com>, git@vger.kernel.org,
        sandals@crustytoothpaste.net,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] http(s): automatically try NTLM authentication first
References: <20170222173936.25016-1-dturner@twosigma.com>
        <xmqqpoiaasgj.fsf@gitster.mtv.corp.google.com>
        <20170222210636.k2ps3qhhpiyyv6cp@sigill.intra.peff.net>
        <xmqq4lzlc408.fsf@gitster.mtv.corp.google.com>
        <20170222213542.opunuepfmj557zyr@sigill.intra.peff.net>
        <xmqqwpchanxz.fsf@gitster.mtv.corp.google.com>
        <20170222215833.d7htyo32ptfse5l4@sigill.intra.peff.net>
Date:   Wed, 22 Feb 2017 14:35:11 -0800
In-Reply-To: <20170222215833.d7htyo32ptfse5l4@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 22 Feb 2017 16:58:33 -0500")
Message-ID: <xmqqshn5am74.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Feb 22, 2017 at 01:57:28PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > On Wed, Feb 22, 2017 at 01:25:11PM -0800, Junio C Hamano wrote:
>> >> 
>> >> Thanks for your thoughts.  I'd think that we should take this change
>> >> and leave the optimization for later, then.  It's not like the
>> >> change of the default is making the normal situation any worse, it
>> >> seems.
>> >
>> > I'm not excited that it will start making known bogus-username requests
>> > by default to servers which do not even support Negotiate. I guess that
>> > is really the server-operators problem, but it feels pretty hacky.
>> 
>> I guess that's another valid concern.  The servers used to be able
>> to say "Ah, this repository needs auth and this request does not, so
>> reject it without asking the auth-db".  Now it must say "Ah, this
>> repository needs auth and this request does have one, but it is
>> empty so let's not even bother the auth-db" in order to reject a
>> useless "empty-auth" request with the same efficiency.
>> 
>> After the first request without auth (that fails), do we learn
>> anything useful from the server side (like "it knows Negotiate")
>> that we can use to flip the "empty-auth" bit to give a better
>> default to people from both worlds, I wonder...?
>
> Yes, that's exactly what I was trying to say in my first message.

I see.  I am still inclined to take this as-is for now to cook in
'next', though.  

A solution along your line would help Negotiate users OOB experience
without hurting the servers that do not offer Negotiate, but until
that materializes, users can set the lazier http.emptyAuth on
(without selectively setting http.<host>.emptyAuth off for sites
without Negotiate) and hurt the servers by throwing an empty auth
anyway regardless of the default, so the flipping of the default is
not fundamentally adding more harm in that sense.
