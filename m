From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] compat/snprintf.c: handle snprintf's that always return
 the   # chars transmitted
Date: Thu, 21 Aug 2008 10:06:31 +0200
Message-ID: <48AD2207.903@viscovery.net>
References: <nYV6zI97uDEOlIEFjH5oAZW1lTFm0mOVlTrIxzRyOY5CCrUJw7ROgA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Aug 21 10:07:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW5Co-0004TC-6o
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 10:07:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755468AbYHUIGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 04:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755026AbYHUIGi
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 04:06:38 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:62748 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753478AbYHUIGf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 04:06:35 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KW5Bg-0001YG-Dq; Thu, 21 Aug 2008 10:06:33 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id F383F6B7; Thu, 21 Aug 2008 10:06:31 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <nYV6zI97uDEOlIEFjH5oAZW1lTFm0mOVlTrIxzRyOY5CCrUJw7ROgA@cipher.nrlssc.navy.mil>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93118>

Brandon Casey schrieb:
> Some platforms provide a horribly broken snprintf. More broken than the
> platforms that return -1 when there is too little space in the target buffer
> for the formatted string. Some platforms provide an snprintf which _always_
> returns the number of characters transmitted to the buffer, regardless of
> whether there was enough space or not.
...
> diff --git a/compat/snprintf.c b/compat/snprintf.c
> index 580966e..357e733 100644
> --- a/compat/snprintf.c
> +++ b/compat/snprintf.c
> @@ -17,6 +17,8 @@ int git_vsnprintf(char *str, size_t maxsize, const char *format, va_list ap)
>  
>  	if (maxsize > 0) {
>  		ret = vsnprintf(str, maxsize-SNPRINTF_SIZE_CORR, format, ap);
> +		if (ret == maxsize-1)
> +			ret = -1;
>  		/* Windows does not NUL-terminate if result fills buffer */
>  		str[maxsize-1] = 0;
>  	}
> @@ -34,6 +36,8 @@ int git_vsnprintf(char *str, size_t maxsize, const char *format, va_list ap)
>  			break;
>  		s = str;
>  		ret = vsnprintf(str, maxsize-SNPRINTF_SIZE_CORR, format, ap);
> +		if (ret == maxsize-1)
> +			ret = -1;
>  	}
>  	free(s);
>  	return ret;

This looks good, and it passes the test suite on MinGW. Hence:

Acked-by: Johannes Sixt <johannes.sixt@telecom.at>

-- Hannes
