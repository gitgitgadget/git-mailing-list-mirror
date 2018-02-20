Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A1D11F404
	for <e@80x24.org>; Tue, 20 Feb 2018 22:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751401AbeBTWs1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 17:48:27 -0500
Received: from titan.plasma.xg8.de ([85.10.203.189]:37564 "EHLO
        titan.PLASMA.Xg8.DE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750884AbeBTWs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 17:48:26 -0500
Received: from titan.PLASMA.Xg8.DE (localhost [127.0.0.1])
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTPS id w1KMmOpK001528
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 20 Feb 2018 23:48:24 +0100
Received: (from uucp@localhost)
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) with UUCP id w1KMmOlG001527;
        Tue, 20 Feb 2018 23:48:24 +0100
Received: from helen.PLASMA.Xg8.DE (localhost.localdomain [127.0.0.1])
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTP id w1KMm9ie025819;
        Tue, 20 Feb 2018 23:48:09 +0100
Received: (from rtc@localhost)
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) id w1KMm9A5025818;
        Tue, 20 Feb 2018 23:48:09 +0100
Date:   Tue, 20 Feb 2018 23:48:09 +0100
From:   Peter Backes <rtc@helen.PLASMA.Xg8.DE>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: Git should preserve modification times at least on request
Message-ID: <20180220224808.GA25678@helen.PLASMA.Xg8.DE>
References: <20180219212235.GA9891@helen.PLASMA.Xg8.DE>
 <nycvar.QRO.7.76.6.1802192257100.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <20180219220819.GA10466@helen.PLASMA.Xg8.DE>
 <nycvar.QRO.7.76.6.1802201127140.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <20180220210554.GA24474@helen.PLASMA.Xg8.DE>
 <nycvar.QRO.7.76.6.1802202329540.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1802202329540.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 20, 2018 at 11:32:23PM +0100, Johannes Schindelin wrote:
> Hi Peter,
> 
> On Tue, 20 Feb 2018, Peter Backes wrote:
> 
> > On Tue, Feb 20, 2018 at 11:46:38AM +0100, Johannes Schindelin wrote:
> > 
> > > I would probably invent a file format (`<mtime><TAB><path><LF>`)
> > 
> > I'm stuck there because of <path> being munged.
> 
> From which command do you want to get it? If you are looking at `git
> diff`, you may want to use the `-z --name-only` options to avoid munging
> the paths.

I plan to use "git diff-tree --name-only $w_tree HEAD" and subtract
all lines from "git diff-index --name-only HEAD" to get the files for 
which the timestamp should be stored..

If I use "-z" I get the non-munged path, but I cannot safely store such 
paths in the proposed file format; they might contain newlines (sigh). 
So at one point I have to munge. Then the same question arises when I 
have to get the actual path from the munged path when restoring the 
timestamps.

If there's no ready-made functionality to munge and unmunge paths, I 
have to write some awk for this. At first I thought this might add one 
more dependency to git, but it seems that awk is already used in 
git-mergetool.sh, so I suppose it's okay to use in git-stash.sh etc, 
too.

Best wishes
Peter

-- 
Peter Backes, rtc@helen.PLASMA.Xg8.DE
