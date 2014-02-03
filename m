From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP/PATCH 3/9] Teach checkout the --[no-]recurse-submodules option
Date: Mon, 03 Feb 2014 14:56:54 -0800
Message-ID: <xmqq8utrdcuh.fsf@gitster.dls.corp.google.com>
References: <xmqqd2k4hh4p.fsf@gitster.dls.corp.google.com>
	<52CC3E16.4060909@web.de>
	<xmqqvbxvekwv.fsf@gitster.dls.corp.google.com>
	<52EFF25E.6080306@web.de> <52EFF2EA.9060709@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Feb 03 23:57:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WASRr-0005ZF-3I
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 23:57:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752715AbaBCW47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 17:56:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41536 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751864AbaBCW46 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 17:56:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DD336955A;
	Mon,  3 Feb 2014 17:56:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=60TQx/DaAZ3wEfVgKiqI7jhXX5Q=; b=H150Zn
	GYigqo1eKJMfkxg5pf33ry+L5IcgnB9sA1Dfm1H7sPkpuwLYfcVDc4q0oi7ZU5oI
	Ml236NWwcFr599c8aShDTzcm9W+Dbfd/z6YYsohPg9wZu+MXxHa8SLdESznEwJlg
	fjRaKzzkpl7TAg7Aes0k4fENSuoL/SjEEg1Ss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X99g5ZMOjXXNnDmsWgQXTkEySemE7pUH
	pOrhhEtDOEFWAZhf44Dh6pVkjxDiHktI7eYLnRSxD0QOXOdIdHLBzx5BW8P3cPpA
	/WmAIIJMHXrAjG+e/dnMxsV7aUYC0uTPXksC2U0PVtQsvtkLBQuoshluAH+pbWLw
	EtnjuGNjmeA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65F3B69559;
	Mon,  3 Feb 2014 17:56:57 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A6EFA69558;
	Mon,  3 Feb 2014 17:56:56 -0500 (EST)
In-Reply-To: <52EFF2EA.9060709@web.de> (Jens Lehmann's message of "Mon, 03 Feb
	2014 20:50:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7B3A4A3A-8D26-11E3-8090-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241488>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> +	set_config_update_recurse_submodules(
> +		parse_update_recurse_submodules_arg("--recurse-submodules-default",
> +						    recurse_submodules_default),
> +		recurse_submodules);

I think I saw these exact lines in another patch.  Perhaps the whole
thing can become a helper function that lets the caller avoid typing
the whole long strings that needs a strange/unfortunate line break? 

> diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule.sh
> index 06b18f8..bc3e1ca 100755
> --- a/t/t2013-checkout-submodule.sh
> +++ b/t/t2013-checkout-submodule.sh
> @@ -4,17 +4,57 @@ test_description='checkout can handle submodules'
>
>  . ./test-lib.sh
>
> +submodule_creation_must_succeed() {

Style: SP before (), i.e.

	submodule_creation_must_succeed () {

> +	# checkout base ($1)
> +	git checkout -f --recurse-submodules $1 &&
> +	git diff-files --quiet &&
> +	git diff-index --quiet --cached $1 &&

Please make it a habit to quote a parameter that is intended not to
be split at $IFS (e.g. write these as "$1" not as $1).  Otherwise
the reader has to wonder if this can be called with a "foo bar" and
the expects it to be split into two.

> +	# checkout target ($2)
> +	if test -d submodule; then

Style: no semicolons in standard control structure, i.e.

	if test -d submodule
	then

> +		echo change>>submodule/first.t &&

Style: SP before but not after redirection operator, i.e.

	echo foo >>bar

> +submodule_removal_must_succeed() {

Likewise.

> +	# checkout base ($1)
> +	git checkout -f --recurse-submodules $1 &&

Likewise.

> +	echo first > file &&

Likewise.

> +test_expect_success '"checkout --recurse-submodules" replaces submodule with files' '
> +	git checkout -f base &&
> +	git checkout -b replace_submodule_with_dir &&
> +	git update-index --force-remove submodule &&
> +	rm -rf submodule/.git .gitmodules &&
> +	git add .gitmodules submodule/* &&
> +	git commit -m "submodule replaced" &&
> +	git checkout -f base &&
> +	git submodule update -f &&
> +	git checkout --recurse-submodules replace_submodule_with_dir &&
> +	test -d submodule &&
> +	! test -e submodule/.git &&
> +	test -f submodule/first.t &&
> +	test -f submodule/second.t
> +'

Hmmmm.  Is it sufficient for these files to just exist, or do we
want to make sure they have expected contents?

Thanks.
