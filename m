Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26C0C54EEB
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 11:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C103F20753
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 11:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtS/txoU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgCVLE2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 07:04:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33326 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbgCVLE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 07:04:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id a25so12949477wrd.0
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 04:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qmcFuNAplY8clHnQ2+SKTw72jZjWRERRiD9s2rxmtIk=;
        b=WtS/txoU803X7f3ZPJ9kH36rG3UBpV/4UlfIBKdiszWI805+01g3QnP69GV5q0Rw0g
         Mx6Wyn0+qbbiYH6jwawIH9T1+OfA5/4JQi6MrQ4WngOoOwMizn9zTCYwVttFLyPtUzE1
         Cph5upJF8iGGeN13ugm4jnuocqEd9UbyiSKq4feYM1s1kpbn+OE/VMG48m4a4kQO1K5b
         c/9X2u3ajzXIhvqj8mQ0s5uImRs8gRezkPTresdJCI/LY+cWQ/83oqFhWCxosfeAH2ub
         cNa6iP4jQYalxChoDzBV8XYO+iQYKzewhCYqtbwFlZmd0cnwxPrPBGmL/6gNm0H6/Pzs
         OOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qmcFuNAplY8clHnQ2+SKTw72jZjWRERRiD9s2rxmtIk=;
        b=QpcIo0/d5KZXv03u5El98IXp2lRyXPjWCNUD1ZEuhVSN6qxFvABk5pxGz7HsGKd8GP
         HkojUiHfzmHIFo2yrtOUefMm4+xYfctzPHOXz+8RUlX8Hjf8xF7sTFthu7u/EhWpNi/E
         JYPQBQ7otSopWWjP2u9R7L6hplRTuO+kZhgLhSR4tLyDd1s55kiHp7W6Jpmy795JYysr
         topnXJliyHQyWU/nQnQa0R/N4jiMFJrF2JZxu243FdAdxTPJDgfIxZokEZEFzsY3cJ5Z
         phv+Ev4DhWR26zpZxoJQeWAkY7ltkpQ1Tz3yTqVdT+cjfWYtn3FAMsohemQPnwoMB0gu
         eAcQ==
X-Gm-Message-State: ANhLgQ1bdZZzt8LkVSNp4rwI3JcseJ2pjgMFpN5s7H5nCknRlQSKhZgV
        LmBWNZpj6p3GMECx2f0GurM=
X-Google-Smtp-Source: ADFU+vtlPVuZY9Hj8UILYLn3a226heihpdRDZXQIy4Qt9JMj6oZMD25EyIZoyiizi7fvw+344JtvuQ==
X-Received: by 2002:a5d:55c2:: with SMTP id i2mr7084724wrw.133.1584875066535;
        Sun, 22 Mar 2020 04:04:26 -0700 (PDT)
Received: from szeder.dev (62-165-238-214.pool.digikabel.hu. [62.165.238.214])
        by smtp.gmail.com with ESMTPSA id z203sm10216224wmg.12.2020.03.22.04.04.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Mar 2020 04:04:25 -0700 (PDT)
Date:   Sun, 22 Mar 2020 12:04:24 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH 1/1] commit-graph.c: avoid unnecessary tag dereference
 when merging
Message-ID: <20200322110424.GC2224@szeder.dev>
References: <cover.1584762087.git.me@ttaylorr.com>
 <4c79a9ea909ebff8c0987bcf95692da92e79bda4.1584762087.git.me@ttaylorr.com>
 <20200321050025.GA1438317@coredump.intra.peff.net>
 <20200321061141.GA30636@syl.local>
 <20200321070333.GB1441446@coredump.intra.peff.net>
 <20200321172716.GA39461@syl.local>
 <20200322053635.GA578498@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200322053635.GA578498@coredump.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 22, 2020 at 01:36:35AM -0400, Jeff King wrote:
> The "--input=none" option
> isn't "no input"; it's actually "take all existing graphed objects as
> input" (i.e., it implies --append). So each of those objects will
> already have been examined in an earlier stage.

Yeah, we discussed it earlier that '--input=none' doesn't properly
describe what it tries to accomplish, and suggested '--input=exists'
(or was it 'existing'?) instead.

> > Where the last step is taking all commits listed in any pack, which is
> > cheap to iterate.
> 
> I'm not sure it's all that cheap. It has to find the type of every
> object in every pack. And finding types involves walking delta chains.

Indeed, that's just about the most expensive way to find all commits,
in my experience it can be well over a magnitude slower than
'--reachable'.

