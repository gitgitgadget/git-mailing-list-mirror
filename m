From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 10/16] fast-import: use skip_prefix for parsing input
Date: Fri, 20 Jun 2014 01:45:49 -0400
Message-ID: <20140620054549.GA4623@sigill.intra.peff.net>
References: <20140618194117.GA22269@sigill.intra.peff.net>
 <20140618194912.GJ22622@sigill.intra.peff.net>
 <CAPig+cTgz1s_68MVT5XgTsM9j=NZnCt3tNX3wBGddEq3nWZgyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jun 20 07:46:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxre9-00015Q-O4
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 07:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934584AbaFTFpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 01:45:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:47998 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933667AbaFTFpv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 01:45:51 -0400
Received: (qmail 7678 invoked by uid 102); 20 Jun 2014 05:45:51 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 20 Jun 2014 00:45:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Jun 2014 01:45:49 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cTgz1s_68MVT5XgTsM9j=NZnCt3tNX3wBGddEq3nWZgyw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252214>

On Thu, Jun 19, 2014 at 11:19:09PM -0400, Eric Sunshine wrote:

> > -               if (starts_with(command_buf.buf, "M "))
> > -                       file_change_m(b);
> > -               else if (starts_with(command_buf.buf, "D "))
> > -                       file_change_d(b);
> > -               else if (starts_with(command_buf.buf, "R "))
> > -                       file_change_cr(b, 1);
> > -               else if (starts_with(command_buf.buf, "C "))
> > -                       file_change_cr(b, 0);
> > -               else if (starts_with(command_buf.buf, "N "))
> > -                       note_change_n(b, &prev_fanout);
> > +               const char *v;
> 
> This declaration of 'v' shadows the 'v' added by patch 8/16 earlier in
> the function.

Thanks.  I reordered the patches before sending, so when this one was
originally written, there was no "v" at the top-level of the function.
I think we can just drop this interior one. The point of the short "v"
is that it can be used as a temporary value for prefix matches, so I
think we can just reuse the same one.

I tried compiling with -Wshadow (which I don't usually do), but we're
not even close to compiling clean there. Some of them are legitimately
confusing (e.g., try figuring out "end" in parse_rev_note). But others
look just annoying (e.g., complaining that a local "usage" conflicts
with the global function). I don't know if we want to put effort into
being -Wshadow clean or not.

-Peff
