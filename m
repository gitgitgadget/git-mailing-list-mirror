Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D333D1F404
	for <e@80x24.org>; Mon, 17 Sep 2018 18:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbeIRARS (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 20:17:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41852 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbeIRARS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 20:17:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id s15-v6so8084181pgv.8
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 11:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jNSlQFS4Motx4Zl4RGKjDzJsRHY2aDdLu91V73RzIFE=;
        b=bg4N8G0xc7lpAsxZBwYFvqqXJYNReY4uVYqa29gzzSSZCKDSHaH2vTINwh6yr4Go96
         GkIiBBsvbM65XJ11xE60U6qsm+3YmymWP4wXYUEgos7HgoTGYhwXsM4xXkgSYAwWQ+O1
         aj+CBovY7EtRqRBuoLdoQsD3FPqeK+YP6Xbq07Q/gwI9zeU+uuC/dY5ydimtBkZsXpEQ
         GaSZ+1LUJn+gVHnctXZWg8bXrBBxKr8X+uWkuAE9WSg/oWmEZ+fBr9vNAREUfkOBDb/H
         URTcAB/Aa989WX6esBJrrvUorVKqr7lcBLwVnxqJAwcdhjTy23GuB9UhLl8bHJIvMz7o
         OU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jNSlQFS4Motx4Zl4RGKjDzJsRHY2aDdLu91V73RzIFE=;
        b=mw6Mr/X6++o15rot3okgooc8IOcgk91vUxoHagF5K3WGmBKOpH5ZVn/xH9B/3jt1VE
         /9MfZkSmPy+65UAtq8dXOR8bGH6OA1xu16kCndkJKslrxXXxynkrw5VAtHUN98Yb5YDN
         5cnhes3IIDwLb1tVUOKQlq68n5Z6/z1v1KeiLwyrGAiymvVdfE9sVZGeJX7gt+SfHRz5
         +icHACK76/8QNvPT3PhEG05EDD0MR71z1mTHNYthU+y3tgLZuuwbRNEo+72oFIjdCmVC
         9I+s89rctQy+0x6sZV+WnsPDAKyQeiiVFqXinStpAErrXVweN5MLArn2w3bA/F995TOL
         2AnQ==
X-Gm-Message-State: APzg51D6Cx9vrdeRMygVO5EUzmqYZ05LcUSUWxOsDGK93wzdBu3fufdL
        gBHqYhX1nV0tr/7IuBv6yKfAbCaL
X-Google-Smtp-Source: ANB0VdYTbBHtI4jPeLmVpOUzfgjgqzTQzu29+jmBM8n9HJA8mQ7f/sulr14DzgUHFKVYxC9S7yXXsQ==
X-Received: by 2002:a62:1089:: with SMTP id 9-v6mr27214303pfq.30.1537210121282;
        Mon, 17 Sep 2018 11:48:41 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 6-v6sm30543539pfr.115.2018.09.17.11.48.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 11:48:40 -0700 (PDT)
Date:   Mon, 17 Sep 2018 11:48:38 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>, ryenus <ryenus@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] linear-assignment: fix potential out of bounds memory
 access
Message-ID: <20180917184838.GE140909@aiede.svl.corp.google.com>
References: <CAKkAvay6crMOJ0Vm2C9Z0ktBj9n4+RkOAiP+zuG=Sm+PVBgQ+Q@mail.gmail.com>
 <1b8a35be-4234-7f71-c0be-41736bbe60cf@gmail.com>
 <844da493-b1c1-b295-0094-beafd48f3b50@gmail.com>
 <fd241679-2283-4e01-315b-db27be8a794c@gmail.com>
 <20180911163419.GB4865@hank.intra.tgummerer.com>
 <20180911172903.GC4865@hank.intra.tgummerer.com>
 <20180912190108.GE4865@hank.intra.tgummerer.com>
 <20180913223834.GF1719@hank.intra.tgummerer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913223834.GF1719@hank.intra.tgummerer.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer wrote:

> Currently the 'compute_assignment()' function may read memory out
> of bounds, even if used correctly.  Namely this happens when we only
> have one column.
[...]
> Reported-by: ryenus <ryenus@gmail.com>
> Helped-by: Derrick Stolee <stolee@gmail.com>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  linear-assignment.c   | 6 ++++++
>  t/t3206-range-diff.sh | 5 +++++
>  2 files changed, 11 insertions(+)

Here's a bit of a non-review, but hopefully it pokes others into
doing a proper review.

I haven't carefully examined the checks you're adding here.  Your
goals seem to be right.  I've been running with this patch since last
Thursday, with no problems yet.  Thanks for writing it.

Sincerely,
Jonathan
