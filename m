From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 2/3] Add a lot of dummy returns to avoid warnings with
 NO_NORETURN
Date: Mon, 20 Jun 2011 17:24:48 -0700
Message-ID: <20110621002448.GB700@alboin.amr.corp.intel.com>
References: <1308445625-30667-1-git-send-email-andi@firstfloor.org>
 <1308445625-30667-2-git-send-email-andi@firstfloor.org>
 <7vsjr4b3tf.fsf@alter.siamese.dyndns.org>
 <20110620213001.GB32765@one.firstfloor.org>
 <7vfwn4b1vb.fsf@alter.siamese.dyndns.org>
 <20110620220347.GE32765@one.firstfloor.org>
 <20110620223156.GA695@elie>
 <20110620223705.GG32765@one.firstfloor.org>
 <20110620224619.GB695@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andi Kleen <andi@firstfloor.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 02:25:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYomA-00028U-GR
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 02:25:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756611Ab1FUAZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 20:25:01 -0400
Received: from mga14.intel.com ([143.182.124.37]:16456 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756359Ab1FUAZA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 20:25:00 -0400
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga102.ch.intel.com with ESMTP; 20 Jun 2011 17:24:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,397,1304319600"; 
   d="scan'208";a="15872128"
Received: from unknown (HELO localhost) ([10.255.12.248])
  by azsmga001.ch.intel.com with ESMTP; 20 Jun 2011 17:24:59 -0700
Content-Disposition: inline
In-Reply-To: <20110620224619.GB695@elie>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176115>

> Anyway, thanks for writing these patches.  I'm happy to see git get
> faster.  As a side question, do you know if gcc provides a way to
> print output about what profile-driven optimizations were especially
> compelling, so they could help people think about how to reorganize
> code to improve the non profile-driven builds, too?

Generally gcc has no idea how much difference an optimization makes.
It would need to run the code for that, but it doesn't.

That's generally only possible for JITs.

For some optimizations (basic block reordering) you could get
the same benefit with __builtin_expect.

But based on my own experience with __builtin_expect in other projects
I strongly recommend to not use it manually: people tend
to use it everywhere eventually and they often get it wrong.
Humans are quite bad at deciding such things. Also code behaviour
changes over time and then the annotations often become outdated.

[e.g. the kernel has a special profiler for builtin_expects --
aka unlikely -- which checks the manual annotation against
the true runtime behaviour and the failure rate of manual annotation 
is quite spectacular]

In addition there are various optimizations in gcc where I am not
aware of a manual annotation possibility (like register allocation). 
The data from profile feedback is used in quite a lot of places all
over the compiler.

-Andi
