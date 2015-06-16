From: Jeff King <peff@peff.net>
Subject: [PATCH/RFC 0/3] add GIT_TRACE_STDIN
Date: Tue, 16 Jun 2015 15:31:02 -0400
Message-ID: <20150616193102.GA15856@peff.net>
References: <20150612212526.GA25447@peff.net>
 <20150612212827.GC25757@peff.net>
 <CAHcr6HYvVR4uTmtegWHK0h+v_aVs4JVLsSwvjthGY3pb=-Q0yQ@mail.gmail.com>
 <20150616171005.GB18667@peff.net>
 <CAHcr6HYA=gpMTaJ5WOOmtEp+J4wBMz9D59fbByzsdBkPRf4CZQ@mail.gmail.com>
 <20150616171849.GD18667@peff.net>
 <CAHcr6Hbajyx5RV10rv2PWEa9ZyzyxA7jCx=auKxpnv3xjSjq7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Augie Fackler <augie@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 21:31:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4wZo-000645-H5
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 21:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756849AbbFPTbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 15:31:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:46990 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754384AbbFPTbF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 15:31:05 -0400
Received: (qmail 20097 invoked by uid 102); 16 Jun 2015 19:31:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Jun 2015 14:31:04 -0500
Received: (qmail 18205 invoked by uid 107); 16 Jun 2015 19:31:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Jun 2015 15:31:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Jun 2015 15:31:02 -0400
Content-Disposition: inline
In-Reply-To: <CAHcr6Hbajyx5RV10rv2PWEa9ZyzyxA7jCx=auKxpnv3xjSjq7Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271788>

On Tue, Jun 16, 2015 at 01:23:31PM -0400, Augie Fackler wrote:

> > I guess there is really room for both. Just because you _can_ accomplish
> > the same thing with both does not mean we cannot have two ways to do it
> > (an easy way, and a harder, more flexible way).
> 
> *nod* that might make the most sense - given that we both seem to have
> use cases in mind for verbatim packs on pulls, that seems like a good
> thing to have easy to deploy.

My ulterior motive is that I actually already have a similar thing in
place _just_ for pack-objects, and I'd like to get rid of my custom
hack. :)

In that case it is not about saving the packfile, but rather saving the
parameters to create it (I was interested in finding out why git was
spending so much CPU to serve some particular requests, and being able
to run the same pack-generation repeatedly is helpful).

Here are the patches I came up with:

  [1/3]: trace: implement %p placeholder for filenames
  [2/3]: trace: add pid to each output line
  [3/3]: trace: add GIT_TRACE_STDIN

They apply on top of the TRACE_PACKFILE patches, only because they also
need the new trace_verbatim(). But I am not altogether happy with the
result; see the comments I'll add to 3/3.

-Peff
