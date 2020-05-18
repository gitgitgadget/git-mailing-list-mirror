Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B1BC433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 09:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87B2A20643
	for <git@archiver.kernel.org>; Mon, 18 May 2020 09:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNOmms4i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgERJJD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 05:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgERJJC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 05:09:02 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876F7C061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 02:09:01 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id n22so5004696qtv.12
        for <git@vger.kernel.org>; Mon, 18 May 2020 02:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j9f0ABJ3OLRR3JWbzm+zX2jJtmsnL7jSaW0yiS2M4+A=;
        b=HNOmms4ith4x3+FeRzLqMNPiHls8ZmdMobhRLGloEkBmd8g7iiQIatGHcXqLWBHB3L
         tqPipQckCNQ/TIRL+suJpqQ+ynXeWAwjr3DSZshxJ/jrzSS88eqzyRulyK7xFHAGi8Uv
         DzDvArxhUphxnI59Dd39JTZaXKhMVnI0UQr9aUZY1Dn45XoFC9Gw/A6uU29UUn7avSk8
         HjxetwcSZXiPpvyE0p6tbbXNtr5cuAgnR2oZsWadKa1673oA3v9vF9IyMOscc0+HsU/A
         2tDOlyK1NAyLwL8Aq5ea1TSHc4SaBqCfTYETDIAiplpZqxNxEmzAk0a/XPXOZiKbsqfK
         +x3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j9f0ABJ3OLRR3JWbzm+zX2jJtmsnL7jSaW0yiS2M4+A=;
        b=RLb5Zqeh314Q5JAZlsk/UH1TtCJrzlzEdTjCvBZyxz4iM3ggXjLpIP4DiaZGNiGDWB
         PTucCVdJ43gpKd7wBXQSon7tlWeLbn6/09re+WLl19VqmPys0IGifZRpTlUQK5Ifcn+W
         3Tsc8JcYIUszWZkheSgExGxgjEcpAbt/O6Uq0e6wEDRW/mcZ0EIa0CXr9Rok1F8OTHNu
         lp5lb6OeXBobbGGvLooTsPoiPbN8Wur6UhMN2d043BVjFQzPzUG5KIUsx+uPEILI3nUw
         41mkwNHmFRSM7+phQLCZVcBJL7woeM/mViifLQYeeQ7p/TiBW4uwuEMs57dkMHWOwgQz
         lONQ==
X-Gm-Message-State: AOAM530TGKbWv8QWptxUh4lUC13/s72uDbqi9iNra2EFr72j3KOp8+VW
        w6S6hAM/ZgW/ngKqS6xI833MQ2zE
X-Google-Smtp-Source: ABdhPJxE7m0b49deVocNqSTfIFK/AfvouieibTEYG46qU/fg7KiSn7tWpVSE4Cizl5+ybQ1gneULfA==
X-Received: by 2002:ac8:6f5a:: with SMTP id n26mr8453671qtv.303.1589792940798;
        Mon, 18 May 2020 02:09:00 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id c3sm5778202qtp.24.2020.05.18.02.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 02:08:59 -0700 (PDT)
Date:   Mon, 18 May 2020 05:08:57 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 5/6] remote-curl: error on incomplete packet
Message-ID: <20200518090857.GA24557@generichostname>
References: <cover.1589393036.git.liu.denton@gmail.com>
 <3ed7cf87aaa40ee66b20aa929d89d28fefcec312.1589393036.git.liu.denton@gmail.com>
 <20200515213844.GD115445@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515213844.GD115445@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, May 15, 2020 at 05:38:44PM -0400, Jeff King wrote:
> On Wed, May 13, 2020 at 02:04:57PM -0400, Denton Liu wrote:
> 
> > Currently, remote-curl acts as a proxy and blindly forwards packets
> > between an HTTP server and fetch-pack. In the case of a stateless RPC
> > connection where the connection is terminated with a partially written
> > packet, remote-curl will blindly send the partially written packet
> > before waiting on more input from fetch-pack. Meanwhile, fetch-pack will
> > read the partial packet and continue reading, expecting more input. This
> > results in a deadlock between the two processes.
> > 
> > Instead of blindly forwarding packets, inspect each packet to ensure
> > that it is a full packet, erroring out if a partial packet is sent.
> 
> Hmm. Right now there's no assumption in rpc_in that we're writing
> pktlines. Will this always be the case?
> 
> I think the answer is probably yes. If there's a case where it isn't, it
> might be something like v0 git-over-http against a server which doesn't
> have the sideband capability.

As far as I can tell from skimming the code, v0 uses always pktlines
although I'm far from being an expert on Git's networking stuff. Perhaps
we could implement this such that the line-length checking only happens
for stateless_connect()?
