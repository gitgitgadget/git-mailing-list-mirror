From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] disallow providing multiple upstream branches to rebase,
 pull --rebase
Date: Wed, 18 Feb 2009 11:18:58 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902181118160.6274@intel-tinevez-2-302>
References: <1234932262-63469-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 11:20:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZjXd-0004JP-Sk
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 11:20:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030AbZBRKTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 05:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751999AbZBRKTD
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 05:19:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:55052 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751988AbZBRKTB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 05:19:01 -0500
Received: (qmail invoked by alias); 18 Feb 2009 10:18:59 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp022) with SMTP; 18 Feb 2009 11:18:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/sptMnzuPsUlCAbUriWB4NvVQYCg8XuaPSurVA35
	VOawsLg/aH79i3
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1234932262-63469-1-git-send-email-jaysoffian@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110522>

Hi,

On Tue, 17 Feb 2009, Jay Soffian wrote:

> It does not make sense to provide multiple upstream branches to either
> git pull --rebase, or to git rebase, so disallow both.
> 
> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
> ---
>  git-pull.sh   |    5 +++++
>  git-rebase.sh |    1 +
>  2 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/git-pull.sh b/git-pull.sh
> index 2c7f432..25adddf 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -171,6 +171,11 @@ case "$merge_head" in
>  		echo >&2 "Cannot merge multiple branches into empty head"
>  		exit 1
>  	fi
> +	if test true = "$rebase"
> +	then
> +		echo >&2 "Cannot rebase onto multiple branches"
> +		exit 1
> +	fi
>  	;;
>  esac
>  

Good catch!

> diff --git a/git-rebase.sh b/git-rebase.sh
> index 5d9a393..ffb6027 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -319,6 +319,7 @@ do
>  	esac
>  	shift
>  done
> +test $# -gt 1 && usage

Did you just break

	$ git rebase $UPSTREAM $BRANCH_TO_SWITCH_TO

?

Ciao,
Dscho
