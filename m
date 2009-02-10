From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Fix contrib/hooks/post-receive-email for new branch with no new commits
Date: Tue, 10 Feb 2009 07:46:31 -0800 (PST)
Message-ID: <m3ab8uuwfg.fsf@localhost.localdomain>
References: <1234273695-4981-1-git-send-email-pknotz@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Pat Notz" <pknotz@sandia.gov>
X-From: git-owner@vger.kernel.org Tue Feb 10 16:48:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWuqB-0008Uc-E6
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 16:48:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153AbZBJPqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 10:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752725AbZBJPqf
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 10:46:35 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:58581 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945AbZBJPqe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 10:46:34 -0500
Received: by ewy14 with SMTP id 14so3123633ewy.13
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 07:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=djqjvjJBpZ4+I0qdevmP9RgeG+CR5alFrQkpF82Y5fw=;
        b=NzV+xRMc5gt+fg7otWCWzJIL+D+bY1rUDovykAHo+e/6VpXa+0Vz0X+t8lHVzJDEN/
         8cs7PBVT25QiRJxi23PnTd6SMym/Zf657dc0GJBUU+yjc6caFSp/JSCuQ8ObSemrGaRZ
         WD7Ot63iPujfu6Id73ZpCKLaMIuDqpFx7GOek=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=N5ATQQTM7fMjXMJAftYe5tzPDSRY4cCY0vyOLdid6eWa0ykEA9hhddT4HAkJa67E4s
         NVptMUqUTakQGb/XVB1sUughGCXV2zBRRIXTS2UDu0MNOzseYqBUNHMM9monAKrn/Rnn
         YHmiZvI54Dkxo3dlhU5AwnOMrk7OD+alt5Z0Y=
Received: by 10.210.61.8 with SMTP id j8mr141915eba.1.1234280792126;
        Tue, 10 Feb 2009 07:46:32 -0800 (PST)
Received: from localhost.localdomain (abwt167.neoplus.adsl.tpnet.pl [83.8.243.167])
        by mx.google.com with ESMTPS id 23sm4156115eya.56.2009.02.10.07.46.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Feb 2009 07:46:31 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n1AFkTwO022712;
	Tue, 10 Feb 2009 16:46:30 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n1AFkS5F022709;
	Tue, 10 Feb 2009 16:46:28 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1234273695-4981-1-git-send-email-pknotz@sandia.gov>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109258>

"Pat Notz" <pknotz@sandia.gov> writes:

> In the show_new_revisions function, the original code:
> 
>    git rev-parse --not --branches | grep -v $(git rev-parse $refname) |
> 
> isn't quite right since one can create a new branch and push it without
> any new commits.  In that case, two refs will have the same sha1 but
> both would get filtered by the 'grep'.  In the end, we'll show ALL the
> history which is not what we want.  Instead, we should list the branches
> by name and remove the branch being updated and THEN pass that list
> through rev-parse.

Good idea, bad execution.

> 
> Signed-off-by: Pat Notz <pknotz@sandia.gov>
> ---
>  contrib/hooks/post-receive-email |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
> index 28a3c0e..116f89c 100644
> --- a/contrib/hooks/post-receive-email
> +++ b/contrib/hooks/post-receive-email
> @@ -615,7 +615,9 @@ show_new_revisions()
>  		revspec=$oldrev..$newrev
>  	fi
>  
> -	git rev-parse --not --branches | grep -v $(git rev-parse $refname) |
> +	this_branch=$(echo $refname | sed 's@refs/heads/@@')
> +	other_branches=$(git branch | sed 's/\*//g' | grep -v $this_branch)

git-branch is porcelain, git-branch is porcelain, git-branch is porcelain,
git-branch is porcelain, git-branch is porcelain, git-branch is porcelain,
git-branch is porcelain, git-branch is porcelain, ...

Don't use sed if shell will suffice...

Either:

+	this_branch=$refname
+	other_branches=$(git for-each-ref --format='%(refname)' refs/heads/ |
+               grep -v $this_branch)

or

+	this_branch=${refname#refs/heads/}
...

> +	git rev-parse --not $other_branches |
>  	if [ -z "$custom_showrev" ]
>  	then
>  		git rev-list --pretty --stdin $revspec
> -- 
> 1.6.1.2
> 
> 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
