From: Jeff King <peff@peff.net>
Subject: Re: Are author names ending with a dot invalid?
Date: Fri, 18 May 2012 20:23:35 -0400
Message-ID: <20120519002335.GD765@sigill.intra.peff.net>
References: <CAMP44s2OoxUVFE57e8C2Km7rcGn88KkLXxdaA3s5RE6nZ7TU=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 19 02:23:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVXSS-0005jG-Do
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 02:23:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932827Ab2ESAXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 20:23:40 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48885
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932552Ab2ESAXj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 20:23:39 -0400
Received: (qmail 9923 invoked by uid 107); 19 May 2012 00:24:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 18 May 2012 20:24:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 May 2012 20:23:35 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s2OoxUVFE57e8C2Km7rcGn88KkLXxdaA3s5RE6nZ7TU=A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197999>

On Fri, May 18, 2012 at 02:14:57AM +0200, Felipe Contreras wrote:

> It looks like authors ending with a dot ('Foo Jr. <foo@bar.com>') are
> converted without a dot ('Foo Jr <foo@bar.com>') is that intentional?

I was just digging in this code today, and I noticed the same thing. The
culprit is ident.c:copy, which strips magic characters from the
beginning, end, and middle. Except that the set of magic characters is
different at the edges (see ident.c:crud), and in the middle ("<", ">",
"\n").

This dates all the way back to 6aa33f4 (Abstract out the "name <email>
date" handling of commit-tree.c, 2005-07-12), which in turn was adapting
code from earlier (though it also has the issue).

So I think it's intentional, but I also think it's wrong, and it's
simply that nobody has complained about it, because it's not that
common.

-Peff
