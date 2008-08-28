From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] Use %as and %cs as pretty format flags
Date: Thu, 28 Aug 2008 19:54:21 -0400
Message-ID: <20080828235420.GB30195@coredump.intra.peff.net>
References: <d77df1110808280409o9445f9fybcab2c8d1066a8d8@mail.gmail.com> <20080828231547.GD29609@coredump.intra.peff.net> <7viqtkd84s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nathan Panike <nathan.panike@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 01:55:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYrKq-0001Rk-7X
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 01:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752549AbYH1XyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 19:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbYH1XyX
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 19:54:23 -0400
Received: from peff.net ([208.65.91.99]:4407 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751771AbYH1XyW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 19:54:22 -0400
Received: (qmail 9467 invoked by uid 111); 28 Aug 2008 23:54:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 28 Aug 2008 19:54:22 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Aug 2008 19:54:21 -0400
Content-Disposition: inline
In-Reply-To: <7viqtkd84s.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94217>

On Thu, Aug 28, 2008 at 04:36:51PM -0700, Junio C Hamano wrote:

> I was actually thinking about rejecting this, asking for something that
> allows to express all the other %[ai][dDri] format can express, and
> perhaps more.  So I think "%ad(short)" is a good direction to go, except
> that 'd' is already taken.  Perhaps %a(date), %a(shortdate,local),...?

I was thinking we could accept %ad _or_ %ad(short), but of course
introducing the latter can break existing "%ad(my other random text)"
which is a bad idea.

I really think some consideration should be given to introducing
arbitrary "arguments" to formatting specifiers, of which this is one
example. Another that has been mentioned is pulling an arbitrary element
from a list.

How do you feel about a brand new syntax (and supporting the old, of
course) that is syntactically a little easier to extend. Like:

  %(macro, key=val, key=val)

e.g.

  %(authordate, format=short, tz=local)

where the syntax can be easily parsed without understanding what
"authordate" means.  Jakub already suggested something akin to RPM's
macro expansion, though I haven't looked too closely at it.

> Oh, and before anybody asks, even if we do %a(specifier), you can keep
> writing "%ad" if you are used to it.  I am not talking about deprecating
> the existing ones, but making future extensions easier without forcing
> people to remember cryptic one-letter format specifiers.

Yes, I don't see a need to get rid of the existing ones. Introducing a
new syntax does have the possibility of breaking existing scripts, since
we just leave unrecognized expansions in place (in fact, just adding %as
has the potential to break scripts!).

Worst case, we can introduce a --pretty=otherformat:, but I don't know
if people are really expecting "%a(blah)" to be left untouched
currently. I don't think we ever claimed that % was magical.

-Peff
