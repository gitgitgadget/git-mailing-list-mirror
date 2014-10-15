From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] Documentation: move some AsciiDoc parameters into variables
Date: Wed, 15 Oct 2014 13:43:49 -0700
Message-ID: <xmqq61flvzay.fsf@gitster.dls.corp.google.com>
References: <1413070656-241955-1-git-send-email-sandals@crustytoothpaste.net>
	<1413070656-241955-4-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Wed Oct 15 22:43:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeVQL-0004Zx-Da
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 22:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbaJOUnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 16:43:53 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50676 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750887AbaJOUnw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 16:43:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B6CAC146B9;
	Wed, 15 Oct 2014 16:43:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LC9xmJT4pvhfDJjoA8wr0mFqP2Y=; b=fLWtj0
	WJ+VCOs9TSXJ0qA3dWY2vsJVytFCPgtFZe/oYILoJo5hGVmZY1z5uSXnMppqSdXI
	763tgKveCsSh4iQm/Qe/ZraV/x6syrmS0FX2Boi+tH97n4X6sfyDmT03Ga9Yv4y5
	PHCnydp2XjDZBCsUQaZPfoNFn7jS94t/DOjCY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vy48cZtq2lMn00Mqif1Ltvy5D9DEaRWU
	PBJEH4fOsSa8XnUsgbzsfx4xz54cXSB15GVncynKfuVwMd5Oa2+YxAvNIDNPFldg
	xIjnDnfmNbDXo20KJN48G90JUZpn9R0tHEH5PsOwv8As3ScnR9bR3xDuX+VEUC+m
	RLlrRqpXq/E=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AE488146B8;
	Wed, 15 Oct 2014 16:43:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 39908146B7;
	Wed, 15 Oct 2014 16:43:50 -0400 (EDT)
In-Reply-To: <1413070656-241955-4-git-send-email-sandals@crustytoothpaste.net>
	(brian m. carlson's message of "Sat, 11 Oct 2014 23:37:35 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F7DB594C-54AB-11E4-8395-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Asciidoctor takes slightly different arguments from AsciiDoc in some
> cases.  It has a different name for the HTML backend and the "docbook"
> backend produces DocBook 5, not DocBook 4.5.  Also, Asciidoctor does not
> accept the -f option.  Move these values into variables so that they can
> be overridden by users wishing to use Asciidoctor instead of Asciidoc.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---

I think it makes sense to make these customizable, but I wonder if
it makes the result easier to maintain if we make units of logical
definitions larger, e.g.

	ASCIIDOC = asciidoc
        TXT_TO_MANHTML = $(ASCIIDOC) -b xhtml11 -d manpage $(ASCIIDOC_CONF)
        TXT_TO_ARTICLE = $(ASCIIDOC) -b docbook -d article
	...

ASCIIDOC_EXTRA may want to apply all of them, even though I see that
we do not feed it to OBSOLETE_HTML right now.  It may also be that
$(ASCIIDOC_CONF) and -agit_version=$(GIT_VERSION) could be shared
among the ones that currently do not have.

Then the above would become something like:

	ASCIIDOC = asciidoc
	ASCIIDOC_COMMON = $(ASCIIDOC) \
        	$(ASCIIDOC_EXTRA) $(ASCIIDOC_CONF) -agit_version=$(GIT_VERSION)
        TXT_TO_MANHTML = $(ASCIIDOC_COMMON) -b xhtml11 -d manpage
        ...

and would further simplify this part

>  $(MAN_HTML): %.html : %.txt asciidoc.conf
>  	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
> -	$(ASCIIDOC) -b xhtml11 -d manpage -f asciidoc.conf \
> +	$(ASCIIDOC) -b $(ASCIIDOC_HTML) -d manpage $(ASCIIDOC_CONF) \
>  		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) -o $@+ $< && \

into just

	$(TXT_TO_MANHTML) -o $@+ $<

After all, our output formats are fairly limited, I would think.
Are there too many different variants and exceptions to make such an
approach infeasible?
