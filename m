From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/1] Honor $(prefix) set in config.mak* when defining
 ETC_GIT* and sysconfdir
Date: Tue, 03 May 2011 08:42:14 +0200
Message-ID: <4DBFA3C6.8060209@viscovery.net>
References: <20110428022922.GC4833@camk.edu.pl> <7v62py5nbp.fsf@alter.siamese.dyndns.org> <20110428192751.GE4833@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kacper Kornet <kornet@camk.edu.pl>
X-From: git-owner@vger.kernel.org Tue May 03 08:42:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QH9JR-0001lI-TJ
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 08:42:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473Ab1ECGmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 02:42:20 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:62007 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752019Ab1ECGmU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 02:42:20 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QH9JH-0007ri-Cd; Tue, 03 May 2011 08:42:15 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 1FBA71660F;
	Tue,  3 May 2011 08:42:15 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <20110428192751.GE4833@camk.edu.pl>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172647>

Please do not set Mail-Followup-To!! It makes communication on this list
extremely inconvenient.

Am 4/28/2011 21:27, schrieb Kacper Kornet:
> Definitions of ETC_GITCONFIG, ETC_GITATTRIBUTES and sysconfdir depend on
> value of prefix. As prefix can be changed in config.mak.autogen, all if
> blocks with conditions based on prefix should be placed after the file
> is included in Makefile.
> 
> Signed-off-by: Kacper Kornet <draenog@pld-linux.org>
> ---
>  Makefile |   19 ++++++++++---------
>  1 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index cbc3fce..bf912b9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -291,15 +291,8 @@ sharedir = $(prefix)/share
>  gitwebdir = $(sharedir)/gitweb
>  template_dir = share/git-core/templates
>  htmldir = share/doc/git-doc
> -ifeq ($(prefix),/usr)
> -sysconfdir = /etc
> -ETC_GITCONFIG = $(sysconfdir)/gitconfig
> -ETC_GITATTRIBUTES = $(sysconfdir)/gitattributes
> -else
> -sysconfdir = $(prefix)/etc
> -ETC_GITCONFIG = etc/gitconfig
> -ETC_GITATTRIBUTES = etc/gitattributes
> -endif
> +ETC_GITCONFIG = $(git_etcdir)/gitconfig
> +ETC_GITATTRIBUTES = $(git_etcdir)/gitattributes
>  lib = lib
>  # DESTDIR=
>  pathsep = :
> @@ -1192,6 +1185,14 @@ endif
>  -include config.mak.autogen
>  -include config.mak
>  
> +ifeq ($(prefix),/usr)
> +sysconfdir = /etc
> +git_etcdir = /etc
> +else
> +sysconfdir = $(prefix)/etc
> +git_etcdir = etc
> +endif
> +
>  ifdef CHECK_HEADER_DEPENDENCIES
>  COMPUTE_HEADER_DEPENDENCIES =
>  USE_COMPUTED_HEADER_DEPENDENCIES =

Does this patch do anything useful? After the patch is applied, sysconfdir
is set-but-not-used. Therefore, you can remove the assignments. But then
you lose the reference to $(prefix) that the commit message claims is so
important. Puzzled...

-- Hannes
