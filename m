From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tests: Introduce test_seq
Date: Mon, 6 Aug 2012 16:16:00 -0400
Message-ID: <20120806201600.GA11078@sigill.intra.peff.net>
References: <20120803160229.GA13094@sigill.intra.peff.net>
 <1344023835-8947-1-git-send-email-michal.kiedrowicz@gmail.com>
 <20120803200201.GA10344@sigill.intra.peff.net>
 <7v3943bsuc.fsf@alter.siamese.dyndns.org>
 <20120804000904.13c4162b@gmail.com>
 <501D4FF0.4060109@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Aug 06 22:16:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyTil-0008Do-Fc
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 22:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754216Ab2HFUQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Aug 2012 16:16:05 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53651 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752697Ab2HFUQE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 16:16:04 -0400
Received: (qmail 18801 invoked by uid 107); 6 Aug 2012 20:16:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Aug 2012 16:16:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Aug 2012 16:16:00 -0400
Content-Disposition: inline
In-Reply-To: <501D4FF0.4060109@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202982>

On Sat, Aug 04, 2012 at 06:38:08PM +0200, Johannes Sixt wrote:

> And the reason for this is that we always told people "don't use seq"
> and they submitted an updated patch. What would we have to do now? We
> have to tell them "don't use seq, use test_seq". Therefore, the patch
> does not accomplish anything useful, IMO.
> 
> The function should really just be named 'seq'.
> 
> Or how about this strategy:
> 
> seq () {
> 	unset -f seq
> 	if ! seq 1 2 >/dev/null 2>&1
> 	then
> 		# don't have a working seq; provide it as a function
> 		seq () {
> 			insert your definition here
> 		}
> 	fi
> 	seq "$@"
> }
> 
> but it is not my favorite.

No, falling back just makes that problem worse. Our test_seq is not
fully compatible with seq. So anyone who uses an advanced feature of seq
(like "seq 0 100 10" or "seq -f %02g 1 10") will have the test work on
their system (with seq) and then break on some other random platform.
So instead of saying "no, don't use seq, use test_seq", reviewers have
to catch it and say "don't use some features of seq, because the
fallback doesn't have them".

If you eliminate the fallback, then at least the reviewers do not have
to catch it (the tests will never work for the patch writer, since they
will always use our feature-less seq replacement). But I find it
slightly confusion-inducing to call something that is not seq-compatible
"seq".

-Peff
