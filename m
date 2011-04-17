From: Jeff King <peff@peff.net>
Subject: Re: Java Inflater problem decompressing packfile
Date: Sun, 17 Apr 2011 00:36:07 -0400
Message-ID: <20110417043607.GA10831@sigill.intra.peff.net>
References: <1302919505984-6278154.post@n2.nabble.com>
 <20110416063729.GC28853@sigill.intra.peff.net>
 <1302963832717-6279028.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: madmarcos <fru574@my.utsa.edu>
X-From: git-owner@vger.kernel.org Sun Apr 17 06:36:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBJip-0001xY-F3
	for gcvg-git-2@lo.gmane.org; Sun, 17 Apr 2011 06:36:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139Ab1DQEgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2011 00:36:14 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36767
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750713Ab1DQEgN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2011 00:36:13 -0400
Received: (qmail 24909 invoked by uid 107); 17 Apr 2011 04:37:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 17 Apr 2011 00:37:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Apr 2011 00:36:07 -0400
Content-Disposition: inline
In-Reply-To: <1302963832717-6279028.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171714>

On Sat, Apr 16, 2011 at 07:23:52AM -0700, madmarcos wrote:

> No, my inflater doesn't handle deltas, yet. 
> But there are a few reasons why I don't think that's the case.
> 1. The project has only been pushed once to the git repository before my
> tests. No updates to the git repository project or anything like that. 

You can still have deltas between blobs in a single commit, but only if
you have similar blobs.

> 2. If it were a delta, would the first 1/3 of it be completely normal and
> readable? There is no pattern that I can see to the remaining 2/3. It looks
> as if the characters in the 2/3 part were interleaved with the other
> characters about 10 times.

It wouldn't be completely normal, but you might see chunks of the file
along with binary patch instructions (like "put this chunk at offset
...").

> 3. The object type in the header is parsed as 3, or a blob. Aren't the delta
> object types higher numbers than that?

Yeah, if it is coming up as type 3, then it should definitely be a
whole, literal blob.

As far as your Java code, I don't see anything overtly wrong, but then,
I know absolutely nothing about any of the classes you are using.

-Peff
