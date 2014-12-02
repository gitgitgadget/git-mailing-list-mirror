From: Jeff King <peff@peff.net>
Subject: Re: http-protocol question
Date: Tue, 2 Dec 2014 14:50:51 -0500
Message-ID: <20141202195050.GA23461@peff.net>
References: <CAGyf7-HmvvHQZkyLgKAs2rrZTTLFkBa8s828hbS9LedLNb2fWA@mail.gmail.com>
 <20141202033416.GY6527@google.com>
 <CAGyf7-GZbRBN4O_yNgrmJCya=6f8XQ4O8m7WBa1k8Ve196ajYQ@mail.gmail.com>
 <20141202044522.GZ6527@google.com>
 <CAGyf7-Gx1VU-1OicCHG0sStUnNXy_0Y8VYUP+PZjpN6nz7dTrw@mail.gmail.com>
 <20141202053331.GA31516@peff.net>
 <xmqqzjb6kkt9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Bryan Turner <bturner@atlassian.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 20:50:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvtTL-0006mi-Vy
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 20:50:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933682AbaLBTuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 14:50:51 -0500
Received: from cloud.peff.net ([50.56.180.127]:47352 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932688AbaLBTuu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 14:50:50 -0500
Received: (qmail 27150 invoked by uid 102); 2 Dec 2014 19:50:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Dec 2014 13:50:49 -0600
Received: (qmail 18276 invoked by uid 107); 2 Dec 2014 19:50:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Dec 2014 14:50:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Dec 2014 14:50:51 -0500
Content-Disposition: inline
In-Reply-To: <xmqqzjb6kkt9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260589>

On Tue, Dec 02, 2014 at 09:45:06AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > For a public repository, it might make sense to provide a config option
> > to loosen the is_our_ref check completely (i.e., to just has_sha1_file).
> > But such an option does not yet exist.
> 
> In principle, yes, but that cannot be has_sha1_file(); it has to
> have a fully connected healthy history behind it.

I thought about that, but I wonder if it matters whether we check up
front. We are not advertising it, but only trying our best to fulfill
the "want" from the other side.  So either:

  1. We check immediately whether we have the full history behind it,
     and reject the "want" otherwise.

  2. We start pack-objects on it, and the first thing it will do is
     collect the full set of objects to send. If it doesn't have them,
     it will barf.

Probably (1) would produce nicer error messages, but (2) is a lot more
efficient.

I dunno. I am not volunteering to implement, so I will leave thinking on
it more to somebody who wants to do so. :)

-Peff
