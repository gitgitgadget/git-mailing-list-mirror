From: Jeff King <peff@peff.net>
Subject: Re: Malformed branch name in fast-export when specifying
 non-HEAD/branch revision
Date: Wed, 17 Aug 2011 16:19:22 -0700
Message-ID: <20110817231922.GA28966@sigill.intra.peff.net>
References: <CAORuUR1viqG27+dYOFS_5SLxFOE2wHJqAQ3i3RByg_fbWACh-Q@mail.gmail.com>
 <CAORuUR154Dhg5vDojga-01bDxxf+=R2X-oJK-0417CgmqxCwvA@mail.gmail.com>
 <CABPp-BFRZMZjhWuUUeD7Oa1HbWQMnZot7dRm3zKOpCoj_QwZeg@mail.gmail.com>
 <7vliurd62x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Elijah Newren <newren@gmail.com>,
	Owen Stephens <git@owenstephens.co.uk>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 01:19:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtpOX-0001mW-Eg
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 01:19:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890Ab1HQXT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Aug 2011 19:19:28 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35716
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752877Ab1HQXT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2011 19:19:26 -0400
Received: (qmail 15962 invoked by uid 107); 17 Aug 2011 23:20:06 -0000
Received: from 173-164-171-125-SFBA.hfc.comcastbusiness.net (HELO sigill.intra.peff.net) (173.164.171.125)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 17 Aug 2011 19:20:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Aug 2011 16:19:22 -0700
Content-Disposition: inline
In-Reply-To: <7vliurd62x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179544>

On Wed, Aug 17, 2011 at 03:30:14PM -0700, Junio C Hamano wrote:

> You can think of "fast-export" an off-line "push" command [*1*]; instead
> of giving a random commit object, e.g. "git fast-export HEAD~1", that can
> not be used as a ref, you can use the refspec notation to tell where the
> result should go, e.g. "git fast-export HEAD~1:refs/heads/a-bit-older",
> from the command line of fast-export.
> 
> I suspect that also may clarify what Sverre was trying to do in his recent
> series. The root cause of both this and the issue Sverre wanted to fix is
> the design mistake of fast-export that tries to reuse the notation of
> object range specification for a different purpose of telling which "ref"
> to update, I think.

Yes, this was the conclusion I came to when I looked at this a month or
so ago. You really need to give fast-export a mapping of objects to
refnames, and it should output ref names _only_ for the mapping. That
would handle this "not a ref" case, but would also let you push
"refs/heads/foo" when it is equivalent to "refs/heads/master", without
fast-export mentioning "refs/heads/master" at all.

-Peff
