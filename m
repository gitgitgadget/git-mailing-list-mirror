From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-push.txt: explain better cases where --force is dangerous
Date: Mon, 17 Jun 2013 12:36:26 -0700
Message-ID: <7vli68cyx1.fsf@alter.siamese.dyndns.org>
References: <1371491561-19117-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, philipoakley@iee.org, artagnon@gmail.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 17 21:36:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UofE9-0001Z6-FN
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 21:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403Ab3FQTg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 15:36:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59750 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751494Ab3FQTg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 15:36:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E002287AD;
	Mon, 17 Jun 2013 19:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zlxEp4h4eRulSzpIiGUSJEKdzKo=; b=RQk0H+
	LH1CZeDNbzsKeS1qbUbxKlfOCk0Bna7ceA2bwnO06LX/wTncHUpHByVnv4Ilb7c5
	F5CR8wPYmYjaO1Qex1ScxxKwCZR+Aubc5orB1QcWwZh8R7TnT9Pk6os27o9fyXO6
	6PC/HGg3XmB4rudG+F6kernpKaUExMOQ2+lnY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ybuTh9mH8Pi9gqY54tSPwZXWdGUdJgUZ
	Gm/osULQNJNvwpwBPwLHIpLjU1ZjsUiq9OddncaUyJwFa7O8x4K6jCNVkeVMxSnt
	xRa7DPdgf4t8khZ1z2ECMY5VpT8iWbUntRZqCBwBMj73ppHsxjFUWvJsOSdyWh3P
	+x6OKZMTtTo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 925E5287AC;
	Mon, 17 Jun 2013 19:36:28 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DF009287A1;
	Mon, 17 Jun 2013 19:36:27 +0000 (UTC)
In-Reply-To: <1371491561-19117-1-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Mon, 17 Jun 2013 19:52:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3419B5B6-D785-11E2-BDB5-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228103>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> The behavior of "git push --force" is rather clear when it updates only
> one remote ref, but running it when pushing several branches can really
> be dangerous. Warn the users a bit more and give them the alternative to
> push only one branch.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---

Looks good.  Thanks.


>  Documentation/git-push.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index 938d1ee..9b9e7d1 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -136,6 +136,14 @@ already exists on the remote side.
>  	not an ancestor of the local ref used to overwrite it.
>  	This flag disables the check.  This can cause the
>  	remote repository to lose commits; use it with care.
> +	Note that `--force` applies to all the refs that are pushed,
> +	hence using it with `push.default` set to `matching` or with
> +	multiple push destination configured may override refs other
> +	than the current branch (including local refs that are
> +	strictly behind their remote counterpart). To force a push to
> +	only one branch, use a `+` in front of the refspec to push
> +	(e.g `git push origin +master` to force a push to the `master`
> +	branch). See the `<refspec>...` section above for details.
>  
>  --repo=<repository>::
>  	This option is only relevant if no <repository> argument is
