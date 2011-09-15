From: Jeff King <peff@peff.net>
Subject: Re: Problems with format-patch UTF-8 and a missing second empty line
Date: Thu, 15 Sep 2011 15:01:32 -0400
Message-ID: <20110915190132.GA17027@sigill.intra.peff.net>
References: <CAHz1FYgPuMHLC+f2mFqD73=NGXQSStRPDOsiCy-HtaWKbHu7NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ingo Ruhnke <grumbel@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 21:01:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4HBs-0004v3-2o
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 21:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756627Ab1IOTBf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Sep 2011 15:01:35 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50358
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754761Ab1IOTBe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 15:01:34 -0400
Received: (qmail 24799 invoked by uid 107); 15 Sep 2011 19:02:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 Sep 2011 15:02:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Sep 2011 15:01:32 -0400
Content-Disposition: inline
In-Reply-To: <CAHz1FYgPuMHLC+f2mFqD73=NGXQSStRPDOsiCy-HtaWKbHu7NQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181487>

On Thu, Sep 15, 2011 at 11:45:15AM +0200, Ingo Ruhnke wrote:

> Creating a patch of a commit including UTF-8 and no empty second line=
,
> like this:

I already responded about the bug with utf8-encoded subjects, but let m=
e
address the second half of your mail, too:

> Here the newline between ABC\nABC gets stripped out and replaced with
> a space when transferring the commit with format-patch from one
> repository to another.

This is by design. Git commit messages are intended to have a
single-line subject, followed by a blank line, followed by more
elaboration. A multi-line subject is treated as a single line that has
been line-broken, and is subject to being reflowed onto a single line.
This is done to help with commits imported from other version control
systems which don't follow this pattern (the other option is truncating
the subject and putting the other lines into the "body", but that often
ends up quite unreadable).

If you really want to retain the newlines across "format-patch | am",
use the "-k" option of both to preserve the subject (I don't recall the
details, but I think you need a more recent version of git for
format-patch to correctly encode this, but "am" can be from any
version).

> Another small issue is that the filename of the patch will strip out
> any UTF-8 characters, Thus a commit message of "123=C3=84=C3=B6=C3=BC=
456" will result
> in "0001-123-456.patch".

Yes, it's an attempt to strip out characters that some filesystems migh=
t
not support well. We could probably enable high-bit characters with a
config option (maybe even just using core.quotepath).

-Peff
