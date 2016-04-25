From: Jeff King <peff@peff.net>
Subject: Re: definition for _attribute() in remote.c
Date: Mon, 25 Apr 2016 17:10:30 -0400
Message-ID: <20160425211030.GA10309@sigill.intra.peff.net>
References: <D7C0C4062A7242B6912E56480CBB06F4@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 23:10:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aunmA-0003wu-BD
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 23:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964915AbcDYVKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 17:10:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:56061 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964811AbcDYVKd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 17:10:33 -0400
Received: (qmail 8143 invoked by uid 102); 25 Apr 2016 21:10:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 Apr 2016 17:10:32 -0400
Received: (qmail 5942 invoked by uid 107); 25 Apr 2016 21:10:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 Apr 2016 17:10:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Apr 2016 17:10:30 -0400
Content-Disposition: inline
In-Reply-To: <D7C0C4062A7242B6912E56480CBB06F4@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292558>

On Mon, Apr 25, 2016 at 10:02:38PM +0100, Philip Oakley wrote:

> I'm looking at getting Git for Windows to compile via Visual Studio
> (https://github.com/git-for-windows/git/pull/256).
> 
> However the use of __attribute() in remote.c at L1662
> (https://github.com/git-for-windows/git/blob/master/remote.c#L1662) has got
> me confused in that I can't see how the regular definition of __attribute()
> is #included in this case. A definition is given in
> git\compat\regex\regex_internal.h but doesn't appear to be on remote.c's
> include path.
> 
> The line was introduced by 3a429d0 (remote.c: report specific errors from
> branch_get_upstream, 2015-05-21) which appears to be later than the previous
> MSVC testers had looked at.

It should be handled in git-compat-util.h, which is included by cache.h,
which is included by remote.c.

There we have:

  #ifndef __GNUC__
  #ifndef __attribute__
  #define __attribute__(x)
  #endif
  #endif

which should make it a noop on compilers which don't know about it. Is
VS (or another file) setting __GNUC__?

-Peff
