From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] introduce "format" date-mode
Date: Tue, 30 Jun 2015 15:33:19 -0400
Message-ID: <20150630193319.GA8365@peff.net>
References: <20150625165341.GA21949@peff.net>
 <20150625165545.GC23503@peff.net>
 <20150629222247.GA31607@flurp.local>
 <20150630102055.GA11928@peff.net>
 <xmqq381988ud.fsf@gitster.dls.corp.google.com>
 <20150630175011.GA5349@peff.net>
 <xmqqbnfxc86b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 21:33:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZA1Hc-0005ug-EA
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 21:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbbF3TdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 15:33:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:53954 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751124AbbF3TdX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 15:33:23 -0400
Received: (qmail 9960 invoked by uid 102); 30 Jun 2015 19:33:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 Jun 2015 14:33:22 -0500
Received: (qmail 18381 invoked by uid 107); 30 Jun 2015 19:33:26 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 Jun 2015 15:33:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Jun 2015 15:33:19 -0400
Content-Disposition: inline
In-Reply-To: <xmqqbnfxc86b.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273100>

On Tue, Jun 30, 2015 at 12:23:08PM -0700, Junio C Hamano wrote:

> >> Why can't I shake this feeling that (" %s", fmt), i.e. prepend not
> >> append, is the safer thing to do than to append?
> >
> > Because then removing the extra space involves `memmove` of the buffer,
> > rather than just shortening the length by one.
> 
> That does not explain why I feel the other way is safer, though ;-)

Sorry, I think I read it as "saner". ;)

> In any case, responding myself to my other question, strftime(3)
> does not define any useful error information even for a case where
> you feed nonsense format to it, so it is even not possible to
> protect ourselves by checking errno or doing something similar X-<.

I do think " %" is probably safer than "% " in that it is less likely to
cause weird output from strftime (e.g., I could see an implementation
treat "%X", where "X" is unknown, as just "X", but treat a trailing "%"
as a raw "%"). But I doubt there is an implementation that would return
"0" for one but not the other (anything's possible of course, but we are
deep in the realm of guessing how systems might implement the
standard, so it's really our best guess until somebody can present a
particular data point; I've looked only at glibc and it is sane).

-Peff
