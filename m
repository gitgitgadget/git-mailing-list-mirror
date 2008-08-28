From: Nick Andrew <nick@nick-andrew.net>
Subject: Re: [PATCH] be paranoid about closed stdin/stdout/stderr
Date: Thu, 28 Aug 2008 22:21:42 +1000
Message-ID: <20080828122142.GA6518@mail.local.tull.net>
References: <48B29C52.8040901@gnu.org> <E1KXawS-0001gg-Ty@fencepost.gnu.org> <48B2AFC2.20901@viscovery.net> <7vbpzgb94q.fsf@gitster.siamese.dyndns.org> <E1KXsL9-0004ef-Co@fencepost.gnu.org> <48B3A948.3080800@viscovery.net> <20080826074044.GA22694@cuci.nl> <32541b130808262201v4d7c1aa5r781720a80b79fcd0@mail.gmail.com> <20080827091800.GB484@cuci.nl> <32541b130808271122t45031cc7n497da8da6ca52bd3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Stephen R. van den Berg" <srb@cuci.nl>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Paolo Bonzini <bonzini@gnu.org>,
	Karl Chen <quarl@cs.berkeley.edu>,
	Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 14:22:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYgWa-0006Pz-QM
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 14:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752190AbYH1MVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 08:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752083AbYH1MVr
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 08:21:47 -0400
Received: from vps1.tull.net ([66.180.172.116]:33090 "HELO vps1.tull.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751202AbYH1MVq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 08:21:46 -0400
Received: (qmail 3805 invoked by uid 1015); 28 Aug 2008 22:21:45 +1000
Received: from [10.0.0.67] (HELO tull.net) (10.0.0.67) by vps1.tull.net (qpsmtpd/0.26) with SMTP; Thu, 28 Aug 2008 22:21:45 +1000
Received: (qmail 6824 invoked by uid 1000); 28 Aug 2008 22:21:42 +1000
Content-Disposition: inline
In-Reply-To: <32541b130808271122t45031cc7n497da8da6ca52bd3@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SMTPD: qpsmtpd/0.26, http://develooper.com/code/qpsmtpd/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94041>

On Wed, Aug 27, 2008 at 02:22:39PM -0400, Avery Pennarun wrote:
> I'm just feeling protective of the future sanity of other developers
> here, hoping they don't have to go through what I did on a multi-week
> bug hunt.  (We were even blaming reiserfs for a while for our boot
> sector getting zapped...)  The fact that someone *other* than me has
> suggested this change implies that I'm not the only one who has seen
> such insanity in the wild.

You're not alone. I've been having trouble with a combination of
fetchmail, procmail and ssmtp, in which situation the ssmtp program
_somehow_ sometimes opens /dev/urandom as file descriptor 0 (while
calculating an SSL key?) and leaves it open, then reads the message
body from that file descriptor, resulting in an endless garbage message
being sent to the SMTP server.

I suspect the error originates in Debian's patch to ssmtp (which
added the SSL support) but I haven't been able to reproduce the bug
in controlled circumstances. It's possible that fetchmail or procmail
is doing something stupid - but a little more defensive programming
in ssmtp could avoid the total disaster area of sending an endless
binary stream to an SMTP server.

So although I'm not experiencing any problems with git due to incorrect
file descriptor usage, I'm sensitive to the general issue.

Nick.
