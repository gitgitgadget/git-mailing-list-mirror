From: bdowning-oU/tDdhfGLReoWH0uzbU5w@public.gmane.org (Brian Downing)
Subject: Re: [PATCH] compat: Add simplified merge sort
 implementation from glibc
Date: Sun, 3 Feb 2008 20:46:44 -0600
Message-ID: <20080204024644.GM26392@lavos.net>
References: <20080203011130.GK26392@lavos.net> <20080204010552.03541642.froese@gmx.de>
Reply-To: bdowning-oU/tDdhfGLReoWH0uzbU5w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: Edgar Toernig <froese-Mmb7MZpHnFY@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Mon Feb 04 03:47:19 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.24])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLrMb-00054q-Lk
	for gcvm-msysgit@m.gmane.org; Mon, 04 Feb 2008 03:47:17 +0100
Received: by yw-out-2122.google.com with SMTP id 4so3953607ywc.37
        for <gcvm-msysgit@m.gmane.org>; Sun, 03 Feb 2008 18:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:x-ironport-av:received:x-ironport-anti-spam-filtered:x-ironport-anti-spam-result:x-ironport-av:received:received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=q/Llz+to3NpFQHUKXELRCmEDQ0cReK0Kf5FE9oMu1zA=;
        b=4w7wEfhzOsFYj7XWiUFlMcLEGxq2g0YHfAiOzacnEPkL3PLdBj2ukbYRKf8c1L6OhOZoh2ftdHmbk4bQ4sMkZz9U4bqv+tMZx0vI9SIeLXcx0IEsfCDM1GtUw0ASEOSEfgTFU9OO49ywn8PLmp4gBTyLY2hPEgn3bPQzu2IzPR8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-ironport-av:x-ironport-anti-spam-filtered:x-ironport-anti-spam-result:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=aidySrelMjTZvbC79l4Fci8QmBi3924XbkpLOdC6moIugk3zD3ZSfvVEZ783HogQdFZHPtF5DlOfcSl4hzoG8AADFu8nGwXNeS1R+EfxQrQukMJtQ5zwf/KDaOYEDtk6DuXsEWwHD0qsYu6CUv7XO7NAAFLJFtLYC4FmIwBymyI=
Received: by 10.150.152.17 with SMTP id z17mr415092ybd.15.1202093205937;
        Sun, 03 Feb 2008 18:46:45 -0800 (PST)
Received: by 10.44.13.45 with SMTP id 45gr1609hsm;
	Sun, 03 Feb 2008 18:46:45 -0800 (PST)
X-Sender: bdowning-oU/tDdhfGLReoWH0uzbU5w@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.14.4 with SMTP id r4mr19194811pyi.2.1202093205533; Sun, 03 Feb 2008 18:46:45 -0800 (PST)
Received: from mxsf05.insightbb.com (mxsf05.insightbb.com [74.128.0.75]) by mx.google.com with ESMTP id v63si11530059pyh.2.2008.02.03.18.46.45; Sun, 03 Feb 2008 18:46:45 -0800 (PST)
Received-SPF: neutral (google.com: 74.128.0.75 is neither permitted nor denied by best guess record for domain of bdowning-oU/tDdhfGLReoWH0uzbU5w@public.gmane.org) client-ip=74.128.0.75;
Authentication-Results: mx.google.com; spf=neutral (google.com: 74.128.0.75 is neither permitted nor denied by best guess record for domain of bdowning-oU/tDdhfGLReoWH0uzbU5w@public.gmane.org) smtp.mail=bdowning-oU/tDdhfGLReoWH0uzbU5w@public.gmane.org
X-IronPort-AV: E=Sophos;i="4.25,299,1199682000";  d="scan'208";a="217422539"
Received: from unknown (HELO asav02.insightbb.com) ([172.31.249.124]) by mxsf05.insightbb.com with ESMTP; 03 Feb 2008 21:46:44 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAEILpkdKhvkY/2dsb2JhbACBWKkp
X-IronPort-AV: E=Sophos;i="4.25,299,1199682000";  d="scan'208";a="198206929"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.249.24]) by asav02.insightbb.com with ESMTP; 03 Feb 2008 21:46:44 -0500
Received: by mail.lavos.net (Postfix, from userid 1000) id 98A14309F21; Sun,  3 Feb 2008 20:46:44 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <20080204010552.03541642.froese-Mmb7MZpHnFY@public.gmane.org>
User-Agent: Mutt/1.5.9i
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72456>


On Mon, Feb 04, 2008 at 01:05:52AM +0100, Edgar Toernig wrote:
> 	if (size < 1024) {
> -		char buf[size]; /* gcc-ism */
> +		char buf[1024];

Good point; when it was a mingw-only hack the gcc-ism didn't matter.

I'll see if I can push an updated patch in a day or so...

-bcd
