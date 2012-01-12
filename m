From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] get_sha1_with_context: report features used in
 resolution
Date: Wed, 11 Jan 2012 21:51:26 -0500
Message-ID: <20120112025126.GA25365@sigill.intra.peff.net>
References: <20120111193916.GA12333@sigill.intra.peff.net>
 <20120111194210.GA12441@sigill.intra.peff.net>
 <7vmx9t4pgj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org, Albert Astals Cid <aacid@kde.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 03:51:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlAlK-00042Z-3v
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 03:51:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752364Ab2ALCv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 21:51:29 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35578
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752198Ab2ALCv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 21:51:28 -0500
Received: (qmail 26850 invoked by uid 107); 12 Jan 2012 02:58:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 11 Jan 2012 21:58:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Jan 2012 21:51:26 -0500
Content-Disposition: inline
In-Reply-To: <7vmx9t4pgj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188417>

On Wed, Jan 11, 2012 at 06:36:12PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Most callers generally treat get_sha1 as a black box, giving
> > it a string from the user and expecting to get a sha1 in
> > return. The get_sha1_with_context function gives callers
> > more information about what happened while resolving the
> > object name so they can make better decisions about how to
> > use the result. We currently use this only to provide
> > information about the path entry used to find a blob.
> >
> > We don't currently provide any information about the
> > resolution rules that were used to reach the final object.
> > Some callers may want these in order to enforce a policy
> > that a particular subset of the lookup rules are used (e.g.,
> > when serving remote requests).
> >
> > This patch adds a set of bit-fields that document the use of
> > particular features during an object lookup.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > The diffstat looks a little scary, but it is mostly just the internal
> > get_sha1 functions learning to pass the object_context around.
> 
> Hmm, shouldn't this also cover peel_to_type()?  That would have made it
> also apply to the maintenance track.

I don't see how peel_to_type is relevant. As far as get_sha1 is
concerned, the interesting thing is actually calling peel_onion. It does
get the context passed to it in my patch, but I didn't bother marking
that the peel feature was used (because it wasn't relevant to the policy
I wanted to implement in the follow-on patch).

But we could pretty easily mark the use of the peel feature, too.

I'm not sure what you mean about the maintenance track, though. AFAICT,
we don't separately call peel_to_type, but just potentially use it as
part of get_sha1_with_context. Am I missing something?

-Peff
