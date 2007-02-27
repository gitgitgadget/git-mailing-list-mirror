From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Do not change the file type if the filesystem does not
 support symlinks.
Date: Tue, 27 Feb 2007 23:54:55 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702272352080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11726125012895-git-send-email-johannes.sixt@telecom.at>
 <11726125033437-git-send-email-johannes.sixt@telecom.at>
 <1172612504272-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Tue Feb 27 23:55:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMBDn-00015w-JP
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 23:54:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137AbXB0Wy5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 17:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752148AbXB0Wy5
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 17:54:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:34593 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752137AbXB0Wy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 17:54:56 -0500
Received: (qmail invoked by alias); 27 Feb 2007 22:54:55 -0000
X-Provags-ID: V01U2FsdGVkX18w360M6qAwwzaegaIHmH4qFjMXrTbkbsRDoB0VZF
	FjrQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <1172612504272-git-send-email-johannes.sixt@telecom.at>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40833>

Hi,

On Tue, 27 Feb 2007, Johannes Sixt wrote:

> diff --git a/read-cache.c b/read-cache.c
> index 605b352..f09ee2e 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -116,7 +116,8 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
>  
>  	switch (ntohl(ce->ce_mode) & S_IFMT) {
>  	case S_IFREG:
> -		changed |= !S_ISREG(st->st_mode) ? TYPE_CHANGED : 0;
> +		if (trust_symlink_fmt && !S_ISREG(st->st_mode))
> +			changed |= TYPE_CHANGED;

Really? If the cache entry says S_IFREG we should not expect a symlink 
here, right?

> @@ -125,7 +126,8 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
>  			changed |= MODE_CHANGED;
>  		break;
>  	case S_IFLNK:
> -		changed |= !S_ISLNK(st->st_mode) ? TYPE_CHANGED : 0;
> +		if (trust_symlink_fmt && !S_ISLNK(st->st_mode))
> +			changed |= TYPE_CHANGED;

This does not handle the case symlink->directory, right?

Ciao,
Dscho
