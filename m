Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCB2C38A30
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 04:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8348206EC
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 04:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVKo0sXT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbgDVEBE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 00:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725355AbgDVEBD (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Apr 2020 00:01:03 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EB3C061BD3
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 21:01:02 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id r4so433987pgg.4
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 21:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z9Gy4yPMEtYk7lu4fbm+YjAsAtqF4fxke1KdopR82ZY=;
        b=GVKo0sXT6UYvlIi51PMQX1NnVTC86uUvanQB+E/Ojarxo1m2u036/X3WT9o4n7TyZI
         MhpqMZAcsYCP6/EZBN9ehRGcNQRK2finmgeX9IlMz+cJDk48g1kMOgKDIi8opFdM5aU7
         aal5cBFLUvXbPmTJXMoyYpr4wr2TNIVpKvqAA7KO815LKcBQdVnz9m0zUFO6xOYCJ3Ii
         XHndbLHXDRo7XRoHBYM2IvVuI9q+O77ylXIijrxJsgAYlsRrIFayM3CQxMaku4xMuu6x
         ++xuFnyfNvLS/CJw7XiafEaBITVcM48DYXiLwPEvAV9s2APJ0PVBTaMboUIVuhq1HrGK
         5SWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z9Gy4yPMEtYk7lu4fbm+YjAsAtqF4fxke1KdopR82ZY=;
        b=TxxWvFeffoRf00bi0cTNOphZa9alWWCjn53V+68gE1xvr9Bz1jCLq8WLlzw+ezw/of
         fYilPCaEiRX+J+of28pBOlb0T1L6gDGh2TQOQqhK1lXj14mgqmPh+N8/TF4vLSfTPgbK
         /29QTyvjI7c0sHA+ynpAbh4tyBWt7KLgGpx3VHKKF8jdZY4VZfVWOS7xdKpgV38KwW8D
         ywMAhKsqGoPnPFsG9SM5zsZ3G51/+8cZhTjOGDJKtsMQHl5+1hcz6NQTtxjZbR5NTJri
         J/dGHqBfjN2tDb4BybdPvIgU7ZPT6pqvevvvjxferW4g8z095GvSZhnXlAye+XNQpPVK
         6I1A==
X-Gm-Message-State: AGi0PuYYnxf2BYiova6YDz3e954DvoSQI0lPzgSVBsRlQCMqL4i1nWvI
        qJC9NFnYsXU8zRVH4cWeB2k=
X-Google-Smtp-Source: APiQypIT80yIDFwx8lzGAwhxkhFozPB7OLIpK2tZn7F74pDToh+ymYeGjv72bZmVGUKffrT01K9l3w==
X-Received: by 2002:a62:13:: with SMTP id 19mr20316444pfa.64.1587528061609;
        Tue, 21 Apr 2020 21:01:01 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id a19sm4066920pfd.91.2020.04.21.21.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 21:01:00 -0700 (PDT)
Date:   Tue, 21 Apr 2020 21:00:58 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Junio C Hamano' <gitster@pobox.com>,
        'Shourya Shukla' <shouryashukla.oo@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        'Derrick Stolee' <dstolee@microsoft.com>,
        'Elijah Newren' <newren@gmail.com>,
        'Christian Couder' <christian.couder@gmail.com>
Subject: Re: [PATCH v3 3/4] gitfaq: shallow cloning a repository
Message-ID: <20200422040058.GB200999@google.com>
References: <20200421131223.29337-1-shouryashukla.oo@gmail.com>
 <20200421131223.29337-4-shouryashukla.oo@gmail.com>
 <xmqqy2qomwwl.fsf@gitster.c.googlers.com>
 <011001d6181d$97301fc0$c5905f40$@nexbridge.com>
 <9142ccdb-6359-4936-e621-55eab980b7cd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9142ccdb-6359-4936-e621-55eab980b7cd@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee wrote:

> Of course, with the speedups from reachability bitmaps, it is sometimes
> _faster_ to do a partial clone than a shallow clone. (It definitely takes
> less time in the "counting objects" phase, and the cost of downloading
> all commits and trees might be small enough on top of the necessary blob
> data to keep the total cost under a shallow clone. Your mileage may vary.)
> Because the cost of a partial clone is "comparable" to shallow clone, I
> would almost recommend partial clone over shallow clones 95% of the time,
> even in scenarios like automated builds on cloud-hosted VMs.

By the way, an idea for the interested (#leftoverbits?):

It would be possible to emulate the shallow clone experience making
use of the partial clone protocol.  That is, fetch a full history
without blobs but record the "shallows" somewhere and make user-facing
traversals like "git log" stop there (similar to the effect "git
replace" has on user-facing traversals).  Then later fetches would be
able to take advantage of the full commit history, but scripts and
muscle memory (e.g., the assumption that most commands will never
contact the remote) that assume a shallow clone would continue to
work.

Would that be useful or interesting to people?

Thanks,
Jonathan
