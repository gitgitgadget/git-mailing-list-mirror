From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] tag: support configuring --sort via .gitconfig
Date: Tue, 15 Jul 2014 19:38:36 -0400
Message-ID: <20140715233836.GA5572@peff.net>
References: <1405119347-3308-1-git-send-email-jacob.e.keller@intel.com>
 <1405119347-3308-3-git-send-email-jacob.e.keller@intel.com>
 <CAPig+cR9VCtNhk-FbqDM1LTCa8VeUTYXU4XEX36Rb5CxPFfLWQ@mail.gmail.com>
 <xmqqfvi518xo.fsf@gitster.dls.corp.google.com>
 <20140713173356.GA8406@sigill.intra.peff.net>
 <20140713183629.GA19293@sigill.intra.peff.net>
 <xmqqfvi3zwp7.fsf@gitster.dls.corp.google.com>
 <1405435933.9147.1.camel@jekeller-desk1.amr.corp.intel.com>
 <xmqqfvi2wqvq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"sunshine@sunshineco.com" <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 01:39:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7CJP-0004uT-0H
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 01:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965318AbaGOXir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 19:38:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:34484 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965035AbaGOXip (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 19:38:45 -0400
Received: (qmail 27093 invoked by uid 102); 15 Jul 2014 23:38:44 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (208.181.190.99)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 15 Jul 2014 18:38:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Jul 2014 19:38:36 -0400
Content-Disposition: inline
In-Reply-To: <xmqqfvi2wqvq.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253646>

On Tue, Jul 15, 2014 at 09:03:53AM -0700, Junio C Hamano wrote:

> > Do we want to go this way?
> 
> I do not speak for Peff, but I personally think this is just a "fun"
> demonstration, nothing more, and my gut feeling is that it would
> make things unnecessary complex without much real gain to pursue it
> further.

Yeah, it is a little too complicated for what it is buying us here. If
we had a real error stack with allocated error types or something, then
callers could do more useful programmatic things with it. But:

  1. We usually only care about system errors in such a case, and get by
     with using errno.

  2. I would not want to annotate all of the library-ish functions with
     case-specific return types. That is a lot of work for little gain.

I think my favorite of the suggestions so far is basically the two-line:

  error: sort specification is bad...
  warning: ignoring invalid tag.sort

There are tons of places in git where we already do this kind of
"error chaining" over multiple lines (and multiple calls to error()),
and it doesn't require any new code or techniques.

But what is in v8 is not so bad from my cursory glance.

-Peff

PS I am traveling this week and will probably be a lot less responsive.
   Please don't let me hold up your conversations.
