From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/3] automatically skip away from broken commits
Date: Mon, 08 Jun 2009 00:25:04 -0700
Message-ID: <7vws7n6vcf.fsf@alter.siamese.dyndns.org>
References: <20090606043853.4031.78284.chriscool@tuxfamily.org>
	<7vskidcf9s.fsf@alter.siamese.dyndns.org>
	<200906070932.36913.chriscool@tuxfamily.org>
	<4A2CAA56.1030707@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>, Ingo Molnar <mingo@elte.hu>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 09:25:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDZEH-0000Tk-H3
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 09:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbZFHHZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 03:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbZFHHZD
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 03:25:03 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:61003 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815AbZFHHZD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 03:25:03 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090608072505.ZGBV2915.fed1rmmtao103.cox.net@fed1rmimpo03.cox.net>;
          Mon, 8 Jun 2009 03:25:05 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 1KR41c0034aMwMQ04KR4BE; Mon, 08 Jun 2009 03:25:04 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=ZlvubiwuF4QA:10 a=BRJNLUJM0I0A:10
 a=oGMlB6cnAAAA:8 a=Z7UACj7Gs9QRIPW5BzYA:9 a=2kjZcLjsAdBid0LFXdAA:7
 a=GrNyyw2YNXhQy7jp6uRD3K4JxeEA:4 a=CY6gl2JlH4YA:10
X-CM-Score: 0.00
In-Reply-To: <4A2CAA56.1030707@zytor.com> (H. Peter Anvin's message of "Sun\, 07 Jun 2009 23\:06\:14 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121043>

"H. Peter Anvin" <hpa@zytor.com> writes:

> It's not entirely clear to me that this is any better than simply
> randomly picking a commit from the list of plausible commits -- in other
> words, eliminate the commits we can totally rule out, and then just pick
> a random commit among the list of plausible commits.  This is not
> *quite* as crazy as it sounds; it has the advantage of being an
> extremely simple algorithm which shouldn't have any pathological behaviours.

That is essentially what Christian's patch does.  It does not try to go
away from untestable commits in topological space.  Instead, when we find
that the commit with the best "goodness" value is known to be untestable,
we step away from that commit by some alternating distance _in the
goodness value space_ (which does not have much to do with how commit
ancestry topology is laid out).  Viewed in the topology space, it is quite
similar to picking a different commit randomly, except for a very special
case where the remaining history is completely linear, in which case the
goodness value space and ancestry topology have a direct correlation.

That special case, and the deterministic hence repeatable nature of the
algorithm, are the two main advantages over picking a completely random
commit among the list of plausible commits.
