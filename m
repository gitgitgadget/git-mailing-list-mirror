From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cg-fetch will now retrieve commits related to tags if missing.
Date: Wed, 19 Oct 2005 18:25:37 -0700
Message-ID: <7voe5lvv1q.fsf@assigned-by-dhcp.cox.net>
References: <1129769745158-git-send-email-martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 03:26:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESPBy-0001ZD-P3
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 03:26:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbVJTBZk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 21:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751675AbVJTBZj
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 21:25:39 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:14308 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751265AbVJTBZj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 21:25:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051020012514.LCOX29216.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 19 Oct 2005 21:25:14 -0400
To: Martin Langhoff <martin@catalyst.net.nz>
In-Reply-To: <1129769745158-git-send-email-martin@catalyst.net.nz> (Martin
	Langhoff's message of "Thu, 20 Oct 2005 13:55:45 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10335>

Martin Langhoff <martin@catalyst.net.nz> writes:

> diff --git a/cg-fetch b/cg-fetch
> index 7694584..d4650e5 100755
> --- a/cg-fetch
> +++ b/cg-fetch
> @@ -417,7 +417,8 @@ $get -i -s -u -d "$uri/refs/tags" "$_git
>  	for tag in *; do
>  		[ "$tag" = "*" ] && break
>  		tagid=$(cat $tag)

You just reported this $tag needs quoting ;-).

> +		GIT_DIR=../.. [ "`git-cat-file -t $tagid 2>/dev/null`" = "commit" ] && continue
> +		GIT_DIR=../.. git-cat-file commit `git-rev-parse $tag^{commit}  2>/dev/null` 2>&1 >> /dev/null && continue

You are saying:
	if "$tagid" is already commit then continue;
        if "$tagid" dereferences to a commit and if you have it
	then continue

If that is the case, then this might be more efficient.

	GIT_DIR=../.. git-rev-parse --verify "$tagid^0" >/dev/null 2>&1 && continue

You can say ^{commit} instead of ^0 if you like that newer
style, of course.
