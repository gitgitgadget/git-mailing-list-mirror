From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Index/hash order
Date: Thu, 14 Apr 2005 09:04:22 +0200
Message-ID: <20050414070422.GA3226@elte.hu>
References: <Pine.LNX.4.58.0504121554140.4501@ppc970.osdl.org> <20050412230027.GA21759@elte.hu> <20050412230729.GA22179@elte.hu> <20050413111355.GB13865@elte.hu> <425D4E1D.4040108@zytor.com> <20050413165310.GA22428@elte.hu> <425D4FB1.9040207@zytor.com> <Pine.LNX.4.58.0504131008500.4501@ppc970.osdl.org> <87aco2gxu2.fsf@deneb.enyo.de> <Pine.LNX.4.58.0504131503180.4501@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Florian Weimer <fw@deneb.enyo.de>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 09:01:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLyLo-0001xD-Mv
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 09:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbVDNHEh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 03:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVDNHEh
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 03:04:37 -0400
Received: from mx1.elte.hu ([157.181.1.137]:40372 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261445AbVDNHEd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 03:04:33 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx1.elte.hu (Postfix) with ESMTP id 0432431D0B1;
	Thu, 14 Apr 2005 09:03:50 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 8773A1FC2; Thu, 14 Apr 2005 09:04:25 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504131503180.4501@ppc970.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> > I've run a few tests, just to get a few numbers of the overhead
> > involved.  I used the last ~8,000 changesets from the BKCVS kernel
> > repository.  With cold cache, a checkout from cold cache takes about
> > 250 seconds on my laptop.  I don't have git numbers, but a mere copy
> > of the kernel tree needs 40 seconds.
> 
> I will bet you that a git checkout is _faster_ than a kernel source 
> tree copy. The time will be dominated by the IO costs (in particular 
> the read costs), and the IO costs are lower thanks to compression. So 
> I think that the cold-cache case will beat your 40 seconds by a clear 
> margin. It generally compresses to half the size, so 20 seconds is not 
> impossible (although seek costs would tend to stay constant, so I'd 
> expect it to be somewhere in between the two).

i'd be surprised if it was twice as fast - cache-cold linear checkouts 
are _seek_ limited, and it doesnt matter whether after a 1-2 msec 
track-to-track disk seek the DMA engine spends another 30 microseconds 
DMA-ing 60K uncompressed data instead of 30K compressed... (there are 
other factors, but this is the main thing.)

	Ingo
