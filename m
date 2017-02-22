Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DFF5201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 21:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933658AbdBVV0e (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 16:26:34 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35697 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933406AbdBVV0c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 16:26:32 -0500
Received: by mail-pg0-f66.google.com with SMTP id 1so1938457pgz.2
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 13:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=eRG2ICxYxjqjrhmwMv0N1l2NPJak5AyCF0wAim+1ENE=;
        b=nfJiGQx0Lenk+RQyGBp0586zEwJ3C2A40kD6rysJHU+vTJfeXmEwgnK52cRAuaCATO
         iEOlVgfpVWoiFjZBbDIOZjIe+PTnxeEh0ETeMwEKIZmxDC2azhMuf074l8R8fRS73hT5
         b3o8a6vTJVCHtpahAZZml3C8RWRsjOSyTgByZfuO/RSlAtxqge2CY6nH/wl2d28p7yd3
         F9N8BvefcHnezPoJPx9/T7LuwKQ99qig8SRniSY86wgetsMgFrqBKkxlAcYcvEB1nu38
         BoIUY+j+u5F7ddKY3gHlJfOYRKAFi5RfdqPdlbSO4wbwjTJ4aoOIqJPduC+TmjFkPw5O
         hLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=eRG2ICxYxjqjrhmwMv0N1l2NPJak5AyCF0wAim+1ENE=;
        b=WB79ei/44JUnD5z+DGh17NByYz3pGroLS4CaT6UCN2J+oF95WK9sh3j4u3S9kdq0T5
         sB3AV8FjTswklFsGvu2Kd8o7/remvmSHY2x2+6bXJ+u9cLcX8gWkfk+hUEbSUY9TLore
         ayTBFQVdWGNLVK1WGDZfV6qVTCfLSxMpyoPicEypXdK/IdcVVJdJuGnmgQgrulxR9j5m
         C6gOWADLhOOOTGxLXwsT816rahBpN0EvpGcglwiBMdY0UlFyCXCGV+BN5LXi7loQqNsF
         ghpSXdlsrVcZD8kGLPFlKf8vGKRu6L+mBFIp4Q1sqF9m/SCbAg9WqnUE8ohl5revuGAn
         ILoA==
X-Gm-Message-State: AMke39khefn0KpBJFbfaHw1gnN3D+Kd4i6RW/NwOmXEKbQY/2HiSzm+FypiZt6Fd7fXGbw==
X-Received: by 10.99.98.195 with SMTP id w186mr10221518pgb.223.1487798712558;
        Wed, 22 Feb 2017 13:25:12 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:21a0:716b:e013:d129])
        by smtp.gmail.com with ESMTPSA id n70sm5391417pfg.34.2017.02.22.13.25.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Feb 2017 13:25:11 -0800 (PST)
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
Date:   Wed, 22 Feb 2017 13:25:11 -0800
In-Reply-To: <20170222210636.k2ps3qhhpiyyv6cp@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 22 Feb 2017 16:06:36 -0500")
Message-ID: <xmqq4lzlc408.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I don't think it incurs an extra round-trip now, because of the way
> libcurl works. Though I think it _does_ make it harder for curl to later
> optimize out that extra round-trip.
> ...
> In the current trace, you can see that libcurl insists on making a
> second auth-less request after we've fed it credentials. I'm not sure
> how to get rid of this useless extra round-trip, but it would be nice to
> do so (IIRC, it is a probe request to find out the list of auth types
> that the server supports, which are not remembered from the previous
> request).
> ...
> With http.emptyauth, the second round-trip _isn't_ useless. It's trying
> to send the empty credential.
> 
> So while curl isn't currently optimizing out the second call, I think
> http.emptyauth makes it harder to do the right thing.
> ...
> I think that would keep it to 2 round-trips for the normal "Basic" case,
> as well as for the GSSNegotiate case. It would be 3 requests when the
> server offers GSSNegotiate but you can't use it (but you could set
> http.emptyauth=false to optimize that out).

Thanks for your thoughts.  I'd think that we should take this change
and leave the optimization for later, then.  It's not like the
change of the default is making the normal situation any worse, it
seems.


