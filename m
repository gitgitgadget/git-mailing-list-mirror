From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] docs: give more hints about how "add -e" works
Date: Thu, 21 Oct 2010 15:32:15 -0700
Message-ID: <7v4ocftbww.fsf@alter.siamese.dyndns.org>
References: <20101021143034.GA16083@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 22 00:32:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P93gU-0007so-ST
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 00:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932613Ab0JUWc2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 18:32:28 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58333 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932608Ab0JUWc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 18:32:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A12B7E0C9B;
	Thu, 21 Oct 2010 18:32:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nL+LSvTGe7UJhcWqT2R1jJwT36s=; b=wBkrr7
	AIhD0DfUckCPVmln+1VYlEmT3C8JHaVVuSrNP+7LctG6x7DftsvRhOIwcfX288cZ
	Ps72imngfsJEqK0AZ5QLQT9XMGogXDjUFo9+sdRRONoEIpikELPBNbEZXJ51oIGL
	LbO31+xuZ4CA/gByv8BBZAE0vJwn58uSus9qE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TyqMnRx++ZG6x9o/+nJFTGuNL1ZVrPQN
	z+dq5ulC22ONev6KPsxDnXAo0viOoOoHxxDzbkUXj1P13EN/jZPRqwNaVah/Ro7n
	gcnO55zPLqR0HgdA/VhjzUohubGmFDvV6S+ApTOU9TfMStpRHj8guBmsWRcDlhba
	G+LnIcH3lok=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 67F20E0C95;
	Thu, 21 Oct 2010 18:32:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8E3A4E0C8F; Thu, 21 Oct
 2010 18:32:17 -0400 (EDT)
In-Reply-To: <20101021143034.GA16083@sigill.intra.peff.net> (Jeff King's
 message of "Thu\, 21 Oct 2010 10\:30\:35 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 11C42F1A-DD63-11DF-A48A-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159582>

Jeff King <peff@peff.net> writes:

> -*NOTE*: Obviously, if you change anything else than the first character
> -on lines beginning with a space or a minus, the patch will no longer
> -apply.

It is a good change to lose this "Obviously", which is often a sign of the
lazyness of the author who didn't even bother to explain certain things,
handwaving them away as "Obvious" ;-)

> +The intent of this option is to pick and choose lines of the patch to
> +apply, or even to modify the contents of lines to be staged. There are
> +three line types in a patch: addition lines (beginning with a plus),
> +removal lines (beginning with a minus), and context lines (beginning
> +with a space). In general, it should be safe to:
> ++
> +--
> +* remove addition lines (don't stage the line)

I am not sure if the use of the word "stage" here is correct, even when
read from the "git stage" lovers' viewpoint.

If the "+" line is a pure addition without any corresponding line in the
preimage (which is removed by "-"), then this is "Don't add that line".
If it has a corresponding "-" line somewhere, that is rather "Remove
the corresponding line in the preimage".

"Don't add the updated line" might be a good compromise.

> +* modify the content of any addition lines (stage modified contents)
> +* add new addition lines (stage the new line)
> +* convert context lines to removal lines (stage removal of line)
> +* convert removal lines to context lines (don't stage removal)

Alternatively, to be consistent with "stage modification", "stage
removal", the removal of "+" can be phrased as "do not stage the addition
of the line".

I'd recommend to phrase them as "don't add", "add modified contents
instead", "add new line", "remove line" and "do not remove line", which
would be simpler to read, though.

> +Similarly, your patch will likely not apply if you:
> ++
> +--
> +* add context or removal lines
> +* delete removal or context lines
> +* modify the contents of context or removal lines
> +--
> ++
> +NOTE: In the first list above, the results given for each action are
> +with respect to that patch line only. Conceptual changes like
> +modification of a line in the original file are actually represented by
> +removal of the old line followed by addition of the new line. Deleting
> +only the addition line of this pair but leaving the removal line would
> +therefore convert the modification into a deletion. In other words, use
> +this feature with caution, as it is easy to stage unintended changes.

Is there a way to move this note way upwards?  Once the reader understands
what this paragraph teaches, it becomes much easier to understand the
implication of "remove addition".
