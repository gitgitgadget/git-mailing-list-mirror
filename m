From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 05/11] trailer: parse trailers from stdin
Date: Wed, 05 Mar 2014 14:56:21 -0800
Message-ID: <xmqq38iw1ch6.fsf@gitster.dls.corp.google.com>
References: <20140304193250.14249.56949.chriscool@tuxfamily.org>
	<20140304194810.14249.52031.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Mar 05 23:56:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLKjm-0001IO-Mh
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 23:56:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757519AbaCEW40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 17:56:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34463 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757296AbaCEW4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 17:56:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 369F471FB1;
	Wed,  5 Mar 2014 17:56:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=PBJkdr5kbRv+zxm1ezsnDaFp7Aw=; b=SdoT2QL8Vbu2KQUZ0Sp6
	/KEAT9n+xA+rt2utEEDMK8cI87G9sj2gXczXa2j12HJiChbnxtk+/dlAuPgoaA8B
	zjAlqlmshghQ5bQz+q64tltGmd1VtsaLZZeHCzDFhrcnJT97ynxxderVU0XlOhDV
	CE5tnI+fSyG13IkrghLiiQw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=fDUdmCJFCkGKc66AwJEEJvTCsOaKKh3UAWzyHdmhuGLFva
	tzDinR3h+16cVXq+U2qJklARIMAHrOUdpWO1X8Yd/N3eE7A9LABQnOYymHR8yFU9
	RYhpj8NkmAL+eCmXWvJctxmeWA+IJrFoLii3Jy1pErI3ady/YL/3OiHcfv4Kw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E60B71FB0;
	Wed,  5 Mar 2014 17:56:25 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 36CC171FAC;
	Wed,  5 Mar 2014 17:56:24 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 60511A64-A4B9-11E3-AB1D-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243491>

Christian Couder <chriscool@tuxfamily.org> writes:

> diff --git a/trailer.c b/trailer.c
> index 5d69c00..e0e066f 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -50,6 +50,13 @@ static size_t alnum_len(const char *buf, size_t len)
>  	return len;
>  }
>  
> +static inline int contains_only_spaces(const char *str)
> +{
> +	const char *s;
> +	for (s = str; *s && isspace(*s); s++);

Have an empty statement on a separate line for readability.  I.e.

	for (...)
        	; /* keep skipping */

> @@ -471,3 +478,72 @@ static struct trailer_item *process_command_line_args(int argc, const char **arg
> ...
> +static void process_stdin(struct trailer_item **in_tok_first,
> +			  struct trailer_item **in_tok_last)
> +{
> ...
> +	/* Print non trailer lines as is */
> +	for (i = 0; lines[i] && i < start; i++) {
> +		printf("%s", lines[i]->buf);
> +	}

Needless brace pair.
