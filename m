From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Expand on impact of threads on memory consumption.
Date: Fri, 24 Oct 2014 10:27:04 -0700
Message-ID: <xmqq7fzpgyzb.fsf@gitster.dls.corp.google.com>
References: <1414136607-24765-1-git-send-email-rdebath@tvisiontech.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Robert de Bath <rdebath@tvisiontech.co.uk>
X-From: git-owner@vger.kernel.org Fri Oct 24 19:27:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xhidv-0002nR-5e
	for gcvg-git-2@plane.gmane.org; Fri, 24 Oct 2014 19:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756441AbaJXR1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2014 13:27:10 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59205 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755390AbaJXR1I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2014 13:27:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C092F14A4E;
	Fri, 24 Oct 2014 13:27:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fPPZsRlM/d6xgz9UwJvfIx7o5lg=; b=IPek72
	/XyDdd+zBBZwHhvI5+t/2lMsu8cgf+xqK8XyBpFLPmCpIyoYxoHCEuBKyvUpwuqA
	VvPGMmkMSoJ70C0tEAABOpo2ZXSded65Wiz65HloObIhacYyzIPwP7UNgE2s2z04
	aUtj8dRAkeSFJF2Vs7r7R2XSaSBEpJn5cArjs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JtoIl+dYVsVtWNhtdU3eLAL16wqLqhF2
	UfUQDu1n8FgoxhVHpKu2sDhkkKbiZSmyLcVyRMYXOcI+TYInnea7uiifqD5ItFZ3
	zMqQQhArZgFLxV70GBJEQnwscS9cQsaXUprYhIimEZvw3tokuvhPx/QAeN2yehve
	58eXLT2SIwI=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B558B14A4D;
	Fri, 24 Oct 2014 13:27:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2151F14A4C;
	Fri, 24 Oct 2014 13:27:06 -0400 (EDT)
In-Reply-To: <1414136607-24765-1-git-send-email-rdebath@tvisiontech.co.uk>
	(Robert de Bath's message of "Fri, 24 Oct 2014 08:43:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F9CA0214-5BA2-11E4-8C76-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert de Bath <rdebath@tvisiontech.co.uk> writes:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index c55c22a..6384038 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1828,7 +1828,10 @@ pack.depth::
>  
>  pack.windowMemory::
>  	The window memory size limit used by linkgit:git-pack-objects[1]
> -	when no limit is given on the command line.  The value can be
> +	when no limit is given on the command line.  This limit may be
> +	allocated individually by each thread doing delta compression
> +	so the total memory allocated by linkgit:git-pack-objects[1] can
> +	be this multiplied by the number of threads.  The value can be
>  	suffixed with "k", "m", or "g".  Defaults to 0, meaning no
>  	limit.

I sense that this change makes the resulting text unnecessarily
opaque by avoiding touching the first sentence.  Wouldn't something
more concise like this sufficient?

    The default maximum size of memory that is consumed by each
    thread in linkgit:git-pack-objects[1] for pack window memory.
    The value can be suffixed with "k", "m", or "g".  When left
    unconfigured, there will be no limit.
