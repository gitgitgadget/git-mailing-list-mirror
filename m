From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] am: Fix launching of pager
Date: Sun, 14 Feb 2010 18:30:53 -0800
Message-ID: <7viq9zw7qa.fsf@alter.siamese.dyndns.org>
References: <462027ff1002131314k62069160h63760fc8316aa43b@mail.gmail.com>
 <20100213235156.GA9054@coredump.intra.peff.net>
 <20100214115430.GA1849@progeny.tock> <20100214120731.GE3499@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Sebastian Celis <sebastian@sebastiancelis.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 03:31:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngqjy-0005pm-Fe
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 03:31:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403Ab0BOCbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 21:31:08 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60908 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065Ab0BOCbE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 21:31:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C056E9AF1B;
	Sun, 14 Feb 2010 21:31:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vn3TlMvIscYH5ddhH8qTewtHNLE=; b=B6olTY
	uq2VrzggJILmaDgImsjPQYXpU3lgUEcURqW1GcB2Nm7DPamLb0QdZluLUf+GpcGz
	mamkDW97ObptJOEiSnWEN3ssqSqkAhcfh9rZVz/aEUo4iNmEEt/c0243uNrMvp07
	2LJ5tAFsXYX7cVMlcpVTwj4KU5jAJj9EoF9GA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q+S7idEBMOWNfOcKCYONJIThqFO2nZ7p
	OUQ13qmvOrY7nWoUZf8u36CTa63R9HFRgh2YT2UvuipxwdFoy3h21mcqEqsrnvkg
	naXwN3CtHynfhAUoamNLyKKMYPlfTFmP9HfLvagd78XkOp6T6EOf0mVr7eOYYhFy
	gmwnMechjQA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D27D9AF1A;
	Sun, 14 Feb 2010 21:30:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 951319AF19; Sun, 14 Feb
 2010 21:30:54 -0500 (EST)
In-Reply-To: <20100214120731.GE3499@progeny.tock> (Jonathan Nieder's message
 of "Sun\, 14 Feb 2010 06\:07\:31 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 272705DC-19DA-11DF-8A73-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139959>

Jonathan Nieder <jrnieder@gmail.com> writes:

> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index d56426d..f3b5237 100755
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -107,6 +107,22 @@ git_editor() {
>  	eval "$GIT_EDITOR" '"$@"'
>  }
>  
> +git_pager() {
> +	if test -z "${GIT_PAGER+set}"
> +	then
> +		if tty <&1 >/dev/null 2>/dev/null
> +		then
> +			GIT_PAGER=cat
> +		else
> +			GIT_PAGER=$(git var GIT_PAGER)
> +		fi
> +	fi
> +	: ${LESS=-FRSX}
> +	export LESS
> +
> +	eval "$GIT_PAGER" '"$@"'
> +}
> +

I didn't read other patches, but I think this is a good change.

Acked-by: Junio C Hamano <gitster@pobox.com>
