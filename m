From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH] More build output cleaning up
Date: Sun, 11 Mar 2007 18:48:27 +0300
Message-ID: <20070311184827.a98691c3.vsu@altlinux.ru>
References: <81b0412b0703061513g7aafc9daq46feea69d969089a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sun__11_Mar_2007_18_48_27_+0300_xWJ./ZAmYA3wTTaZ"
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 11 16:49:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQQIq-0002Vu-OU
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 16:49:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933784AbXCKPtk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 11:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933785AbXCKPtk
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 11:49:40 -0400
Received: from master.altlinux.org ([62.118.250.235]:1449 "EHLO
	master.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933784AbXCKPtj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 11:49:39 -0400
Received: by master.altlinux.org (Postfix, from userid 584)
	id 55C00E3EC6; Sun, 11 Mar 2007 18:49:38 +0300 (MSK)
In-Reply-To: <81b0412b0703061513g7aafc9daq46feea69d969089a@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.6; x86_64-alt-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41932>

--Signature=_Sun__11_Mar_2007_18_48_27_+0300_xWJ./ZAmYA3wTTaZ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 7 Mar 2007 00:13:08 +0100 Alex Riesen wrote:

> - print output file name for .c files
> - suppress output of the names of subdirectories when make changes into them
> - use GEN prefix for makefile generation in perl/
>
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
>  Makefile      |    8 +++++---
>  perl/Makefile |    2 +-
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 72d4291..eb6c421 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -605,14 +605,16 @@ ifdef NO_PERL_MAKEMAKER
>  	export NO_PERL_MAKEMAKER
>  endif
>  ifndef V
> -	QUIET_CC       = @echo '   ' CC $<;
> +	QUIET_CC       = @echo '   ' CC $@;
>  	QUIET_AR       = @echo '   ' AR $@;
>  	QUIET_LINK     = @echo '   ' LINK $@;
>  	QUIET_BUILT_IN = @echo '   ' BUILTIN $@;
>  	QUIET_GEN      = @echo '   ' GEN $@;
>  	QUIET_SUBDIR0  = @subdir=
> -	QUIET_SUBDIR1  = ;echo '   ' SUBDIR $$subdir; $(MAKE) -C$$subdir
> +	QUIET_SUBDIR1  = ;echo '   ' SUBDIR $$subdir; \
> +			 $(MAKE) --no-print-directory -C $$subdir

Using --no-print-directory will break movement to the location of an
error/warning message at least in vim (emacs will probably have
problems too), if the error is in some file in a subdirectory.  The
problem is that the nested make will output paths relative to the
subdirectory, but without "Entering directory..." messages the editor
will not know that filenames should be interpreted relative to that
subdirectory.

Currently this problem is not visible, because subdirectories with
their own Makefiles (perl/ and git-gui/) do not contain C code - but
the problem will appear, e.g., if Git.xs will be added again.

--Signature=_Sun__11_Mar_2007_18_48_27_+0300_xWJ./ZAmYA3wTTaZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.1 (GNU/Linux)

iD8DBQFF9CTPW82GfkQfsqIRAiRwAJ9/Bp8YwFQmTGeH9IcGC1ikXA6OqwCeNkGf
p2Osy0u0Xs6bAIkwupU0L18=
=TqBt
-----END PGP SIGNATURE-----

--Signature=_Sun__11_Mar_2007_18_48_27_+0300_xWJ./ZAmYA3wTTaZ--
