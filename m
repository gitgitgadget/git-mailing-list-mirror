From: Jeff King <peff@peff.net>
Subject: Re: RFC: git cat-file --follow-symlinks?
Date: Thu, 30 Apr 2015 15:51:35 -0400
Message-ID: <20150430195135.GA6742@peff.net>
References: <20150429214817.GA2725@peff.net>
 <1430346576.14907.40.camel@ubuntu>
 <20150429231150.GB3887@peff.net>
 <20150430003750.GA4258@peff.net>
 <1430355983.14907.55.camel@ubuntu>
 <20150430011612.GA7530@peff.net>
 <1430358345.14907.62.camel@ubuntu>
 <20150430033725.GB12361@peff.net>
 <1430421924.22711.57.camel@ubuntu>
 <xmqqegn1z9fp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>,
	git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 21:51:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnuUu-0005uN-NN
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 21:51:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752992AbbD3Tvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 15:51:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:52489 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752989AbbD3Tvi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2015 15:51:38 -0400
Received: (qmail 15327 invoked by uid 102); 30 Apr 2015 19:51:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Apr 2015 14:51:38 -0500
Received: (qmail 8955 invoked by uid 107); 30 Apr 2015 19:52:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Apr 2015 15:52:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Apr 2015 15:51:35 -0400
Content-Disposition: inline
In-Reply-To: <xmqqegn1z9fp.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268099>

On Thu, Apr 30, 2015 at 12:46:02PM -0700, Junio C Hamano wrote:

> David Turner <dturner@twopensource.com> writes:
> 
> > The weirdest case is log.  If I say git log HEAD^{resolve} --
> > foo/bar/baz,...
> 
> That invocation does not make any sense to me, at least within the
> context of what has been discussed for ^{resolve}, which is an
> instruction to the "name to object name" mapping layer to notice
> symbolic links while it traverses the tree containment relationships
> starting from the root of the tree to arrive at a single object
> name.
> 
>     git rev-parse HEAD^{resolve}:path/that/might/involve/symlink/some/where
>     git cat-file HEAD^{resolve}:path/that/might/involve/symlink/some/where
>     git grep -e pattern HEAD^{resolve}:path/that/might/involve/symlink/some/where
> 
> would, though.  In other words, ^{resolve} that is not followed by a
> colon and path is something entirely different from what we have
> been discussing.

Yeah, I agree that HEAD^{resolve} without a colon does not make any
sense. In fact, I wanted to originally suggest a syntax that replaced
the colon with something else, to make it clear that it the modifier is
really about the colon. But I could not think of a character that was
readable and would not have backward-compatibility issues.

I guess you could spell it:

  HEAD^{resolve:foo/bar/baz}

but that opens up parsing questions for the filename. Would we allow "}"
in the filename? Or require that the "}" balance, which means
speculative parsing if there is more content after the trailing "}"
(e.g., you could in theory resolve to a tree and then stick a ":" with
more path after that. Yech).

-Peff
