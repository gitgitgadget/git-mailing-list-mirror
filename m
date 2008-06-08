From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] progress.c: avoid use of dynamic-sized array
Date: Sun, 8 Jun 2008 23:34:38 +0200
Message-ID: <20080608213438.GA3073@steel.home>
References: <Pine.LNX.4.64.0806080924330.18454@xenau.zenez.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 23:35:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5SY5-0007q7-O5
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 23:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756013AbYFHVep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 17:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755877AbYFHVeo
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 17:34:44 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:62556 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755947AbYFHVeo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 17:34:44 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMna1oX/wC4
Received: from tigra.home (Fa942.f.strato-dslnet.de [195.4.169.66])
	by post.webmailer.de (mrclete mo39) (RZmta 16.42)
	with ESMTP id q046f2k58KDJvn ; Sun, 8 Jun 2008 23:34:38 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 70C6D277BD;
	Sun,  8 Jun 2008 23:34:38 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 4423156D28; Sun,  8 Jun 2008 23:34:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0806080924330.18454@xenau.zenez.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84326>

Boyd Lynn Gerber, Sun, Jun 08, 2008 17:26:15 +0200:
>  		/* Force the last update */
> -		char buf[strlen(msg) + 5];
> +		char buf[128], *bufp;
> +		size_t len = strlen(msg) + 5;
>  		struct throughput *tp = progress->throughput;
> +
> +		bufp = (len < sizeof(buf)) ? buf : xmalloc(len + 1);

It is just a temporary buffer, there is no urgent need to
micro-optimize the allocation like that. Maybe just leave
one of the buffers, the one on stack? It is just a progress
message, snprintf will cut it, yes, but it is unlikely to
cause any harm (unless you forget to \n-terminate it).
