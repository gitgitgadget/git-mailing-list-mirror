Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 798FE1F462
	for <e@80x24.org>; Thu, 13 Jun 2019 15:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbfFMPqs (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 11:46:48 -0400
Received: from ariake.ledovskis.lv ([92.222.72.25]:60546 "EHLO
        ariake.ledovskis.lv" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731783AbfFMJh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 05:37:59 -0400
X-Greylist: delayed 453 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Jun 2019 05:37:58 EDT
Received: by ariake.ledovskis.lv (Postfix, from userid 1000)
        id E58CB5DB79; Thu, 13 Jun 2019 12:30:23 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ledovskis.lv; s=mail;
        t=1560418223; bh=9KSVYPuhGZKyXLH4A4YM7/f7bl6YVMaaQtOCCrn39Bg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j7+U8IxyZcAsVjSNH10VbbDvTKmZh+r9D76jSQ+OAsZtX6aSPF02NyJHcK41ZUbWM
         /bnnUZYXX94dizyo7CMZo7Ckl/wGlfc50RbJg+KiyRSDMmsF1uQbvwQLa9uhU1Whj4
         T/QU/F4ug2SNWclr6GfdoMaRwC/saITMCuaw9i0JoddShBha+EIL56H9oexeKg9srl
         hyP1dNReL8oHNDaZNmJ1eptkU0gsgTqWm70WlmVGJXBYclzohrmH4fNtfy4cbVJ9uB
         ioCGVkqAa+IexwiFROFilWvRHR5+UueYP6Wf42ovURVOF7BEUiN21L0JJYQBpbeGwU
         NzZxq8I8MXFXQ==
Date:   Thu, 13 Jun 2019 12:30:23 +0300
From:   aleksandrs@ledovskis.lv
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Espen Antonsen <espen@inspired.no>, git@vger.kernel.org
Subject: Re: Git status parse error after v.2.22.0 upgrade
Message-ID: <20190613093023.GA3919@ariake.ledovskis.lv>
References: <3bc58c33-4268-4e7c-bf1a-fe349b3cb037@www.fastmail.com>
 <nycvar.QRO.7.76.6.1906112127420.789@QRFXGBC-DHN364S.ybpnyqbznva>
 <38b0f33a-1da1-4231-802e-ae14d9843ad2@www.fastmail.com>
 <nycvar.QRO.7.76.6.1906122046400.789@QRFXGBC-DHN364S.ybpnyqbznva>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1906122046400.789@QRFXGBC-DHN364S.ybpnyqbznva>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Managed to repro this problem on my private repo too.

Bisect points to b51a0fdc3822c2ef260f6d496b6df6d33b101e8a
However, I think the real culprit is 4a72486de97b5c6b0979b2b51e50c268bdb0d4f6, specifically `parse_insn_line` call.

My repo indeed contains a ".git/sequencer/todo" file which contains references to commits long-gone (i.e., rebased).
Renaming or deleting this file stops whines about "error: could not parse".

--
Regards,
Aleksandrs Ļedovskis

On Wed, Jun 12, 2019 at 08:47:27PM +0200, Johannes Schindelin wrote:
> Hi Espen,
> 
> On Wed, 12 Jun 2019, Espen Antonsen wrote:
> 
> > I don't have any hooks, just the default sample scripts. GIT_TRACE
> > doesn't show anything else.
> 
> Okay, it was just a guess.
> 
> And here is another guess: unless you impart with more details about your
> test case, I guess there is little anybody else can do to help you.
> 
> Ciao,
> Johannes
