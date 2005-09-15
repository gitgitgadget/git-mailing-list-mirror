From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Avoid wasting memory in git-rev-list
Date: Fri, 16 Sep 2005 00:38:58 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0509160034170.20360@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.58.0509151434470.26803@g5.osdl.org>
 <7v7jdiyop9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 00:39:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EG2Nq-0003Qt-IT
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 00:39:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161033AbVIOWjD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 18:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161034AbVIOWjB
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 18:39:01 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:18818 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1161033AbVIOWjA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2005 18:39:00 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 19E0F13C2F9; Fri, 16 Sep 2005 00:38:59 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id F1A20919B9; Fri, 16 Sep 2005 00:38:58 +0200 (CEST)
Received: from wrzx35.rz.uni-wuerzburg.de (wrzx35.rz.uni-wuerzburg.de [132.187.3.35])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D1BCF8C1B8; Fri, 16 Sep 2005 00:38:58 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx35.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 90088E0F3A; Fri, 16 Sep 2005 00:38:58 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7jdiyop9.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8648>

Hi Linus, hi Junio,

On Thu, 15 Sep 2005, Junio C Hamano wrote:

> So using this I could also avoid wasting memory by the "are we
> already walking the commit reachable from our existing refs"
> check by doing something like this?
> 
> ------------
> git diff
> diff --git a/fetch.c b/fetch.c
> --- a/fetch.c
> +++ b/fetch.c
> @@ -207,6 +207,7 @@ int pull(char *target)
>  	unsigned char sha1[20];
>  	int fd = -1;
>  
> +	save_commit_buffer = 0;
>  	if (write_ref && current_ref) {
>  		fd = lock_ref_sha1(write_ref, current_ref);
>  		if (fd < 0)

Together with both of Linus' patches, this works wonders! It uses _lots_ 
less of memory. Actually, the performance impact on my tiny server was 
negligible.

Ciao,
Dscho
