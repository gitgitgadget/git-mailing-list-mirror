From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] compat/mingw.[ch]: Change return type of exec functions
 to int
Date: Thu, 5 Apr 2012 17:34:36 -0500
Message-ID: <20120405223408.GA13910@burratino>
References: <4F7DDAFE.1060902@ramsay1.demon.co.uk>
 <20120405181600.GA6340@burratino>
 <20120405220615.GA11751@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 06 00:34:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFvGY-0007oK-4M
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 00:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754318Ab2DEWet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 18:34:49 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44668 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136Ab2DEWes (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 18:34:48 -0400
Received: by iagz16 with SMTP id z16so2356121iag.19
        for <git@vger.kernel.org>; Thu, 05 Apr 2012 15:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=mFoZBAYTjSpNg7OnMxRwR8nQ2oC22yOBjt4rgoAVJMc=;
        b=BbaaqzISyeeFQLXF3sktdhXfCgRZmXJzqkmO7yVMnOpijzdHKSM0BWn7sGu7eCwTdZ
         EB5QetZhtEfolhy9ROcvflQWrJcNTlk8JqOkYO6YZdBDo1C0m5p/iQwVQQBfElT9QZdN
         ZtqqmBrHITfH5EXBqBot6lqA5Cwl7AFCvCMwZI2YQGfDoGMnWmWnPKE/z6lame1/rNp3
         canMrQw17gofZ64cln72sOLBGC62M9TTq4a1GL0RSQuKe4+Mpa5liDoYOhbY+Ws8JwKI
         uCqEBnNKJikp3ajpahkRpAfdJeg+nB7qEqYkSMeWQ90pqFoon0uGVxINk9qwYsHIze0T
         Ba2w==
Received: by 10.42.139.9 with SMTP id e9mr2828334icu.43.1333665287766;
        Thu, 05 Apr 2012 15:34:47 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id wf10sm498700igb.8.2012.04.05.15.34.45
        (version=SSLv3 cipher=OTHER);
        Thu, 05 Apr 2012 15:34:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120405220615.GA11751@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194817>

Jeff King wrote:

> I don't have a strong opinion. The "return 0" is a little misleading,
> since it will never be called, but I think we should at least have a
> comment like:
[...]
> --- a/run-command.c
> +++ b/run-command.c
> @@ -117,8 +117,11 @@ static int exists_in_PATH(const char *file)
>  
>  int sane_execvp(const char *file, char * const argv[])
>  {
> -	if (!execvp(file, argv))
> -		return 0;
> +	/*
> +	 * No need to check the return value; if it returns at all, an error
> +	 * occurred.
> +	 */
> +	execvp(file, argv);
>  

I'd rather have the "return 0" then.  Such a comment that focuses on C
library details rather than providing additional information for
understanding the sane_execvp function is distracting.
