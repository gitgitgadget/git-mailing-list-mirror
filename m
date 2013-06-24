From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] documentation: add git transport security notice
Date: Mon, 24 Jun 2013 09:24:29 -0700
Message-ID: <7vppvbbhoi.fsf@alter.siamese.dyndns.org>
References: <1372069414-12601-1-git-send-email-frase@frase.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Fraser Tweedale <frase@frase.id.au>
X-From: git-owner@vger.kernel.org Mon Jun 24 18:24:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur9ZO-0004ys-On
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 18:24:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068Ab3FXQYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 12:24:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51254 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751152Ab3FXQYd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 12:24:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 93A042B7D9;
	Mon, 24 Jun 2013 16:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i3XtmoDFpr2w1KC/0lCEcjqCs8c=; b=QNJYbZ
	BmiI8f7G2miATPiiwA5uXMN9WrX//5AxImB2Nt5Yz72sHG2cnrdxsfSNcF55G1cg
	KBtvor6NZBZ4hAEX2h9zfwAWVCVVxPVmV6JBzIesUN3wujAHluHEbh2AVCKC65sk
	h5s1G7XpBAjb/Ro1ShiA5ipePx3uxU9SYNIn8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Goub5eFR1Z5fyGobCYMwn9yd0jnIHCGi
	lozPBVT2F3jHjAwcJ14MYg2CZo/IIE3pA6E0UAbi/2eoEk8tupCD7XjnL+2JGu0E
	1OYkMWv5VZOP8Tbz42bEzZA9WkGIBjhVSrq2F6zcMVzjMu1UL4AeiQRotXFh2pAi
	AXcumCnNM/w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87CE12B7D8;
	Mon, 24 Jun 2013 16:24:32 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E546C2B7D4;
	Mon, 24 Jun 2013 16:24:30 +0000 (UTC)
In-Reply-To: <1372069414-12601-1-git-send-email-frase@frase.id.au> (Fraser
	Tweedale's message of "Mon, 24 Jun 2013 20:23:34 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8C56BEF8-DCEA-11E2-BB62-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228846>

Fraser Tweedale <frase@frase.id.au> writes:

> The fact that the git transport has no end-to-end security is easily
> overlooked.  Add a brief security notice to the "GIT URLS" section
> of the documentation stating that the git transport should be used
> with caution on unsecured networks.
>
> Signed-off-by: Fraser Tweedale <frase@frase.id.au>
> ---
>  Documentation/urls.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/urls.txt b/Documentation/urls.txt
> index 3ca122f..c218af5 100644
> --- a/Documentation/urls.txt
> +++ b/Documentation/urls.txt
> @@ -11,6 +11,9 @@ and ftps can be used for fetching and rsync can be used for fetching
>  and pushing, but these are inefficient and deprecated; do not use
>  them).
>  
> +The git protocol provides no end-to-end security and should be used
> +with caution on unsecured networks.

Is this necessary?

I thought we already say the git protocol does not even authenticate
elsewhere in the document, and if not, I think it is a sensible
thing to say here.  And once it is done, I doubt it is necessary to
bring up a narrower concept such as "end-to-end security" which
requires a lot more than authentication.

The only thing git protocol ensures is that the receiving end
validates that what is fetched from an unknown server, and what is
pushed by an unknown pusher, is internally consistent.

If you allowed a push over the git protocol by enabling the
receive-pack service in "git daemon" (not recommended), you may
allow anonymous users to delete branches and to do other funky
things unless you protect your repository with pre-receive hook, but
that won't corrupt the repository (of course, deleting all the refs
may make the repository an empty but not corrupt one, which is just
as unusable as a corrupt one, so there may not be a huge practical
difference).  If you fetched from an unauthenticated server,
possibly with MITM, over the git protocol, you may end up getting
something you did not ask for, but the resulting history in your
repository would still be internally consistent (the commits may be
malicious ones, of course, but that is what signed tags are there to
protect you against).
