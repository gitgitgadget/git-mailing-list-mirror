From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT 21/28] The log.decorate setting should not influence
 import-commit.
Date: Tue, 6 May 2014 16:41:14 -0400
Message-ID: <20140506204114.GR1655@meili.valhalla.31bits.net>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
 <1395387126-13681-22-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Tue May 06 22:42:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhmAx-000115-MP
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 22:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755442AbaEFUlO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 16:41:14 -0400
Received: from josefsipek.net ([64.9.206.49]:1668 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752522AbaEFUlL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 16:41:11 -0400
Received: from meili.valhalla.31bits.net (c-98-209-117-250.hsd1.mi.comcast.net [98.209.117.250])
	by josefsipek.net (Postfix) with ESMTPSA id B0CC955654;
	Tue,  6 May 2014 16:41:10 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1395387126-13681-22-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248247>

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>

On Fri, Mar 21, 2014 at 08:31:59AM +0100, Per Cederqvist wrote:
> Use --no-decorate in the call to git log that tries to read the commit
> message to produce patch names.  Otherwise, if the user has set
> log.decorate to short or full, the patch name will be less useful.
> 
> Modify the t-034.sh test case to demonstrate that this is needed.
> 
> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  guilt-import-commit  | 2 +-
>  regression/t-034.out | 2 ++
>  regression/t-034.sh  | 2 ++
>  3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/guilt-import-commit b/guilt-import-commit
> index 6eb2f4e..703f034 100755
> --- a/guilt-import-commit
> +++ b/guilt-import-commit
> @@ -26,7 +26,7 @@ disp "About to begin conversion..." >&2
>  disp "Current head: `cat \"$GIT_DIR\"/refs/heads/\`git_branch\``" >&2
>  
>  for rev in `git rev-list $rhash`; do
> -	s=`git log --pretty=oneline -1 $rev | cut -c 42-`
> +	s=`git log --no-decorate --pretty=oneline -1 $rev | cut -c 42-`
>  
>  	# Try to convert the first line of the commit message to a
>  	# valid patch name.
> diff --git a/regression/t-034.out b/regression/t-034.out
> index bda4399..5d81bd4 100644
> --- a/regression/t-034.out
> +++ b/regression/t-034.out
> @@ -232,6 +232,7 @@ Date:   Mon Jan 1 00:00:00 2007 +0000
>      
>      Signed-off-by: Commiter Name <commiter@email>
>  % guilt init
> +% git config log.decorate short
>  % guilt import-commit base..HEAD
>  About to begin conversion...
>  Current head: 2a8b1889aa5066193bac978e6bf5073ffcfa6541
> @@ -259,6 +260,7 @@ Converting 45e81b51 as the_sequence_.lock-_is_forbidden
>  Converting eebb76e9 as the_sequence_-._is_forbidden
>  Done.
>  Current head: d4850419ccc1146c7169f500725ce504b9774ed0
> +% git config log.decorate no
>  % guilt push -a
>  Applying patch..the_sequence_-._is_forbidden.patch
>  Patch applied.
> diff --git a/regression/t-034.sh b/regression/t-034.sh
> index 1055ddb..8179bc7 100755
> --- a/regression/t-034.sh
> +++ b/regression/t-034.sh
> @@ -57,7 +57,9 @@ cmd git log
>  
>  # Import all the commits to guilt.
>  cmd guilt init
> +cmd git config log.decorate short
>  cmd guilt import-commit base..HEAD
> +cmd git config log.decorate no
>  
>  for patch in .git/patches/master/*.patch
>  do
> -- 
> 1.8.3.1
> 

-- 
Evolution, n.:
  A hypothetical process whereby infinitely improbable events occur with
  alarming frequency, order arises from chaos, and no one is given credit.
