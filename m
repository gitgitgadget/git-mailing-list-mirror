From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] update-hook: fix incorrect use of git-describe and sed
 for finding previous tag
Date: Fri, 16 Mar 2007 10:06:40 +0100
Message-ID: <45FA5E20.2050905@op5.se>
References: <200703141425.53192.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 16 10:07:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HS8On-00060Z-FA
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 10:06:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbXCPJGp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 05:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753136AbXCPJGp
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 05:06:45 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:52606 "EHLO
	smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128AbXCPJGo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 05:06:44 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588)
	id 6FF4E6BCCB; Fri, 16 Mar 2007 10:06:42 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	linux-server1.op5.se
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.1.4
Received: from [192.168.1.179] (unknown [192.168.1.179])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id DC31E6BCBF; Fri, 16 Mar 2007 10:06:40 +0100 (CET)
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
In-Reply-To: <200703141425.53192.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42337>

Andy Parkins wrote:
> Previously git-describe would output lines of the form
>  v1.1.1-gf509d56
> The update hook found the dash and stripped it off using
>  sed 's/-g.*//'
> The remainder was then used as the previous tag name.
> 
> However, git-describe has changed format.  The output is now of the form
>  v1.1.1-23-gf509d56
> The above sed fragment doesn't strip the middle "-23", and so the
> previous tag name used would be "v1.1.1-23".  This is incorrect.
> 
> Since the hook script was written, git-describe now gained support for
> "--abbrev=0", which it uses as a special flag to tell it not to output
> anything other than the nearest tag name.  This patch fixes the problem,
> and prevents any future recurrence by using this new flag rather than
> sed to find the previous tag.
> 
> Signed-off-by: Andy Parkins <andyparkins@gmail.com>

Acked-by: Andreas Ericsson <ae@op5.se>


> ---
>  templates/hooks--update |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/templates/hooks--update b/templates/hooks--update
> index 5b82b68..8f6c4fe 100644
> --- a/templates/hooks--update
> +++ b/templates/hooks--update
> @@ -210,7 +210,7 @@ case "$refname_type" in
>  		fi
>  
>  		# If this tag succeeds another, then show which tag it replaces
> -		prevtag=$(git describe $newrev^ 2>/dev/null | sed 's/-g.*//')
> +		prevtag=$(git describe --abbrev=0 $newrev^ 2>/dev/null)
>  		if [ -n "$prevtag" ]; then
>  			echo "  replaces  $prevtag"
>  		fi

I just updated git on our repo server and did this exact change to our update
tag 15 minutes ago.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
