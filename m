From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH v1] Add Travis CI support
Date: Fri, 25 Sep 2015 14:52:27 -0400
Message-ID: <20150925185227.GA15190@sigill.intra.peff.net>
References: <1443131004-39284-1-git-send-email-larsxschneider@gmail.com>
 <xmqqeghnuy8t.fsf@gitster.mtv.corp.google.com>
 <20150925162615.GF8417@sigill.intra.peff.net>
 <xmqqa8sa4ak4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: larsxschneider@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 20:52:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfY6k-0006fM-QR
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 20:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932896AbbIYSwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2015 14:52:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:36528 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932786AbbIYSwa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2015 14:52:30 -0400
Received: (qmail 31651 invoked by uid 102); 25 Sep 2015 18:52:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 25 Sep 2015 13:52:29 -0500
Received: (qmail 6623 invoked by uid 107); 25 Sep 2015 18:52:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 25 Sep 2015 14:52:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Sep 2015 14:52:27 -0400
Content-Disposition: inline
In-Reply-To: <xmqqa8sa4ak4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278674>

On Fri, Sep 25, 2015 at 11:29:31AM -0700, Junio C Hamano wrote:

> When I finally complain to the hosting site that it is deliberately
> rejecting the fix that would rob them the illicit revenue source, it
> does not help the hosting site to keep copies of push certificates
> when it wants to refute such a complaint.  "We publish all push
> certificates and there is no record that gitster already tried to
> fix the issue" has to be taken with faith in that scenario.

Right. Your earlier examples showed non-repudiation by the original
signer (the hosting site says "you definite pushed this to us, and here
is the signature to prove it, so you cannot deny it"). But in this
example, it is going the other way: the pusher wants the hosting site to
admit to an action.

To do that, the hosting site would have to re-sign the push cert to say
"we got this, it is published", and return the receipt to the original
pusher, who can then use it as proof of the event. Or alternatively, it
could be signed by a third-party notary.

I don't think it is all that interesting an avenue to pursue, though. If
you say "I have this update and the hosting site is not providing it to
people", people are not that interested in whether the hosting site is
being laggy, malicious, or whatever. They are interested in getting your
update. :)

So the more general problem is "I want to make sure I have Junio's
latest push, and I do not want to trust anything else". For that, you
could publish expiring certs (so you can fool me for up to, say, a week,
but after that I consider the old certs to be garbage either way). Or
you could do something clever with a quorum (e.g., N of K hosting sites
say there is no update, so there probably isn't one).

But I think all of that is outside of git's scope. Git provides the
signed ref-state in the form of a push cert. Since it's a small-ish blob
of data, you can use any external mechanism you want to decide on the
correct value of it.

> >  So I wonder if it would be
> > helpful to have a microformat that the client would use to look at this.
> > E.g., it would fetch the cert tree, then confirm that the current ref
> > values match the latest cert.
> 
> Yeah, that is one possibility.  Just a single flat file that
> concatenates all the push cert in the received order would do as an
> export format, too ;-)

I agree that's a more logical format, in a sense; it really is a linear
log. It's just that the receive-pack code already creates a blob for us,
so it's cheap to reference that in tree (and then fetching it is cheap,
too). IOW, git is much better at adding files to trees than it is at
appending to files. :)

-Peff
