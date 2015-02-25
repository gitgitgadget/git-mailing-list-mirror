From: Jeff King <peff@peff.net>
Subject: Re: feature request: excluding files/paths from "git grep"
Date: Wed, 25 Feb 2015 14:11:08 -0500
Message-ID: <20150225191108.GA17467@peff.net>
References: <54EDBEC2.8090107@peralex.com>
 <CACsJy8AM=W4f6u_7YpvmfiBwrJjqfJMJoq6CQYfKOh+qD6rF3Q@mail.gmail.com>
 <20150225143116.GA13567@peff.net>
 <xmqqk2z5on72.fsf@gitster.dls.corp.google.com>
 <20150225185128.GA16569@peff.net>
 <xmqqbnkholx9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>, Noel Grandin <noel@peralex.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 20:11:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQhMa-0006lH-9M
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 20:11:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753072AbbBYTLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2015 14:11:11 -0500
Received: from cloud.peff.net ([50.56.180.127]:53288 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752557AbbBYTLK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2015 14:11:10 -0500
Received: (qmail 8446 invoked by uid 102); 25 Feb 2015 19:11:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Feb 2015 13:11:10 -0600
Received: (qmail 17842 invoked by uid 107); 25 Feb 2015 19:11:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Feb 2015 14:11:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Feb 2015 14:11:08 -0500
Content-Disposition: inline
In-Reply-To: <xmqqbnkholx9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264406>

On Wed, Feb 25, 2015 at 11:01:22AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So I think _if_ using "diff" attributes is enough for this purpose, then
> > there is no code to be written.  But if somebody wants to draw a
> > distinction between the uses (I want to diff "foo" files, but never see
> > them in grep) then we could introduce a "grep" attribute (with the
> > fallback being the value of the "diff" attribute for that path).
> 
> That is all true.
> 
> If we were to have a new 'grep' attribute that can be used to
> express 'It is OK to diff two versions of this path, but hits by
> grep in this path is useless' (and verse versa), the built-in macro
> attribute 'binary' should also be updated with it.  A path being
> 'binary' currently means '-diff -merge -text' but it should also
> mean '-grep' in the new world, if we were to go in that direction.

I think it would do so automatically. There is no "grep" attribute
given, so we fall back to the "-diff" attribute. But I do not mind
modifying the macro to be more explicit.

Note also that I am not volunteering to work on this, nor am I convinced
it's actually worth pursuing. I've yet to see a useful case where you
would want text diffs but not greps (or vice versa), and if we can avoid
cluttering the attribute space, we should. I was mostly pointing it out
that it is not logically inconsistent to want such a thing. :)

If somebody does look into it, I suspect the place to start is modifying
userdiff_find_by_path to optionally prefer "grep" to "diff".

-Peff
