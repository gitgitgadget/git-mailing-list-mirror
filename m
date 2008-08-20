From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Extend "checkout --track" DWIM to support more cases
Date: Wed, 20 Aug 2008 22:29:52 +0200
Message-ID: <20080820202952.GH16626@blimp.local>
References: <20080820185028.GA16626@blimp.local> <alpine.DEB.1.00.0808202151320.24820@pacific.mpi-cbg.de.mpi-cbg.de> <20080820200440.GF16626@blimp.local> <alpine.DEB.1.00.0808202213340.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 20 22:31:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVuKk-0006un-P4
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 22:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757428AbYHTU34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 16:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755678AbYHTU34
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 16:29:56 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:8590 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757428AbYHTU3z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 16:29:55 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg201f5UW7
Received: from tigra.home (Faf2f.f.strato-dslnet.de [195.4.175.47])
	by post.webmailer.de (mrclete mo7) (RZmta 16.47)
	with ESMTP id 603b44k7KKMdcu ; Wed, 20 Aug 2008 22:29:53 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id EBC51277AE;
	Wed, 20 Aug 2008 22:29:52 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id D86C436D18; Wed, 20 Aug 2008 22:29:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0808202213340.24820@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93037>

Johannes Schindelin, Wed, Aug 20, 2008 22:16:19 +0200:
> > 
> > No. It strips refs/ OR remotes/ (because of prefixcmp with argv[0]).
> > And I still wanted refs/<namespace>/something...
> 
> Yes, you are correct.  However, to fix my thinko, I deem this preferable:
> 
> -- snipsnap --
> 
>  builtin-checkout.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin-checkout.c b/builtin-checkout.c
> index e95eab9..2a076cf 100644
> --- a/builtin-checkout.c
> +++ b/builtin-checkout.c
> @@ -448,8 +448,10 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>  		if (!argc || !strcmp(argv[0], "--"))
>  			die ("--track needs a branch name");
>  		slash = strchr(argv[0], '/');
> -		if (slash && !prefixcmp(argv[0], "refs/"))
> -			slash = strchr(slash + 1, '/');
> +		if (slash && !prefixcmp(argv[0], "refs/")) {
> +			argv[0] = slash + 1;
> +			slash = strchr(argv[0], '/');
> +		}

Yes, I agree (and its shorter). The git-checkout manpage can be
improved, too (no DWIM is obvious, except may be for the implementor).
