From: jeffpc@josefsipek.net
Subject: Re: [PATCH] guilt: Make sure the commit time is increasing
Date: Sun, 4 Jul 2010 22:59:00 -0400
Message-ID: <20100705025900.GQ22659@josefsipek.net>
References: <1278296639-25024-1-git-send-email-tytso@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Jul 05 05:05:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVbzj-0005hE-8d
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 05:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756291Ab0GEDFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jul 2010 23:05:12 -0400
Received: from josefsipek.net ([141.212.112.63]:49515 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753809Ab0GEDFL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jul 2010 23:05:11 -0400
X-Greylist: delayed 370 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 Jul 2010 23:05:11 EDT
Received: by josefsipek.net (Postfix, from userid 1000)
	id 397FF7ED1; Sun,  4 Jul 2010 22:59:00 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1278296639-25024-1-git-send-email-tytso@mit.edu>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150238>

On Sun, Jul 04, 2010 at 10:23:59PM -0400, Theodore Ts'o wrote:
> Git has various algorithms, most notably in git rev-list, git
> name-rev, and others, which depend on the commit time increasing.  We
> want to keep the commit time the same as much as possible, but if
> necessary, adjust the time stamps of the patch files to obey this
> constraint.

Am I understanding this right?  You want the timestamps to be monotonically
increasing?  Is the +60 the most obvious choice?

Can I get an example of how git can get confused?

Josef 'Jeff' Sipek.

> Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
> ---
>  guilt |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/guilt b/guilt
> index b6e2a6c..2371e98 100755
> --- a/guilt
> +++ b/guilt
> @@ -535,6 +535,13 @@ commit()
>                          export GIT_AUTHOR_EMAIL="`echo $author_str | sed -e 's/[^<]*//'`"
>  		fi
>  
> +		ct=$(git log -1 --pretty=%ct)
> +		if [ $ct -gt $(stat -c %Y "$p") ]; then
> +		    echo "Warning time went backwards, adjusting mod time of" \
> +			$(basename "$p")
> +		    touch -d @$(expr $ct + 60) "$p" || touch "$p"
> +		fi
> +
>  		# must strip nano-second part otherwise git gets very
>  		# confused, and makes up strange timestamps from the past
>  		# (chances are it decides to interpret it as a unix
> -- 
> 1.7.0.4
> 

-- 
UNIX is user-friendly ... it's just selective about who its friends are
