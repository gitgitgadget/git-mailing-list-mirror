From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: Updated Kernel Hacker's guide to git
Date: Fri, 22 Dec 2006 10:35:47 +0100
Message-ID: <38b2ab8a0612220135p6925be4cmf003811f616395ba@mail.gmail.com>
References: <38b2ab8a0612210424o4ec5fcd5kb5086c52ccd76491@mail.gmail.com>
	 <Pine.LNX.4.64.0612211013500.3394@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jay Cliburn" <jacliburn@bellsouth.net>, git@vger.kernel.org,
	"Jeff Garzik" <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Fri Dec 22 10:35:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxgon-0007Kj-Rc
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 10:35:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946008AbWLVJft (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 04:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965144AbWLVJft
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 04:35:49 -0500
Received: from wx-out-0506.google.com ([66.249.82.230]:34805 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965113AbWLVJfs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 04:35:48 -0500
Received: by wx-out-0506.google.com with SMTP id h27so2680880wxd
        for <git@vger.kernel.org>; Fri, 22 Dec 2006 01:35:47 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mUFGujtt9PrRKS1eaiAvyKhbCe+4+2Npwnf2uauuHcn1l9XUSx7YQmIeXoXLZXbUupLOCcSSsYjtNMWy/1cJVO6b/QLa5ZRijDPalfn5PtC3r7Ri245f79FoLQqQtYnYo/u0UkD10gFVKkbhkygYS7i/Nf8je6K3/MpAkncw1OM=
Received: by 10.90.32.14 with SMTP id f14mr9191798agf.1166780147899;
        Fri, 22 Dec 2006 01:35:47 -0800 (PST)
Received: by 10.90.106.16 with HTTP; Fri, 22 Dec 2006 01:35:47 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612211013500.3394@woody.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35154>

Linus Torvalds wrote:
>
> In short, for git diff (and ONLY) git diff, all of these are the same:
>
> 	git diff a..b
> 	git diff a b
> 	git diff b ^a
>

I think this part is really confusing. For a new comer, saying that:

	git diff a b == git diff a..b

is really not intuitive. Maybe just because adding a new symbol ".."
in git diff command line means (for me) that we're doing a special
diff. I would never thought by my own that ".." means a simple "to".

> [ ADDITIONALLY git diff _also_ has a magic special case of
>
> 	git diff a b ^c
>
>   which actually means the same as "git diff c..a" (and "b" is
>   totally ignored). That may sound strange, but it's because the
>   expression "a...b" means "b a --not $(git-merge-base a b)", and so what
>   you actually WANT is that if you do
>
> 	git diff a...b
>
>   you should get "diff from merge-base to b", so when "a...b" expands to
>   "b a ^merge-base", then git understands that if it gets that stange
>   command line with THREE commits, and one of them is negated, you really
>   wanted the diff from the negated one to the first one ]
>
> It basically all boils down to:
>
> 	"git diff" is special
>

but this very special part of git diff is also not documented at all
when reading the manual of git-diff... Maybe it can be reached by
others manuals ?

> exactly because unlike almost ALL other git commands, "git diff" does not
> work on a _list_ of commits, it only works on two end-points. That means
> that the "list operations" actually end up meaning something else for git
> diff than they do for "git log" and friends.
>

I think I got your point now: git-diff only works on two end-points.


Why not making it less special as follow:

	git diff a b
	git diff b ^a

These two diff commands are the same. They do a diff between a and b
end-points (maybe commits is better there since we don't add one more
keyword). It's similar to diff command. For me it's quite intuitive.

	git diff a..b

Ok now the command syntax is more special (maybe simply because
traditional diff() does not have a similar syntax, it's really
specific to git). "git log" and friends have a similar syntax and they
do work on a list of commits. For consistency sake, make this commad
works on commit list too. Therefore this command would end up doing
exactly the same thing like "git diff a...b"

	git diff a...b

No more need of this special syntax.


What do you think ?

thanks
-- 
Francis
