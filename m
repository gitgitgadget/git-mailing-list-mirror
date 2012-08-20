From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] parseopt: do not translate empty help string
Date: Mon, 20 Aug 2012 12:21:54 -0700
Message-ID: <7vboi5jrn1.fsf@alter.siamese.dyndns.org>
References: <bcb1f4437760452f967737fddf26dff019d0f0b2.1345487066.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Aug 20 21:22:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3XY3-0006GM-Qq
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 21:22:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612Ab2HTTV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 15:21:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40730 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753221Ab2HTTV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 15:21:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AE2D623B;
	Mon, 20 Aug 2012 15:21:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8NpbJrolqX1ICV6LkGhxU3BbDlo=; b=QtmeUf
	KEPFj3oJc7lcpXHcRPu1obBfCJSF9+XsnMDjhsERtTseXC8+b42NfXyfdGNcUOUv
	Itil8v1Pz3TmPGl5tmN6lHAdSGZrtj6lpBfHlBhijJPglwpp9M9ffzo+569JGlWH
	4JMrntpqD6eDOE0ezP61q7fF3NT6FH4WqKKO4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k3D9vH+Jl8s1AAbyLnxzRHa/iIpe9K+6
	9w/dGehr0p8p9sq/J1XXAQw5/Ql4lZG+kukR4aa98HVRz4WqcoiExS4Z4r0xMV6M
	4/18nNa9KpmlkRKQhsQ7f8LOZkqC4IB97YoPmRGyBRs6bbFhPcQQhkXRcd+s76D2
	fX0oI6j6jGU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58E4E623A;
	Mon, 20 Aug 2012 15:21:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B38276239; Mon, 20 Aug 2012
 15:21:55 -0400 (EDT)
In-Reply-To: <bcb1f4437760452f967737fddf26dff019d0f0b2.1345487066.git.trast@student.ethz.ch> (Thomas Rast's message of "Mon, 20 Aug 2012 20:24:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4DE675FE-EAFC-11E1-8556-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203869>

Thomas Rast <trast@student.ethz.ch> writes:

> The gettext .po files have a header, but it looks like the translation
> specification for an empty string.  This results in _("") actually
> returning that header.
>
> Prevent parseopt from passing empty strings to gettext when it
> displays help about commands.  In some instances it already did this,
> but git-grep's --or etc. caught another case.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>  parse-options.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/parse-options.c b/parse-options.c
> index c1c66bd..f95bbb2 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -562,7 +562,8 @@ static int usage_with_options_internal(struct parse_opt_ctx_t *ctx,
>  			fputc('\n', outfile);
>  			pad = USAGE_OPTS_WIDTH;
>  		}
> -		fprintf(outfile, "%*s%s\n", pad + USAGE_GAP, "", _(opts->help));
> +		fprintf(outfile, "%*s%s\n", pad + USAGE_GAP, "",
> +			*opts->help ? _(opts->help) : "");
>  	}
>  	fputc('\n', outfile);

Thanks; this is a tricky bit to catch and makes me wonder where else
we have a similar breakage.

Perhaps we would want to do this instead?  I dunno.

 gettext.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git i/gettext.h w/gettext.h
index 57ba8bb..376297b 100644
--- i/gettext.h
+++ w/gettext.h
@@ -44,6 +44,8 @@ extern int use_gettext_poison(void);
 
 static inline FORMAT_PRESERVING(1) const char *_(const char *msgid)
 {
+	if (!*msgid)
+		return "";
 	return use_gettext_poison() ? "# GETTEXT POISON #" : gettext(msgid);
 }
 
