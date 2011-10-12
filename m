From: Jeff King <peff@peff.net>
Subject: Re: Re* [PATCH v3 19/22] resolve_ref(): emit warnings for
 improperly-formatted references
Date: Tue, 11 Oct 2011 22:11:28 -0400
Message-ID: <20111012021128.GA32149@sigill.intra.peff.net>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
 <1316121043-29367-20-git-send-email-mhagger@alum.mit.edu>
 <20111011161652.GA15629@sigill.intra.peff.net>
 <7vr52jfm8i.fsf@alter.siamese.dyndns.org>
 <7vmxd7flkw.fsf@alter.siamese.dyndns.org>
 <7v39ezffq5.fsf_-_@alter.siamese.dyndns.org>
 <20111011230749.GA29785@sigill.intra.peff.net>
 <7vehyjcckp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	cmn@elego.de, A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 04:11:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDoID-0005v2-7Y
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 04:11:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358Ab1JLCLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 22:11:31 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57997
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751183Ab1JLCLa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 22:11:30 -0400
Received: (qmail 7392 invoked by uid 107); 12 Oct 2011 02:11:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 11 Oct 2011 22:11:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Oct 2011 22:11:28 -0400
Content-Disposition: inline
In-Reply-To: <7vehyjcckp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183350>

On Tue, Oct 11, 2011 at 04:50:46PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It looks like we also use it in remote.c:count_refspec_match, but I
> > haven't figured out if that can trigger a warning or not.
> 
> It starts sounding like that the ill-thought-out warning should be ripped
> out regardless of what other things we do.

Maybe. I think it is not the warning that is wrong, but that it is
exposing a slightly hack-ish part of git (that we consider things like
$GIT_DIR/config as possible refs, and just silently reject them because
they happen not to have the right format).

On the other hand, it has been working fine that way for years, so maybe
it is not worth changing now.

At any rate, I think the changes should be all or nothing. If the
warning goes away, fine. But if the warning stays, and dwim_ref is going
to have special rules for looking in the top-level $GIT_DIR, then things
like shorten_unambiguous_ref need to respect those rules, or we've just
created a new bug.

-Peff
