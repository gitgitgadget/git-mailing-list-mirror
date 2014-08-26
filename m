From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] contrib/svn-fe: fix Makefile
Date: Tue, 26 Aug 2014 11:31:48 +0200
Message-ID: <53FC5404.7050403@web.de>
References: <1409057062-72857-1-git-send-email-satori@yandex-team.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Maxim Bublis <satori@yandex-team.ru>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 26 22:30:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMNO2-000239-Oi
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 22:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754498AbaHZUac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 16:30:32 -0400
Received: from mout.web.de ([212.227.15.4]:54121 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752427AbaHZUab (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 16:30:31 -0400
Received: from [192.168.2.130] ([130.246.150.208]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0LlsUC-1Wn2dC1pRo-00ZLbx; Tue, 26 Aug 2014 22:30:22
 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.7.0
In-Reply-To: <1409057062-72857-1-git-send-email-satori@yandex-team.ru>
X-Provags-ID: V03:K0:vzyQWWovfFfz12ByojpvyEAegRMys6iV3uScL5BcN4fI1ek06aJ
 l3oDziEfmDz5GbEqz5tPl1kqR+r30Q+WEEckmu5dkEdHg7eOPHA5WdUxTmFJVefWwcDesrZ
 UmoLHeSnAem1nPmuSlgJX6QvMKaNmJmriXoHwPsjHya4kmuslIVfKcbkPqog3/c5CPNWkGm
 XfTbEl/ypE1uAyywERPag==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255941>

On 08/26/2014 02:44 PM, Maxim Bublis wrote:
> Fixes several problems:
>    * include config.mak.uname, config.mak.autogen and config.mak
>      in order to use settings for prefix and other such things;
>    * link xdiff/lib.a as it is a requirement for libgit.a;
>    * fix CFLAGS and EXTLIBS for Linux and Mac OS X.
> ---
>   contrib/svn-fe/Makefile | 47 ++++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 38 insertions(+), 9 deletions(-)
>
> diff --git a/contrib/svn-fe/Makefile b/contrib/svn-fe/Makefile
> index 360d8da..8e1d622 100644
> --- a/contrib/svn-fe/Makefile
> +++ b/contrib/svn-fe/Makefile
> @@ -1,18 +1,45 @@
>   all:: svn-fe$X
>   
> -CC = gcc
> +CC = cc
>   RM = rm -f
>   MV = mv
>   
>   CFLAGS = -g -O2 -Wall
>   LDFLAGS =
> -ALL_CFLAGS = $(CFLAGS)
> -ALL_LDFLAGS = $(LDFLAGS)
> -EXTLIBS =
> +EXTLIBS = -lz
> +
> +include ../../config.mak.uname
> +-include ../../config.mak.autogen
> +-include ../../config.mak
> +
> +ifeq ($(uname_S),Darwin)
> +	CFLAGS += -I/opt/local/include
> +	LDFLAGS += -L/opt/local/lib
> +endif
> +
Should it be possible to disable this by using NO_DARWIN_PORTS
like we do in the main Makefile ?
