From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] grep --no-index: allow use of "git grep" outside a git
 repository
Date: Mon, 18 Jan 2010 01:50:18 -0500
Message-ID: <20100118065018.GA18074@coredump.intra.peff.net>
References: <7vzl4fum3r.fsf_-_@alter.siamese.dyndns.org>
 <20100115210854.GA21540@coredump.intra.peff.net>
 <7vwrzin9jt.fsf@alter.siamese.dyndns.org>
 <20100116011512.GA27082@coredump.intra.peff.net>
 <7vpr5ait1m.fsf@alter.siamese.dyndns.org>
 <20100118015140.GB6831@coredump.intra.peff.net>
 <7v8wbwultw.fsf@alter.siamese.dyndns.org>
 <7v3a24ukku.fsf@alter.siamese.dyndns.org>
 <20100118055703.GA17879@coredump.intra.peff.net>
 <7vk4vgsz5w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 07:50:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWlRV-0001rz-RX
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 07:50:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995Ab0ARGuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 01:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751666Ab0ARGuX
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 01:50:23 -0500
Received: from peff.net ([208.65.91.99]:33610 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751218Ab0ARGuX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 01:50:23 -0500
Received: (qmail 2963 invoked by uid 107); 18 Jan 2010 06:55:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 18 Jan 2010 01:55:14 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jan 2010 01:50:18 -0500
Content-Disposition: inline
In-Reply-To: <7vk4vgsz5w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137372>

On Sun, Jan 17, 2010 at 10:30:19PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Hmm. I like the new behavior. The implementation feels a little
> > hack-ish, like we should really be supporting full-on:
> >
> >   git log --author=me --and --grep=foo
> >
> > That gets a little weird, though. We already have "--not" for ref
> > limiting, so clearly there is some conflict ...
> 
> That is fundamentally wrong.
> 
> Remember, "grep" works on two levels: a line matches or does not match the
> given set of patterns (rather, the expression given), and matched lines
> are shown.  A file as a whole is considered to have matched if one or more
> lines produced a match, or under the --all-match option, only when all of
> the top-level ORed terms in the expression have fired for some lines in
> it.

Fundamentally wrong for the way "log --grep" is currently implemented
perhaps, but I don't see anything wrong with considering each commit as
a single "record", just as regular grep considers each line to be a
record. That is a much more useful distinction for log traversal than
lines, which are useless from the user's perspective. If searching for
two terms, I care about whether they are in the same commit message, but
I don't care at all about line breaks.

Yes, I know that internally --author is really about line-matching the
commit headers, but that is an implementation detail. The mental model
we should present to the user is record-matching based on specific
fields like author, committer, or body text.

-Peff
