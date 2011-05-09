From: Kacper Kornet <draenog@pld-linux.org>
Subject: Re: [PATCH 1/1] Honor $(prefix) set in config.mak* when defining
 ETC_GIT* and sysconfdir
Date: Mon, 9 May 2011 13:56:55 +0200
Message-ID: <20110509115655.GA18423@camk.edu.pl>
References: <4DC0E99E.6090402@viscovery.net>
 <20110504135827.GC18585@camk.edu.pl>
 <4DC1653A.7000000@viscovery.net>
 <7v4o5afht7.fsf@alter.siamese.dyndns.org>
 <7vwri5c27e.fsf@alter.siamese.dyndns.org>
 <20110505142910.GA31229@camk.edu.pl>
 <4DC2B814.5070507@viscovery.net>
 <20110505150036.GB31229@camk.edu.pl>
 <7vd3jxb16s.fsf@alter.siamese.dyndns.org>
 <4DC7A4D7.2050401@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon May 09 13:57:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJP5K-0004Ys-Oq
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 13:57:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508Ab1EIL5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 07:57:04 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:60463 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752352Ab1EIL5D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 07:57:03 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id A0A135F0048;
	Mon,  9 May 2011 13:57:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 7aHLZ79cCV0g; Mon,  9 May 2011 13:56:56 +0200 (CEST)
Received: from gatekeeper.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 0B6C45F0046;
	Mon,  9 May 2011 13:56:56 +0200 (CEST)
Received: by gatekeeper.camk.edu.pl (Postfix, from userid 1293)
	id ECBFB80B9E; Mon,  9 May 2011 13:56:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DC7A4D7.2050401@viscovery.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173224>

On Mon, May 09, 2011 at 10:24:55AM +0200, Johannes Sixt wrote:
> --- 8< ---
> From: Johannes Sixt <j6t@kdbg.org>
> Subject: [PATCH] Honor $(prefix) set in config.mak* when defining ETC_GIT*

> Notice that the prefix specified for the build influenced the definitions
> of ETC_GITCONFIG and ETC_GITATTRIBUTES only when it was exactly '/usr'.
> Kacper Kornet noticed that this was furthermore only the case when the
> build was triggered using 'make prefix=/usr', i.e., the prefix was given
> on the command line; it did not work when the prefix was specified in
> config.mak because this file is included much later in the Makefile.

> To fix this, move the conditional after the inclusion of config.mak.

> Additionally, it is desirable to specify the etc directory for a build
> (for example, a build with prefix /usr/local may still want to have the
> system configuration in /etc/gitconfig). For this purpose, promote the
> variable 'sysconfdir' from a helper variable to a configuration
> variable. The prefix check that was moved must now be wrapped so that it
> does not override sysconfdir setting given in config.mak.

> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  Makefile |   18 +++++++++---------
>  1 files changed, 9 insertions(+), 9 deletions(-)

> diff --git a/Makefile b/Makefile
> index ca4b38e..10d6bd5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -274,8 +274,7 @@ STRIP ?= strip
>  #   mandir
>  #   infodir
>  #   htmldir
> -#   ETC_GITCONFIG (but not sysconfdir)
> -#   ETC_GITATTRIBUTES
> +#   sysconfdir
>  # can be specified as a relative path some/where/else;
>  # this is interpreted as relative to $(prefix) and "git" at
>  # runtime figures out where they are based on the path to the executable.
> @@ -291,15 +290,8 @@ sharedir = $(prefix)/share
>  gitwebdir = $(sharedir)/gitweb
>  template_dir = share/git-core/templates
>  htmldir = share/doc/git-doc
> -ifeq ($(prefix),/usr)
> -sysconfdir = /etc
>  ETC_GITCONFIG = $(sysconfdir)/gitconfig
>  ETC_GITATTRIBUTES = $(sysconfdir)/gitattributes
> -else
> -sysconfdir = $(prefix)/etc
> -ETC_GITCONFIG = etc/gitconfig
> -ETC_GITATTRIBUTES = etc/gitattributes
> -endif
>  lib = lib
>  # DESTDIR=
>  pathsep = :
> @@ -1192,6 +1184,14 @@ endif
>  -include config.mak.autogen
>  -include config.mak

> +ifndef sysconfdir
> +ifeq ($(prefix),/usr)
> +sysconfdir = /etc
> +else
> +sysconfdir = etc
> +endif
> +endif
> +
>  ifdef CHECK_HEADER_DEPENDENCIES
>  COMPUTE_HEADER_DEPENDENCIES =
>  USE_COMPUTED_HEADER_DEPENDENCIES =

For me it looks all right. Thanks for writing the patch instead of me. 
-- 
  Kacper Kornet
