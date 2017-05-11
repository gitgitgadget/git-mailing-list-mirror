Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A64A8201A0
	for <e@80x24.org>; Thu, 11 May 2017 19:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934323AbdEKTE3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 15:04:29 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:32968 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933801AbdEKTE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 15:04:28 -0400
Received: by mail-pf0-f178.google.com with SMTP id e193so18195574pfh.0
        for <git@vger.kernel.org>; Thu, 11 May 2017 12:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X4GEGfCb51TLc/mlQsL90n9HAWQzH9b8Up/RzGr1cl0=;
        b=I8rKf6+gCifEcNf2OxfOHL443CGI4TjWJww29UXCGaX8D9jUc/IzBiyCooqEXhSrof
         +GRem5d+9fJ3duPXk9IJcVk+qA/GuNO7/MwPUxSh4zxKgHEDO5os8dqNMeMsl3xGVsMr
         SA7qLFL/NHk5YQBnpokJJ4fx2+EJSRd+uNDOV1HYhYAeLdQVs2evOFZ/u52dMoT+mxxL
         b3TWJkhuns2kagCGrxcYA3ZBNcN5Xu/XpIvejNttfijrXVOJbAiPAFsZYspr2m2+uAsa
         Y+BdMfgnaLZYmiQg/qdXRaboOP3yrvjR9HENWTGg5YZcduSbsnzYU6j5NBXurSqpzRt4
         M+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X4GEGfCb51TLc/mlQsL90n9HAWQzH9b8Up/RzGr1cl0=;
        b=GnNFuoZfo1Kwdi7VrwMiSMkehA5N6Wp22ylAVmfAFxQ8nEOeO2T4ePeB61mpnS+pvO
         ex+hjI03c3BvZP3HYzo3ag8d/HJfX9M6lITfjduZBW6Hsa4jjR6Ph5XzqwLmgxgPEyDa
         3i2CsOQRQJbnmJTbq65jQYNQKxo6U1fuvtxFwQQtfU5s2j+qxmGVYJ896j66mIzxe5G+
         iEMUePCH7xJvopozwttmNtvSaAeCuF2LijPjRUm9J2UKiml9ckIyjvlT9C57SO9IX9ZA
         m9QBU+rPCgzCbLTBjH0YUo6/olFd4B4KCbCpZmkreMU17WIBLUQ1uHZD7qHNA6KutLw/
         HODw==
X-Gm-Message-State: AODbwcB94qpsju/s32CN/Hq5myo0WYjnygrxLGNy3QuM6wsjLnkgH6CQ
        NZgeSXMCAvQAWg==
X-Received: by 10.98.194.215 with SMTP id w84mr66453pfk.192.1494529467853;
        Thu, 11 May 2017 12:04:27 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:ac23:a158:2bd3:569b])
        by smtp.gmail.com with ESMTPSA id n7sm1916649pfn.0.2017.05.11.12.04.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 May 2017 12:04:27 -0700 (PDT)
Date:   Thu, 11 May 2017 12:03:54 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Shawn Pearce <spearce@spearce.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH] fetch-pack: always allow fetching of literal SHA1s
Message-ID: <20170511190354.GA12516@aiede.svl.corp.google.com>
References: <20170509182042.28389-1-jonathantanmy@google.com>
 <20170509221629.3z35qcz36oiix3kh@sigill.intra.peff.net>
 <CAJo=hJvAg2WqpiuykpbHcB5vgQiHJ74CZ8Y4qudkYqZrmd30zg@mail.gmail.com>
 <20170510043343.mgb7heqzu2etcgvf@sigill.intra.peff.net>
 <20170510170044.GX28740@aiede.svl.corp.google.com>
 <20170511095925.grmyagv4hesxqprj@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170511095925.grmyagv4hesxqprj@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Wed, May 10, 2017 at 10:00:44AM -0700, Jonathan Nieder wrote:
>> Jeff King wrote:

>>> [1] The reachability checks from upload-pack don't actually do much on
>>>     GitHub, because you can generally access the objects via the API or
>>>     the web site anyway.
[...]
>> Given that, what would make me really happy is if github enables
>> uploadpack.allowAnySHA1InWant.  That would be useful for me, at least.
>
> One of my hesitations is that we've actually considered moving in the
> opposite direction. The object storage for all of the repositories in a
> network is shared, so I can fork git.git, push up malicious crap, and
> then point people to:
>
>   https://github.com/git/git/commit/$sha1
>
> and it resolves. Obviously there's a social-engineering component to any
> such attack, but it's not great. And even without security in mind, it's
> potentially confusing.
[...]
> But even leaving all the refs/pull stuff aside, allowAnySHA1InWant does
> seem to increase that confusion, and I don't see a way around it short
> of never sharing objects between repositories at all. So I think at most
> we'd do allowReachableSHA1InWant.

I had guessed you didn't want to do allowReachableSHA1InWant for
performance reasons.  (I haven't checked to what extent we are already
taking advantage of bitmaps to avoid a slow reachability check.)  If I
was wrong and allowReachableSHA1InWant is on the table then it is of
course even better. :)

Thanks,
Jonathan
