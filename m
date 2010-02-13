From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-for-each-ref: add new field name "symbolic"
Date: Sat, 13 Feb 2010 03:51:32 -0500
Message-ID: <20100213085132.GA13181@coredump.intra.peff.net>
References: <1266040518-11748-1-git-send-email-larry@elder-gods.org>
 <7v4ollshn5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Larry D'Anna <larry@elder-gods.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 13 09:54:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgDlR-0005Ab-9R
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 09:54:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752976Ab0BMIvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 03:51:31 -0500
Received: from peff.net ([208.65.91.99]:57178 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751926Ab0BMIvb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 03:51:31 -0500
Received: (qmail 11846 invoked by uid 107); 13 Feb 2010 08:51:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 13 Feb 2010 03:51:39 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Feb 2010 03:51:32 -0500
Content-Disposition: inline
In-Reply-To: <7v4ollshn5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139781>

On Fri, Feb 12, 2010 at 11:45:50PM -0800, Junio C Hamano wrote:

> Larry D'Anna <larry@elder-gods.org> writes:
> 
> > %(symbolic) will expand to "true" for symbolic refs, and "false" otherwise.
> > This is a lot faster than calling git-symbolic-ref on every single ref from your
> > shell script.
> 
> I think this is a good idea, but I suspect that much more than half of
> people who iterate over for-each-ref output and run symbolic-ref would
> actually want to learn what actual ref a symbolic one points at.  So you
> may not be helping as much people as you could by going in this direction.
> 
> Instead of expanding to "true", why not make it show the expansion if it
> is symbolic, and to empty if it is not?

That was my first thought, too. Unfortunately it needs some pretty heavy
refactoring of the for_each_ref call chain, as we throw away the
dereferenced ref name at the very bottom.

So while I would be in favor of a real "%(symbolic)" as you describe, it
is significantly more work. If we are just going to do a flag check,
though, I would much rather see it called "%(issymbolic)" or something
so that "%(symbolic)" can be used later for the actual value.

One other alternative would be to simply expose "%(flags)" which would
expand to nothing, "symbolic", "packed", or "symbolic,packed".

-Peff
