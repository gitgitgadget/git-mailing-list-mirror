Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2521FC43331
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 20:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB18620714
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 20:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="juMajXuY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgCWUP2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 16:15:28 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37888 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgCWUP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 16:15:27 -0400
Received: by mail-pl1-f194.google.com with SMTP id w3so6400054plz.5
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 13:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=aQWiKfTzRir3HBr3xeY1OwZ29cDbJ8cwISQB11slghk=;
        b=juMajXuY5KgQJTYeGtK3udR941mjsDy0o8Im0ARXcJg7oPOBSxd2wO7hQNUnWnok+K
         xsOn5o35WA96v94Jblqkz98BVaP0jwv+1bZsNt/g4B8T4GRkqjZYJQLANouOQZBqxLya
         8Xj/MoR8n4Rqa1loZAkT+UeDTLcuBYBWD7fQxKcVoVGIuDUvyRHCT5lmc0J9YA5g/RLA
         /wHiDGHRFuZj7nTKGECIy7Vz9P+hCy+K5jGNhLMUm/UhhSzReOWa01aatG21NT1jWD7Q
         BB36vopVfKA1ltd/0laQdXOZMfFp7ZofVztRlnZN4TgUv85EjbJQABP7WevYpaTqiA4e
         dNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=aQWiKfTzRir3HBr3xeY1OwZ29cDbJ8cwISQB11slghk=;
        b=THtvdtleoHvtNFlHbdo2H75Qa0VnMAVx8M86+brOYL/pSrUHGQmlxL1/j+POiYOBKI
         SlFXRale5tJPQAe7J8mG7Tc0FoSy98bzcIS1uUc3gmDtzjk9c+gu/zeqUzp6tqpy9fXD
         9xNaSDOAxzzCrlwPMlEtWcYZc72dF31RrleaiwOYFpa66gJcB44QiXIWLGejOM2txQ/g
         LZV7eVNsDYZBrJiq067v8MYIXP5ZOBidrIfWRjel8X4n5mB+Gr8cA33X1//bWEjTRGX5
         7jNsmh+pKzpi56BfYuidGr+vUv3bnVeZZhtMAauC+OV/oHPyUbrneyZYci98V60vnLxq
         3uIA==
X-Gm-Message-State: ANhLgQ3vZzMO234dauCsdJmtBsl772xvw/H/8W+mm9rX+DOJP9KzVJoO
        F35hBIfIcfvvznOzs5H97o30JA==
X-Google-Smtp-Source: ADFU+vu8NOh369SbMmY1s9fBij9DK7KpFHy8xJk/WaQ8F767LpcBWjfXzS2skW0Nf+l18xIKUN28bQ==
X-Received: by 2002:a17:90a:5a42:: with SMTP id m2mr1110396pji.165.1584994526562;
        Mon, 23 Mar 2020 13:15:26 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id y131sm14326385pfb.78.2020.03.23.13.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 13:15:25 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Mon, 23 Mar 2020 14:15:25 -0600
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, dstolee@microsoft.com
Subject: Re: [PATCH 1/1] commit-graph.c: avoid unnecessary tag dereference
 when merging
Message-ID: <20200323201525.GA98905@syl.local>
References: <cover.1584762087.git.me@ttaylorr.com>
 <4c79a9ea909ebff8c0987bcf95692da92e79bda4.1584762087.git.me@ttaylorr.com>
 <20200321050025.GA1438317@coredump.intra.peff.net>
 <20200321061141.GA30636@syl.local>
 <20200321070333.GB1441446@coredump.intra.peff.net>
 <20200321172716.GA39461@syl.local>
 <20200322053635.GA578498@coredump.intra.peff.net>
 <20200322110424.GC2224@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200322110424.GC2224@szeder.dev>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 22, 2020 at 12:04:24PM +0100, SZEDER Gábor wrote:
> On Sun, Mar 22, 2020 at 01:36:35AM -0400, Jeff King wrote:
> > The "--input=none" option
> > isn't "no input"; it's actually "take all existing graphed objects as
> > input" (i.e., it implies --append). So each of those objects will
> > already have been examined in an earlier stage.
>
> Yeah, we discussed it earlier that '--input=none' doesn't properly
> describe what it tries to accomplish, and suggested '--input=exists'
> (or was it 'existing'?) instead.

Good idea. I don't remember discussing '--input=exist{s,ing}',
specifically, but I do think that '--input=none' is not as clear as it
could be.

I sent [1], which I think may be a step in the right direction. I'll
look forward to your thoughts.

> > > Where the last step is taking all commits listed in any pack, which is
> > > cheap to iterate.
> >
> > I'm not sure it's all that cheap. It has to find the type of every
> > object in every pack. And finding types involves walking delta chains.
>
> Indeed, that's just about the most expensive way to find all commits,
> in my experience it can be well over a magnitude slower than
> '--reachable'.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/e0f42a2f3c0162a5d43bb2bce0f69264b59f92e9.1584994172.git.me@ttaylorr.com/
