From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] userdiff: add built-in pattern for CSS
Date: Thu, 02 Jun 2016 16:07:41 -0700
Message-ID: <xmqq1t4frxz6.fsf@gitster.mtv.corp.google.com>
References: <20160524142537.19324-1-william.duclot@ensimag.grenoble-inp.fr>
	<20160602224809.5167-1-william.duclot@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, simon.rabourg@ensimag.grenoble-inp.fr,
	antoine.queru@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr, j6t@kdbg.org,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 03 01:07:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8biP-0003Cc-BG
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 01:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933032AbcFBXHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 19:07:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53816 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932888AbcFBXHo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 19:07:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8524620734;
	Thu,  2 Jun 2016 19:07:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P/HzVRShWCX+6dwg3lwT+gPF7cU=; b=swYCye
	oAs5T2/5Anmk2OpOVxs4oOXn0yGpJeeem1qR1wCnXOs5an6qerKVlX6ynIKT0qez
	vgpx0qggT4mzndhQaBmqCZ+CLbgtu0PO/7+B2ttWfCe0C4nVLBpbwPRgXugO3HOR
	QtciBBFc351w6RidPe4xhSx1llaI30Ri3kF8M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GiThjeSu19z+cthjYuU1svLhLnByBKXO
	mCzBjgcTQx2SGQc6zKMUNF5NHAYJzEariFNeBoR0FRec5po24/N6Wh3eEee0uFTW
	55fNtT+9k7rEJFRb+vn4ewlbchqXEC/8oZtlSOLXfM3CwFsXy6dQvVPEgXNxPzsS
	KEfgClzSGm4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7CC3F20732;
	Thu,  2 Jun 2016 19:07:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 07B8C20731;
	Thu,  2 Jun 2016 19:07:43 -0400 (EDT)
In-Reply-To: <20160602224809.5167-1-william.duclot@ensimag.grenoble-inp.fr>
	(William Duclot's message of "Fri, 3 Jun 2016 00:48:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CFA4D5FC-2916-11E6-9649-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296254>

William Duclot <william.duclot@ensimag.grenoble-inp.fr> writes:

> diff --git a/userdiff.c b/userdiff.c
> index 6bf2505..00fc3bf 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -148,6 +148,18 @@ PATTERNS("csharp",
>  	 "[a-zA-Z_][a-zA-Z0-9_]*"
>  	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
>  	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"),
> +IPATTERN("css",
> +	 "!^.*;\n"
> +	 "^[_a-z0-9].*$",
> +	 /* -- */
> +	 /*
> +	  * This regex comes from W3C CSS specs. Should theoretically also
> +	  * allow ISO 10646 characters U+00A0 and higher,
> +	  * but they are not handled in this regex.
> +	  */
> +	 "-?[_a-zA-F][-_a-zA-F0-9]*" /* identifiers */
> +	 "|-?[0-9]+|\\#[0-9a-fA-F]+" /* numbers */

You could now lose A-F from the above two lines.  In fact, the first
line "identifiers" has "a-zA-F", which probably would work correctly
under IPATTERN() to include 'G-Z' as part of the legit letters for
identifiers, but is indeed misleading.

> +),
>  { "default", NULL, -1, { NULL, 0 } },
>  };
>  #undef PATTERNS
