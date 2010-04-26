From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] start_command: close cmd->err descriptor when fork/spawn
 fails
Date: Mon, 26 Apr 2010 08:16:43 +0200
Message-ID: <4BD52FCB.6020902@viscovery.net>
References: <1272244540-5960-1-git-send-email-dvornik+git@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: bert Dvornik <dvornik+git@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 08:16:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6Hcj-0000C2-Hi
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 08:16:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008Ab0DZGQs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 02:16:48 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:18329 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786Ab0DZGQr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 02:16:47 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1O6Hca-0005qF-Eg; Mon, 26 Apr 2010 08:16:44 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 1130B1660F;
	Mon, 26 Apr 2010 08:16:43 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <1272244540-5960-1-git-send-email-dvornik+git@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145790>

Am 4/26/2010 3:15, schrieb bert Dvornik:
> Fix the problem where the cmd->err passed into start_command wasn't
> being properly closed when certain types of errors occurr.  (Compare
> the affected code with the clean shutdown code later in the function.)

> diff --git a/run-command.c b/run-command.c
> index d1a8ceb..41666ac 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -383,6 +383,8 @@ fail_pipe:
>  			close(cmd->out);
>  		if (need_err)
>  			close_pair(fderr);
> +		else if (cmd->err)
> +			close(cmd->err);
>  		errno = failed_errno;
>  		return -1;
>  	}

Good catch! This should go on maint (1.7.0).

Acked-by: Johannes Sixt <j6t@kdbg.org>

-- Hannes
