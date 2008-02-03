From: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH] compat: Add simplified merge sort
 implementation from glibc
Date: Sun, 3 Feb 2008 21:09:35 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802032109050.7372@racer.site>
References: <20080203011130.GK26392@lavos.net> <alpine.LSU.1.00.0802030231080.7372@racer.site> <20080203045033.GL26392@lavos.net>
Reply-To: Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>,  git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: Brian Downing <bdowning-oU/tDdhfGLReoWH0uzbU5w@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Sun Feb 03 22:10:53 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.250])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLm6w-00067g-HK
	for gcvm-msysgit@m.gmane.org; Sun, 03 Feb 2008 22:10:47 +0100
Received: by wa-out-0708.google.com with SMTP id n36so2525506wag.21
        for <gcvm-msysgit@m.gmane.org>; Sun, 03 Feb 2008 13:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=mPzYaDQ/wSJr3Ex9BiGvf8BtXJT3HoTFYZugsyaMebE=;
        b=KvoUHROVZifGdQa96Zw4HaqlZRuFPV6G4MAg/AAf1u+2PGjpEysKwR/INwCuk/afmc9UrlyU9iQzy/753k+i6JjuNmPgMZoQjpdpofeisWjZd5GgxW54qNHGaM9RuNsN8KaHfg8q6XDZI4j0QbBMyM3nYby/TQ2p4n8lKSX85+U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=GdGhHVEpkB/bDGse4wokLi8bOE03fYBLzlBT06vmIUE1mc4KNvDXyucoQPCcGmfh/Y1VoED69zUyWfljxql54IeVnTHuTCwOUDghDGoXLmYELtD+KkxCaA3x9V7WLSN0mSPbM0IopIkb0WAaXPW2ccaPqHpKh8pcY1znRp0UZR4=
Received: by 10.141.116.16 with SMTP id t16mr183406rvm.20.1202073013670;
        Sun, 03 Feb 2008 13:10:13 -0800 (PST)
Received: by 10.44.219.52 with SMTP id r52gr1601hsg;
	Sun, 03 Feb 2008 13:10:13 -0800 (PST)
X-Sender: Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.59.5 with SMTP id m5mr18843338pyk.0.1202073013113; Sun, 03 Feb 2008 13:10:13 -0800 (PST)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by mx.google.com with SMTP id x46si11108566pyg.3.2008.02.03.13.10.12; Sun, 03 Feb 2008 13:10:13 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
Received: (qmail invoked by alias); 03 Feb 2008 21:10:10 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40] by mail.gmx.net (mp041) with SMTP; 03 Feb 2008 22:10:10 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/7lJRVuS77qGlTdbpslHTMelA4Ydr+kLyLmkn/mk Psacjt9V8rhBNi
X-X-Sender: gene099-OGWIkrnhIhzN0uC3ymp8PA@public.gmane.org
In-Reply-To: <20080203045033.GL26392-oU/tDdhfGLReoWH0uzbU5w@public.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72401>


Hi,

On Sat, 2 Feb 2008, Brian Downing wrote:

> On Sun, Feb 03, 2008 at 02:37:27AM +0000, Johannes Schindelin wrote:
> > I should add that this is a stripped-down version of glibc's sort() 
> > (yes, the GPL of glibc allows that we rip it, for all you license 
> > wieners out there).
> > 
> > AFAIR the discussion about the different implementations of a sort 
> > algorithm boiled down to one particular implementation being quicker 
> > than what this patch has, but with dubious licensing, and the glibc 
> > implementation without the modifications present in this patch being 
> > slower.
> > 
> > So I would like this to go in, evidently, if only as a starting point 
> > for people to play with sorting algorithms, to find the one which is 
> > optimal for our general use (we have quite some uses where we put in 
> > _almost_ sorted data, which seems to be the worst-case for many 
> > sorting algorithms).
> 
> If this is what I am thinking of, the sort of dubious licensing was 
> faster than glibc's quicksort.  This patch, however, is simplified from 
> glibc's mergesort (which is what glibc uses for the qsort() call except 
> for very large arrays), and was determined to be faster than both.
> 
> See:
> 
> http://groups.google.com/group/msysgit/browse_frm/thread/3c2eb564b9d0a994
> 
> and the links from that thread for more information.

Yeah, sorry, I forgot that important fact.

Thanks,
Dscho
