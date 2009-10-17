From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/5] Pretty formats for reflog data
Date: Fri, 16 Oct 2009 21:18:01 -0400
Message-ID: <20091017011801.GA31443@coredump.intra.peff.net>
References: <20091016053230.GB10629@coredump.intra.peff.net>
 <cover.1255701207.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jef Driesen <jefdriesen@hotmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Oct 17 03:18:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Myxvu-00019f-S9
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 03:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752911AbZJQBR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 21:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752311AbZJQBR7
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 21:17:59 -0400
Received: from peff.net ([208.65.91.99]:42645 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751986AbZJQBR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 21:17:59 -0400
Received: (qmail 19520 invoked by uid 107); 17 Oct 2009 01:21:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 16 Oct 2009 21:21:35 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Oct 2009 21:18:01 -0400
Content-Disposition: inline
In-Reply-To: <cover.1255701207.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130543>

On Fri, Oct 16, 2009 at 04:20:32PM +0200, Thomas Rast wrote:

> I tried for some time, but all attempts at interrupting the lists
> ended up terminating it again, so that the %g family list would not
> line up with the rest of the parameters.  Having the note there would
> be nice, but I think keeping the list together optically is more
> important.  However, AFAICS it really is the first character that only
> works with certain options (%m makes little sense without A...B, but
> still expands to >).

Another example is "%d", but there we load decorations on the fly the
first time it is used. I don't think that's a good idea here, since
using "%gd" shouldn't automatically imply "-g", which drastically
changes the nature of the command.

The "%m" behavior does what I would expect. If you haven't done any
limiting, then there can be no "left" or "boundary" entries.

I am tempted to do a note like the one below, but maybe the behavior is
obvious enough to users that it isn't necessary.

> Looking at it did make me notice that @{1} is invalid asciidoc and
> needs to be spelled @\{1\} though :-)

Thanks. I am often very guilty of not actually building documentation
when reviewing patches, because it is so tedious to build and examine.

---
diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 6359272..43192af 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -135,6 +135,12 @@ The placeholders are:
 - '%n': newline
 - '%x00': print a byte from a hex code
 
+NOTE: Some placeholders may depend on other options given to the
+revision traversal engine. For example, the `%g*` reflog options will
+insert an empty string unless we are traversing reflog entries (e.g., by
+`git log -g`). The `%d` placeholder will use the "short" decoration
+format if `--decorate` was not already provided on the command line.
+
 * 'tformat:'
 +
 The 'tformat:' format works exactly like 'format:', except that it
