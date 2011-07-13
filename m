From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCHv2 6/6] limit "contains" traversals based on commit
 generation
Date: Wed, 13 Jul 2011 17:18:27 -0400
Message-ID: <20110713211826.GA17284@sigill.intra.peff.net>
References: <20110713064709.GA18499@sigill.intra.peff.net>
 <20110713070644.GF18566@sigill.intra.peff.net>
 <20110713072350.GA18614@sigill.intra.peff.net>
 <7vaach7wfh.fsf@alter.siamese.dyndns.org>
 <20110713205844.GA15435@sigill.intra.peff.net>
 <7vpqld6g14.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Ted Ts'o <tytso@mit.edu>, Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 13 23:18:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh6pE-0004e3-77
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 23:18:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060Ab1GMVSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 17:18:30 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40467
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751818Ab1GMVS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 17:18:29 -0400
Received: (qmail 30239 invoked by uid 107); 13 Jul 2011 21:18:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 13 Jul 2011 17:18:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jul 2011 17:18:27 -0400
Content-Disposition: inline
In-Reply-To: <7vpqld6g14.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177084>

On Wed, Jul 13, 2011 at 02:12:55PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Or are you suggesting dropping generations entirely, and just using
> > marked-up commit timestamps (or even a flag saying "this timestamp is
> > bogus, don't use it for cutoffs")?
> 
> Not suggesting, but that was exactly what I was wondering.  For example,
> still_interesting() in revision.c says "compare timestamp and return SLOP,
> not 'we are done'", and presumably that code could notice that "ah, this
> commit is marked as being on a stretch that timestamp based cut-off is
> unusable--keep digging". The "tag --contains" and "name-rev" would also
> have similar logic (I haven't looked at them for a while though).

Yes, the slop code in still_interesting could use a
"timestamp_is_bogus(commit)" check. It could also use generation
numbers. :)

I actually wonder if we could make merge-base computation more efficient
using generation numbers, and if it would be worth switching more
algorithms over to it. I haven't thought too hard about it, though.

-Peff
