From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/7] Allow core.autocrlf=input and core.eol=crlf
Date: Fri, 01 Apr 2016 15:20:30 -0700
Message-ID: <xmqqio01gedt.fsf@gitster.mtv.corp.google.com>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
	<1459526906-19868-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Sat Apr 02 00:20:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am7Qj-0007Xv-Mn
	for gcvg-git-2@plane.gmane.org; Sat, 02 Apr 2016 00:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753737AbcDAWUe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Apr 2016 18:20:34 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:55058 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752688AbcDAWUd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Apr 2016 18:20:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 534FD4F72B;
	Fri,  1 Apr 2016 18:20:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=oCAr8gS49er5
	JsofBedmrU+1YoU=; b=b9CgOX7sIP0u2qdW6BpKA+aAco2SZZo1r6DPSYyhVtai
	TQsTnV25il4Huo2Gy66Rob27BhvfovJCBz/bAJKu9usLhMOmywveBKD5LWCAfjgs
	qGieL6dQqEHCI7Onc6c/w3ZDzFkCofDop2/1k2wvgVFBqZurIqVJwrxWwKoowzk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=IbfhBf
	hdUwbAvAY5jU/U5v5WbX//kefnxUpY0S/bIdJeeK13B29QrckEcPOKPu6bymc+I4
	fLLuCg4AqeXr1g9b5kp06jtVMJQVy4uwJk4s3Ots/EVryJEdMUj8DnjtoT879H+g
	F81q9RYeEIAdGDO2BdknV1DDss7wC80An+UDY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 42D144F729;
	Fri,  1 Apr 2016 18:20:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B4EAE4F727;
	Fri,  1 Apr 2016 18:20:31 -0400 (EDT)
In-Reply-To: <1459526906-19868-1-git-send-email-tboegi@web.de>
	(tboegi@web.de's message of "Fri, 1 Apr 2016 18:08:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F26A4210-F857-11E5-A233-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290584>

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> Commit  942e77 "Add "core.eol" config variable" adds a condition to
> the config parser: core.autocrlf=3Dinput is not allowed together with
> core.eol=3Dcrlf.
>
> This may lead to unnecessary problems, when config files are parsed:
> A global config file sets core.autocrlf=3Dinput,
> the repo local config file sets is own configuration: core.eol=3Dcrlf

This paragraph is unparsable.  Do you mean

	When the global configuration file sets core.autocrlf=3Dinput
        and the repository local one sets core.eol=3Dcrlf, they violate
        this condition and triggers an error when the configuration
        is read.

I think that is the designed behaviour, so it is not "a problem" at
all, and an example that makes them come from two different sources
of configuration is a red herring.  The parser faithfully implement
the policy that the combination is invalid.

The "problem" is in the policy itself, which you address below.

> There is no need to prevent combinations in config.c, in any case
> core.autocrlf overrides core.eol.

So

        Even though the configuration parser errors out when
        core.autocrlf is set to 'input' when core.eol is set to
        'crlf', there is no need to do so, because the core.autocrlf
        setting trumps core.eol.

or something like that, perhaps?

> Allow all combinations of core.crlf and core.eol and document
> that core.autocrlf overrides core.eol.

That is a good change.

> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>  Documentation/config.txt | 6 +++---
>  config.c                 | 4 ----
>  2 files changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 2cd6bdd..4a27ad4 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -337,9 +337,9 @@ core.quotePath::
> =20
>  core.eol::
>  	Sets the line ending type to use in the working directory for
> -	files that have the `text` property set.  Alternatives are
> -	'lf', 'crlf' and 'native', which uses the platform's native
> -	line ending.  The default value is `native`.  See
> +	files that have the `text` property set when core.autocrlf is false=
=2E
> +	Alternatives are 'lf', 'crlf' and 'native', which uses the platform=
's
> +	native line ending.  The default value is `native`.  See
>  	linkgit:gitattributes[5] for more information on end-of-line
>  	conversion.
> =20
> diff --git a/config.c b/config.c
> index 9ba40bc..a6adc8b 100644
> --- a/config.c
> +++ b/config.c
> @@ -803,8 +803,6 @@ static int git_default_core_config(const char *va=
r, const char *value)
> =20
>  	if (!strcmp(var, "core.autocrlf")) {
>  		if (value && !strcasecmp(value, "input")) {
> -			if (core_eol =3D=3D EOL_CRLF)
> -				return error("core.autocrlf=3Dinput conflicts with core.eol=3Dcr=
lf");
>  			auto_crlf =3D AUTO_CRLF_INPUT;
>  			return 0;
>  		}
> @@ -830,8 +828,6 @@ static int git_default_core_config(const char *va=
r, const char *value)
>  			core_eol =3D EOL_NATIVE;
>  		else
>  			core_eol =3D EOL_UNSET;
> -		if (core_eol =3D=3D EOL_CRLF && auto_crlf =3D=3D AUTO_CRLF_INPUT)
> -			return error("core.autocrlf=3Dinput conflicts with core.eol=3Dcrl=
f");
>  		return 0;
>  	}
