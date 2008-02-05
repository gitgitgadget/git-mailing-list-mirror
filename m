From: "Mike Ralphson" <mike.ralphson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] compat: Add simplified merge sort
 implementation from glibc
Date: Tue, 5 Feb 2008 10:19:32 +0000
Message-ID: <e2b179460802050219h58f086fer77792e3f06d74ff4@mail.gmail.com>
References: <20080203011130.GK26392@lavos.net> <alpine.LSU.1.00.0802030231080.7372@racer.site> <20080203045033.GL26392@lavos.net>
Reply-To: mike.ralphson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>,  "Junio C Hamano" <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>,  "Steffen Prohaska" <prohaska-wjoc1KHpMeg@public.gmane.org>, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,  msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: "Brian Downing" <bdowning-oU/tDdhfGLReoWH0uzbU5w@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Tue Feb 05 11:20:06 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.242])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMKuL-0002zg-Bj
	for gcvm-msysgit@m.gmane.org; Tue, 05 Feb 2008 11:20:05 +0100
Received: by wa-out-0708.google.com with SMTP id n36so3896795wag.21
        for <gcvm-msysgit@m.gmane.org>; Tue, 05 Feb 2008 02:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:dkim-signature:domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=/+FdrcWJTpjB1DXcS2R4gLq5AkLFC9QbqbeRslOtFwk=;
        b=06sJ7fV9Yixqqw/q4CoFiNH00vt86fkoRWigrNhgbyAF9Q+eSfrpCX+lTyGgZMF/tsEw/ght8UyNVeyTaqT2R/FyoExPUL4wozIZcZuLx6HtwCGh4g//bNFvio0YCDdsxSbMBe4hur/aAXMsMz0VyE61mWLf9c5H73KJ0B2K8gY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:dkim-signature:domainkey-signature:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=Ru5qQQpXPyCLZY+argKmcWVz/RD/rEZBAkSaAbS7xVq9GbAn31LCnC+2rDpyZeegdt7ERIQfG1s49H9nnub9RHMdHtKHm0BCMAKqkdtY37KZvaLORsuaVqRZ3ZcI77bjVgn7s3iI8M7Vb5YBNDyB1dOd1/we8Z+3hS5xZWwBf3Y=
Received: by 10.115.109.1 with SMTP id l1mr644142wam.28.1202206774085;
        Tue, 05 Feb 2008 02:19:34 -0800 (PST)
Received: by 10.106.243.37 with SMTP id q37gr1614prh;
	Tue, 05 Feb 2008 02:19:34 -0800 (PST)
X-Sender: mike.ralphson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.126.2 with SMTP id d2mr21284933pyn.1.1202206773781; Tue, 05 Feb 2008 02:19:33 -0800 (PST)
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.191]) by mx.google.com with ESMTP id v63si1802419pyh.2.2008.02.05.02.19.32; Tue, 05 Feb 2008 02:19:33 -0800 (PST)
Received-SPF: pass (google.com: domain of mike.ralphson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 209.85.198.191 as permitted sender) client-ip=209.85.198.191;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of mike.ralphson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 209.85.198.191 as permitted sender) smtp.mail=mike.ralphson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; dkim=pass (test mode) header.i=@gmail.com
Received: by rv-out-0910.google.com with SMTP id b22so1491286rvf.21 for <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Tue, 05 Feb 2008 02:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references; bh=/51IKYrlIYJwCf/9iLCmZsqcxR3S49Afrbzzyh3r340=; b=RHpH99MQFeB+OKyDOURQAAktLf22RyBKUdfEzb3O+rfTPxagWVKvYKSO/2EZ9c6ce/jOoSOTxngJAm/fb1jkXqJuuqtiHlemtk4JRhpUDRXR5o/7+nmwwLnJQdLV06tpDtrctPugGb2AGyH6jfjJdnS+1BU5xYgh8hjA2tRtmuM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references; b=L4ZbO1APLVs2Zk0LVOhklOK57CQmVB6LVZhWty3DNlDghOncfrQFW3VdoU3p26sdVKnx5AgM+fwYdJLBalLA9q9CEXrbqgZwNYT9TfzTpwNt3pkpqJgOtPAWaFsrov++Ami2Ziio8E8v9RBgwtBHOBovKbrbMBobV2CGFNp3UhA=
Received: by 10.141.107.13 with SMTP id j13mr5499579rvm.276.1202206772586; Tue, 05 Feb 2008 02:19:32 -0800 (PST)
Received: by 10.140.208.2 with HTTP; Tue, 5 Feb 2008 02:19:32 -0800 (PST)
In-Reply-To: <20080203045033.GL26392-oU/tDdhfGLReoWH0uzbU5w@public.gmane.org>
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72641>


On Feb 3, 2008 4:50 AM, Brian Downing <bdowning-oU/tDdhfGLReoWH0uzbU5w@public.gmane.org> wrote:
> On Sun, Feb 03, 2008 at 02:37:27AM +0000, Johannes Schindelin wrote:
> > I should add that this is a stripped-down version of glibc's sort() (yes,
> > the GPL of glibc allows that we rip it, for all you license wieners out
> > there).
> >
> > AFAIR the discussion about the different implementations of a sort
> > algorithm boiled down to one particular implementation being quicker than
> > what this patch has, but with dubious licensing, and the glibc
> > implementation without the modifications present in this patch being
> > slower.
> >
> > So I would like this to go in, evidently, if only as a starting point for
> > people to play with sorting algorithms, to find the one which is optimal
> > for our general use (we have quite some uses where we put in _almost_
> > sorted data, which seems to be the worst-case for many sorting
> > algorithms).
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

Tested-by: Mike Ralphson <mike.ralphson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Many thanks Brian, I held off from submitting your patch to git.git
because of the 1.5.4 freeze. I'll retest my other candidate qsort
implementations and report back. For now this makes git look good on
AIX. It would be good to have feedback from users of older versions of
Solaris too.

Once the final patch is in, I'll drop some queued AIX Makefile patches on top.

Cheers, Mike
