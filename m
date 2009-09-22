From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] git-log --format: Add %B tag with %B(x) option
Date: Tue, 22 Sep 2009 12:41:17 -0700
Message-ID: <7vfxaercma.fsf@alter.siamese.dyndns.org>
References: <7vtyz083tk.fsf@alter.siamese.dyndns.org>
 <1253354304-13117-1-git-send-email-heipei@hackvalue.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Gilger <heipei@hackvalue.de>
X-From: git-owner@vger.kernel.org Tue Sep 22 21:45:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqBI3-00084P-HF
	for gcvg-git-2@lo.gmane.org; Tue, 22 Sep 2009 21:44:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752706AbZIVTl1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2009 15:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752696AbZIVTl0
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 15:41:26 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57191 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057AbZIVTlX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2009 15:41:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E92E83CAD7;
	Tue, 22 Sep 2009 15:41:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MlfW6SIEzvY1KWmt7lVGklSaIRQ=; b=nTFTy1
	CYkleWqMo4mUG6tUF41+si+FwBjLuR3F4z1p6m8msUq1XXeOAu3r1gfgej4W0n6W
	KkT1QR9VrWRDCImsJmi0ybPJAK+KaukYut6eC52C6LDnO2hywZrTdtpH/k0lqim7
	qt4t9e0FYey5sDZVtDL7SrYihvDfmFgKug+Lo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q5FrNzp5HWuej1GNKwdMF3f+puKUvf4G
	1brqBN4/kLZ3S7Y4LXUZdyXM+pPJKUr+N61Ui8bqHRVgi8n5eO1vtFekT9615+ac
	HWyV0wcFA5+Y7kEsy89f4lJuj9jt6e5JWQ5a3hmBRRRJk8FcLoL4z3h6RTi5+zVd
	CbkiNB4MblI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C047F3CAD6;
	Tue, 22 Sep 2009 15:41:23 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CAE993CAD1; Tue, 22 Sep
 2009 15:41:18 -0400 (EDT)
In-Reply-To: <1253354304-13117-1-git-send-email-heipei@hackvalue.de>
 (Johannes Gilger's message of "Sat\, 19 Sep 2009 11\:58\:24 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E8FBBBE6-A7AF-11DE-9099-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128954>

Johannes Gilger <heipei@hackvalue.de> writes:

> Since one can simply use spaces to indent any other --pretty field we
> should have an option to do that with the body too.
>
> Also the %B flag strips the trailing newlines, to enable more compact
> display.
>
> Signed-off-by: Johannes Gilger <heipei@hackvalue.de>
> ---
> Changes to PATCHv2:
> - Make %B() strict: Only nonnegative integers are allowed between the brackets, 
>   everything else yields the placemark itself as output to indicate a wrong 
>   argument. This also goes for an empty argument.
>
>  Documentation/pretty-formats.txt |    2 ++
>  pretty.c                         |   29 ++++++++++++++++++++++++-----
>  2 files changed, 26 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index 2a845b1..533bc5e 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -733,7 +737,20 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
>  		format_sanitized_subject(sb, msg + c->subject_off);
>  		return 1;
>  	case 'b':	/* body */
> -		strbuf_addstr(sb, msg + c->body_off);
> +		strbuf_addstr(sb, body);
> +		return 1;
> +	case 'B':	/* body without trailing newline */
> +		if (end) {
> +			char *endp = NULL;
> +			int indent = strtol(placeholder + 2, &endp, 10);
> +			if (placeholder + 2 == endp || *endp != ')' || indent < 0)
> +				return 0;
> +			pp_remainder(CMIT_FMT_MEDIUM, &body, sb, indent);
> +			strbuf_rtrim(sb);
> +			return end - placeholder + 1;
> +		}
> +		strbuf_addstr(sb, body);
> +		strbuf_rtrim(sb);
>  		return 1;
>  	}
>  	return 0;	/* unknown placeholder */
> @@ -875,6 +892,8 @@ void pp_remainder(enum cmit_fmt fmt,
>  		}
>  		first = 0;
>  
> +		if (indent < 0)
> +			indent = 0;

I'd move this check to the caller; other than that and some other small
style issues I think this round is Ok.

>  		strbuf_grow(sb, linelen + indent + 20);
>  		if (indent) {
>  			memset(sb->buf + sb->len, ' ', indent);
> -- 
> 1.6.5.rc1.20.geb7d9
