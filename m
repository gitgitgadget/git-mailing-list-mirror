Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4E7C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 11:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbhKVMAs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 07:00:48 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:56536 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbhKVMAs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 07:00:48 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 38A4D1FCA3;
        Mon, 22 Nov 2021 11:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637582261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n+rc8G96wIXBLcjklu5AKmkTnUDChm3crGheK6copPY=;
        b=iXzIo4H8d3K3FnXNEeR+7Fr9TZCbPXdGt8HachKwexZ/e3NDJMUTDd+y9mJFflYV4LJJ3Z
        D9lQXv+P+lznldsI9+AQJMpaJkHqkQigIv6qZtWtftHvB5UA+j9EVzwhDNsB/XyHjVj+XC
        Gjk/ZkFkhXxbw6qtNVPl5gDuDkR0mF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637582261;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n+rc8G96wIXBLcjklu5AKmkTnUDChm3crGheK6copPY=;
        b=wg3yFbLPuNpuB3UWCAtK2geE2jM89n7C1ZpjfYQ0OBU5fXyBbD3lzMSVYzttNkzbIEXgpr
        Mi+1NBWI8HqA7fBw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 10AC5A3B84;
        Mon, 22 Nov 2021 11:57:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A530D1E3C6D; Mon, 22 Nov 2021 12:57:40 +0100 (CET)
Date:   Mon, 22 Nov 2021 12:57:40 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jan Kara <jack@suse.cz>, Git List <git@vger.kernel.org>
Subject: Re: Stochastic bisection support
Message-ID: <20211122115740.GA24453@quack2.suse.cz>
References: <20211118164940.8818-1-jack@suse.cz>
 <nycvar.QRO.7.76.6.2111191731400.63@tvgsbejvaqbjf.bet>
 <CAPx1GvfT36SvJ6Lwf1-2KUebVXkCkNvYTUw=FU+dHBy76VN5RQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPx1GvfT36SvJ6Lwf1-2KUebVXkCkNvYTUw=FU+dHBy76VN5RQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri 19-11-21 23:54:12, Chris Torek wrote:
> On Fri, Nov 19, 2021 at 8:51 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > An interesting problem, for sure!
> >
> > It is slightly related to a scenario that has been described to me
> > recently: in a gigantic project whose full test suite is too large to run
> > with every Pull Request, where tests are more likely to become flaky
> > rather than simply break, a stochastic CI regime was introduced where a
> > semi-random subset of the test suite is run with every CI build. That team
> > also came up with the concept of attaching confidences as you describe.
> >
> > I only had time to look at the first patch closely so far. I hope to find
> > more time next week to review further.
> 
> I only scanned for obvious items myself, but the idea of a
> probabilistic test is indeed interesting.
> 
> I do wonder why you (Jan Kara, not Dscho :-) ) used fixed-point
> arithmetic here though.

Ah, very good question. I guess because I'm primarily Linux kernel
programmer and we don't have floating point arithmetics in the kernel so
I'm used to fixedpoint :).  Secondarily because fixedpoint arithmetics
provides me more control over where I'm loosing precision but looking at
this now I agree the ugliness in the code is not probably worth the
imagined win.  I'll rewrite stuff using floating point. Thanks for the
suggestion.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
