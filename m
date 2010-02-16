From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fix threaded grep for machines with only one cpu
Date: Tue, 16 Feb 2010 09:15:01 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002160914140.20986@pacific.mpi-cbg.de>
References: <20100215225001.GA944@book.hvoigt.net> <7vwryet2cw.fsf@alter.siamese.dyndns.org> <7vocjpnc5v.fsf@alter.siamese.dyndns.org> <7vljetlx8r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Fredrik Kuivinen <frekui@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 09:08:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhIU0-0001NF-0j
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 09:08:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932745Ab0BPIIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 03:08:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:39709 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932735Ab0BPIIY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 03:08:24 -0500
Received: (qmail invoked by alias); 16 Feb 2010 08:08:22 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp029) with SMTP; 16 Feb 2010 09:08:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+tOJVXTR2tHKP4EKSwTaPvIP/1cBKxA54vMjD8E2
	E1SV9/pkP+tZxX
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vljetlx8r.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64000000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140085>

Hi,

On Mon, 15 Feb 2010, Junio C Hamano wrote:

> diff --git a/builtin-grep.c b/builtin-grep.c
> index 26d4deb..5c1545e 100644
> --- a/builtin-grep.c
> +++ b/builtin-grep.c
> @@ -81,8 +81,8 @@ static pthread_mutex_t read_sha1_mutex;
>  
>  #define grep_lock() pthread_mutex_lock(&grep_mutex)
>  #define grep_unlock() pthread_mutex_unlock(&grep_mutex)
> -#define read_sha1_lock() pthread_mutex_lock(&read_sha1_mutex)
> -#define read_sha1_unlock() pthread_mutex_unlock(&read_sha1_mutex)
> +#define read_sha1_lock() do { if (use_threads) pthread_mutex_lock(&read_sha1_mutex); } while (0)
> +#define read_sha1_unlock() do { if (use_threads) pthread_mutex_unlock(&read_sha1_mutex); } while (0)

This is inconsistent. Just look at the code above and tell me why it is so 
different.

Ciao,
Dscho
