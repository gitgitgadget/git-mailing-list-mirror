From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pretty.c: Don't expand %N without --show-notes
Date: Sat, 10 Apr 2010 13:00:33 -0700
Message-ID: <7vaatbw00u.fsf@alter.siamese.dyndns.org>
References: <201004061127.01471.trast@student.ethz.ch>
 <1270883127-11488-1-git-send-email-heipei@hackvalue.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git ML <git@vger.kernel.org>, Thomas Rast <trast@student.ethz.ch>,
	Jeff King <peff@peff.net>
To: Johannes Gilger <heipei@hackvalue.de>
X-From: git-owner@vger.kernel.org Sat Apr 10 22:00:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0grK-0008Th-Mq
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 22:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973Ab0DJUAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 16:00:45 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46325 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284Ab0DJUAo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 16:00:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 26574A93B2;
	Sat, 10 Apr 2010 16:00:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bhTwBfoXYo8v5297M49E1Kd+7oc=; b=RrS2Yr
	UEdovHxWVLMoeVqJU/WxFRuCKwsxfA59Pq4B7VRPyDIAACWUVjmd2OVEGY6DvMXO
	6gUAvLG73uhyXU817x+Gy/UPR4+aCxfic6LZXY2nTUcNKdL1/o01DFDxE4jFVepI
	OAFIDVkOzWjoA3OZO5+dhpQxdZtMkXDVBAX84=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eRDb/eVSk8gT0ItmucgrODweWtaa2GC1
	QNK0wbzi+tJ6UDt8Y4s0CgxiZ/aXu49lrh19YllHomdKFhR/9D+m+aKsXKsWTqqg
	sbTRXGOXs8CsSzdMOui2G7uvMddpl1mrcC1eJWDdNEd/ShiVxIZJ+fa9CID3GbYN
	W7FNV1Fg1Lw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D6AC2A93B1;
	Sat, 10 Apr 2010 16:00:39 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 09E95A93AE; Sat, 10 Apr
 2010 16:00:34 -0400 (EDT)
In-Reply-To: <1270883127-11488-1-git-send-email-heipei@hackvalue.de>
 (Johannes Gilger's message of "Sat\, 10 Apr 2010 09\:05\:27 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BCADD668-44DB-11DF-BA3C-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144588>

Johannes Gilger <heipei@hackvalue.de> writes:

> The %N placeholder will only work if --show-notes was provided to log.
> By not expanding the user is given feedback that he won't be shown any
> notes.

I kind of like the simplicity of this approach, but this probably cuts
both ways.  I can hear some users screaming "But but but I already told
you that I am interested in notes---how else would I say %N in the format
string?" while others say "Yeah, that way I can keep using the same format
and when I don't give --show-notes it won't show extra information in the
output.  Very nice".

> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index 1686a54..bf7813f 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -143,7 +143,8 @@ NOTE: Some placeholders may depend on other options given to the
>  revision traversal engine. For example, the `%g*` reflog options will
>  insert an empty string unless we are traversing reflog entries (e.g., by
>  `git log -g`). The `%d` placeholder will use the "short" decoration
> -format if `--decorate` was not already provided on the command line.
> +format if `--decorate` was not already provided on the command line. The %N
> +placeholder won't be expanded unless `--show-notes` was provided.
>  
>  If you add a `{plus}` (plus sign) after '%' of a placeholder, a line-feed
>  is inserted immediately before the expansion if and only if the
> diff --git a/pretty.c b/pretty.c
> index 6ba3da8..b39e2d5 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -775,6 +775,9 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
>  		}
>  		return 0;	/* unknown %g placeholder */
>  	case 'N':
> +		if (!c->pretty_ctx->show_notes)
> +			return 0;
> +
>  		format_display_notes(commit->object.sha1, sb,
>  			    git_log_output_encoding ? git_log_output_encoding
>  						    : git_commit_encoding, 0);
> -- 
> 1.7.0.2.201.g80978
