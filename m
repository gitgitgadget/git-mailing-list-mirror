From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH] Make cg-clone handle local directories as sources
Date: Fri, 29 Apr 2005 18:08:02 -0400
Message-ID: <20050429220802.GG1233@mythryan2.michonline.com>
References: <20050429215928.GF1233@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 00:03:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRdZS-000170-F3
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 00:02:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbVD2WIb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 18:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263025AbVD2WIb
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 18:08:31 -0400
Received: from mail.autoweb.net ([198.172.237.26]:5264 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S263024AbVD2WIX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 18:08:23 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DRdep-0007RG-7q
	for git@vger.kernel.org; Fri, 29 Apr 2005 18:08:23 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1DRdeV-0003Xd-00; Fri, 29 Apr 2005 18:08:03 -0400
Received: from ryan by mythical with local (Exim 4.50)
	id 1DRdeV-0002Xa-05; Fri, 29 Apr 2005 18:08:03 -0400
To: Ryan Anderson <ryan@michonline.com>
Content-Disposition: inline
In-Reply-To: <20050429215928.GF1233@mythryan2.michonline.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ignore this, I did something stupid - new patch to follow in a minute.

On Fri, Apr 29, 2005 at 05:59:29PM -0400, Ryan Anderson wrote:
> 
> cg-clone is described as only being used with remote repositories, but
> it has the nice feature of creating the destination directory for you.
> 
> This patch adds two features:
> 	1. A destination directory can (optionally) be specified.
> 	2. The source directory can be in the local file system.
> 
> The following, for example, now works:
> 
> 	cg-clone rsync://rsync.kernel.org/pub/scm/cogito/cogito.git
> 	mkdir test ; cd test
> 	cg-clone ../cogito ../cogito2/
> 
> Index: cg-clone
> ===================================================================
> --- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/cg-clone  (mode:100755 sha1:4ee0685c358e094c5350b3968d013105da6ddf7e)
> +++ uncommitted/cg-clone  (mode:100755)
> @@ -11,13 +11,22 @@
>  . cg-Xlib
>  
>  location=$1
> -[ "$location" ] || die "usage: cg-clone SOURCE_LOC"
> +[ "$location" ] || die "usage: cg-clone SOURCE_LOC [DEST_LOC]"
>  location=${location%/}
>  
> -dir=${location##*/}; dir=${dir%.git}
> +if [ "$2" == "" ]; then
> +	dir=${location##*/}; dir=${dir%.git}
> +else
> +	dir=$2
> +fi
> +
> +pwd=$(pwd)
> +relative_location=$(echo "$location" | sed -e "s#^[^/]#$pwd\/&#")
> +
>  [ -e "$dir" ] && die "$dir/ already exists"
>  mkdir "$dir"
>  cd "$dir"
>  
> -cg-init $location || exit $?
> +echo "cg-init $relative_location"
> +cg-init $relative_location || exit $?
>  echo "Cloned to $dir/ (origin $location available as branch \"origin\")"
> 
> 
> -- 
> 
> Ryan Anderson
>   sometimes Pug Majere
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 

Ryan Anderson
  sometimes Pug Majere
