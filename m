From: Jeff King <peff@peff.net>
Subject: Re: Re* [PATCH v3 19/22] resolve_ref(): emit warnings for
 improperly-formatted references
Date: Wed, 12 Oct 2011 00:50:05 -0400
Message-ID: <20111012045004.GA22413@sigill.intra.peff.net>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
 <1316121043-29367-20-git-send-email-mhagger@alum.mit.edu>
 <20111011161652.GA15629@sigill.intra.peff.net>
 <7vr52jfm8i.fsf@alter.siamese.dyndns.org>
 <7vmxd7flkw.fsf@alter.siamese.dyndns.org>
 <7v39ezffq5.fsf_-_@alter.siamese.dyndns.org>
 <20111011230749.GA29785@sigill.intra.peff.net>
 <7vehyjcckp.fsf@alter.siamese.dyndns.org>
 <20111012021128.GA32149@sigill.intra.peff.net>
 <7v39eyddoc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	cmn@elego.de, A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 06:50:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDqlu-0000QE-Vg
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 06:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752276Ab1JLEuK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 00:50:10 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58106
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751374Ab1JLEuH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 00:50:07 -0400
Received: (qmail 8465 invoked by uid 107); 12 Oct 2011 04:50:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Oct 2011 00:50:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Oct 2011 00:50:05 -0400
Content-Disposition: inline
In-Reply-To: <7v39eyddoc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183354>

On Tue, Oct 11, 2011 at 09:41:39PM -0700, Junio C Hamano wrote:

> Whether we remove the warning or not, I think it would be an improvement
> not to look at random files directly underneath $GIT_DIR/. I am not sure
> how we can be confident that we caught everything, though.
> 
> In other words, is shorten-unambiguous-refs the last one that needs
> fixing? How would we know for certain?

My assumption was that the set of rules is defined by
ref_rev_parse_rules, so grepping for functions that access that would be
sufficient.

It looks like there is also ref_fetch_rules, which serves a similar
purpose. Uses of that would also need to be audited.

I _think_ that should be enough for arbitrary lookup. I'm sure other
callsites directly say things like 'git_path("MERGE_HEAD")', but that's
not a problem. They would be doing so with a well-defined top-level
refname. This is really just about the ref_rev_parse_rules lookups.

-Peff
