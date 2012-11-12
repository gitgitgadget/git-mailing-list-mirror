From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] git-sh-setup: refactor ident-parsing functions
Date: Mon, 12 Nov 2012 15:12:35 -0500
Message-ID: <20121112201235.GA7210@sigill.intra.peff.net>
References: <20121018072207.GA1605@sigill.intra.peff.net>
 <20121018072522.GA9999@sigill.intra.peff.net>
 <7vpq3ik97i.fsf@alter.siamese.dyndns.org>
 <20121112194434.GB4623@sigill.intra.peff.net>
 <7vzk2mh9dm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Ilya Basin <basinilya@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 21:12:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY0NJ-0002Wq-Qz
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 21:12:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817Ab2KLUMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 15:12:39 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44944 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752434Ab2KLUMj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 15:12:39 -0500
Received: (qmail 13346 invoked by uid 107); 12 Nov 2012 20:13:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Nov 2012 15:13:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2012 15:12:35 -0500
Content-Disposition: inline
In-Reply-To: <7vzk2mh9dm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209516>

On Mon, Nov 12, 2012 at 12:08:37PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Changing the interface for get_author_ident_from_commit would be a pain,
> > but if we just wanted to help filter-branch, we could do something like
> > this:
> 
> Yes, that is the direction I was alluding to.
> 
> Callers of get_author_ident_from_commit can also do the same and
> avoid rebuilding the same $pick_author_script over and over again,
> or get_author_ident_from_commit can do so for its callers.

I don't think get_author_ident_from_commit can do so on demand due to
the subshell issue I mentioned. So you'd have to generate the pick
script on inclusion of git-sh-setup, whether the includer wants to call
the function or not.

I wonder if we should simply generate these at build time and store them
in the script.

I'm also not sure that saving one process invocation is worth spending a
lot of thought cycles on. Maybe somebody on Windows could run a
filter-branch with the patch I just sent and measure whether it even
makes a difference.

-Peff
