From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Cleanup cogito command usage reporting
Date: Mon, 30 May 2005 10:45:58 +0200
Message-ID: <20050530084558.GE1036@pasky.ji.cz>
References: <20050530023603.GC10715@diku.dk> <20050530030521.GA13232@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 30 10:44:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcfsA-0003HT-MK
	for gcvg-git@gmane.org; Mon, 30 May 2005 10:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbVE3IqJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 04:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbVE3IqJ
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 04:46:09 -0400
Received: from w241.dkm.cz ([62.24.88.241]:33932 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261565AbVE3IqA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2005 04:46:00 -0400
Received: (qmail 20005 invoked by uid 2001); 30 May 2005 08:45:58 -0000
To: Jonas Fonseca <fonseca@diku.dk>
Content-Disposition: inline
In-Reply-To: <20050530030521.GA13232@diku.dk>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, May 30, 2005 at 05:05:21AM CEST, I got a letter
where Jonas Fonseca <fonseca@diku.dk> told me that...
> [ Sorry for the resend. This should bring all usage strings in sync. I
>   forgot to add the new options. ]
> 
>  - Synchronize usage strings with those in cg-help. The command
>    identifiers are still not as descriptive, though.

Ok, I'll focus on this point (the rest seems fine). I think it's
inferior this way, since you are losing information, and for no benefit.

> diff --git a/cg-clone b/cg-clone
> --- a/cg-clone
> +++ b/cg-clone
> @@ -15,11 +15,12 @@
> -USAGE="cg-clone [-s] LOCATION [<directory>]"
> +USAGE="cg-clone [-s] LOCATION [DESTINATION]"
> @@ -30,7 +31,7 @@ if [ "$1" = "-s" ]; then
>  fi
>  
>  location=$1
> -[ "$location" ] || die "usage: cg-clone [-s] SOURCE_LOC [DESTDIR]"
> +[ "$location" ] || usage

LOCATION -> SOURCE_LOC is fine in this context (if we would ever want
DEST_LOC, it would be better to stick with SOURCE_LOC, though). But
DESTDIR->DESTINATION is losing information. In cogito.txt you describe
DESTINATION as a general target location, but it's really a directory
here. And it's shorter.

> diff --git a/cg-export b/cg-export
> --- a/cg-export
> +++ b/cg-export
> @@ -22,7 +22,7 @@ USAGE="cg-export DESTINATION [TREE]"
>  dest=$1
>  id=$(tree-id $2)
>  
> -([ "$dest" ] && [ "$id" ]) || die "usage: cg-export DEST [TREE_ID]"
> +([ "$dest" ] && [ "$id" ]) || usage

I'm for DESTDIR here too, and what harm does the _ID part make here? I
think it's non-obvious otherwise - "TREE" can be understood as some
directory name too.

> diff --git a/cg-help b/cg-help
> --- a/cg-help
> +++ b/cg-help
> @@ -43,7 +43,7 @@ Available commands:
>  	cg-export	DEST [TREE_ID]
>  	cg-help		[COMMAND]
>  	cg-init
> -	cg-log		[-c] [-f] [-m] [-r FROM_ID[:TO_ID]] [FILE]...
> +	cg-log		[-c] [-f] [-m] [-uUSERNAME] [-r FROM_ID[:TO_ID]] [FILE]...
>  	cg-ls		[TREE_ID]
>  	cg-merge	[-c] [-b BASE_ID] FROM_ID
>  	cg-mkpatch	[-m] [-s] [-r FROM_ID[:TO_ID]]

So what about bringing those in sync too? (Or alternatively letting it
be now and build the output dynamically in another patch.)

> diff --git a/cg-merge b/cg-merge
> --- a/cg-merge
> +++ b/cg-merge
> @@ -38,11 +38,11 @@ fi
>  base=
>  if [ "$1" = "-b" ]; then
>  	shift
> -	[ "$1" ] || die "usage: cg-merge [-c] [-b BASE_ID] FROM_ID"
> +	[ "$1" ] || usage

I think BASE_ID->REVISION is loosing information too. What about
BASE_COMMIT or something?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
