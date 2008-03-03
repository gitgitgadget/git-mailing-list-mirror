From: Jeff King <peff@peff.net>
Subject: Re: Re* [PATCH] allow git-am to run in a subdirectory
Date: Mon, 3 Mar 2008 01:58:08 -0500
Message-ID: <20080303065808.GA22810@coredump.intra.peff.net>
References: <20080301062255.GA27538@coredump.intra.peff.net> <7vprue6ghc.fsf@gitster.siamese.dyndns.org> <20080301081235.GA31855@coredump.intra.peff.net> <7vlk50joe0.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 07:58:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW4dS-0005g2-8G
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 07:58:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753297AbYCCG6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 01:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753107AbYCCG6L
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 01:58:11 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3744 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752853AbYCCG6K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 01:58:10 -0500
Received: (qmail 8186 invoked by uid 111); 3 Mar 2008 06:58:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 03 Mar 2008 01:58:09 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Mar 2008 01:58:08 -0500
Content-Disposition: inline
In-Reply-To: <7vlk50joe0.fsf_-_@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75892>

On Sun, Mar 02, 2008 at 10:46:31PM -0800, Junio C Hamano wrote:

> > The problem is that I need to turn the original "$@" into a new "$@"
> > that is correctly prefixed, which requires proper quoting.
> 
> Perhaps like this?

Yes. For some reason I didn't think of doing 'set "$@" "$new"' to
rebuild the list one by one.

> +	if test -n "$prefix" && test $# != 0
> +	then
> +		first=t
> +		for arg
> +		do
> +			test -n "$first" && {
> +				set x
> +				first=
> +			}
> +			case "$arg" in
> +			/*)
> +				set "$@" "$arg" ;;
> +			*)
> +				set "$@" "$prefix$arg" ;;
> +			esac
> +		done
> +		shift
> +	fi

This handles the mailbox parameters. The only other file parameter is
$dotest. If I do "cd t && git am --dotest=.foo", then should it be
"t/.foo" or ".foo"?

-Peff
