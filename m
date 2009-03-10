From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] config: set help text for --bool-or-int
Date: Tue, 10 Mar 2009 13:59:04 -0400
Message-ID: <20090310175904.GB26351@sigill.intra.peff.net>
References: <1236446046-18319-1-git-send-email-peff@peff.net> <1236446046-18319-3-git-send-email-peff@peff.net> <94a0d4530903071307p46092810rb1637bfc853ee4d1@mail.gmail.com> <20090307224807.GA18548@coredump.intra.peff.net> <94a0d4530903091450gdcad625g95cd9550cfb724fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 19:00:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh6Fr-0006OK-Qb
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 19:00:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754201AbZCJR7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 13:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752326AbZCJR7J
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 13:59:09 -0400
Received: from peff.net ([208.65.91.99]:56280 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752761AbZCJR7I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 13:59:08 -0400
Received: (qmail 12839 invoked by uid 107); 10 Mar 2009 17:59:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 10 Mar 2009 13:59:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Mar 2009 13:59:04 -0400
Content-Disposition: inline
In-Reply-To: <94a0d4530903091450gdcad625g95cd9550cfb724fa@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112837>

On Mon, Mar 09, 2009 at 11:50:09PM +0200, Felipe Contreras wrote:

> Yeah, I meant usage_with_help. I don't know what should be done, but I
> think two things should be achieved:
> 
> a) don't crash
> b) encourage the options to always have a description

I don't know of a good way to check at compile time that the struct
member is non-NULL. So I think we are stuck with parse_options dying, or
doing something to cover it up, like:

> Perhaps not showing the option at all, or perhaps showing "**EMPTY**".

But the problem there is that if you _did_ mean for it to be shown, such
a bug can easily escape notice. Tests will generally still pass, so
unless you are scanning the output manually, nothing will tell you what
happened.

I think our best bet is to simply try to catch such things in code
review. This one slipped through, but it was still caught in 'next',
most because it _did_ crash on a non-glibc platform.

> Minor nitpick: "value is interpreted either as bool or int"
> 
> The value is what it is, the --boo-or-int option doesn't change the
> value, just how it is interpreted.

Fair enough. My patch is is in 'next' now, so please go ahead and submit
a new patch with your suggested change. You might want to change --bool
and --int at the same time, though, as they use the same wording.

-Peff
