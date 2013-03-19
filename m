From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] index-pack: always zero-initialize object_entry list
Date: Tue, 19 Mar 2013 11:43:53 -0400
Message-ID: <20130319154353.GA10010@sigill.intra.peff.net>
References: <20130319102422.GB6341@sigill.intra.peff.net>
 <20130319105852.GA15182@sigill.intra.peff.net>
 <8738vr5rqh.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Zager <szager@google.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Mar 19 16:44:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHyiE-0000jC-Ej
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 16:44:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932756Ab3CSPoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 11:44:00 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58484 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932339Ab3CSPn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 11:43:59 -0400
Received: (qmail 30779 invoked by uid 107); 19 Mar 2013 15:45:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Mar 2013 11:45:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Mar 2013 11:43:53 -0400
Content-Disposition: inline
In-Reply-To: <8738vr5rqh.fsf@pctrast.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218526>

On Tue, Mar 19, 2013 at 04:33:42PM +0100, Thomas Rast wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Commit 38a4556 (index-pack: start learning to emulate
> > "verify-pack -v", 2011-06-03) added a "delta_depth" counter
> > to each "struct object_entry". Initially, all object entries
> > have their depth set to 0; in resolve_delta, we then set the
> > depth of each delta to "base + 1". Base entries never have
> > their depth touched, and remain at 0.
> 
> This patch causes index-pack to fail on the pack that triggered the
> whole discussion.  More in a minute in another side thread, but
> meanwhile: NAK until we understand what is really going on here.

Odd; that's what I was testing with, and it worked fine.

Let me double-check that I didn't screw up my tests. I initially did
something more like:

  if (is_delta_type(base->obj->type))
          delta_obj->delta_depth = base->obj->delta_depth + 1;
  else
          delta_obj->delta_depth = 1;

and I'm wondering if I screwed up testing the revised version.

-Peff
