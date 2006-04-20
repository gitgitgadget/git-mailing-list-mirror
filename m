From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: 1.3.0 creating bigger packs than 1.2.3
Date: Thu, 20 Apr 2006 23:56:49 +0200
Organization: At home
Message-ID: <e2902t$dnq$1@sea.gmane.org>
References: <20060420133640.GA31198@spearce.org> <Pine.LNX.4.64.0604200745550.3701@g5.osdl.org> <20060420150315.GB31198@spearce.org> <Pine.LNX.4.64.0604200857460.3701@g5.osdl.org> <20060420164351.GB31738@spearce.org> <Pine.LNX.4.64.0604200954440.3701@g5.osdl.org> <20060420173131.GF31738@spearce.org> <7vodywvsrq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Apr 20 23:57:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWh9K-0001qy-5g
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 23:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbWDTV5K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 17:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWDTV5K
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 17:57:10 -0400
Received: from main.gmane.org ([80.91.229.2]:64493 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751354AbWDTV5J (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Apr 2006 17:57:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FWh92-0001nW-1Y
	for git@vger.kernel.org; Thu, 20 Apr 2006 23:57:00 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 Apr 2006 23:57:00 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 Apr 2006 23:57:00 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19003>

Junio C Hamano wrote:

> v1.2.3 hash was base-name only.  doc/Makefile and t/Makefile
> were thrown in the same bin and sorted by size.  When the
> history you are packing is deep, and doc/Makefile and t/Makefile
> are not related at all, this made effective size of delta window
> 1/N where N is the number of such duplicates.
> 
> The one you found above uses a hash that is fully full-path.
> The two are in completely different bins, and bins are totally
> random.  This was not a good strategy.
> 
> v1.3.0 hash is base-name hash concatenated with leading-path
> has.  t/Makefile and doc/Makefile go in separate bins, but the
> bins are close to each other; this avoids the problem in v1.2.3
> when you have deep history, but at the same time if you do not
> have many many versions of t/Makefile to overflow the delta
> window, it gives t/Makefile a chance to delta with doc/Makefile.
[...]
> You could try this patch to resurrect the hash used in v1.2.3,
> and you may get better packing for your particular repository;
> but I am not sure if it gives better results in the general
> case.  I am running the test myself now while waiting for my
> day-job database to load X-<.

Perhaps the packing code could check which version gives smaller pack, or at
least be instructed that one might want different packing heuristic for
specific repository? Surely 2x difference in size is worth considering (and
complication)...

-- 
Jakub Narebski
Warsaw, Poland
