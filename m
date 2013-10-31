From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] for-each-ref: introduce %C(...) for color
Date: Thu, 31 Oct 2013 13:50:58 -0700
Message-ID: <xmqq38nh411p.fsf@gitster.dls.corp.google.com>
References: <1383212774-5232-1-git-send-email-artagnon@gmail.com>
	<1383212774-5232-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 21:51:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbzCt-0006LV-Ir
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 21:51:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753887Ab3JaUvC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 16:51:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57170 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751283Ab3JaUvB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 16:51:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA5A84D6F0;
	Thu, 31 Oct 2013 16:51:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xZcLTaBLstH8oGyJ/AQpYI6uSkg=; b=A4FJ34
	7G8fLGtcbrCihQi/tQe7ryEprBxR6wma+R6YXP9oF6ica52N5ofPoAtDYYTlSV7F
	sCe0PAqnozuctfXJbOxWEgSCwNcgMo3W4m+UcSTu1g07bYTM+SRS0TZZROWWa3jW
	H7F4uPBN5MmusVgPQs98JkGXlXN//kvapaEJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jr3V84EdGtIBBgSHi9YBqn9dfxTcqwO+
	pHA7kgd3bljq/BErfGLBVClCDqzgZQN7dPxi9AogZgQ8g5mXKRhh/wm5D/sK//Ll
	k9lrGJFmphveW4xXf0tS2dgweHXMWsGuaz31IjGzHouCEdxRH156baewQpWfRdCZ
	rCUDI2Z4UJc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EFD64D6EF;
	Thu, 31 Oct 2013 16:51:00 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C723A4D6EC;
	Thu, 31 Oct 2013 16:50:59 -0400 (EDT)
In-Reply-To: <1383212774-5232-2-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Thu, 31 Oct 2013 15:16:12 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 25BD410A-426E-11E3-AB88-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237183>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Enhance 'git for-each-ref' with color formatting options.  You can now
> use the following format in for-each-ref:
>
>   %C(green)%(refname:short)%C(reset)

So far, every magic for-each-ref takes were of form %(...); was
there a reason why this had to be %C(...), not %(color=blah), or
something more in-line with the existing other magic?

>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Documentation/git-for-each-ref.txt |  4 +++-
>  builtin/for-each-ref.c             | 23 +++++++++++++++++++----
>  2 files changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index f2e08d1..6fa4464 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -45,7 +45,9 @@ OPTIONS
>  	It also interpolates `%%` to `%`, and `%xx` where `xx`
>  	are hex digits interpolates to character with hex code
>  	`xx`; for example `%00` interpolates to `\0` (NUL),
> -	`%09` to `\t` (TAB) and `%0a` to `\n` (LF).
> +	`%09` to `\t` (TAB) and `%0a` to `\n` (LF). Additionally,
> +	colors can be specified using `%C(...)`, with names
> +	described in color.branch.*.
>  
>  <pattern>...::
>  	If one or more patterns are given, only refs are shown that
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index 1d4083c..6da2903 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -9,6 +9,7 @@
>  #include "quote.h"
>  #include "parse-options.h"
>  #include "remote.h"
> +#include "color.h"
>  
>  /* Quoting styles */
>  #define QUOTE_NONE 0
> @@ -155,10 +156,13 @@ static const char *find_next(const char *cp)
>  	while (*cp) {
>  		if (*cp == '%') {
>  			/*
> +			 * %C( is the start of a color;
>  			 * %( is the start of an atom;
>  			 * %% is a quoted per-cent.
>  			 */
> -			if (cp[1] == '(')
> +			if (cp[1] == 'C' && cp[2] == '(')
> +				return cp;
> +			else if (cp[1] == '(')
>  				return cp;
>  			else if (cp[1] == '%')
>  				cp++; /* skip over two % */
> @@ -180,8 +184,11 @@ static int verify_format(const char *format)
>  		const char *ep = strchr(sp, ')');
>  		if (!ep)
>  			return error("malformed format string %s", sp);
> -		/* sp points at "%(" and ep points at the closing ")" */
> -		parse_atom(sp + 2, ep);
> +		/* Ignore color specifications: %C(
> +		 * sp points at "%(" and ep points at the closing ")"
> +		 */
> +		if (prefixcmp(sp, "%C("))
> +			parse_atom(sp + 2, ep);
>  		cp = ep + 1;
>  	}
>  	return 0;
> @@ -933,12 +940,20 @@ static void emit(const char *cp, const char *ep)
>  static void show_ref(struct refinfo *info, const char *format, int quote_style)
>  {
>  	const char *cp, *sp, *ep;
> +	char color[COLOR_MAXLEN] = "";
>  
>  	for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
>  		ep = strchr(sp, ')');
>  		if (cp < sp)
>  			emit(cp, sp);
> -		print_value(info, parse_atom(sp + 2, ep), quote_style);
> +
> +		/* Do we have a color specification? */
> +		if (!prefixcmp(sp, "%C("))
> +			color_parse_mem(sp + 3, ep - sp - 3, "--format", color);
> +		else {
> +			printf("%s", color);
> +			print_value(info, parse_atom(sp + 2, ep), quote_style);
> +		}
>  	}
>  	if (*cp) {
>  		sp = cp + strlen(cp);
