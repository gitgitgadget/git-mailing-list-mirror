From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 4/5] branch: introduce --list option
Date: Thu, 8 Sep 2011 17:11:56 -0400
Message-ID: <20110908211156.GA510@sigill.intra.peff.net>
References: <20110825175301.GC519@sigill.intra.peff.net>
 <0785cac235c3b45537cf161c86dde8e798c4ff3e.1314367414.git.git@drmicha.warpmail.net>
 <7vfwkodq5s.fsf@alter.siamese.dyndns.org>
 <4E5A5290.4050005@drmicha.warpmail.net>
 <20110907195611.GD13364@sigill.intra.peff.net>
 <4E6889DF.7030404@drmicha.warpmail.net>
 <7vr53qwxtz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 00:58:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1nYV-0005mo-2l
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 00:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499Ab1IHW6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 18:58:40 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44846
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750874Ab1IHW6j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 18:58:39 -0400
Received: (qmail 16990 invoked by uid 107); 8 Sep 2011 21:12:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Sep 2011 17:12:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Sep 2011 17:11:56 -0400
Content-Disposition: inline
In-Reply-To: <7vr53qwxtz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180989>

On Thu, Sep 08, 2011 at 02:03:52PM -0700, Junio C Hamano wrote:

> Hasn't 'git branch -v' meant listing in verbose mode for a long enough
> time that changing it now would mean a moderately major regression?
> 
> At least my copy of v1.7.0 seems to list with "git branch -v".

No, it will mean the same thing as in v1.7.0; it is not the "-v" which
does it, but the lack of non-option arguments.

Right now, "-v" just means "if we are listing, do it verbosely". And if
you don't specify any non-option arguments, it means "list". So right
now:

  git branch        ;# list
  git branch -v     ;# list verbosely
  git branch -v foo ;# create branch 'foo', -v does nothing

Michael's proposal was:

  git branch -v foo ;# assume verbose list, interpret 'foo' as pattern

which is actually a regression, albeit one that probably doesn't matter
(because "-v" didn't ever do anything with a non-option argument).

Whereas mine is:

  git branch -v foo ;# create branch 'foo' verbosely

Which happens to do exactly the same thing as the current behavior,
because there are no verbose messages to add to "git branch". But it
leaves the door open to adding them in the future (and it's consistent
with "git branch -m -v" and "git branch -d -v", both of which could use
"-v" to do their operations more verbosely).

-Peff
