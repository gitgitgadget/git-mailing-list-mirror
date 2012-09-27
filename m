From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-web--browse: Fix open HTML help pages from iTerm
Date: Thu, 27 Sep 2012 12:11:36 -0700
Message-ID: <7v3923qo0n.fsf@alter.siamese.dyndns.org>
References: <1348597003-28403-1-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Sep 27 21:11:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THJUz-0003UO-4M
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 21:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753044Ab2I0TLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 15:11:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33791 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752697Ab2I0TLj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 15:11:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28A0B944C;
	Thu, 27 Sep 2012 15:11:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nkUZ7WLk8cB+is/GDuIS9FXHNKM=; b=gU8D7z
	IS1M2l0U+26hEAnDBalUA6qlksDyykzZdtXQVxh1ams7SjbVvcQgAlIooCNBfr56
	22gUQJ+hiXtdwWDHt56iTlC6Xuos1dOlfkSovlMgVSldG4QeCTxjgVzcEzCtdfWK
	fJl9DMCIGAsYlAeqIm8Sk070Fpg7elTwNrJPU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LHLm20RcQuY7y/4KM/UglQVcY82SNKzD
	jG2Vh0JO03iErCm4eU0CRlUp6VQHt/uZK4Rcql55z7EekXxFMj16owTzbhOM7IqF
	mu5Kjyupx7D4vb2NgCR2QTstiNwzHKGkas6gYhawb3P62rtpRPG/uopPP/VsXuUW
	ARAx+80HWLs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 15AB2944B;
	Thu, 27 Sep 2012 15:11:38 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E8D7944A; Thu, 27 Sep 2012
 15:11:37 -0400 (EDT)
In-Reply-To: <1348597003-28403-1-git-send-email-prohaska@zib.de> (Steffen
 Prohaska's message of "Tue, 25 Sep 2012 20:16:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 29128544-08D7-11E2-AB80-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206509>

Steffen Prohaska <prohaska@zib.de> writes:

> iTerm is an alternative to the default terminal emulation program on Mac
> OS X.  git-web--browse wasn't aware of iTerm and failed to open HTML
> help pages when used in a shell session running in iTerm, reporting "No
> known browser available."  Now it works as expected.
>
> Signed-off-by: Steffen Prohaska <prohaska@zib.de>
> ---
>  git-web--browse.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/git-web--browse.sh b/git-web--browse.sh
> index 1e82726..95ecf65 100755
> --- a/git-web--browse.sh
> +++ b/git-web--browse.sh
> @@ -120,7 +120,8 @@ if test -z "$browser" ; then
>  	fi
>  	# SECURITYSESSIONID indicates an OS X GUI login session
>  	if test -n "$SECURITYSESSIONID" \
> -		-o "$TERM_PROGRAM" = "Apple_Terminal" ; then
> +		-o "$TERM_PROGRAM" = "Apple_Terminal" \
> +		-o "$TERM_PROGRAM" = "iTerm.app" ; then
>  		browser_candidates="open $browser_candidates"
>  	fi

I do not have anything against iTerm, but could we have a solution
that does not force us to keep adding 47 different terminal program
names to the list over the longer term (no pun intended)?  For
example, "If on OS-X (which by the way does not seem to be checked
with the current logic) and environment TERM_PROGRAM is set to any
value", or something.
