From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH v2 1/2] rebase -i -p: handle index and workdir correctly
Date: Wed, 13 Aug 2008 22:58:06 +0200
Message-ID: <20080813205806.GC10758@leksak.fem-net>
References: <200808131207.31616.trast@student.ethz.ch> <23b4780a3a7bbe06f4157b6843d1d9dab26d7087.1218628444.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Aug 13 22:59:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTNR4-0001nk-DS
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 22:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155AbYHMU6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 16:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbYHMU6L
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 16:58:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:47075 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752155AbYHMU6K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 16:58:10 -0400
Received: (qmail invoked by alias); 13 Aug 2008 20:58:08 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp012) with SMTP; 13 Aug 2008 22:58:08 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/UgH55P5jUfBo15WlOsZP5aMklzEb/lViMUpTzwP
	xcNkF5b0OglpfD
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KTNPy-0005OL-1h; Wed, 13 Aug 2008 22:58:06 +0200
Content-Disposition: inline
In-Reply-To: <23b4780a3a7bbe06f4157b6843d1d9dab26d7087.1218628444.git.trast@student.ethz.ch>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92273>

Hi,

Thomas Rast wrote:
> Also, it attempted to do a fast forward even if it was instructed not
> to commit (via -n).  Fall back to the cherry-pick code path and let
> that handle the issue for us.
> 
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>  git-rebase--interactive.sh    |   13 ++++++++++++-
>  t/t3404-rebase-interactive.sh |    6 ++++++
>  2 files changed, 18 insertions(+), 1 deletions(-)
> 
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 4e334ba..1dc24b1 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -145,7 +145,16 @@ pick_one () {
>  }
>  
>  pick_one_preserving_merges () {
> -	case "$1" in -n) sha1=$2 ;; *) sha1=$1 ;; esac
> +	fast_forward=t
> +	case "$1" in
> +	-n)
> +		fast_forward=f
> +		sha1=$2

The intention of setting fast_forward=f is clear, but it is overwritten
later on line 169 that is not shown in this patch:

168:	# rewrite parents; if none were rewritten, we can fast-forward.
169:	fast_forward=t

Clearly, this is due to your patch split, because after the second
patch, this is fixed.

The rest of this patch seems to be ok to me.

Regards.

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
