From: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH] compat: Add simplified merge sort
 implementation from glibc
Date: Sun, 3 Feb 2008 02:37:27 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802030231080.7372@racer.site>
References: <20080203011130.GK26392@lavos.net>
Reply-To: Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>,  git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: Brian Downing <bdowning-oU/tDdhfGLReoWH0uzbU5w@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Sun Feb 03 03:38:38 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.24])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLUke-0007lF-5X
	for gcvm-msysgit@m.gmane.org; Sun, 03 Feb 2008 03:38:37 +0100
Received: by yw-out-2122.google.com with SMTP id 4so3593299ywc.37
        for <gcvm-msysgit@m.gmane.org>; Sat, 02 Feb 2008 18:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=Ejt3DHeyIhOtEqanhpKvfeEfoad6kJ2FOXQ1JssAq/g=;
        b=cIUeOKFdsCbGeb6iCbnqgB3uS9WH/SnANxaKBcKCtyuCXQFZ6h4g/b2nLntSXpXXT+EwWROw0BK4xpp7qkuVCO8FC6H3opQFsDjCf9fjp/fS/uZiA2R+DYHNXMtQeljojlx7R86pFH0WFZZqkAQ4lKr2Iq5vyEZHnBCyw6jqD4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=6vdpuafJiuzEnqK2wfE1DnTbgFntM7jlp0BthA0PGvaMQZ6rVOr0mNIGp0CmQBHdMdav5A+Mt/pHYE4zh1+apNyMmw7+4Anx4gh5B9VZQhDCp55Y2893Jf2kWYMx45RsWsHSaD1fKnoK32EhzgQqsgtQ37i/CXdwKn94nye8Ke4=
Received: by 10.100.173.18 with SMTP id v18mr720491ane.0.1202006281883;
        Sat, 02 Feb 2008 18:38:01 -0800 (PST)
Received: by 10.44.53.58 with SMTP id b58gr1594hsa;
	Sat, 02 Feb 2008 18:38:01 -0800 (PST)
X-Sender: Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.99.14 with SMTP id b14mr17749456pym.4.1202006281501; Sat, 02 Feb 2008 18:38:01 -0800 (PST)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by mx.google.com with SMTP id x46si9839071pyg.3.2008.02.02.18.38.00; Sat, 02 Feb 2008 18:38:01 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
Received: (qmail invoked by alias); 03 Feb 2008 02:38:00 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40] by mail.gmx.net (mp046) with SMTP; 03 Feb 2008 03:38:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/UYTEAhwrUoU1te3myEkrUiWfrwHOmOpttBBA5im r5/VB7X8fbvhh6
X-X-Sender: gene099-OGWIkrnhIhzN0uC3ymp8PA@public.gmane.org
In-Reply-To: <20080203011130.GK26392-oU/tDdhfGLReoWH0uzbU5w@public.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72318>


Hi,

On Sat, 2 Feb 2008, Brian Downing wrote:

> qsort in Windows 2000 (and possibly other older Windows' C libraries)
> is a Quicksort with the usual O(n^2) worst case.  Unfortunately, sorting
> Git trees seems to get very close to that worst case quite often:
> 
>     $ /git/gitbad runstatus
>     # On branch master
>     qsort, nmemb = 30842
>     done, 237838087 comparisons.
> 
> This patch adds a simplified version of the merge sort that is glibc's
> qsort(3).  As a merge sort, this needs a temporary array equal in size
> to the array that is to be sorted.
> 
> The complexity that was removed is:
> 
> * Doing direct stores for word-size and -aligned data.
> * Falling back to quicksort if the allocation required to perform the
>   merge sort would likely push the machine into swap.
> 
> Even with these simplifications, this seems to outperform the Windows
> qsort(3) implementation, even in Windows XP (where it is "fixed" and
> doesn't trigger O(n^2) complexity on trees).
> 
> [jes: moved into compat/qsort.c, as per Johannes Sixt's suggestion]
> 
> Signed-off-by: Brian Downing <bdowning-oU/tDdhfGLReoWH0uzbU5w@public.gmane.org>
> Signed-off-by: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>
> Signed-off-by: Johannes Schindelin <johannes.schindelin-Mmb7MZpHnFY@public.gmane.org>

I should add that this is a stripped-down version of glibc's sort() (yes, 
the GPL of glibc allows that we rip it, for all you license wieners out 
there).

AFAIR the discussion about the different implementations of a sort 
algorithm boiled down to one particular implementation being quicker than 
what this patch has, but with dubious licensing, and the glibc 
implementation without the modifications present in this patch being 
slower.

So I would like this to go in, evidently, if only as a starting point for 
people to play with sorting algorithms, to find the one which is optimal 
for our general use (we have quite some uses where we put in _almost_ 
sorted data, which seems to be the worst-case for many sorting 
algorithms).

Ciao,
Dscho
