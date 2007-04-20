From: Junio C Hamano <junkio@cox.net>
Subject: Re: git clone problem through HTTP
Date: Fri, 20 Apr 2007 14:31:40 -0700
Message-ID: <7vd51yybpf.fsf@assigned-by-dhcp.cox.net>
References: <6d6a94c50704200015p65dc4a8dn4abd8aaed35b9521@mail.gmail.com>
	<7vodliyd1j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Julian Phillips <julian@quantumfyre.co.uk>,
	"Alex Riesen" <raa.lkml@gmail.com>,
	Brian Gernhardt <benji@silverinsanity.com>
To: "Aubrey Li" <aubreylee@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 20 23:31:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hf0hl-0004GU-UY
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 23:31:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767246AbXDTVbm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 17:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767262AbXDTVbm
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 17:31:42 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:37656 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767246AbXDTVbl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 17:31:41 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070420213142.KLTD1235.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Fri, 20 Apr 2007 17:31:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id pZXg1W00R1kojtg0000000; Fri, 20 Apr 2007 17:31:41 -0400
In-Reply-To: <7vodliyd1j.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 20 Apr 2007 14:02:48 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45134>

Junio C Hamano <junkio@cox.net> writes:

> [[manual workaround to make it work with existing tools]]
> ... should work, because I knew about this problem and fixed it in
> git-fetch in v1.5.0.
>
> Alas, I forgot to update the matching code in git-clone.
>
> This is why I keep saying that we should get rid of as much code
> from git-clone, and make it essentially a thin wrapper around
> the six commands I quoted above.
>
> ---
>
> diff --git a/git-clone.sh b/git-clone.sh
> index 513b574..cad5c0c 100755
> --- a/git-clone.sh
> +++ b/git-clone.sh
> @@ -60,7 +60,7 @@ Perhaps git-update-server-info needs to be run there?"
>  		else
>  			tname=$name
>  		fi
> -		git-http-fetch $v -a -w "$tname" "$name" "$1" || exit 1
> +		git-http-fetch $v -a -w "$tname" "$sha1" "$1" || exit 1
>  	done <"$clone_tmp/refs"
>  	rm -fr "$clone_tmp"
>  	http_fetch "$1/HEAD" "$GIT_DIR/REMOTE_HEAD" ||

I've applied the above patch on top of 'maint' and it clones
Linus's reopsitory over http just fine.  I will include this fix
in upcoming maintenance release v1.5.1.2.

Thanks for reporting the breakage.
