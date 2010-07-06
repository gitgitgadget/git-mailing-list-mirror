From: jeffpc@josefsipek.net
Subject: Re: [PATCH] guilt: Make sure the commit time is increasing
Date: Tue, 6 Jul 2010 13:29:54 -0400
Message-ID: <20100706172954.GD18795@josefsipek.net>
References: <1278296639-25024-1-git-send-email-tytso@mit.edu>
 <20100705025900.GQ22659@josefsipek.net>
 <67D0ABD4-BD1A-4B7A-B3EC-F48F21B5DD01@mit.edu>
 <20100705185238.GS22659@josefsipek.net>
 <20100705192201.GI25518@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: tytso@mit.edu
X-From: git-owner@vger.kernel.org Tue Jul 06 19:30:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWBy4-0007uC-By
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 19:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755582Ab0GFR34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 13:29:56 -0400
Received: from josefsipek.net ([141.212.112.63]:33459 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755548Ab0GFR3z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 13:29:55 -0400
Received: by josefsipek.net (Postfix, from userid 1000)
	id 091AE7ED1; Tue,  6 Jul 2010 13:29:54 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20100705192201.GI25518@thunk.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150372>

On Mon, Jul 05, 2010 at 03:22:01PM -0400, tytso@mit.edu wrote:
...

I'm going to play with this patch locally a little bit, but I'm all for it.

> From d5659084435a885e05a8fc9afbffe8cdd9535828 Mon Sep 17 00:00:00 2001

Speaking of weird timestamps...2001?  Where did that come from? :)

> From: Theodore Ts'o <tytso@mit.edu>
> Date: Sun, 4 Jul 2010 22:06:08 -0400
> Subject: [PATCH] guilt: Make sure the commit time is increasing
> 
> Git has various algorithms, most notably in git rev-list, git
> name-rev, and others, which depend on the commit time increasing.  We
> want to keep the commit time the same as much as possible, but if
> necessary, adjust the time stamps of the patch files to obey this
> constraint.
> 
> Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
> ---
>  guilt |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/guilt b/guilt
> index b6e2a6c..edcfb34 100755
> --- a/guilt
> +++ b/guilt
> @@ -535,6 +535,17 @@ commit()
>                          export GIT_AUTHOR_EMAIL="`echo $author_str | sed -e 's/[^<]*//'`"
>  		fi
>  
> +		ct=$(git log -1 --pretty=%ct)
> +		if [ $ct -gt $(stat -c %Y "$p") ]; then
> +		    echo "Adjusting mod time of" $(basename "$p")

Depending on how my playing goes, I might remove the echo.

> +		    ct=$(expr $ct + 60)

So, ct is now the +1min time.

> +		    if [ $ct -gt $(date +%s) ]; then
> +			touch "$p"
> +		    else
> +			touch -d @$(expr $ct + 60) "$p"

And we're touching +1+1min.  I'll fix it up before applying.

Thanks,

Jeff.

-- 
NT is to UNIX what a doughnut is to a particle accelerator.
