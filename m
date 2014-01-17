From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH 2/3] setup_pager: set MORE=R
Date: Thu, 16 Jan 2014 23:26:50 -0800
Message-ID: <398F146D-72F1-44CD-B205-729665FD8765@gmail.com>
References: <20140117041430.GB19551@sigill.intra.peff.net> <20140117042153.GB23443@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>, Yuri <yuri@rawbw.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 17 08:26:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W43pS-0003hE-KM
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 08:26:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892AbaAQH0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jan 2014 02:26:55 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:53782 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155AbaAQH0y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 02:26:54 -0500
Received: by mail-pa0-f52.google.com with SMTP id bj1so2282413pad.11
        for <git@vger.kernel.org>; Thu, 16 Jan 2014 23:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=4b/wV6VQDvIM70CA5loQbYYYNF0GSU8VJDmNMfP9KX0=;
        b=sqvzCf75UCaG5hxZWMe/Lhykgrkvt54pBexHnIWRFIkX+HZt1SGkVMRiITyZpJWnl8
         sQQ7h5fifO1/0PG3aOOsMxvgWOWIcLeq0OuO5MiFjsyieBdlMoX5BnJPYDIpVNlv7SOO
         LkyOfrO/Wq31mqMOXpIU75eMUBVia6RrE4i7VCRjqw63IuDF3uXa7CAjOUrQ5wvITkFA
         y8sNLgLr5yh9iQGtqb3zUYqSceFGv3JUuNHa8TckE15w83pTUdMWMOZob3Rf9KE2VLzl
         7OItF6ZASMSJ8TUuOwv58kq1OtP6Qze4RqpR0cadNGpfUjSvGQ6ufXYymFH0IwQf5Klu
         v+Pw==
X-Received: by 10.67.3.97 with SMTP id bv1mr515608pad.54.1389943613815;
        Thu, 16 Jan 2014 23:26:53 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id z10sm27347367pas.6.2014.01.16.23.26.52
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 16 Jan 2014 23:26:53 -0800 (PST)
In-Reply-To: <20140117042153.GB23443@sigill.intra.peff.net>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240576>

On Jan 16, 2014, at 20:21, Jeff King wrote:
> When we run the pager, we always set "LESS=R" to tell the
> pager to pass through ANSI colors. On modern versions of
> FreeBSD, the system "more" can do the same trick.
[snip]
> diff --git a/pager.c b/pager.c
> index 90d237e..2303164 100644
> --- a/pager.c
> +++ b/pager.c
> @@ -87,6 +87,10 @@ void setup_pager(void)
> 		argv_array_push(&env, "LESS=FRSX");
> 	if (!getenv("LV"))
> 		argv_array_push(&env, "LV=-c");
> +#ifdef PAGER_MORE_UNDERSTANDS_R
> +	if (!getenv("MORE"))
> +		argv_array_push(&env, "MORE=R");
> +#endif

How about adding a leading "-" to both the LESS and MORE settings?   
Since you're in there patching... :)

The man page for more states:

"Options are also taken from the environment variable MORE (make sure  
to precede them with a dash (``-'')) but command line options will  
override them."

And while the less man page does not have that wording, it does show  
this:

   LESS="-options"; export LESS

and this:

   LESS="-Dn9.1$-Ds4.1"

So it looks like both LESS and MORE prefer to have their options start  
with a '-' more or less.
