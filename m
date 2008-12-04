From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Allow passing of --directory to git-am.
Date: Thu, 04 Dec 2008 11:35:41 -0800 (PST)
Message-ID: <m3hc5jivjo.fsf@localhost.localdomain>
References: <49382612.3010207@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: "Simon 'corecode' Schubert" <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Thu Dec 04 20:37:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8K0X-0000ol-KN
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 20:37:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754340AbYLDTfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 14:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753722AbYLDTfq
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 14:35:46 -0500
Received: from ti-out-0910.google.com ([209.85.142.186]:58333 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799AbYLDTfp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 14:35:45 -0500
Received: by ti-out-0910.google.com with SMTP id b6so2702572tic.23
        for <git@vger.kernel.org>; Thu, 04 Dec 2008 11:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=oyI7JpmAHHuFnJRiYz6YcHT6QAUCCGwjY0L4LFl+Iz8=;
        b=ACC+6dMtUjX7fq/q3Gkfmqm2eqn4PgQ6YX8T1a7wNbJzUK4PJLEtQKlnIV+eUwvoIK
         Vf2YHrVtPlB6yoqxUs1gvusP5D9bLKuz6e1ADgxYsn9VBs1vMKroLizHPM2E6GJ7geoP
         H3WntkcAUkfglT9BK8QbaBmV8PqQ+MvX8NQQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=cJBawYYVZXhyJti1u1RhOQzPu6C0FfI8PhePoQ5QCYczlb0acbor7wTxIWO0Fm6DKR
         p1SInGKES8fGTiBR0L/HPt6GeB88ZniWGwMieROlDAc0q4udzbcKQulva3/Zl040yn+S
         TghmGqZxaVFmTuAM5w+tizJeWZAUU8jmP8JGk=
Received: by 10.110.63.17 with SMTP id l17mr7337340tia.57.1228419343327;
        Thu, 04 Dec 2008 11:35:43 -0800 (PST)
Received: from localhost.localdomain (abvv86.neoplus.adsl.tpnet.pl [83.8.219.86])
        by mx.google.com with ESMTPS id i6sm5103003tid.5.2008.12.04.11.35.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Dec 2008 11:35:41 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mB4JYq4Y005312;
	Thu, 4 Dec 2008 20:35:02 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mB4JYZ6x005308;
	Thu, 4 Dec 2008 20:34:35 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <49382612.3010207@fs.ei.tum.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102360>

Simon 'corecode' Schubert <corecode@fs.ei.tum.de> writes:

> We need to play some shell tricks to be able to pass directory names
> which contain spaces and/or quotes.
> 
> Signed-off-by: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
> ---
> 
> Boyd Stephen Smith Jr. wrote:
>  > I'm thinking your sed line doesn't do what you think it does.
>  > You probably want something like:
>  > bss@monster:~$ echo "don't" | sed -e "s/'/'\\\\''/g"
>  > don'\''t
> 
> Thanks, I clearly did not test this well enough.
> 
>   git-am.sh |    8 +++++---
>   1 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/git-am.sh b/git-am.sh
> index aa60261..3baff4e 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -16,6 +16,7 @@ s,signoff       add a Signed-off-by line to the commit message
>   u,utf8          recode into utf8 (default)
>   k,keep          pass -k flag to git-mailinfo
>   whitespace=     pass it through git-apply
> +directory=      pass it through git-apply

Shouldn't it be

+ directory=      pass it through git-apply

to have it aligned like the rest of it?

By the way, your patch looks whitespace damaged, although only context
for the above chunk was wrapped...

>   C=              pass it through git-apply
>   p=              pass it through git-apply
>   resolvemsg=     override error message when patch failure occurs
> @@ -155,8 +156,9 @@ do
>   		;;
>   	--resolvemsg)
>   		shift; resolvemsg=$1 ;;
> -	--whitespace)
> -		git_apply_opt="$git_apply_opt $1=$2"; shift ;;
> +	--whitespace|--directory)
> +		quot=$(echo "$2" | sed -e "s/'/'\\\''/g")

Why not simply use "git rev-parse --sq"?

> +		git_apply_opt="$git_apply_opt $1='$quot'"; shift ;;
>   	-C|-p)
>   		git_apply_opt="$git_apply_opt $1$2"; shift ;;
>   	--)
> @@ -454,7 +456,7 @@ do
> 
>   	case "$resolved" in
>   	'')
> -		git apply $git_apply_opt --index "$dotest/patch"
> +		eval git apply $git_apply_opt --index '"$dotest/patch"'

Why eval?

>   		apply_status=$?
>   		;;
>   	t)
> -- 
> 1.6.1.rc1.45.g123ed.dirty

Hmmm... 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
