From: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH v2] compat: Add simplified merge sort
 implementation from glibc
Date: Tue, 5 Feb 2008 22:21:58 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802052220500.8543@racer.site>
References: <20080205211044.GP26392@lavos.net>
Reply-To: Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,  msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Edgar Toernig <froese-Mmb7MZpHnFY@public.gmane.org>,  Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>
To: Brian Downing <bdowning-oU/tDdhfGLReoWH0uzbU5w@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Tue Feb 05 23:23:13 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from ug-out-1516.google.com ([66.249.92.163])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMWC9-0000g4-72
	for gcvm-msysgit@m.gmane.org; Tue, 05 Feb 2008 23:23:13 +0100
Received: by ug-out-1516.google.com with SMTP id 1so738962uga.9
        for <gcvm-msysgit@m.gmane.org>; Tue, 05 Feb 2008 14:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=wSiH7JX4hXEsPLDHTXTp5kUoOY23yen/q9At3iilVF4=;
        b=OXCZzXXM+fEcoN+H4e3wVNFHZeFtajQ6+0gBdoCD5762td3HFqU/+JL4ZhAPhtSjFKWvp1sGPDpQDtAxDl+FEG8Rl2Z10juxwPoxs0TcPEEe3mjWZIlNjTPnAioG/+y9lF0D19Rqiw/4SVeB3vf4oHQNfyzZtKdYvB5z483ySi8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=LoAPUZNmCtb6i9d0PJWyzdZ7AhrF0108KVXCI382e2WmoH71DYU5xisben17uuvUhjkYyOCKvS9mnwYKeca3b4pVn/HU3RafumW+Ird0wV3xoDR3z9DAhoW+IF7Kzu2fYwJDN1PrHGmrQ6AiIB3rLNDLhADdyCkxbwyaHVLiGQw=
Received: by 10.86.63.19 with SMTP id l19mr22150fga.20.1202250160791;
        Tue, 05 Feb 2008 14:22:40 -0800 (PST)
Received: by 10.107.168.22 with SMTP id v22gr1631pro;
	Tue, 05 Feb 2008 14:22:40 -0800 (PST)
X-Sender: Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.14.4 with SMTP id r4mr22345568pyi.2.1202250160200; Tue, 05 Feb 2008 14:22:40 -0800 (PST)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by mx.google.com with SMTP id a28si3180169pye.0.2008.02.05.14.22.39; Tue, 05 Feb 2008 14:22:40 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
Received: (qmail invoked by alias); 05 Feb 2008 22:22:38 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40] by mail.gmx.net (mp008) with SMTP; 05 Feb 2008 23:22:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18d/f8j5X8diXjSkScqW6e1BGfKzXWBMv5bIeTkWc S9qy2DnCYRQQrp
X-X-Sender: gene099-OGWIkrnhIhzN0uC3ymp8PA@public.gmane.org
In-Reply-To: <20080205211044.GP26392-oU/tDdhfGLReoWH0uzbU5w@public.gmane.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org;
	contact msysgit-owner-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <mailto:msysgit-help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72709>


Hi,

On Tue, 5 Feb 2008, Brian Downing wrote:

> diff --git a/compat/qsort.c b/compat/qsort.c
> new file mode 100644
> index 0000000..8663889
> --- /dev/null
> +++ b/compat/qsort.c
> @@ -0,0 +1,60 @@
> +#include "../git-compat-util.h"
> +
> +/* This merge sort implementation is simplified from glibc's. */
> +static void msort_with_tmp(void *b, size_t n, size_t s,

Didn't you forget to include the original copyright, as well as yours?

BTW if these 60 lines have code that is really faster than Microsoft's 
implementation of a sort, it is really fascinating to me.

Ciao,
Dscho
