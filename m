From: Bryan Larsen <bryan.larsen@gmail.com>
Subject: Re: [PATCH] cg-commit chokes when given a very large list of files
Date: Sun, 17 Jul 2005 23:29:41 -0400
Message-ID: <42DB2225.2070207@gmail.com>
References: <20050718031808.20247.43698.sendpatchset@bryan-larsens-ibook-g4.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: pasky@suse.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 05:30:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DuMKI-0002Bw-SO
	for gcvg-git@gmane.org; Mon, 18 Jul 2005 05:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbVGRD3n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jul 2005 23:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVGRD3n
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jul 2005 23:29:43 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:60136 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261508AbVGRD3n (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jul 2005 23:29:43 -0400
Received: by zproxy.gmail.com with SMTP id z31so39415nzd
        for <git@vger.kernel.org>; Sun, 17 Jul 2005 20:29:42 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=LpHyJ3gn6P9at1ugumbYANtmh5VZ3KJlUrxeiOKn4INYeKPfQU0mOk8WDAFPdX056aeQmg9AYgoSIj46n0zyLFh9TeqLGiGBxcih4I/qOJPMVVsSxtU5pGGvMKxNWSCmOT1k99qpxjEm9A1E0Ps96l8ti7mrUl8dsOO6pJJ4JtQ=
Received: by 10.36.157.2 with SMTP id f2mr3632832nze;
        Sun, 17 Jul 2005 20:29:42 -0700 (PDT)
Received: from ?192.168.1.100? ([70.26.43.137])
        by mx.gmail.com with ESMTP id 22sm5319201nzn.2005.07.17.20.29.41;
        Sun, 17 Jul 2005 20:29:42 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: en-us, en
To: Bryan Larsen <bryanlarsen@yahoo.com>
In-Reply-To: <20050718031808.20247.43698.sendpatchset@bryan-larsens-ibook-g4.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch is broken.  The original patch still works.

Bryan


Bryan Larsen wrote:
> cg-commit currently chokes when passed a very large list of files.
> Fix it.
> 
> This patch depends on your filenames not containing line feeds.  No
> big deal, other parts of cogito break on filenames containing line
> feeds.
> 
> Resent because previous send appears to have been dropped.  This patch
> is cleaner.
> 
> Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>
> ---
> 
>  cg-commit |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/cg-commit b/cg-commit
> --- a/cg-commit
> +++ b/cg-commit
> @@ -289,9 +289,9 @@ precommit_update () {
>  		eval "queue$op[\${#queue$op[@]}]=\"\$fname\""
>  	done
>  	# XXX: Do we even need to do the --add and --remove update-caches?
> -	[ "$queueN" ] && { git-update-cache --add ${infoonly} -- "${queueN[@]}" || return 1; }
> -	[ "$queueD" ] && { git-update-cache --force-remove -- "${queueD[@]}" || return 1; }
> -	[ "$queueM" ] && { git-update-cache ${infoonly} -- "${queueM[@]}" || return 1; }
> +	[ "$queueN" ] && { ( echo "${queueN[*]}" | tr \\n \\0 | IFS=$'\n' xargs -0 git-update-cache --add ${infoonly} -- ) || return 1; }
> +	[ "$queueD" ] && { ( echo "${queueD[*]}" | tr \\n \\0 | IFS=$'\n' xargs -0 git-update-cache --force-remove -- ) || return 1;  }
> +	[ "$queueM" ] && { ( echo "${queueM[*]}" | tr \\n \\0 | IFS=$'\n' xargs -0 git-update-cache ${infoonly} -- ) || return 1; }
>  	return 0
>  }
>  
> 
