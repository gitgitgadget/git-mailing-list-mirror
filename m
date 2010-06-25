From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: What's cooking in git.git (Jun 2010, #04; Wed, 23)
Date: Fri, 25 Jun 2010 10:43:32 +0200
Message-ID: <20100625084332.GC4734@pvv.org>
References: <7viq59e6zn.fsf@alter.siamese.dyndns.org> <20100624111757.GB3453@pvv.org> <7veifwchb6.fsf@alter.siamese.dyndns.org> <40D1B374-E80A-4BA2-B3A2-142E8256C23E@gmail.com> <7vtyosnj23.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 25 10:43:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OS4Vm-0007du-3s
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 10:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471Ab0FYInk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 04:43:40 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:32853 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019Ab0FYInj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jun 2010 04:43:39 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1OS4VY-0000Jf-TF; Fri, 25 Jun 2010 10:43:33 +0200
Content-Disposition: inline
In-Reply-To: <7vtyosnj23.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149672>

On Thu, Jun 24, 2010 at 03:48:36PM -0700, Junio C Hamano wrote:

> A natural expectation would be that g2w-then-w2g is an identity function,
> I think.  But the "feature" under discussion in this thread depends on
> that g2w-then-w2g is _not_ a noop (otherwise it wouldn't do us any good).

This is a natural expecation for subsequent runs. The first time you
run it though, it makes more sense (and all built in filters act this
way) to change the file to its canonical form instead. If it already
is in its canonical form, you expect no further change.

> IOW, we are suggesting authors of clean/smudge to make their g2w-then-w2g
> perform more than just a round-trip but actively _clean things up_, aren't
> we?  I don't think we have documented that suggestion, and I actually
> think we might even have said that g2w-then-w2g should be a no-op
> somewhere in the documentation.

It's not that we suggest they should clean things up, it is that they
ALREADY clean things up. It's hard to make a reasonable filter that
doesn't. And git should (and can!) give you some assistance in
handling cleanup-related changes if you have such a filter.

To make a non-normalizing filter, both of these would have to be true:
1. g2w then g2w again would change the file even more
2. w2g on something that was run twice through g2w would be equivalent
   to running it through g2w once.. e.g. w2g(g2w(g2w(x))) == g2w(x),
   can't think of any resaonable scenario.

If you somehow manage to make a filter where w2g(g2w(x)) == x for all
x, the patch under discussion will not create any problems. I've never
seen such a filter though.

- Finn Arne
