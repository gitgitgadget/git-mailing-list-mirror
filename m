From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] cogito: Add cg-undo command
Date: Tue, 3 May 2005 23:32:04 +0200
Message-ID: <20050503213204.GC15995@pasky.ji.cz>
References: <20050503100624.A29266@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 23:26:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT4tz-0003ts-8k
	for gcvg-git@gmane.org; Tue, 03 May 2005 23:25:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbVECVcQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 17:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbVECVcQ
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 17:32:16 -0400
Received: from w241.dkm.cz ([62.24.88.241]:972 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261757AbVECVcJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 17:32:09 -0400
Received: (qmail 11360 invoked by uid 2001); 3 May 2005 21:32:05 -0000
To: Matt Porter <mporter@kernel.crashing.org>
Content-Disposition: inline
In-Reply-To: <20050503100624.A29266@cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, May 03, 2005 at 07:06:25PM CEST, I got a letter
where Matt Porter <mporter@kernel.crashing.org> told me that...
> Index: cg-help
> ===================================================================
> --- a1aff2a6748c0c0d08058c7d74503e724abc5d03/cg-help  (mode:100755 sha1:1f5d2d79b67490d44ce0f575ff9a4b80134ea47f)
> +++ 023d9a7929d2f933d8e008f1679f13a58f7b1229/cg-help  (mode:100755 sha1:c7dc8f3e03895374cd0dae544570a37a459c2466)
> @@ -43,6 +43,7 @@
>  	cg-status
>  	cg-tag		TNAME [COMMIT_ID]
>  	cg-tag-ls
> +	cg-undo		[COMMIT_ID]

It doesn't seem very optional now.

>  	cg-update	[BNAME]
>  	cg-version
>  
> Index: cg-undo
> ===================================================================
> --- /dev/null  (tree:a1aff2a6748c0c0d08058c7d74503e724abc5d03)
> +++ 023d9a7929d2f933d8e008f1679f13a58f7b1229/cg-undo  (mode:100755 sha1:7fd6d89158fb5aeee42aa05a93f2c81884d9bd34)
> @@ -0,0 +1,20 @@
> +#!/usr/bin/env bash
> +#
> +# Undo a commit or a series of commits
> +# Copyright (C) Matt Porter, 2005
> +#
> +# Takes a commit ID which is the earliest commit to be
> +# removed from the repository.
> +
> +. cg-Xlib
> +
> +PARENT=`git-cat-file commit $1 | grep parent | cut -f 2 -d " "`

What's wrong with parent-id?

> +echo "Undo from $1 to current HEAD"
> +echo "Reset HEAD to $PARENT"

You talk way too much, I think. I'd just do

	echo "Rewinding $HEAD -> $PARENT" >&2

> +echo "$PARENT" > .git/HEAD
> +git-read-tree -m "$PARENT" || {
> +	echo >&2 "$PARENT: bad commit"
> +	exit 1
> +}
> +git-checkout-cache -f -a
> +git-update-cache --refresh

You really don't want to do this if the tree has any local
modifications.


Please make sure the commit you are rewinding to is an ancestor of your
current HEAD (there should be something like separate cg-branch-rm for
killing enemy branches).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
