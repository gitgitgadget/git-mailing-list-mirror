From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: crlf with git-svn driving me nuts...
Date: Thu, 17 Apr 2008 00:01:07 +0400
Message-ID: <20080416200107.GG3133@dpotapov.dyndns.org>
References: <320075ff0804161210m46f3e83bpf7bf9d1d5816d914@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Nigel Magnay <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 22:20:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmDxE-0002Hf-A7
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 22:10:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793AbYDPUJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 16:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752783AbYDPUJT
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 16:09:19 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:29235 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637AbYDPUJS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 16:09:18 -0400
Received: by nf-out-0910.google.com with SMTP id g13so799486nfb.21
        for <git@vger.kernel.org>; Wed, 16 Apr 2008 13:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=vydC5ZyTd23iP46dZeR/elossLmH+BqM+rI413LRUpU=;
        b=k3bFcDuyRzPIigqe4vlqZIrYzeqLLmE/SXtgpF2zr6k87JspjkJqiB3a92KM2wvX7wMlepcL5i0lD06m7/NeGZ2te++gBDwlFITayb2EW1eazu5QHrugXiXieJcuFkCNjeICrw0VYgKHLr2kIInLajMbtOl1zw1yevFt/QPzVXs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=PjnPFvh/FeWAhoE/rHObtCkb7nEtC4gGl4efY6xWhX35qgzc1KcR9Y9ZDGKc4TuEaWsvT0ukfS/zpO4IYcVFe2sPiU/p7oKKXSMMqZ2gVAt4zI2Rcxkhob1lSwdkTcYqcWClxca0W4ew+8vTuEdE21vWA/HBk4mXISvzYCXeUMU=
Received: by 10.78.183.20 with SMTP id g20mr758281huf.31.1208376075256;
        Wed, 16 Apr 2008 13:01:15 -0700 (PDT)
Received: from localhost ( [85.141.188.158])
        by mx.google.com with ESMTPS id b35sm12999325ugd.33.2008.04.16.13.01.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Apr 2008 13:01:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <320075ff0804161210m46f3e83bpf7bf9d1d5816d914@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79740>

On Wed, Apr 16, 2008 at 08:10:26PM +0100, Nigel Magnay wrote:
> We've got projects with a mixed userbase of windows / *nix; I'm trying
> to migrate some users onto git, whilst everyone else stays happy in
> their SVN repo.
> 
> However, there's one issue that has been driving me slowly insane.
> This is best illustrated thusly (on windows) :
> 
>   $ git init
>   $ git config core.autocrlf false

core.autocrlf=false is a bad choice for Windows.

> 
> -->Create a file with some text content on a few lines
>   $ notepad file.txt
> 
>   $ git add file.txt
>   $ git commit -m "initial checkin"

You added a file with the CRLF ending in the repository!
You are going to have problems now...

> 
>   $ git status
> # On branch master
> nothing to commit (working directory clean)
> --> Yarp, what I wanted
> 
>   $ git config core.autocrlf true
>   $ git status

You should not change core.autocrlf during your work, or you
are going to have some funny problems. If you really need to
change it, it should be followed by "git reset --hard".

In this case, you already have a file with the wrong ending,
so file.txt will be shown as changed now, because if you commit
it again then it will be commited with <LF>, which should have
been done in the first place.

> 
> # On branch master
> nothing to commit (working directory clean)
> --> Yarp, still all good
> 
> --> Simulate non-change happened by an editor opening file...
>   $ touch file.txt
>   $ git status
> # On branch master
> # Changed but not updated:
> #   (use "git add <file>..." to update what will be committed)
> #
> #       modified:   file.txt
> #
> no changes added to commit (use "git add" and/or "git commit -a")
> 
> --> Oh Noes! I wonder what it could be
>   $ git diff file.txt
> diff --git a/file.txt b/file.txt
> index 7a2051f..31ca3a0 100644
> --- a/file.txt
> +++ b/file.txt
> @@ -1,3 +1,3 @@
> -<xml>
> -       wooot
> -</xml>
> +<xml>
> +       wooot
> +</xml>
> 
> --> Huh? ...

Actually, it is

@@ -1,3 +1,3 @@
-<xml>^M
-       wooot^M
-</xml>^M
+<xml>
+       wooot
+</xml>

where ^M is <CR>

> 
> --> WtF?
> 
> Why does it think in this instance that there is a change? It's CRLF
> in the repo, it's CRLF in the working tree, and the checkout in either
> mode ought to be identical ??

If you do not want problems, you should use core.autocrlf=true
on Windows. Then all text files will be stored in the repository
with <LF>, but they will have <CR><LF> in your work tree.
Users on *nix should set core.autocrlf=input or false, so they
will have <LF> in their work tree.

Dmitry
