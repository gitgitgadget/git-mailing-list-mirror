From: Jeff King <peff@peff.net>
Subject: Re: [BUG] two-way read-tree can write null sha1s into index
Date: Thu, 3 Jan 2013 03:37:12 -0500
Message-ID: <20130103083712.GC32377@sigill.intra.peff.net>
References: <20120728150132.GA25042@sigill.intra.peff.net>
 <20120728150524.GB25269@sigill.intra.peff.net>
 <20121229100130.GA31497@elie.Belkin>
 <20121229102707.GA26730@sigill.intra.peff.net>
 <20121229103430.GG18903@elie.Belkin>
 <20121229110541.GA1408@sigill.intra.peff.net>
 <20121229205154.GA21058@sigill.intra.peff.net>
 <7vvcbg7d8x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 09:37:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqgIz-0001Rx-9E
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 09:37:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752986Ab3ACIhS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2013 03:37:18 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41864 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751422Ab3ACIhR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 03:37:17 -0500
Received: (qmail 4650 invoked by uid 107); 3 Jan 2013 08:38:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 03 Jan 2013 03:38:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Jan 2013 03:37:12 -0500
Content-Disposition: inline
In-Reply-To: <7vvcbg7d8x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212575>

On Tue, Jan 01, 2013 at 02:24:46PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So I think we need to update twoway_merge to recognize unmerged entries,
> > which gives us two options:
> >
> >   1. Reject the merge.
> >
> >   2. Throw away the current unmerged entry in favor of the "new" entry
> >      (when old and new are the same, of course; otherwise we would
> >      reject).
> >
> > I think (2) is the right thing.
> 
> As "--reset" in "read-tree --reset -u A B" is a way to say "we know
> we are based on A and we want to go to B no matter what", I agree we
> should not reject the merge.
> 
> With -m instead of --reset, I am not sure what the right semantics
> should be, though.

Good point; I was just thinking about the --reset case.

With "-m", though, we could in theory carry over the unmerged entries
(again, assuming that "old" and "new" are the same; otherwise it is an
obvious reject). But those entries would be confused with any new
unmerged entries we create. It seems we already protect against this,
though: "read-tree -m" will not run at all if you have unmerged entries.

Likewise, "checkout" seems to have similar protections.

So I think it may be a non-issue.

-Peff
