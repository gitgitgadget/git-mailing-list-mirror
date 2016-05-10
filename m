From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 3/3] submodule: ensure that -c http.extraheader is heeded
Date: Tue, 10 May 2016 10:38:03 -0700
Message-ID: <xmqqzirxq0ec.fsf@gitster.mtv.corp.google.com>
References: <cover.1462774709.git.johannes.schindelin@gmx.de>
	<cover.1462863934.git.johannes.schindelin@gmx.de>
	<1b3d7bde2b92da7722ae46a2f76ccedf532ce35e.1462863934.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 10 19:38:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0Bbp-0002xZ-EB
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 19:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbcEJRiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 13:38:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51955 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751144AbcEJRiH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 13:38:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4DED819EB3;
	Tue, 10 May 2016 13:38:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ist8pn77kxZOOEIHtRj6LkOWGDU=; b=yJkE+B
	CQdciw10c5pchVHoWP7PKkPEoNZIChKaytEMiimo5vmnQnBlLrvTLwtebE77opRT
	hPLnNfiA/zlyJBrAuTf7nCVZ3BDIcezm5QIhaeJt/KQeEVKBRpQbfUvBc28vfE32
	/qpvKpn+Ck1qd3dsRESveRwtTS+Uz/pq9R2Ws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hO4x8hEio1PLxF6furoYOoFx/SSQKIt1
	UUYPk1lBuaw8lMrdyL2OJrvz6eGbdO95Jue78AcLAOSmcYhshaGrNuDJMdvP2ELF
	bxj3qBKhv51rgPiX+UVZPlO8V873ZbFjjQnWSw3vY6yOgKUnHpFJPmCKzIKiOYi2
	V+KaTDLDKmU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4717C19EB2;
	Tue, 10 May 2016 13:38:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B0F3C19EB1;
	Tue, 10 May 2016 13:38:05 -0400 (EDT)
In-Reply-To: <1b3d7bde2b92da7722ae46a2f76ccedf532ce35e.1462863934.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Tue, 10 May 2016 09:08:56 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F3E8E85C-16D5-11E6-9AE2-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294164>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> To support this developer's use case of allowing build agents token-based
> access to private repositories, we introduced the http.extraheader
> feature, allowing extra HTTP headers to be sent along with every HTTP
> request.
>
> This patch verifies that we can configure these extra HTTP headers via the
> command-line for use with `git submodule update`, too. Example: git -c
> http.extraheader="Secret: Sauce" submodule update --init
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Applying this directly on top of the other two fails, and when
merged with jk/submodule-c-credential, the test passes.

Which is exactly what we expect to see.  Nice.

I'll merge jk/submodule-c-credential into js/http-custom-headers
that already has 1 & 2, and then apply this.  An alternative would
be to hold this and wait until both jk/submodule-c-credential and
js/http-custom-headers with 1 & 2 graduates and then apply this,
which is a lot inferior option.

Thanks.

>  t/t5551-http-fetch-smart.sh | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> index 43b257e..2f375eb 100755
> --- a/t/t5551-http-fetch-smart.sh
> +++ b/t/t5551-http-fetch-smart.sh
> @@ -287,7 +287,16 @@ test_expect_success 'custom http headers' '
>  		fetch "$HTTPD_URL/smart_headers/repo.git" &&
>  	git -c http.extraheader="x-magic-one: abra" \
>  	    -c http.extraheader="x-magic-two: cadabra" \
> -	    fetch "$HTTPD_URL/smart_headers/repo.git"
> +	    fetch "$HTTPD_URL/smart_headers/repo.git" &&
> +	git update-index --add --cacheinfo 160000,$(git rev-parse HEAD),sub &&
> +	git config -f .gitmodules submodule.sub.path sub &&
> +	git config -f .gitmodules submodule.sub.url \
> +		"$HTTPD_URL/smart_headers/repo.git" &&
> +	git submodule init sub &&
> +	test_must_fail git submodule update sub &&
> +	git -c http.extraheader="x-magic-one: abra" \
> +	    -c http.extraheader="x-magic-two: cadabra" \
> +		submodule update sub
>  '
>  
>  stop_httpd
