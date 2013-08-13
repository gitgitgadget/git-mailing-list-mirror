From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git should not use a default user.email config value
Date: Tue, 13 Aug 2013 09:31:35 -0700
Message-ID: <7vwqnpy2l4.fsf@alter.siamese.dyndns.org>
References: <20130809134236.28143.75775.reportbug@tglase.lan.tarent.de>
	<20130809194214.GV14690@google.com>
	<20130809223758.GB7160@sigill.intra.peff.net>
	<20130809231928.GY14690@google.com>
	<20130810064717.GB30185@sigill.intra.peff.net>
	<52060EF9.2040504@alum.mit.edu>
	<7vvc3d1o01.fsf@alter.siamese.dyndns.org>
	<CAH5451nHfOaBzFzkrGvw+TyRj==cVpKF_QdXsTxnn5tTr1c0dw@mail.gmail.com>
	<20130812123921.GA16088@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thorsten Glaser <tg@mirbsd.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 13 18:32:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9HVp-00079q-KE
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 18:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758683Ab3HMQbn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Aug 2013 12:31:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56317 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758373Ab3HMQbk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Aug 2013 12:31:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A1A3438A1B;
	Tue, 13 Aug 2013 16:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EcHHvpW1HOBAJZfhmdtyMm1/JI0=; b=nJwD++
	QZ39pHJ0tQFixmO87qRuHvQZ7v3rnJCgAKHHcyMVrTmMy6ZcXjzU+0piH4kR5dkR
	ZVEWltx+A6o9bcwejBIeSnyMTlR3ge7nnxc7tIJpcrp0Mof7Ro/pgzP6YLOBsVk3
	IsUpkBoaaOYg36OmTTAShu5Q3pDDhSks51TUo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C9ecStiRdu8i6utbTG39ihtZtoUuwre/
	n+LycRkNWr3LclLSZeOeIRYpkUpmCVK6EK4jY8wkL31SKL0g1Y7O8GALLHE+McQA
	aLSOMvl/xMIRcOUouYRfm+aqySOKXH+zbgJU6pPjC5jw1sLOSB/d2G0Le46x/HGi
	ZicxJ0n7Jp8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 836DC38A1A;
	Tue, 13 Aug 2013 16:31:39 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7679F38A10;
	Tue, 13 Aug 2013 16:31:37 +0000 (UTC)
In-Reply-To: <20130812123921.GA16088@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 12 Aug 2013 08:39:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D366B812-0435-11E3-8EB2-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232231>

Jeff King <peff@peff.net> writes:

> diff --git a/config.c b/config.c
> index e13a7b6..a31dc85 100644
> --- a/config.c
> +++ b/config.c
> @@ -119,10 +119,45 @@ int git_config_include(const char *var, const char *value, void *data)
>  	return ret;
>  }
>  
> +static NORETURN void die_bad_regex(int err, regex_t *re)
> +{
> +	char errbuf[1024];
> +	regerror(err, re, errbuf, sizeof(errbuf));
> +	if (cf && cf->name)
> +		die("bad regex (at %s:%d): %s", cf->name, cf->linenr, errbuf);
> +	else
> +		die("bad regex: %s", errbuf);
> +}
> +
> +static int match_repo_path(const char *re_str)
> +{
> +	regex_t re;
> +	int ret;
> +	const char *repo_path;
> +
> +	ret = regcomp(&re, re_str, REG_EXTENDED);
> +	if (ret)
> +		die_bad_regex(ret, &re);
> +
> +	repo_path = absolute_path(get_git_dir());
> +	ret = regexec(&re, repo_path, 0, NULL, 0);
> +	regfree(&re);
> +	return !ret;

We do this every time during the parsing?

Hmph, if you had "include.repo:/home/junio/frotz/.path" and
"include.repo:/srv/project/git.git/.path" in your ~/.gitconfig,
then a single regexp that is lazily prepared once will not cut it,
so I guess that you cannot avoid it.

Unlike "git init|clone --profile=foo" that requires you to be
explicit about your profile upon invocation, this mechanism is much
easier to use by having include.<magic>.path in some global
configuration, and the existing precedence rule makes it perfect.
By starting /etc/gitconfig and/or your $HOME/.gitconfig with series
of include.<magic>.path, you can have the default definitions
included from these magic include to take effect before anything
else, and settings from other configuration files can override it.
