From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Jan 2010, #01; Mon, 04)
Date: Wed, 6 Jan 2010 12:29:55 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001061219180.11013@intel-tinevez-2-302>
References: <7vljgei7rs.fsf@alter.siamese.dyndns.org> <7vskal5c11.fsf@alter.siamese.dyndns.org> <20100106191825.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 12:30:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSU5V-00008I-L3
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 12:30:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755514Ab0AFL37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 06:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755478Ab0AFL37
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 06:29:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:35151 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755403Ab0AFL37 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 06:29:59 -0500
Received: (qmail invoked by alias); 06 Jan 2010 11:29:57 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp023) with SMTP; 06 Jan 2010 12:29:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ihbFYWD2iYXES6On9gG0berImywXtr3yo4RZ+0i
	xlpmxECVm4xdJm
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20100106191825.6117@nanako3.lavabit.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136260>

Hi,

On Wed, 6 Jan 2010, Nanako Shiraishi wrote:

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 23ded48..d42cc4f 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -482,6 +482,25 @@ get_saved_options () {
>  	test -f "$DOTEST"/rebase-root && REBASE_ROOT=t
>  }
>  
> +LF='
> +'
> +parse_onto () {
> +	if	expr "$1" : '.*\.\.\.' >/dev/null &&
> +		left=${1%...*} right=${1#*...} &&
> +		: ${left:=HEAD} ${right:=HEAD} &&
> +		onto=$(git merge-base "$left" "$right")
> +	then
> +		case "$onto" in
> +		?*"$LF"?* | '')
> +			exit 1 ;;
> +		esac
> +		echo "$onto"
> +		exit 0
> +	else
> +		git rev-parse --verify "$1^0"
> +	fi
> +}

It might be easier to understand like this:

	case "$1" in
	*...*)
		left=${1%...*} &&
		right=${1#*...} &&
		onto="$(git merge-base "${left:-HEAD}" "${right:-HEAD}")" &&
		test ! -z "$onto" &&
		echo "$onto"
	;;
	*)
		git rev-parse --verify "$1^0"
	;;
	esac

Besides, why do you change the "$1" to "$1^0"?
		
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 6503113..43c62c0 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh

I would separate the patches.  rebase.sh and rebase--interactive.sh are 
fundamentally different.

Thanks,
Dscho
