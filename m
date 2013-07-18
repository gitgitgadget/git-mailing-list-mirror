From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Add the GIT_SENTINEL macro
Date: Thu, 18 Jul 2013 14:06:52 -0700
Message-ID: <20130718210652.GX14690@google.com>
References: <51E849C4.7020305@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Jul 18 23:07:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzvPh-0007Lp-Dq
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 23:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933287Ab3GRVG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 17:06:57 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:64612 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933212Ab3GRVG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 17:06:56 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp16so3647502pbb.0
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 14:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=A4UhosKp1OaRp9/4qkqACXUSfF0d+GFvqoDFXb/at6k=;
        b=WOIcljtx8ze3mo3wqp2dRV2+pQWKeZAgiwqalLQ7OqRVG11CUOVYjkdgKLErirNg4K
         1ND2KAFVMWCSpTXSD/y4VXHle8DeZPbSB+DjjmymOnY/KWwW1RxkcBb/ZJvYcPbIsZ8q
         Ddb4Jg1PtlvSxWY77f/u214MRa3P1NFB8ejnDTO+UgO90z1/FKkUJgYmfjgF6jItg2tQ
         pCLr5TPom70bIPgeqyR+HV97+GEN2DsM6MS8+QQ8yw71Gab1XGKZnL4PD31vKVYQQeX+
         ZC+b+wj/oGPBOARdHwz7QbKVQfKfQbSNbILUuWFFEExgr/d6XYRgFoJyOIEixif50HXp
         TiGw==
X-Received: by 10.68.218.199 with SMTP id pi7mr13958234pbc.19.1374181616117;
        Thu, 18 Jul 2013 14:06:56 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id bb1sm5724971pbc.10.2013.07.18.14.06.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jul 2013 14:06:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51E849C4.7020305@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230746>

Ramsay Jones wrote:

> This was built on the next branch

All the uses of the sentinel attribute seem to come from
eccb6149 (use "sentinel" function attribute for variadic
lists, 2013-07-09), so this should be okay to go on top of the
jk/gcc-function-attributes branch.

> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -303,6 +303,13 @@ extern char *gitbasename(char *);
>  #endif
>  #endif
>  
> +/* The sentinel attribute is valid from gcc version 4.0 */
> +#if defined(__GNUC__) && (__GNUC__ >= 4)
> +#define GIT_SENTINEL(n) __attribute__((sentinel(n)))
> +#else
> +#define GIT_SENTINEL(n)
> +#endif

I'd mildly prefer

	#if ...
	#define GIT_SENTINEL __attribute__((sentinel))
	#else
	...

(without the numeric parameter).  I don't know any function in git
(or any other project for that matter) that takes extra parameters
after the NULL sentinel.

But I don't care much, so

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for a pleasant patch.
Jonathan
