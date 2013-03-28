From: Jeff King <peff@peff.net>
Subject: Re: More detailed error message for 403 forbidden.
Date: Thu, 28 Mar 2013 16:18:26 -0400
Message-ID: <20130328201826.GA24103@sigill.intra.peff.net>
References: <CAFT+Tg_PwAS__AYCwQQZjy4LVvAMZFJuJ+ediDJpRnxx73qMMg@mail.gmail.com>
 <20130328183601.GA11914@sigill.intra.peff.net>
 <7vk3ortk3o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Yi, EungJun" <semtlenori@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 21:19:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULJHp-0005Ef-6C
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 21:19:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752320Ab3C1USd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 16:18:33 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43945 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751091Ab3C1USd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 16:18:33 -0400
Received: (qmail 29677 invoked by uid 107); 28 Mar 2013 20:20:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 28 Mar 2013 16:20:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Mar 2013 16:18:26 -0400
Content-Disposition: inline
In-Reply-To: <7vk3ortk3o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219456>

On Thu, Mar 28, 2013 at 12:11:55PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > One problem is that the content body sent along with the error is not
> > necessarily appropriate for showing to the user (e.g., if it is HTML, it
> > is probably not a good idea to show it on the terminal). So I think we
> > would want to only show it when the server has indicated via the
> > content-type that the message is meant to be shown to the user. I'm
> > thinking the server would generate something like:
> >
> >    HTTP/1.1 403 Forbidden
> >    Content-type: application/x-git-error-message
> >
> >    User 'me' does not have enough permission to access the repository.
> >
> > which would produce the example you showed above.
> 
> Actually, isn't the human-readable part of the server response meant
> for this kind of thing?  I.e.
> 
> 	HTTP/1.1 403 User 'me' not allowed to accept the repository.

In theory, yes. But I don't think that most servers make it very easy to
use custom "reason phrases" (that is the rfc 2616 term for them). At
least I could not easily figure out how to make Apache do so. You can do
so from CGIs, but I think you'd want to customize some of this at the
HTTP server level (e.g., overriding 404s with a custom message). There's
much better support at that level for custom error documents (e.g.,
Apache's ErrorDocument).

I do not configure http servers very often, though, so I could be wrong
about what is normal practice, and what is easy to do.

-Peff
