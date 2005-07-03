From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Cogito: Use git-rev-parse instead of cg-Xnormid.
Date: Sun, 3 Jul 2005 08:59:20 +0200
Message-ID: <20050703065920.GA11765@pasky.ji.cz>
References: <42C77ECE.2080903@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 03 08:59:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoyS5-0005ml-O2
	for gcvg-git@gmane.org; Sun, 03 Jul 2005 08:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVGCG71 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jul 2005 02:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVGCG71
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jul 2005 02:59:27 -0400
Received: from w241.dkm.cz ([62.24.88.241]:15762 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261385AbVGCG7W (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Jul 2005 02:59:22 -0400
Received: (qmail 12899 invoked by uid 2001); 3 Jul 2005 06:59:20 -0000
To: Brian Gerst <bgerst@didntduck.org>
Content-Disposition: inline
In-Reply-To: <42C77ECE.2080903@didntduck.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Jul 03, 2005 at 07:59:42AM CEST, I got a letter
where Brian Gerst <bgerst@didntduck.org> told me that...
> Use git-rev-parse instead of cg-Xnormid.  This allows Cogito to work 
> properly with packed objects.
> 
> Signed off by: Brian Gerst <bgerst@didntduck.org>

But git-rev-parse sucks. It won't detect invalid IDs (--revs-only?), and
does not support short object IDs (that's a must, it's tremendously
useful). You need to add that for it to be useful first.

> diff --git a/tree-id b/tree-id
> --- a/tree-id
> +++ b/tree-id
> @@ -5,8 +5,8 @@
>  #
>  # Takes ID of the appropriate commit, defaults to HEAD.
>  
> -id="$1"
> -normid=$(${COGITO_LIB}cg-Xnormid "$id") || exit 1
> +id="${1:-HEAD}"
> +normid=$(git-rev-parse "$id")
>  type=$(git-cat-file -t "$normid")
>  
>  if [ "$type" = "commit" ]; then

This is broken too. You need to be able to pass _tree_ ID to tree-id too,
not just commit ID. Hmm, or is git-rev-parse able to process any ids?
Then it's terribly misnamed too. :-) A comment would be useful in that
case. (Or better a patch to rename it.)

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
