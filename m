From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] run-command.c: Fix unused variables warning with gcc
 4.6
Date: Tue, 26 Apr 2011 15:13:37 +0200
Message-ID: <4DB6C501.6000705@drmicha.warpmail.net>
References: <4DB6BA5E.3040306@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 15:13:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEi5P-0006Be-VO
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 15:13:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755426Ab1DZNNk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 09:13:40 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:51204 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755419Ab1DZNNk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2011 09:13:40 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E14C1206C7;
	Tue, 26 Apr 2011 09:13:38 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 26 Apr 2011 09:13:38 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=3K/GUv6Dv8AFFS6x9yIjP7Pb4Qo=; b=HyGPAD1o1IGhLSqAXcRvriFfe2UabztBaVCwbrwy2Q/KdwXf2LdecBWeY7OlbGufFo+XTs2ZGgSgnFIn0ZxsP0bcAfawbR/5mt+W4z9sYB9Jvfc5dGNEWlQ+zt0XMLw/haZqEoMjexGn+Thgyv/8uHBEEThEVOD8nhzx6vP9vzc=
X-Sasl-enc: P/BsPa32EeHfiX0HrmvRXf+cxJcKadLdgua7FgH64apJ 1303823618
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 672D1402602;
	Tue, 26 Apr 2011 09:13:38 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <4DB6BA5E.3040306@elegosoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172092>

Michael Schubert venit, vidit, dixit 26.04.2011 14:28:
> As of gcc 4.6 -Wall includes -Wunused-but-set-variable. Remove all
> unused variables to prevent those warnings.
> 
> Signed-off-by: Michael Schubert <mschub@elegosoft.com>
> ---
>  run-command.c |   10 ++++------
>  1 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/run-command.c b/run-command.c
> index f91e446..6e0be54 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -67,21 +67,19 @@ static int child_notifier = -1;
> 
>  static void notify_parent(void)
>  {
> -	ssize_t unused;
> -	unused = write(child_notifier, "", 1);
> +	write(child_notifier, "", 1);
>  }
> 
>  static NORETURN void die_child(const char *err, va_list params)
>  {
>  	char msg[4096];
> -	ssize_t unused;
>  	int len = vsnprintf(msg, sizeof(msg), err, params);
>  	if (len > sizeof(msg))
>  		len = sizeof(msg);
> 
> -	unused = write(child_err, "fatal: ", 7);
> -	unused = write(child_err, msg, len);
> -	unused = write(child_err, "\n", 1);
> +	write(child_err, "fatal: ", 7);
> +	write(child_err, msg, len);
> +	write(child_err, "\n", 1);
>  	exit(128);
>  }
>  #endif

git log -S"unused" origin/master run-command.c

shows that these dummies were introduced for a reason. How do you
invalidate that?

Michael
