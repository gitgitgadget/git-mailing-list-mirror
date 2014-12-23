From: Jeff King <peff@peff.net>
Subject: Re: Question on for-each-ref and --contains
Date: Tue, 23 Dec 2014 03:52:14 -0500
Message-ID: <20141223085214.GA25444@peff.net>
References: <CA++b5FaiKC2+U-Q_q7tBBjX2s+rLY6725H2ScUW26eOf-nmRjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "St. Blind" <st.s.blind@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 09:52:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3LCa-0001Tu-Bu
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 09:52:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbaLWIwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 03:52:15 -0500
Received: from cloud.peff.net ([50.56.180.127]:56570 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750724AbaLWIwO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 03:52:14 -0500
Received: (qmail 18831 invoked by uid 102); 23 Dec 2014 08:52:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Dec 2014 02:52:14 -0600
Received: (qmail 20234 invoked by uid 107); 23 Dec 2014 08:52:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Dec 2014 03:52:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Dec 2014 03:52:14 -0500
Content-Disposition: inline
In-Reply-To: <CA++b5FaiKC2+U-Q_q7tBBjX2s+rLY6725H2ScUW26eOf-nmRjw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261718>

On Tue, Dec 23, 2014 at 09:50:50AM +0200, St. Blind wrote:

> In order to make some analyses here I had to build certain report
> lists of our remote refs, based on various "containing" and "merged"
> rules. We have more than hundred such refs at a time usually. So my
> poor script which tries to make decisions with the help of rev-list
> for each ref on each arbitrary commit is not really fast. The
> git-branch --contains and --merged are not very handy too, because the
> output is not really flexible, and the --merged works on HEAD only.
> 
> Do you think is a good idea to have the option "--contains" in
> for-each-ref too (and/or in rev-list directly)?
> If yes, then probably also the --(no-)merged options, but hopefully
> with the arbitrary commit this time?

Yes, it's absolutely a good idea to teach for-each-ref these options.
This is something I've been meaning to work on for a while. This is at
least the second time it has been mentioned in the past week or so, too.
Maybe I'll try to move it forward soon. The last attempt got stuck on
factoring out a single universal "--contains" traversal (we have 2
implementations):

  http://thread.gmane.org/gmane.comp.version-control.git/252472

I don't think there was any particular blocker besides time to look at
and think about it. We need to be very sure of the termination
requirements for the traversal (there was some discussion in the thread,
but I think I convinced myself that some of the optimization suggestions
there could return wrong answers for some cases).

-Peff
