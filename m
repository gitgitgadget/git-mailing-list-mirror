From: Jeff King <peff@peff.net>
Subject: Re: Hardcoded #!/bin/sh in t5532 causes problems on Solaris
Date: Sat, 9 Apr 2016 18:37:39 -0400
Message-ID: <20160409223738.GA1738@sigill.intra.peff.net>
References: <570965B9.9040207@jupiterrise.com>
 <20160409210429.GB18989@sigill.intra.peff.net>
 <57098259.1060608@jupiterrise.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Elia Pinto <gitter.spiros@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Tom G. Christensen" <tgc@jupiterrise.com>
X-From: git-owner@vger.kernel.org Sun Apr 10 00:38:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ap1WK-0007gq-U1
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 00:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbcDIWho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 18:37:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:47050 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750760AbcDIWhn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2016 18:37:43 -0400
Received: (qmail 20540 invoked by uid 102); 9 Apr 2016 22:37:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 09 Apr 2016 18:37:42 -0400
Received: (qmail 15288 invoked by uid 107); 9 Apr 2016 22:37:46 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 09 Apr 2016 18:37:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 09 Apr 2016 18:37:39 -0400
Content-Disposition: inline
In-Reply-To: <57098259.1060608@jupiterrise.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291136>

On Sun, Apr 10, 2016 at 12:29:45AM +0200, Tom G. Christensen wrote:

> On 09/04/16 23:04, Jeff King wrote:
> >I did some quick grepping around, and I suspect you may run
> >into the same thing in other places (e.g., t3404.40 looks
> >like a similar case).
> 
> There are only a few tests that fail and just t5532.3 seems affected by this
> issue.

Hmm. t3404.40 does this:

        echo "#!/bin/sh" > $PRE_COMMIT &&
	echo "test -z \"\$(git diff --cached --check)\"" >>$PRE_COMMIT &&
	chmod a+x $PRE_COMMIT &&

So I'm pretty sure that $PRE_COMMIT script should be barfing each time
it is called on Solaris. I think the test itself doesn't notice because
"/bin/sh barfed" and "the pre-commit check said no" look the same from
git's perspective (both non-zero exits), and we test only cases where we
expect the hook to fail.

I think that particular test could simplify its pre-commit hook to just
"exit 1".

I didn't dig into any other cases, so that might be the only one. If
you're not seeing problems, I'm not inclined to explore each one
manually.

> I applied this to 2.8.1 and as expected the test now passes on Solaris.

Thanks.

-Peff
