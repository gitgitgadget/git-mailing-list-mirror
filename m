From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] mailmap from blobs
Date: Wed, 12 Dec 2012 05:58:23 -0500
Message-ID: <20121212105822.GA15842@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 12 11:58:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tik1b-00058K-Lg
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 11:58:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753736Ab2LLK6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 05:58:35 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42753 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751632Ab2LLK6e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 05:58:34 -0500
Received: (qmail 22578 invoked by uid 107); 12 Dec 2012 10:59:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Dec 2012 05:59:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Dec 2012 05:58:23 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211336>

I noticed recently that the GitHub contributions page for git.git did
not seem very accurate. The problem is that while it uses shortlog, it
does not respect .mailmap, because we do not have a working tree from
which to read the .mailmap.

This series adds a config option analogous to mailmap.file, but which
reads from a blob in the repository (so the obvious thing to set it to
is "HEAD:.mailmap" in a bare repo, and probably "master:.mailmap" if you
frequently want to traverse while on unrelated branches). The obvious
alternative is to checkout a temporary file of .mailmap and point
mailmap.file at it, but this is a bit more convenient.

A config option is perhaps not the most flexible way to access this. For
example, one could in theory want to pull the mailmap from the tip of
the history being traversed (e.g., because you have multiple unrelated
DAGs in a single repo). But that could also produce the _wrong_ results,
if you are looking at the shortlog of older history (e.g., when doing
"git shortlog v1.5.0..v1.5.5", you would still want to be using the
modern mailmap from "master").

By making it a config option, the simple, common case does the right
thing, and people with complex cases can use "git -c mailmap.blob=..."
to feed the appropriate map for the history they are traversing. If
somebody wants to do something fancier (like --mailmap-from-tip or
something), it would be easy to build on top later.

  [1/2]: mailmap: refactor mailmap parsing for non-file sources
  [2/2]: mailmap: support reading mailmap from blobs

-Peff
