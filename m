From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] instaweb: use 'browser.<tool>.path' config option if it's set.
Date: Sun, 27 Jan 2008 23:38:52 -0800
Message-ID: <7vtzkyv1pv.fsf@gitster.siamese.dyndns.org>
References: <20080128080225.583dbac8.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Jan 28 08:39:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJOaY-00050D-Lp
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 08:39:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbYA1HjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 02:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbYA1HjA
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 02:39:00 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51672 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622AbYA1Hi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 02:38:59 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DCFF638C;
	Mon, 28 Jan 2008 02:38:58 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 92075638B;
	Mon, 28 Jan 2008 02:38:54 -0500 (EST)
In-Reply-To: <20080128080225.583dbac8.chriscool@tuxfamily.org> (Christian
	Couder's message of "Mon, 28 Jan 2008 08:02:25 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71858>

Christian Couder <chriscool@tuxfamily.org> writes:

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/config.txt |    3 ++-
>  git-instaweb.sh          |   10 +++++++++-
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index c2fedd1..584250c 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -369,7 +369,8 @@ branch.<name>.rebase::
>  
>  browser.<tool>.path::
>  	Override the path for the given tool that may be used to
> -	browse help. See linkgit:git-help[1].
> +	browse help (see linkgit:git-help[1]) or a working repository
> +	in gitweb (see linkgit:git-instaweb[1]).
>  
>  clean.requireForce::
>  	A boolean to make git-clean do nothing unless given -f
> diff --git a/git-instaweb.sh b/git-instaweb.sh
> index ad0723c..b21a0a5 100755
> --- a/git-instaweb.sh
> +++ b/git-instaweb.sh
> @@ -274,6 +274,14 @@ webrick)
>  	;;
>  esac
>  
> +init_browser_path() {
> +	browser_path=`git config browser.$1.path`

Needquote?

> +	test -z "$browser_path" && browser_path=$1
> +}
> +
>  start_httpd
>  url=http://127.0.0.1:$port
> -test -n "$browser" && "$browser" $url || echo $url
> +test -n "$browser" && {
> +	init_browser_path "$browser"
> +	"$browser_path" $url
> +} || echo $url
> -- 
> 1.5.4.rc4.16.g1009
