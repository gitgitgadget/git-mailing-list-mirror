Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BC9D2018F
	for <e@80x24.org>; Tue, 19 Jul 2016 19:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708AbcGSTxw (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 15:53:52 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36123 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbcGSTxv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 15:53:51 -0400
Received: by mail-pa0-f65.google.com with SMTP id ez1so1847150pab.3
        for <git@vger.kernel.org>; Tue, 19 Jul 2016 12:53:51 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8AHHj17uXvV6TDWGgN8vSD5ft84GRXKk2KwRj//tfg8=;
        b=hpzap+Hx+0iQwVtM55NpGOqo1FI+TUPCx+tKJCL27bV2Ok+z8NgpyXN+/uGvZ06BYM
         1dKQY8LAiU0l4fwyb7LRrrIXBAxKfPq1YNX4XXZZwE1wDnovBT6Hf3jyPrxYwi1btnsH
         ZKrK87HpYcJHj1jwFG10lHktIIqBdLU/4dMMqrGJArMe7h4ODKUMbwOU3jGbXacUSt12
         9G0nO8UmsPJZL6Cyvp64C1prnQqClug86wk0TBxzdJm+/oANZETNBijdUKcJ5BMh4scc
         +o4gslWXtDZ1iKlNR4G1JIDz2QjzImD/m86knG/nkEDIJJxWT4dO4STemNe7eAvrD6C2
         Fu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8AHHj17uXvV6TDWGgN8vSD5ft84GRXKk2KwRj//tfg8=;
        b=XKYz0jGlA7vQZo2TxQ/FyV23sBcZ6hSeLCpUPbglA2Q3TShTEIBzWAqOXZsYVzN3Fk
         gdyKB07D2c0MAW/txMS3GFQUM8z4pEFShCcATgrOAvJVQ4YaK5fcqfg6x54ZhfvCVKmh
         ukJ0OL3x2OHLgDwjOSmNns3mDZa8ZTQOq0JCYFPVo7tc/zzhgjywP9ssw6VBZ7pIDqZy
         O+1opR2BiOhA56affNui1FAgHons39Czvv/AhMw8IL/zXDmExsdm1A0bZN+nWOXMtN+3
         3fZ1WHcFqyDEWWrcDdJqk4XkW0VX2DqLOIFPQFukg6UxH66L6lyBh+W74E6GOG7kummR
         gi0A==
X-Gm-Message-State: ALyK8tKBgUny5d0lYs/8JQ5mFzSoyen4BhXrnhBtSgFufchziaN3vOcOrEz/F7bhYhHGLw==
X-Received: by 10.66.254.102 with SMTP id ah6mr69311595pad.59.1468958030569;
        Tue, 19 Jul 2016 12:53:50 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:1490:ebec:2572:a3af])
        by smtp.gmail.com with ESMTPSA id u72sm464383pfa.31.2016.07.19.12.53.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 19 Jul 2016 12:53:49 -0700 (PDT)
Date:	Tue, 19 Jul 2016 12:53:47 -0700
From:	Jonathan Nieder <jrnieder@gmail.com>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jonathan Tan <jonathantanmy@google.com>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v2] fetch-pack: grow stateless RPC windows exponentially
Message-ID: <20160719195347.GF29326@google.com>
References: <xmqq37n6iq7d.fsf@gitster.mtv.corp.google.com>
 <1468880498-30235-1-git-send-email-jonathantanmy@google.com>
 <CAGZ79kY+2PYx9oz9tvi0zG-oE6qS-Za7D3ocY1XtqcSsDchz0Q@mail.gmail.com>
 <CAGf8dgL3t7uX7yAux0xc2QMJJdmnM0262Quj4o6gDehwA+4JqQ@mail.gmail.com>
 <xmqq8twxfn4j.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8twxfn4j.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano wrote:

> Even if it is conservative, I wonder if it is truly a good idea to
> make it exponentially grow forever from that point of view.  Would
> it give essentially the same result to you if we discard the patch
> in question and just raise LARGE_FLUSH to 10k instead?

I don't think it would be essentially the same result.  As discussed
before, unlike the bidi (ssh:// and git:// protocols) case, linear
growth is expensive in the stateless-rpc (https://) case --- each
round of negotiation requires re-sending the existing 'have's and
requires the peer repeatedly processing this increasingly large list
of 'have's.

For comparison, in the bidi case, linear growth of next_flush means
sending a bounded number of 'have's per round and is quite sensible.

In the stateless-rpc case, linear growth means getting a bounded
number of 'have's worth of benefit (new 'have's) in each round, in
exchange for a linearly increasing cost (existing 'have's).  That is a
high cost for limited benefit.  Exponential growth is a better deal.

Jonathan
