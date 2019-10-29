Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC7131F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 19:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732371AbfJ2TJi (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 15:09:38 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:56969 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732351AbfJ2TJi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 15:09:38 -0400
Received: from localhost (unknown [1.186.12.13])
        (Authenticated sender: me@yadavpratyush.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 7FFCB240007;
        Tue, 29 Oct 2019 19:09:36 +0000 (UTC)
Date:   Wed, 30 Oct 2019 00:39:34 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] git-gui: remove unused global declarations
Message-ID: <20191029190934.mr73g3ohwtgmndoo@yadavpratyush.com>
References: <20191025013255.7367-1-me@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1910281412300.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1910281412300.46@tvgsbejvaqbjf.bet>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/10/19 02:15PM, Johannes Schindelin wrote:
> Hi Pratyush,
> 
> On Fri, 25 Oct 2019, Pratyush Yadav wrote:
> 
> > A lot of places have unused global variables declared. Remove them.
> >
> > It started as a couple of quick fixes and ended up in me writing an ugly
> > hacky script to catch all the instances of unused global declarations.
> > Lot more than I expected.
> >
> > The script can be found at [0].
> 
> Wouldn't it make more sense to integrate that script into a Makefile
> target `check`, rather than hiding it in a gist (that might become
> unavailable if GitHub goes away, as some of you seem to fear)?

The idea of the script was just a quick hack to list as many instances 
as possible, and then I could manually verify them. It turned out to be 
pretty accurate. I linked it here so other people can know what I used 
to find these, and can suggest some cases I missed, if any. That's why I 
linked to the script in the cover letter, and not in the commit message.

It would probably be a better idea to use a linter/static analyzer. This 
would provide much better coverage than a script written for one-off 
usage.

I looked up some linters. There doesn't seem to be a lot of options, and 
most of them are not very good. One option I found is [0], but it gives 
more useless warnings than useful ones. Tcl being a really difficult 
language to lint doesn't help. So unless someone knows a good Tcl 
linter, maybe the best compromise would be to clean up the script and 
add it to our build process. But I'd really prefer a "proper" linter.
 
> > The script at [0] will only catch the unused globals in 'proc's. But
> > git-gui also has 'method's and 'constructor's. Just change '^proc' to
> > '^constructor' or '^method'.
> 
> Why not use `grep -E -n -e '^(proc|method)'`?

No particular reason. I just wrote it for 'proc', and then realized I 
might as well check 'method' and 'constructor'. Like I said, the aim of 
the script was use-and-throw.
 
> > I manually checked each instance before removing just to be sure I'm not
> > doing something wrong. Still, a bit of testing would be appreciated.
> > Just apply this patch and go on about your business as usual. There
> > _should_ be no change in the behaviour. I tested some basic functions
> > like commit, push, etc, and they work fine for me.
> 
> I would, if I used Git GUI regularly ;-)

[0] https://github.com/Xilinx/XilinxTclStore/blob/master/support/linter/tcl_lint.tcl

-- 
Regards,
Pratyush Yadav
