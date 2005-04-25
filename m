From: Paul Mackerras <paulus@samba.org>
Subject: Re: Revised PPC assembly implementation
Date: Tue, 26 Apr 2005 09:00:45 +1000
Message-ID: <17005.30365.995256.963911@cargo.ozlabs.ibm.com>
References: <17004.47876.414.756912@cargo.ozlabs.ibm.com>
	<20050425173430.11031.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 00:56:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQCUt-0005wk-KU
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 00:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbVDYXBQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 19:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbVDYXBQ
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 19:01:16 -0400
Received: from ozlabs.org ([203.10.76.45]:63465 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261273AbVDYXBN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 19:01:13 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 1E68167AC7; Tue, 26 Apr 2005 09:01:12 +1000 (EST)
To: linux@horizon.com
In-Reply-To: <20050425173430.11031.qmail@science.horizon.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

linux@horizon.com writes:

> Huh?  I'm saving 19 registers, r13..r31, and not saving 13, namely
> r0..r12.

Oops. :)  Somehow I thought you were saving r13..r32 or something. :)

> Damn.  So that's actually *worse* than me earlier version which achieved
> an (also piddling) 2% speedup?

I wouldn't say it is worse, I would say it is the same.  I didn't do
as many runs of the previous version.  The spread of times looked
about the same with both of your versions.

> Damn, I wish I had at that IBM pipeline profiling tool.  If it could
> just tell me which cycles didn't have both ALUs busy, I could solve it
> in relatively little time.

I'm going to look at trying to get it going.

> The place that could really use scheduing help is the G4, which has three
> integer ALUs, but can only *think* about executing the bottom three entries
> in the reorder queue.  So if one of those instructions isn't ready, it
> stalls in the queue and idles the ALU with it.

Yes, the performance on the G4 is also important.  Not everyone has a
G5. ;)

> Maybe I can improve the scheduling some more...

The main loop seems to be taking about 560 cycles (assuming that
essentially all the time spent in my little test program is spent in
the main loop).  It contains about 1000 integer instructions, which
will take at least 500 cycles, as we have 2 ALUs.  So we are already
within about 10% of the theoretical optimum.

So I think we are already at the point of diminishing returns as far
as the overall performance of git is concerned.  But if you want to
try to get that last 10%, go for it... :)

Paul.
