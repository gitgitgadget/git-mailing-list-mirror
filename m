From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Optimize common pattern of alloc_ref from string
Date: Sun, 11 May 2008 16:32:19 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805111630590.30431@racer>
References: <1210462018-47060-1-git-send-email-kkowalczyk@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Krzysztof Kowalczyk <kkowalczyk@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 11 17:33:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvDY0-0001B7-HT
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 17:33:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716AbYEKPcX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 11:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752826AbYEKPcX
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 11:32:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:53499 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750885AbYEKPcW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 11:32:22 -0400
Received: (qmail invoked by alias); 11 May 2008 15:32:20 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp031) with SMTP; 11 May 2008 17:32:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/0zAcBM3r06D1Fiq+Lr5L+XyTu65rgNdN/Jg9JSW
	T2FmoG3UCbYaOz
X-X-Sender: gene099@racer
In-Reply-To: <1210462018-47060-1-git-send-email-kkowalczyk@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81778>

Hi,

On Sat, 10 May 2008, kkowalczyk@gmail.com wrote:

> diff --git a/builtin-fetch.c b/builtin-fetch.c
> index e56617e..f6584ec 100644
> --- a/builtin-fetch.c
> +++ b/builtin-fetch.c
> @@ -508,10 +508,8 @@ static void find_non_local_tags(struct transport *transport,
>  		     will_fetch(head, ref->old_sha1))) {
>  			path_list_insert(ref_name, &new_refs);
>  
> -			rm = alloc_ref(strlen(ref_name) + 1);
> -			strcpy(rm->name, ref_name);
> -			rm->peer_ref = alloc_ref(strlen(ref_name) + 1);
> -			strcpy(rm->peer_ref->name, ref_name);
> +			rm = alloc_ref_from_str(ref_name);
> +			rm->peer_ref = alloc_ref_from_str(ref_name);

Thanks.  This was on my ever-growing TODO list (actually, fix alloc_ref() 
to take the string length instead of the size to be allocated).

Together with the comments from Peff I am very positive on this patch.

Thanks,
Dscho
