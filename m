Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BBE61F597
	for <e@80x24.org>; Thu,  2 Aug 2018 02:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbeHBEOy (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 00:14:54 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38258 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725745AbeHBEOy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 00:14:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id k3-v6so354736pgq.5
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 19:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YIkAsRprDdEA8mLp7QNgd0LgW/VG74TjbJMgyghEenk=;
        b=gqEl0v9sI/D/cwbEcENoeOthMZIFX8oUuSwn/a7Y+fJM30q3JPcVc5iQohA9C2N1Ro
         xGgzWle8+j87alRua1zDRC/oAZROwO00CORlZxgNddhUITa1MG2CERycTgtSnRAGMNpN
         QaitRSamzDN7PAExskfjqpOxehvGwKMpft8jYccSZ0jUNCGK9BXvzLZ1sWlni/mFWKrs
         LQDAxxoH2MNjR5vyQ+l5jM66xIYLWJdwJxueqBD4pq0g4fcN+qq2vjxE9C840qqLnSvd
         Y7jGtbBsJbAwVs3/WdvOc6zsx4SZ+lrt7NmzARRMEJ9mxcfRS2nTVIJM0Lu6K77oGhQR
         zTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YIkAsRprDdEA8mLp7QNgd0LgW/VG74TjbJMgyghEenk=;
        b=S4XDu3+499nX8xVAFOWmr3KfMGolkMoSGdfsDbzvloOw6W6r0vzqQvyuW3NwPBuRPp
         jzXcHpFJ0wHfKNs6v8yMUtq9wEXNeEh+s9wbTgDOagysv9/XK598KmkyMtexYhPjCNZ0
         r67/FqwBFvb6l0UrkXhVtvYPXEqBHSOIP05KlhYEQLz4p+3Dzon0W/Jk622OxFvbb9Gf
         znCipZ8exQkKajysWPN97YXtwRJAl0jZCSchfF7ftrXAV/yXL0gE6gAkuAkrdK6FYGNw
         BdPSl/lOJ03AkRM7UfhOe8Nf6pHORB+9/mK7BGB55/hbwOlpdtKcxM97+acY80lZooSi
         497g==
X-Gm-Message-State: AOUpUlFEJmFRMQ2ZwomBn+2p7Fp82OfJP2pzmd7+S4UpZ03qrL9MbVGt
        nq6hOTpnSp25PPL5nJviv7Y=
X-Google-Smtp-Source: AAOMgpc3btHdNOtJGbWKhARjTFj2a7nDAC79/OAA0VL8VW500aOKb8Q54kBRqnVcBncD6u+wvyJykg==
X-Received: by 2002:a63:27c1:: with SMTP id n184-v6mr785159pgn.29.1533176765642;
        Wed, 01 Aug 2018 19:26:05 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id c12-v6sm677967pfl.20.2018.08.01.19.26.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 19:26:05 -0700 (PDT)
Date:   Wed, 1 Aug 2018 19:26:03 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v2] remote: make refspec follow the same disambiguation
 rule as local refs
Message-ID: <20180802022603.GE189024@aiede.svl.corp.google.com>
References: <xmqq8t5q821c.fsf@gitster-ct.c.googlers.com>
 <20180801230802.GC189024@aiede.svl.corp.google.com>
 <xmqqo9el4ige.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo9el4ige.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> One thing I forgot to mention.
>
> When asking to fetch T, in order to be able to favor refs/tags/T
> over refs/heads/T at the fetching end, you would have to be able to
> *see* both, so all 6 variants "T", "refs/tags/T", "refs/heads/T",
> "refs/remotes/T", "refs/remotes/T/HEAD" must be asked to be shown
> when the ls-remote limiting is in effect.  Since the ls-remote
> filtering is relatively new development, we may further find subtle
> remaining bugs, if there still are some.

Fortunately, the fetch code does already do that. ;-)

Jonathan
