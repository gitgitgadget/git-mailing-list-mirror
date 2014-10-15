From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Custom hunk-header with ignore case setting
Date: Wed, 15 Oct 2014 12:35:56 -0700
Message-ID: <xmqqd29tw2g3.fsf@gitster.dls.corp.google.com>
References: <543E6E23.5030708@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
X-From: git-owner@vger.kernel.org Wed Oct 15 21:36:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeUMd-0005HU-Ry
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 21:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbaJOTf7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 15:35:59 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51119 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751106AbaJOTf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 15:35:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BF3BD151E0;
	Wed, 15 Oct 2014 15:35:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zsiJ+2IE/DNg8a5t3KNAo189JyQ=; b=tNoDln
	SLOrvvt8Fr3HyuoBh6kj3V7Z2LDeNPQggbWsaRyFh9AVwWqKqb/3VHNScbfv4Gpx
	FHjZR531mKJxazNLTDveOKxArLSHDhKwvR06wgj/p8wYVGdgl+58ld/uTtwvnGJi
	YBlJ1ec1QaoXoNTTY+L1JGFgjbERQU4dE73Wo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mFzgQh3F/rzq/R/UyJr96rRy5uQaFSQm
	exfKyZcR7JhmaE216ZR2n0zeNTIFvQCc+VFkMDsp5wojChr/2otACCQUdc/05Lns
	Om0N6wQxIz9vbZ2giT4JPwN1qGStEQXhzDDH7GAw9Go93+0tyH4vy0ILKA9vsyOn
	oXjclx50Tn0=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B5CDF151DF;
	Wed, 15 Oct 2014 15:35:57 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 41EB1151DC;
	Wed, 15 Oct 2014 15:35:57 -0400 (EDT)
In-Reply-To: <543E6E23.5030708@virtuell-zuhause.de> (Thomas Braun's message of
	"Wed, 15 Oct 2014 14:52:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7C2E5FD2-54A2-11E4-B353-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Braun <thomas.braun@virtuell-zuhause.de> writes:

> I've seen that the builtin diff patterns in userdiff.c can be
> specified ignoring case using the IPATTERN macro.
>
> One of the possible solutions would be to patch userdiff.c
> (patch courtesy of Johannes Schindelin):
>
> -- snip --
> diff --git a/userdiff.c b/userdiff.c
> index fad52d6..f089e50 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -228,6 +228,9 @@ int userdiff_config(const char *k, const char *v)
>  		return parse_funcname(&drv->funcname, k, v, 0);
>  	if (!strcmp(type, "xfuncname"))
>  		return parse_funcname(&drv->funcname, k, v, REG_EXTENDED);
> +	if (!strcmp(type, "ixfuncname"))
> +		return parse_funcname(&drv->funcname, k, v,
> +				REG_EXTENDED | REG_ICASE);
>  	if (!strcmp(type, "binary"))
>  		return parse_tristate(&drv->binary, k, v);
>  	if (!strcmp(type, "command"))

I am not sure if we care deeply about supporting case insensitive
payload in the first place, but the above change, unlike other
possibilities, adds only small burden to the end users' cognitive
load, and it looks like a sensible way to go forward.

Thanks.
