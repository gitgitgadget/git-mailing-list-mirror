From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 0/3] compiling git with gcc -O3 -Wuninitialized
Date: Sat, 15 Dec 2012 05:09:55 -0500
Message-ID: <20121215100954.GA21577@sigill.intra.peff.net>
References: <20121214220903.GA18418@sigill.intra.peff.net>
 <CACsJy8BqOEvEHy7i89fKSgQH5kUYFWvchJwD_fQsYjagrh+X2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 11:10:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjohW-0002P9-Lt
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 11:10:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544Ab2LOKKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 05:10:07 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55326 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751057Ab2LOKKG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 05:10:06 -0500
Received: (qmail 19339 invoked by uid 107); 15 Dec 2012 10:11:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 15 Dec 2012 05:11:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 15 Dec 2012 05:09:55 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8BqOEvEHy7i89fKSgQH5kUYFWvchJwD_fQsYjagrh+X2w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211526>

On Sat, Dec 15, 2012 at 10:07:54AM +0700, Nguyen Thai Ngoc Duy wrote:

> > If get_foo() is not inlined, then when compiling some_fun, gcc sees only
> > that a pointer to the local variable is passed, and must assume that it
> > is an out parameter that is initialized after get_foo returns.
> >
> > However, when get_foo() is inlined, the compiler may look at all of the
> > code together and see that some code paths in get_foo() do not
> > initialize the variable. And we get the extra warnings.
> 
> Other options:
> 
>  - Any __attribute__ or #pragma to aid flow analysis (or would gcc dev be
>    willing to add one)?

I looked through the full list of __attribute__ flags and couldn't find
anything that would help.

>  - Maintain a list of false positives and filter them out from gcc output?

I think it would be just as simple to use the "int foo = foo" hack,
which accomplishes the same thing without any post-processing step.

> And if we do this, should we support other compilers as well? I tried
> clang once a long while ago and got a bunch of warnings iirc.

I don't use clang myself, but I don't have any problem with other people
submitting patches to clean up its warnings, provided they don't make
the code harder to read or write.

-Peff
