From: Jeff King <peff@peff.net>
Subject: Re: Re* [PATCH v3 19/22] resolve_ref(): emit warnings for
 improperly-formatted references
Date: Wed, 12 Oct 2011 15:26:49 -0400
Message-ID: <20111012192649.GA26636@sigill.intra.peff.net>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
 <1316121043-29367-20-git-send-email-mhagger@alum.mit.edu>
 <20111011161652.GA15629@sigill.intra.peff.net>
 <7vr52jfm8i.fsf@alter.siamese.dyndns.org>
 <7vmxd7flkw.fsf@alter.siamese.dyndns.org>
 <7v39ezffq5.fsf_-_@alter.siamese.dyndns.org>
 <20111011230749.GA29785@sigill.intra.peff.net>
 <7vipnu81al.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	cmn@elego.de, A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 21:27:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE4S8-0005MP-QU
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 21:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753622Ab1JLT0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 15:26:52 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58737
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753567Ab1JLT0v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 15:26:51 -0400
Received: (qmail 15544 invoked by uid 107); 12 Oct 2011 19:26:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Oct 2011 15:26:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Oct 2011 15:26:49 -0400
Content-Disposition: inline
In-Reply-To: <7vipnu81al.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183405>

On Wed, Oct 12, 2011 at 12:20:18PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > We also look at ref_rev_parse_rules in shorten_unambiguous_ref. So even
> > with your patch, I still get the warning with:
> >
> >   $ git branch config
> >   $ git for-each-ref --format='%(refname:short)' refs/heads/
> >
> > It looks like we also use it in remote.c:count_refspec_match, but I
> > haven't figured out if that can trigger a warning or not.
> 
> I do not think this is "do not trigger a warning" exercise. This is "we no
> longer consider names outside refs/ as potential magic refs unless they
> are all uppercase".
> 
> If the updated dwim_ref() says $GIT_DIR/frotz will no longer create
> ambiguity with $GIT_DIR/refs/heads/frotz, then refname_match() needs to
> know about it, and cause count_refspec_match() to say that "frotz"
> uniquely names "refs/heads/frotz".
> 
> The same stands for shorten_unambiguous_ref(). If $GIT_DIR/frotz no longer
> is ambiguous with $GIT_DIR/refs/heads/frotz, then %(refname:shrot) for
> refs/heads/frotz should yield "frotz", and we should not have to qualify
> it as "heads/frotz".

Absolutely. I was lazy in how I woreded it, but I meant that the warning
was the indicator that we were doing something buggy, not that it was
the bug itself. It just happened to be a convenient way to test. :)

Your most recent patch looks right.

-Peff
