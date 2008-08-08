From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFH] filter-branch: ancestor detection weirdness
Date: Fri, 8 Aug 2008 13:42:32 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808081341170.9611@pacific.mpi-cbg.de.mpi-cbg.de>
References: <200808080148.27384.trast@student.ethz.ch> <1218153242-18837-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jan Wielemaker <J.Wielemaker@uva.nl>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Aug 08 13:39:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRQJF-0002lR-3Q
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 13:39:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754817AbYHHLiB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 07:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754767AbYHHLiB
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 07:38:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:39413 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754648AbYHHLiB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 07:38:01 -0400
Received: (qmail invoked by alias); 08 Aug 2008 11:37:58 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp066) with SMTP; 08 Aug 2008 13:37:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+AF7sCbU+AKxzuGp9fdB6KdINBiB8pSFzNeKkheR
	n1g9ILfJa1lf68
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <1218153242-18837-1-git-send-email-trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91658>

Hi,

On Fri, 8 Aug 2008, Thomas Rast wrote:

> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index 182822a..52b2bdf 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -325,15 +325,9 @@ while read ref
>  do
>  	sha1=$(git rev-parse "$ref"^0)
>  	test -f "$workdir"/../map/$sha1 && continue
> -	# Assign the boundarie(s) in the set of rewritten commits
> -	# as the replacement commit(s).
> -	# (This would look a bit nicer if --not --stdin worked.)
> -	for p in $( (cd "$workdir"/../map; ls | sed "s/^/^/") |
> -		git rev-list $ref --boundary --stdin |
> -		sed -n "s/^-//p")
> -	do
> -		map $p >> "$workdir"/../map/$sha1
> -	done
> +	# Assign the first commit not pruned as the replacement.
> +	candidate=$(git rev-list $ref -1 -- "$filter_subdir")

Is it not just a question of adding '-- "$filter_subdir"' to the rev-list 
call you removed?

Ciao,
Dscho
