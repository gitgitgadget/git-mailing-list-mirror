From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] git-fast-import.txt: improve documentation for
 quoted paths
Date: Thu, 29 Nov 2012 13:11:42 -0500
Message-ID: <20121129181141.GA17309@sigill.intra.peff.net>
References: <vpq624omjn4.fsf@grenoble-inp.fr>
 <1354208455-21228-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Nov 29 19:12:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te8ad-0000nr-MY
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 19:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752364Ab2K2SLo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 13:11:44 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41305 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751100Ab2K2SLo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 13:11:44 -0500
Received: (qmail 24074 invoked by uid 107); 29 Nov 2012 18:12:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 Nov 2012 13:12:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Nov 2012 13:11:42 -0500
Content-Disposition: inline
In-Reply-To: <1354208455-21228-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210853>

On Thu, Nov 29, 2012 at 06:00:54PM +0100, Matthieu Moy wrote:

> The documentation mentionned only newlines and double quotes as

s/nn/n/

> diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
> index 6603a7a..35b909c 100644
> --- a/Documentation/git-fast-import.txt
> +++ b/Documentation/git-fast-import.txt
> @@ -558,8 +558,9 @@ A `<path>` string must use UNIX-style directory separators (forward
>  slash `/`), may contain any byte other than `LF`, and must not
>  start with double quote (`"`).
>  
> -If an `LF` or double quote must be encoded into `<path>` shell-style
> -quoting should be used, e.g. `"path/with\n and \" in it"`.
> +If an `LF`, backslash or double quote must be encoded into `<path>`
> +shell-style quoting should be used, and the complete name should be
> +surrounded with double quotes e.g. `"path/with\n, \\ and \" in it"`.

I think the point of the original is that you do not _need_ to quote
unless you have those two characters. IOW, you can do:

  M 100644 :1 file \with \backslashes

and it will stay in the "literal to the end of line" code path because
the path does not begin with a double-quote. It is only when you trigger
the "shell-style quoting" code path is in effect that you must then
follow the rules of that quoting (which includes escaping backslashes).
So technically, your modification to the beginning of the sentence is
not correct.

That being said, I think what you have written is more helpful to an end
user. There is no harm in quoting when we do not have to, as fast-import
implementations must know how to unquote anyway (and we over-quote in
fast-export in this case). And while the example above does work (and
was always designed to), it is sort of an unintuitive area that I would
not be surprised to see other fast-import implementations get wrong. As
a writer of a stream, it probably pays to be defensive and err on the
side of quoting more.

As for the text itself, a few minor punctuation suggestions:

> If an `LF`, backslash or double quote must be encoded
                       ^
                       missing comma as list delimiter

> into `<path>` shell-style quoting should be used, and the complete
               ^
               missing comma in if/then clause

This one was in the original as well, but it makes it harder to read and
is worth fixing.

> surrounded with double quotes e.g. `"path/with\n, \\ and \" in it"`.

Should the parenthetical be in parentheses (or a separate sentence)?

-Peff
