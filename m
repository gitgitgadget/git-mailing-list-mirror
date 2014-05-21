From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 1/2] format-patch: make newline after signature conditional
Date: Wed, 21 May 2014 14:22:38 -0700
Message-ID: <xmqq1tvmq129.fsf@gitster.dls.corp.google.com>
References: <1400706472-13471-1-git-send-email-jmmahler@gmail.com>
	<1400706472-13471-2-git-send-email-jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 21 23:22:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnDyK-0006sM-Dc
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 23:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752687AbaEUVWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 17:22:44 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54666 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751786AbaEUVWo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 17:22:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9BD60197C8;
	Wed, 21 May 2014 17:22:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gV02wYKSyqjXNOMkbteEW/wxosM=; b=ivllFB
	5zKtrCL5T85x7soG0b/S+EChBfhj43EUfPI53prxvMHshjOlyDO0ZAJ0C2DnPaO7
	lHoe0euAEdZvHsEJv1aKsLiobMOnGPSWqwrHv5vfQuJ+CAfq6Y1+UE+CickE0l1A
	F9+JeioRoxndEO8uKZFx0OtjwXG/xORAmRnkg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pA9hPEKWmV95gG+bNSjW5azNjyeoA9hb
	ORSjkUr8Q41e5+5sy8WPdA3ImmtwjGtfUslV3bu8MMRs5bEIBMFEmUQ4ZLq3aZsC
	ihFSXWEDkUkCb6n6Pax679BYtldm8FkcbMUfDGkahrSCK7jCPJc4klaYB+3EmvQI
	202P8WWYJhU=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9044D197C7;
	Wed, 21 May 2014 17:22:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 79AC2197BF;
	Wed, 21 May 2014 17:22:40 -0400 (EDT)
In-Reply-To: <1400706472-13471-2-git-send-email-jmmahler@gmail.com> (Jeremiah
	Mahler's message of "Wed, 21 May 2014 14:07:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0A14225C-E12E-11E3-A7C5-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249834>

Jeremiah Mahler <jmmahler@gmail.com> writes:

> From: Jeff King <peff@peff.net>
>
> When we print an email signature, we print the divider "--
> \n", then the signature string, then two newlines.
> Traditionally the signature is a one-liner (and the default
> is just the git version), so the extra newline makes sense.
>
> But one could easily specify a longer, multi-line signature,
> like:
>
>   git format-patch --signature='
>   this is my long signature
>
>   it has multiple lines
>   ' ...
>
> We should notice that it already has its own trailing
> newline, and suppress one of ours.

That is a half-good example; the first line being a blank is
misleading, as we are not doing anything about that, though.

Other than that, the patch looks OK to me.  If anybody complains we
can fix it later to do more cleansing.

> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
> ---
>  builtin/log.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index 39e8836..5acc048 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -844,8 +844,13 @@ static void gen_message_id(struct rev_info *info, char *base)
>  
>  static void print_signature(void)
>  {
> -	if (signature && *signature)
> -		printf("-- \n%s\n\n", signature);
> +	if (!signature || !*signature)
> +		return;
> +
> +	printf("-- \n%s", signature);
> +	if (signature[strlen(signature)-1] != '\n')
> +		putchar('\n');
> +	putchar('\n');
>  }
>  
>  static void add_branch_description(struct strbuf *buf, const char *branch_name)
