From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] compat/mingw.[ch]: Change return type of exec functions
 to int
Date: Thu, 5 Apr 2012 19:42:26 -0500
Message-ID: <20120406004226.GA2658@burratino>
References: <4F7DDAFE.1060902@ramsay1.demon.co.uk>
 <20120405181600.GA6340@burratino>
 <20120405220615.GA11751@sigill.intra.peff.net>
 <20120405223408.GA13910@burratino>
 <20120406002454.GB14224@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 06 02:42:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFxGC-00044W-35
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 02:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756675Ab2DFAmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 20:42:35 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45751 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255Ab2DFAmf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 20:42:35 -0400
Received: by iagz16 with SMTP id z16so2475606iag.19
        for <git@vger.kernel.org>; Thu, 05 Apr 2012 17:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=xFsPHuO9owTPjeY97OPp/TToghAgJaTz1bCQxayZvzQ=;
        b=GqANDimUqHg8CboZjIw34HhVCvL6n8Ec7/o3/yZAfjmBAjIlM5Br6XEnB9tcM0VqT7
         tLeUqc94sTCJRQ0GIjF1JVK0e/7a2NGL8H7cfVX0rWUWOLmMWZbiwL2UHnlmq2OiPmTC
         wfaDp/NXEYXJ+T8fsPS65sYoid+qHyIBh4ZF/kG2gE8lTBR3vZieq9zzqpwHmrfq+m/c
         m0plqwOrb48cIUzBCwC0IVvCve7Rr+YzN5OCAMzzdMCCaG73fHYXTnjiavKXyF8n7gy1
         YSvIUCOozLBNCNGSAPEthZ/vIxt0boVhK+VYD2Dr2PfAmnAjr5z+gRCq7lCCuhQojfXq
         iqOw==
Received: by 10.50.181.132 with SMTP id dw4mr3621384igc.62.1333672954292;
        Thu, 05 Apr 2012 17:42:34 -0700 (PDT)
Received: from burratino (adsl-99-24-202-99.dsl.chcgil.sbcglobal.net. [99.24.202.99])
        by mx.google.com with ESMTPS id dl10sm905401igb.5.2012.04.05.17.42.32
        (version=SSLv3 cipher=OTHER);
        Thu, 05 Apr 2012 17:42:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120406002454.GB14224@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194827>

Jeff King wrote:

> I think both (attempt to) document the same thing: that if we get past
> execvp, we know are in error-checking mode. Which is not explicitly said
> anywhere. So maybe:
>
> diff --git a/run-command.c b/run-command.c
> index 7123436..e6ece79 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -117,10 +117,12 @@ static int exists_in_PATH(const char *file)
>  
>  int sane_execvp(const char *file, char * const argv[])
>  {
> -	if (!execvp(file, argv))
> -		return 0;
> +	execvp(file, argv);
>  
>  	/*
> +	 * If we are still running, we know an error occurred; let's try to
> +	 * diagnose it more specifically.
> +	 *
>  	 * When a command can't be found because one of the directories

Looks fine to me. :)

Thanks for your patience.
Jonathan
