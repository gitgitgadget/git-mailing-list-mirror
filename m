Return-Path: <SRS0=P8cE=5O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72192C43331
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 05:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4174E2073B
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 05:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kkyl2ld/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgC2FeZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 01:34:25 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35965 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgC2FeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 01:34:25 -0400
Received: by mail-qt1-f194.google.com with SMTP id m33so12386403qtb.3
        for <git@vger.kernel.org>; Sat, 28 Mar 2020 22:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=isrc1iswxjiRsnwzvSQimTk4Fqm15v7GKvHCai8AxP4=;
        b=Kkyl2ld/oxn+FLamtHcS1r6HEXHgE4yBb2dazDW+FtN8b0cUrBQfmfLWtEMTFzdErR
         w/07sOnTRkCYPUUIcrDf8sbpSX7bh3LjGP/YSaS8MPBN+SVmxEY1H9ePZa9xje/ff2AT
         GZ65SGVnx14UdK3tflrlq92d7UxLLF+plFq+cJee1b+52UmW0v41NELFxn8/RX8+cxpr
         xQu0QqraE3o52oXwxCIVwjcRXy/6KsSeVS96EqExiJizcw4HwgdXzhr6ek39hk/nJ9b7
         HYR0JQ5hvGGOeHhUGwdr4ApnivWmhpZqlXD5kKqUIzNFxHGP0T6DKhlWyTQqVATh8qGO
         ND2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=isrc1iswxjiRsnwzvSQimTk4Fqm15v7GKvHCai8AxP4=;
        b=CWSyn27Kwux5vrMxPkLaE6LTJzjrDA50HKWEKhDwC1ZfmANbJsS7v5OT1PeGZEhhJp
         q7bT2oHbW/F7f0horRR8bn+VITiggwAGuh1nwm/RPyqJ8MZ+DOswkmT2x3i2e2t4k1wb
         Pj/mW1i5SUC6j7F0ZvY1szT4Q78I5o2sUJvQmd1IfsMJE50/EOZhWuftEU78Mxb6v5rs
         /uILn9KgQqK3HZmCCzMvRLpSngY7Z/bdJokM7rjXumZ88YyV1HEYr5SsBDHsbaPwkAEA
         uOTyspZ8MLjih9OTQi7V1Dx8o8kZAnuT9tYJ3q8PNUjyrtLendf1LlgEeH//KDHlAVYV
         oNSw==
X-Gm-Message-State: ANhLgQ34vpZe53mY6syW5DUmFuAo+fGE3STXp3hzot1Q3crpbafSO1w+
        28CvJwDr0aom/CCBIOqv6e8=
X-Google-Smtp-Source: ADFU+vsrLrzhDtHZuY1F65C7Mk+4QbYbylENHfOscKrx5eTdgn1oqzxpCp808K1YouS1yFsZ/NmVkg==
X-Received: by 2002:aed:3ec2:: with SMTP id o2mr6461630qtf.310.1585460064085;
        Sat, 28 Mar 2020 22:34:24 -0700 (PDT)
Received: from generichostname ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id q44sm8228875qtq.11.2020.03.28.22.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 22:34:23 -0700 (PDT)
Date:   Sun, 29 Mar 2020 01:34:21 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [RFC PATCH] http-backend: write error packet if backend command
 fails
Message-ID: <20200329053421.GA685115@generichostname>
References: <b5f8b81498e1d152014acab92fa1b6e9701b3a0e.1585363771.git.liu.denton@gmail.com>
 <20200328145741.GA1209174@coredump.intra.peff.net>
 <20200328151300.GA1215566@coredump.intra.peff.net>
 <20200328154936.GA1217052@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328154936.GA1217052@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Sat, Mar 28, 2020 at 11:49:36AM -0400, Jeff King wrote:
> On Sat, Mar 28, 2020 at 11:13:00AM -0400, Jeff King wrote:
> 
> > On Sat, Mar 28, 2020 at 10:57:42AM -0400, Jeff King wrote:
> > 
> > > But since it works for v1 (which also dies!), and since you were able to
> > > reproduce the problem locally, I suspect it may be an issue in
> > > upload-pack itself.
> > 
> > Actually, I think the problem is on the client side.
> > 
> > If I run your test without the http-backend change, then nothing is left
> > running on the server side, but on the client we have two processes:
> > git-clone and the git-remote-https helper. And they're deadlocked trying
> > to read from each other.
> > 
> > I think the issue is that git-remote-https in v2 mode calls into
> > stateless_connect(), and just pumps http request/response pairs from
> > git-clone to the server. But if a request generates an empty response,
> > then clone has no idea that anything was received at all. It continues
> > waiting, but remote-https has looped to expect another request from it.
> > 
> > Your patch fixes _this case_ because it causes the server to send a
> > non-empty response. But the client can't rely on that. Besides that not
> > being a documented server behavior, in the worst case the connection
> > could be severed mid-stream. So I think remote-https needs to complain
> > about an empty response. This isn't a problem in v1 because it would
> > actually try to look at that empty response; in v2 it's just proxying
> > bytes around.
> 
> Ugh, it's actually much worse than this. We dealt with the
> empty-response case in 296b847c0d (remote-curl: don't hang when a server
> dies before any output, 2016-11-18). The issue here is that we got a
> _partial_ response, and clone is waiting for the rest of it.
> 
> The server said "0011shallow-info\n" before it bailed. So from the
> perspective of git-clone, it's now waiting to read through a flush
> packet. But remote-https has nothing left to send. The root of the issue
> is that it has no way to signal to clone that it has already sent
> everything the server gave it. In non-helper code, clone would see the
> EOF. And in v1 https, I think there's some extra framing between
> remote-https and "fetch-pack --stateless-rpc" so that EOF effectively
> gets passed along. But v2's stateless_connect() strategy is
> fundamentally missing this signal, and there are probably other spots in
> the protocol that could cause similar deadlocks.
> 
> I wonder if remote-https's stateless_connect() could complain if there's
> no flush packet in the output it writes back. That would certainly fix
> this case, but I'd worry there are rpc messages that don't end in a
> flush. And it would be susceptible to data cut-offs that happened to
> look like a flush packet.
> 
> I think the robust solution is to introduce an extra level of pktline
> framing into the remote-helper stateless-connect protocol.

Thanks for doing some more investigation and correcting my faulty
analysis. I'll use this information to try and create a new patch.

-Denton

> -Peff
