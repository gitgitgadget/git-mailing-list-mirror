From: Jeff King <peff@peff.net>
Subject: Re: git diff-tree output inconsistency?
Date: Thu, 7 Apr 2011 15:08:32 -0400
Message-ID: <20110407190832.GA18842@sigill.intra.peff.net>
References: <20110407135938.GA322@regex.yaph.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Arjen Laarhoven <arjen@yaph.org>
X-From: git-owner@vger.kernel.org Thu Apr 07 21:08:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7uZN-0006jo-UE
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 21:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756681Ab1DGTIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 15:08:36 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40872
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756677Ab1DGTIf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2011 15:08:35 -0400
Received: (qmail 22679 invoked by uid 107); 7 Apr 2011 19:09:22 -0000
Received: from 70-36-146-44.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.44)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 07 Apr 2011 15:09:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Apr 2011 15:08:32 -0400
Content-Disposition: inline
In-Reply-To: <20110407135938.GA322@regex.yaph.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171078>

On Thu, Apr 07, 2011 at 03:59:38PM +0200, Arjen Laarhoven wrote:

> I was fiddling with the git-diff-tree command to retrieve a list of
> files which have in a commit:
> 
> $ git diff-tree --name-only HEAD
> 
> According to the documentation, the output starts with the SHA-1 of the
> tree-ish given, after which the list of changed files follows.  This is
> the case when just one commit-id is given.
> 
> However, when given 2 tree-ish objects, the separate line with the SHA-1
> is not shown.
> 
> I browsed through the code and the history for diff-tree.c, but couldn't
> find an explanation for the inconsistency.  The documentation for the
> --no-commit-id confuses me a bit more, as it states that the commit id
> is shown 'when applicable'.  Unfortunately, it fails to explain when
> exactly that is :-)
> 
> Have I found a documentation bug/shortcoming, is it a code bug or am I
> misunderstanding something else?

I think it's a documentation bug. The sha1 is shown only when a single
tree-ish is given (either on the command line, or via --stdin). This is
a historical behavior, as one of the original uses of diff-tree was
to implement log as:

  git rev-list | git diff-tree --stdin

You can even do "git diff-tree --stdin --pretty=medium" to get the full
log-ish output.  These days, though, log does everything in one process.

But I don't think we make that clear anywhere in the diff-tree manpage.

-Peff
