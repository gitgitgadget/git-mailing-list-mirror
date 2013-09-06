From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 6/6] status: add missing blank line after list of
 "other" files
Date: Fri, 6 Sep 2013 18:09:02 -0400
Message-ID: <20130906220902.GB13319@sigill.intra.peff.net>
References: <vpq38phsvuc.fsf@anie.imag.frvpq38phsvuc.fsf@anie.imag.fr>
 <1378489389-25802-1-git-send-email-Matthieu.Moy@imag.fr>
 <1378489389-25802-7-git-send-email-Matthieu.Moy@imag.fr>
 <xmqqbo45yfm5.fsf@gitster.dls.corp.google.com>
 <xmqq4n9xyepx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 07 00:09:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VI4DG-0000Ci-OF
	for gcvg-git-2@plane.gmane.org; Sat, 07 Sep 2013 00:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752871Ab3IFWJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 18:09:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:58687 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751827Ab3IFWJF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 18:09:05 -0400
Received: (qmail 10035 invoked by uid 102); 6 Sep 2013 22:09:05 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 Sep 2013 17:09:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Sep 2013 18:09:02 -0400
Content-Disposition: inline
In-Reply-To: <xmqq4n9xyepx.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234105>

On Fri, Sep 06, 2013 at 11:42:02AM -0700, Junio C Hamano wrote:

> > It is not like we want to add a blank line at the end of each
> > element; it is rather that we want to have a blank line between each
> > element, so that they can have a bit of breathing room between them.
> >
> > The output looks especially bad when there is nothing after the
> > 'untracked' list.
> 
> We might want to revisit this later, but I take the above back at
> least for now.

I agree with most of what you say here, and I started to look at a
simple patch to give separator semantics. But there's an interesting
case.

Given this:

> If we have absolutely nothing, we get this:
> 
> 	$ git status
> 	On branch master
>         nothing to commit
> 	$

I think the lack of extra line delimiter looks fine.

But here:

> And if we have something, we get this:
> 
> 	$ git status
> 	On branch master
> 	Changes to be committed:
> 	  (use "git reset HEAD <file>..." to unstage)
> 
> 	        new file:   foo

I think it looks kind of bad, because the branch specifier is is
smooshed into the "to be committed" header.

So the logic is not just "separate with a newline". It's more like
"separate big chunks with a newline, but if we only have small chunks,
it's OK to stick them together".

-Peff
