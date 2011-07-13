From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/5] add object-cache infrastructure
Date: Wed, 13 Jul 2011 02:37:01 -0400
Message-ID: <20110713063701.GA18238@sigill.intra.peff.net>
References: <20110711161332.GA10057@sigill.intra.peff.net>
 <20110711161754.GB10418@sigill.intra.peff.net>
 <201107121241.40242.jnareb@gmail.com>
 <20110712175739.GA17031@sigill.intra.peff.net>
 <7v62n78hpk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Ted Ts'o <tytso@mit.edu>, Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 13 08:37:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qgt4N-0005CE-VS
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 08:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961Ab1GMGhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 02:37:04 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48829
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964928Ab1GMGhD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 02:37:03 -0400
Received: (qmail 20823 invoked by uid 107); 13 Jul 2011 06:37:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 13 Jul 2011 02:37:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jul 2011 02:37:01 -0400
Content-Disposition: inline
In-Reply-To: <7v62n78hpk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176995>

On Tue, Jul 12, 2011 at 11:41:27AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >   2. The disk store uses a binary search over a sorted list of sha1s.
> >      Generalizing this to "a sequence of bytes" would not be hard. But
> >      we currently have the option of using the uniform distribution of
> >      sha1 to make better guesses about our "middle" (see the comments in
> >      sha1-lookup.c). That assumption does not hold over arbitrary bytes.
> 
> A side note. I notice that the "comment" you refer to appears twice in the
> file, and the sha1_pos() function that comes earlier in the file does not
> protect itself from overshoot penalty like the sha1_entry_pos() function
> does.
> 
> Perhaps we should think about unifying them somehow.

It would be easy to implement sha1_entry_pos in terms of sha1_pos by
writing an access function. But it seems unnecessarily slow to add
function call overhead in what should be a fairly tight loop.

OTOH, we do it everywhere else that we call sha1_pos; either it isn't a
big deal, or nobody has bothered to measure and micro-optimize there
yet.

-Peff
