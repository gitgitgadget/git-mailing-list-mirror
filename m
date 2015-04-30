From: Jeff King <peff@peff.net>
Subject: Re: RFC: git cat-file --follow-symlinks?
Date: Thu, 30 Apr 2015 14:49:44 -0400
Message-ID: <20150430184944.GA3661@peff.net>
References: <20150430011612.GA7530@peff.net>
 <1430358345.14907.62.camel@ubuntu>
 <20150430033725.GB12361@peff.net>
 <xmqqfv7i2n81.fsf@gitster.dls.corp.google.com>
 <5541E3D4.7040207@alum.mit.edu>
 <1430417023.22711.8.camel@ubuntu>
 <xmqqzj5pzdfo.fsf@gitster.dls.corp.google.com>
 <1430418522.22711.22.camel@ubuntu>
 <20150430183226.GA2855@peff.net>
 <1430419490.22711.30.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 20:50:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YntX7-0002qs-24
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 20:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752927AbbD3Stt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 14:49:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:52413 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752759AbbD3Str (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2015 14:49:47 -0400
Received: (qmail 12300 invoked by uid 102); 30 Apr 2015 18:49:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Apr 2015 13:49:47 -0500
Received: (qmail 7951 invoked by uid 107); 30 Apr 2015 18:50:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Apr 2015 14:50:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Apr 2015 14:49:44 -0400
Content-Disposition: inline
In-Reply-To: <1430419490.22711.30.camel@ubuntu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268091>

On Thu, Apr 30, 2015 at 11:44:50AM -0700, David Turner wrote:

> > git ls-tree HEAD -- BUILD ?
> 
> This does not actually seem to work (even with -r); it only recurses
> into directories that are named BUILD, rather than being equivalent to
> git ls-tree -r HEAD |grep /BUILD$.

Ah, I thought that was what you wanted (to find specific files, not a
pattern). I think `ls-tree` doesn't understand our normal pathspecs, for
historical reasons.

> Also, BUILD files are scattered throughout the tree, so the entire tree
> would still need to be traversed.  At present, our monorepo is not quite
> large enough for this to matter (a full ls-tree only takes me 0.6s), but
> it is growing.

But aren't you asking git to do that internally? I.e., it can limit the
traversal for a prefix-match, but it cannot do so for an arbitrary
filename. It has to open every tree. So the extra expense is really just
the I/O over the pipe. That's not optimal, but it is a constant factor
slowdown from what git would do internally.

-Peff
