From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitignore.txt: suggestions how to get literal # or ! at
 the beginning
Date: Sat, 6 Oct 2012 09:21:27 -0400
Message-ID: <20121006132127.GC11712@sigill.intra.peff.net>
References: <1349512701-29729-1-git-send-email-pclouds@gmail.com>
 <01ADED0717024E6F93B7FBADB1AEAE6B@PhilipOakley>
 <CACsJy8DObOJUSdDPEsTwAKjXMYiOyf7P_6oEE9xbU6QFz7rOxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 06 15:21:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKUK6-00029j-5J
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 15:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754245Ab2JFNVc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Oct 2012 09:21:32 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42903 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750965Ab2JFNVb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2012 09:21:31 -0400
Received: (qmail 6498 invoked by uid 107); 6 Oct 2012 13:22:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 06 Oct 2012 09:22:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 06 Oct 2012 09:21:27 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8DObOJUSdDPEsTwAKjXMYiOyf7P_6oEE9xbU6QFz7rOxQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207145>

On Sat, Oct 06, 2012 at 06:43:50PM +0700, Nguyen Thai Ngoc Duy wrote:

> On Sat, Oct 6, 2012 at 6:33 PM, Philip Oakley <philipoakley@iee.org> =
wrote:
> >> Asciidoc 8.2.6 does not like me writing
> >> "Put \# if you need a literal #.." so I go with "backslash" and
> >> "hash" instead. `\!` displays fine both in man page and html forma=
t.
> >> '!' changed to `!` because it looks clearer in monospace.
> >
> >
> > Why not put the backslash-hash in back quotes as well to give the s=
ame
> > look/feel consistency?
>=20
> Because asciidoc does not like \#, '\#' nor `\#`. It just shows \
> without # and I don't want to master asciidoc just to make it show \#=
=2E

It works fine for me with asciidoc 8.6.7. <sigh>

I would think the "inline literal" syntax started in 8.2.5 would take
care of it; maybe there were some bug fixes, considering how new it was
in your version.

I also think switching "!" to `!` is a slight regression; it will chang=
e
fonts in the HTML version, but usually not in the manpage, and the loss
of the quotes makes things harder to read. I would use both, and it doe=
s
not hurt to also spell out the name of the punctuation.

So this:

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 96639e0..c0a5851 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -73,12 +73,15 @@ PATTERN FORMAT
  - A blank line matches no files, so it can serve as a separator
    for readability.
=20
- - A line starting with # serves as a comment.
+ - A line starting with "`#`" serves as a comment.
+   Put a backslash ("`\`") in front of the first hash for the patterns
+   that start with a hash (i.e., "`\#`").
=20
- - An optional prefix '!' which negates the pattern; any
+ - An optional prefix "`!`" which negates the pattern; any
    matching file excluded by a previous pattern will become
    included again.  If a negated pattern matches, this will
-   override lower precedence patterns sources.
+   override lower precedence patterns sources. Use "`\!`" if
+   you need a literal "`!`" at the beginning of the pattern.
=20
  - If the pattern ends with a slash, it is removed for the
    purpose of the following description, but it would only find

renders to:

       =C2=B7   A line starting with "#" serves as a comment. Put a
           backslash ("\") in front of the first hash for the patterns
           that start with a hash (i.e., "\#").

       =C2=B7   An optional prefix "!" which negates the pattern; any
           matching file excluded by a previous pattern will become
           included again. If a negated pattern matches, this will
           override lower precedence patterns sources. Use "\!" if you
           need a literal "!" at the beginning of the pattern.

-Peff
