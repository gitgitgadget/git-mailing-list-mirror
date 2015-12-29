From: Jeff King <peff@peff.net>
Subject: [PATCH 0/14] counting trailers with shortlogs
Date: Tue, 29 Dec 2015 02:18:47 -0500
Message-ID: <20151229071847.GA8726@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 08:18:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDoYY-0005bU-H5
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 08:18:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530AbbL2HSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 02:18:51 -0500
Received: from cloud.peff.net ([50.56.180.127]:46606 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751891AbbL2HSu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 02:18:50 -0500
Received: (qmail 17612 invoked by uid 102); 29 Dec 2015 07:18:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 01:18:50 -0600
Received: (qmail 19748 invoked by uid 107); 29 Dec 2015 07:19:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 02:19:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Dec 2015 02:18:47 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283091>

I happened to be reading an old discussion on trailers a few weeks ago,
and the idea was mentioned of providing access to commit trailers in a
more structured way from traversal commands. E.g., we could presumably
have a log pretty-format for showing "Signed-off-by", like
"%(trailer:signed-off-by)" or something. But that opens up a lot of
questions, like the exact formatting, whether we would allow wildcards
("*-by:"), and if so how that affects formatting.

So I took the cowards way out and implemented trailer support for
git-shortlog, which seemed much simpler. I'll admit I haven't used it
for anything so far beyond a few "fun" queries, but it does provide some
infrastructure we could use later for git-log.

And things being what they are, I ended up with a few cleanups and
optimizations along the way. After this series, a regular "shortlog -ns"
is about 10% faster.

  [01/14]: move string functions out of git-compat-util
  [02/14]: log: refactor add_header to drop some magic numbers
  [03/14]: strutil: add skip_prefix_case
  [04/14]: shortlog: use skip_prefix_icase to parse "Author" lines
  [05/14]: shortlog: use strbufs to read from stdin
  [06/14]: shortlog: replace hand-parsing of author with pretty-printer
  [07/14]: shortlog: optimize "--summary" mode
  [08/14]: shortlog: optimize out useless "<none>" normalization
  [09/14]: shortlog: optimize out useless string list
  [10/14]: shortlog: change "author" variables to "ident"
  [11/14]: shortlog: allow grouping by committer ident
  [12/14]: trailer: factor out config reading
  [13/14]: trailer: add interface for parsing commit trailers
  [14/14]: shortlog: match commit trailers with --ident

-Peff
