From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: How to get bash to shut up about SIGPIPE?
Date: Fri, 29 Apr 2005 19:59:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504291956030.2296@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504281121430.18901@ppc970.osdl.org>
 <20050429172235.21c1af10.pj@sgi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, pasky@ucw.cz
X-From: git-owner@vger.kernel.org Sat Apr 30 04:52:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRi5u-0005ng-0p
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 04:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262471AbVD3C6Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 22:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263139AbVD3C6Q
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 22:58:16 -0400
Received: from fire.osdl.org ([65.172.181.4]:63386 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262471AbVD3C54 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 22:57:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3U2vls4006572
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 29 Apr 2005 19:57:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3U2vkCQ019438;
	Fri, 29 Apr 2005 19:57:46 -0700
To: Paul Jackson <pj@sgi.com>
In-Reply-To: <20050429172235.21c1af10.pj@sgi.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 29 Apr 2005, Paul Jackson wrote:
>
> > bash is being an ass about SIGPIPE
> 
> You have a multiprocessor, don't you.

Yes. 

> The following silly little shell script will provoke the bash SIGPIPE
> complaint reliably on a multiprocessor.

Yup:

	t: line 5:  3853 Broken pipe             cat /etc/termcap
	t: line 5:  3855 Broken pipe             cat /etc/termcap

> Adding a right trap _inside_ the shell loop that is _before_ the pipe
> will reduce the verbosity of the complaint substantially (not show the
> line number and text for each command inside the loop that is killed by
> the SIGPIPE; rather just show the simple "Broken pipe" error message):
> 
> Code Sample 2:
> 
>     #!/bin/bash
>     for x in 1 2
>     do
> 	trap continue PIPE	# reduce broken pipe screeching
> 	cat /etc/termcap	# a big text file
>     done | sed 1q

Didn't change anything for me. Same thing.

> Then wrapping the entire pipeline (now that the bogus output is a
> constant "Broken pipe" string) in the following manner will filter out
> just that noise, leaving whatever else was on stdout and/or stderr
> unscathed:

It will also grep out any occurrence of "Broken pipe", so if we're talking 
about a kernel changelog, where we fix a pipe bug...

> Whether or not this is actually worth persuing (or was even worth
> reading ;) I don't know.

I don't know why the bash people have that stupid pipe reporting in the 
first place, considering that no other shell seems to do it, and everybody 
just wants to shut it up..

		Linus
