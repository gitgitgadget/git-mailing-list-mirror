From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v3 16/25] commit_lock_file(): die() if called for unlocked
 lockfile object
Date: Tue, 15 Apr 2014 08:49:57 +0200
Message-ID: <534CD695.20306@viscovery.net>
References: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu> <1397483695-10888-17-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?ISO-8859-15?Q?Torst?= =?ISO-8859-15?Q?en_B=F6gershausen?= 
	<tboegi@web.de>, Eric Sunshine <sunshine@sunshineco.com>
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 15 08:50:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZxCB-000081-FE
	for gcvg-git-2@plane.gmane.org; Tue, 15 Apr 2014 08:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbaDOGuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2014 02:50:07 -0400
Received: from so.liwest.at ([212.33.55.14]:45438 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750911AbaDOGuG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2014 02:50:06 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1WZxBu-0005o4-96; Tue, 15 Apr 2014 08:49:58 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id F3B9F16613;
	Tue, 15 Apr 2014 08:49:57 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <1397483695-10888-17-git-send-email-mhagger@alum.mit.edu>
X-Enigmail-Version: 1.6
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246276>

Am 4/14/2014 15:54, schrieb Michael Haggerty:
> diff --git a/lockfile.c b/lockfile.c
> index 664b0c3..1453a7a 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -292,6 +292,9 @@ int commit_lock_file(struct lock_file *lk)
>  	if (lk->fd >= 0 && close_lock_file(lk))
>  		return -1;
>  
> +	if (!lk->filename[0])
> +		die("BUG: attempt to commit unlocked object");
> +

Shouldn't this be the first thing to check after entering the function?

>  	strcpy(result_file, lk->filename);
>  	/* remove ".lock": */
>  	result_file[strlen(result_file) - LOCK_SUFFIX_LEN] = 0;
> 
