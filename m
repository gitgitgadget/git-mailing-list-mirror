From: Anton Blanchard <anton@samba.org>
Subject: Re: git clone takes ages on a slow link
Date: Mon, 5 Jun 2006 08:29:02 +1000
Message-ID: <20060604222901.GD986@krispykreme>
References: <20060604010145.GC986@krispykreme> <Pine.LNX.4.64.0606041046340.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Jun 05 00:30:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fn17I-0001Ag-Cw
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 00:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWFDWah (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 18:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWFDWah
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 18:30:37 -0400
Received: from ozlabs.org ([203.10.76.45]:9684 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932288AbWFDWah (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jun 2006 18:30:37 -0400
Received: by ozlabs.org (Postfix, from userid 1010)
	id 616BA67A3A; Mon,  5 Jun 2006 08:30:36 +1000 (EST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606041046340.5498@g5.osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21290>


Hi Linus,

> It is indeed. It's _meant_ to only tick once a second or when the 
> percentage changes, but I think it forgot to clear the "once a second 
> happened" flag, so instead of updates the percentage output for every 
> file it checks out after the first second has passed.
> 
> So something like this should help... Can you verify?

Thanks, it fixes it.

Anton

> diff --git a/builtin-read-tree.c b/builtin-read-tree.c
> index 716f792..80c9320 100644
> --- a/builtin-read-tree.c
> +++ b/builtin-read-tree.c
> @@ -336,6 +336,7 @@ static void check_updates(struct cache_e
>  					fprintf(stderr, "%4u%% (%u/%u) done\r",
>  						percent, cnt, total);
>  					last_percent = percent;
> +					progress_update = 0;
>  				}
>  			}
>  		}
