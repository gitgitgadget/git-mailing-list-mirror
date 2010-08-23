From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Compiling git with makepp patch
Date: Mon, 23 Aug 2010 09:47:06 +0200
Message-ID: <201008230947.06777.trast@student.ethz.ch>
References: <84FD9808A65CDF4C959FDB41FC3D134CBCF306D6@MSSRVS4.atlas.de> <4C71A53F.2020108@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: <occitan@esperanto.org>
X-From: git-owner@vger.kernel.org Mon Aug 23 09:47:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnRkm-0003F5-VE
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 09:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367Ab0HWHrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 03:47:32 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:48261 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752813Ab0HWHrb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 03:47:31 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 23 Aug
 2010 09:47:29 +0200
Received: from thomas.site (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.0.702.0; Mon, 23 Aug
 2010 09:47:07 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <4C71A53F.2020108@t-online.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154205>

Daniel Pfeiffer wrote:
> [Attachment: git-makepp.patch]

Please read Documentation/SubmittingPatches for next time.

> There are however two things which I can hardly hope to fix:
[...]
> PERL_PATH_SQ  = $(subst ','\'',$(PERL_PATH))#'
> 
> [...] makepp parses this line just like Emacs, so it doesn't find
> the comment, adding in the #' at the point of use, which completely
> screws the sed command.
[...]
>  # Shell quote;
> -bindir_SQ = $(subst ','\'',$(bindir))#'
> -gitwebdir_SQ = $(subst ','\'',$(gitwebdir))#'
> -gitwebstaticdir_SQ = $(subst ','\'',$(gitwebdir)/static)#'
> -SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))#'
> -PERL_PATH_SQ  = $(subst ','\'',$(PERL_PATH))#'
> -DESTDIR_SQ    = $(subst ','\'',$(DESTDIR))#'
> +Q='
> +# ' This comment is only to appease IDEs like Emacs.
> +# The comment is on a new line, else makepp would see it as a quoted hash.
> +bindir_SQ = $(subst $Q,'\'',$(bindir))
> +gitwebdir_SQ = $(subst $Q,'\'',$(gitwebdir))
> +gitwebstaticdir_SQ = $(subst $Q,'\'',$(gitwebdir)/static)
> +SHELL_PATH_SQ = $(subst $Q,'\'',$(SHELL_PATH))
> +PERL_PATH_SQ  = $(subst $Q,'\'',$(PERL_PATH))
> +DESTDIR_SQ    = $(subst $Q,'\'',$(DESTDIR))

Confusingly, you talk about comments above, but the real issue is that
your makepp apparently gives the ' special meaning.  For once "info
make" and "man 1p make" on my system agree on the semantics of ': none
at all.  From the latter:

  Early proposals stated that an "unquoted" number sign  was  treated  as  the
  start of a comment. The make utility does not pay any attention to quotes. A
  number sign starts a comment regardless of its surroundings.

So can you quote chapter and verse to show that there is anything to
fix?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
