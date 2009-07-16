From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH v5] Re: git-am: allow e-mail file(s) as input
Date: Thu, 16 Jul 2009 10:06:57 +0200
Message-ID: <20090716080657.GJ12971@vidovic>
References: <7v7hy9bb8k.fsf@alter.siamese.dyndns.org> <eb6317e39369adc8d2594c35ee351b49aaadcc24.1247721562.git.nicolas.s.dev@gmx.fr> <4A5ED22B.6050101@gmail.com> <7v8wip9jjw.fsf@alter.siamese.dyndns.org> <20090716075055.GI12971@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Thu Jul 16 10:07:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRLzq-00028M-K2
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 10:07:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752868AbZGPIHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 04:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752674AbZGPIHI
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 04:07:08 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:53978 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571AbZGPIHD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 04:07:03 -0400
Received: by ewy26 with SMTP id 26so4621776ewy.37
        for <git@vger.kernel.org>; Thu, 16 Jul 2009 01:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=+4tsCfDUPE3oPwXLFwFuCzSoxuTq0GWE4WLW6shOUAQ=;
        b=ql+KOO9GBWZ5bniT46nwsPYYC76HccDEZreiWbg70uuWjbNVi69caECIbCErG0qJgk
         npzlnZZXvyHzGQh7JVfsLl7UN8RAo7AEFiqF5cR3C/STK4ktuQVRib40XNPSVS38JNZP
         KK8c81kQ/SJ/BbvVmO/idQpSbwfIJZmOeNCks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qL4JoiO1mL6rniF8/XddWckR29GhzdobippHVbM4p6igN7QKCKr6iI1IoMLoOCHglI
         YRlJjmAxT8GQKRlTKqvFyX/cbCkSb4Tvfka9khUI09pGwLqfkSQJoFdCj5bs5D8Ob/eD
         1nt37U4XC8OTTkZX0qqdC9TgM87x2xTJ5XAN8=
Received: by 10.211.194.9 with SMTP id w9mr9370113ebp.10.1247731620829;
        Thu, 16 Jul 2009 01:07:00 -0700 (PDT)
Received: from @ (88-121-124-61.rev.libertysurf.net [88.121.124.61])
        by mx.google.com with ESMTPS id 28sm1842358eyg.42.2009.07.16.01.06.59
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 16 Jul 2009 01:07:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090716075055.GI12971@vidovic>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123382>

The 16/07/09, Nicolas Sebrecht wrote:
> The 16/07/09, Junio C Hamano wrote:
> > Stephen Boyd <bebarino@gmail.com> writes:
> > > Nicolas Sebrecht wrote:
> > 
> > >> +	# Then, accept what really looks like (series of) email(s).
> > >> +	# the first sed select headers but the folded ones
> > >> +	sed -e '/^$/q' -e '/^[[:blank:]]/d' "$1" |
> > >> +	# this one is necessary for the next 'grep -v'
> > >> +	sed -e '/^$/d' |
> > >> +	grep -v -E -e '^[A-Za-z]+(-[A-Za-z]+)*:' ||
> > >> +	{
> > >> +		patch_format=mbox
> > >> +		return 0
> > >> +	}
> > >> +
> > >>  	# otherwise, check the first few lines of the first patch to try
> > >>  	# to detect its format
> > >>  	{
> > >
> > > This fails t4150-am.sh #10 (am -3 -q is quiet). You should redirect the
> > > output of the sed and grep to /dev/null like Junio did in his "how about
> > > this" patch.
> 
> Thank you.
> 
> > Honestly speaking, I do not understand why Nicolas changed my patch at
> > all.
> > 
> > This patch wastes an extra sed process
> 
> Should we really worry about that in a script like git-am.sh? I mean,
> does it matter in a day to day work?

Oh I've forgotten, yes we need it: sed -e '/^$/q' leaves this matching
line to the output. An extra CRLF makes 'grep -v' fail.

> >                                         introduces [[:blank::]] where
> > space and tab inside [] is perfectly adequate, and we know the latter is
> > understood by everybody's sed.
> 
> But is harder to read in editors.
> 
> > The worst part is that this check was moved before the most common case of
> > mbox file for which none of the overhead for this this extra processing is
> > necessary.
> 
> Well, I did this move just because of the logical structure of the code.
> That said, you're right about the overhead.

-- 
Nicolas Sebrecht
