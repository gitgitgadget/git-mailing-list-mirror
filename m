From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] cat-file --batch / --batch-check: do not exit if hashes
 are missing
Date: Mon, 9 Jun 2008 00:34:43 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806090033030.1783@racer>
References: <1212967717-5165-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 01:37:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5URY-0001ni-RI
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 01:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753745AbYFHXgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 19:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753818AbYFHXgG
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 19:36:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:52541 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753676AbYFHXgE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 19:36:04 -0400
Received: (qmail invoked by alias); 08 Jun 2008 23:36:02 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp030) with SMTP; 09 Jun 2008 01:36:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19d4z4oqRtdD2kqT3taO7DHC4Y1OPjnNBZgHjMFIt
	3WEYPqL7c7TCaj
X-X-Sender: gene099@racer
In-Reply-To: <1212967717-5165-1-git-send-email-LeWiemann@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84347>

Hi,

maybe s/do not exit/complain/?  Because it still exits if the hashes are 
missing...

> diff --git a/builtin-cat-file.c b/builtin-cat-file.c
> index f8b3160..112b9db 100644
> --- a/builtin-cat-file.c
> +++ b/builtin-cat-file.c
> @@ -168,8 +168,11 @@ static int batch_one_object(const char *obj_name, int print_contents)
>  	else
>  		type = sha1_object_info(sha1, &size);
>  
> -	if (type <= 0)
> -		return 1;
> +	if (type <= 0) {
> +		printf("%s missing\n", obj_name);
> +		fflush(stdout);
> +		return 0;
> +	}

Is it really intended that it returns 0 now?

Further, should it not be an error("%s missin...  instead?  It is an 
error, isn't it?

Ciao,
Dscho
