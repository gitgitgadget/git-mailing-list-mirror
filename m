From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT v2 25/29] "guilt push" now fails when there are no more
 patches to push.
Date: Tue, 13 May 2014 17:41:14 -0400
Message-ID: <20140513214114.GI4791@meili.valhalla.31bits.net>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
 <1400013065-27919-26-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Tue May 13 23:41:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkKRl-0002WI-QI
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 23:41:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754709AbaEMVlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 17:41:10 -0400
Received: from josefsipek.net ([64.9.206.49]:1760 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753100AbaEMVlI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 17:41:08 -0400
Received: from meili.valhalla.31bits.net (c-98-209-117-250.hsd1.mi.comcast.net [98.209.117.250])
	by josefsipek.net (Postfix) with ESMTPSA id DB7A055654;
	Tue, 13 May 2014 17:41:06 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1400013065-27919-26-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248866>

On Tue, May 13, 2014 at 10:31:01PM +0200, Per Cederqvist wrote:
> This makes it easier to script operations on the entire queue, for
> example run the test suite on each patch in the queue:
> 
>     guilt pop -a;while guilt push; do make test||break; done
> 
> This brings "guilt push" in line with the push operation in Mercurial
> Queues (hg qpush), which fails when there are no patches to apply.
> 
> Updated the test suite.
> 
> "guilt push -a" still does not fail.  (It successfully manages to
> ensure that all patches are pushed, even if it did not have to do
> anything to make it so.)
> 
> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  guilt-push           | 19 ++++++-----
>  regression/t-020.out | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  regression/t-020.sh  | 13 +++++++-
>  3 files changed, 113 insertions(+), 8 deletions(-)
...
> diff --git a/regression/t-020.sh b/regression/t-020.sh
> index 906aec6..0f9f85d 100755
> --- a/regression/t-020.sh
> +++ b/regression/t-020.sh
> @@ -26,6 +26,17 @@ guilt series | while read n ; do
>  done
>  
>  #
> +# pushing when there is nothing to push
> +#
> +
> +shouldfail guilt push
> +cmd guilt push -a
> +
> +cmd list_files
> +
> +cmd git log -p

I don't particularly care for the git-log.  Otherwise it looks good.

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>


> +
> +#
>  # pop all
>  #
>  cmd guilt pop --all
> @@ -61,7 +72,7 @@ cmd guilt pop --all
>  
>  npatches=`guilt series | wc -l`
>  for n in `_seq -2 $npatches`; do
> -	if [ $n -ge 0 ]; then
> +	if [ $n -gt 0 ]; then
>  		cmd guilt push -n $n
>  	else
>  		shouldfail guilt push -n $n
> -- 
> 1.8.3.1
> 

-- 
Evolution, n.:
  A hypothetical process whereby infinitely improbable events occur with
  alarming frequency, order arises from chaos, and no one is given credit.
