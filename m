From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/15] Rearrange xcalloc arguments
Date: Tue, 27 May 2014 21:16:58 -0400
Message-ID: <20140528011658.GA17688@sigill.intra.peff.net>
References: <1401118436-66090-1-git-send-email-modocache@gmail.com>
 <20140526233741.GB8570@hudson.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: Jeremiah Mahler <jmmahler@gmail.com>,
	Brian Gesiak <modocache@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 28 03:17:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpSUM-000542-9V
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 03:17:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068AbaE1BRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 21:17:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:60676 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751379AbaE1BRA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 21:17:00 -0400
Received: (qmail 14529 invoked by uid 102); 28 May 2014 01:17:00 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 May 2014 20:17:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 May 2014 21:16:58 -0400
Content-Disposition: inline
In-Reply-To: <20140526233741.GB8570@hudson.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250254>

On Mon, May 26, 2014 at 04:37:41PM -0700, Jeremiah Mahler wrote:

> > xcalloc takes two arguments: the number of elements and their size.
> > The vast majority of the Git codebase passes these arguments in the
> > correct order, but there are some exceptions. This patch series
> > corrects those exceptions.
> > 
> 
> Let me see if I understand the issue underlying this patch set.
> 
> xcalloc works like calloc and takes two arguments, the number of
> elements and the size of each element.  However, many calls specified
> these arguments in the reverse order.  It didn't produce a compile
> error because both arguments are the same type.  And it didn't produce
> a run time error because A*B is the same as B*A.

Yes, I think that is a good summary.

It may be theoretically possible that an implementation of calloc()
can use the distinction between the two arguments to adjust the padding
or alignment of the result. However, I don't know if any implementation
actually does this, or if it is even true in theory. You can find
some discussions[1,2] online, but nothing conclusive. The most plausible
theory I saw is that early K&R C may have done something clever here,
but ANSI C alignment requirements effectively remove any wiggle room for
the implementation.

But it certainly does not hurt to follow the spec and be consistent.

-Peff

[1] http://stackoverflow.com/questions/501839/is-calloc4-6-the-same-as-calloc6-4

[2] https://groups.google.com/d/msg/comp.lang.c/jZbiyuYqjB4/NIAmeNd11IoJ
