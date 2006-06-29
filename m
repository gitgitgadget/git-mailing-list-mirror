From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Cache negative delta pairs
Date: Thu, 29 Jun 2006 00:09:59 -0400
Message-ID: <20060629040959.GA32156@coredump.intra.peff.net>
References: <20060628223744.GA24421@coredump.intra.peff.net> <7v4py4y7wo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 29 06:10:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fvnqy-00013Y-Ti
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 06:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716AbWF2EKE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 00:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751722AbWF2EKE
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 00:10:04 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:59370 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751716AbWF2EKB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 00:10:01 -0400
Received: (qmail 8652 invoked from network); 29 Jun 2006 00:09:39 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 29 Jun 2006 00:09:39 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Jun 2006 00:09:59 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4py4y7wo.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22837>

On Wed, Jun 28, 2006 at 08:09:43PM -0700, Junio C Hamano wrote:

> that hit your the negative cache are?  That is, in find_deltas()
> function, we have "while (--j > 0)" loop that attempts to delta
> with the entry that is j (modulo window size) entries away from
> the current one, then j-1, j-2, ...; I am interested in the
> distribution of "j" value for the pair "n,m" that hits your
> negative cache for normal repositories, and I am speculating
> that the value would probably be small relative to the delta
> window size.

Just to make sure I am understanding you correctly, you're interested in
the distribution of 'j' each time we skip a delta for being negative
(or each time we mark a negative, but that should simply equal the
lookup times for the next run). The instrumentation I added simply
prints the value of j each time we skip a delta. The counts are
surprisingly uniform (this is for linux-2.6):
  57209 j=1
  57213 j=2
  57217 j=3
  57221 j=4
  57225 j=5
  57229 j=6
  57233 j=7
  57237 j=8
  57241 j=9
  57245 j=10
They're so uniform (and in order by j!) that I feel like I must have done
something wrong...

-Peff
