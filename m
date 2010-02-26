From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Having keywords without value is not a global error.
Date: Thu, 25 Feb 2010 21:14:49 -0800
Message-ID: <7vk4u0efxy.fsf@alter.siamese.dyndns.org>
References: <c28821e9079f35e7267a1e7381ccf7793c12bf24.1267156694.git.sdrake@xnet.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Drake <sdrake@xnet.co.nz>
X-From: git-owner@vger.kernel.org Fri Feb 26 06:15:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NksXY-0002nY-Dp
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 06:15:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106Ab0BZFO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 00:14:58 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56509 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976Ab0BZFO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 00:14:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 182A49DB10;
	Fri, 26 Feb 2010 00:14:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VlpJKxBdPfxJI39z4W28DbUqhQQ=; b=cbYZUO
	KSipaPznjGIkjqbnkZUWYXBu9zqI+TmSUAR56nxTZB0fV2ijydv+xIVTF2hre8b0
	1Ak/jJfBCriJjKmIi2dDPuQma0N9wM5o5SDxxhnGp1Si1koO1Ll2xKYPVeth6sNk
	+aTAyygolApQdPaydaUQe7EHIkhjBtuPDEsUo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xDeQoP6cbozIB3WDgSfpYBlvgD+qpAoh
	T1aFrikX77i+khPEFh5MaT4PoFXeNbiaSXdtbt7TNu8pUYIPWCuALYqRsgb4ZMs8
	R5vysmJDbZh3ozQsBeAzOuxQ4D350GVHMXSaAiGht1PAlJiIXIhX261t/HSXjMeK
	ydeIsyNluTw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D7AB39DB0F;
	Fri, 26 Feb 2010 00:14:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E63CC9DB0B; Fri, 26 Feb
 2010 00:14:51 -0500 (EST)
In-Reply-To: <c28821e9079f35e7267a1e7381ccf7793c12bf24.1267156694.git.sdrake@xnet.co.nz>
 (Steven Drake's message of "Fri\, 26 Feb 2010 17\:00\:20 +1300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E007D0A4-2295-11DF-9A1E-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141106>

Steven Drake <sdrake@xnet.co.nz> writes:

> It is not a good Idea to give a config_error for _any_ keyword without a
> value as it means that
>
> 	[section]
> 		keyword
>
> sytle can not be using for setting bool type keyword.
>
> Signed-off-by: Steven Drake <sdrake@xnet.co.nz>
> ---
>  builtin/init-db.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 9273942..edc40ff 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -170,8 +170,6 @@ static void copy_templates(const char *template_dir)
>  
>  static int git_init_db_config(const char *k, const char *v, void *cb)
>  {
> -	if (!v)
> -		return config_error_nonbool(k);
>  	if (!strcmp(k, "init.templatedir"))
>  		return git_config_pathname(&init_db_template_dir, k, v);

But then don't you need to catch init.templatedir does have a string
value?

>  
> -- 
> 1.6.6
