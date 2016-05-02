From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/10] submodule deinit: send messages to stderr
Date: Mon, 02 May 2016 16:28:30 -0700
Message-ID: <xmqqpot4ox9d.fsf@gitster.mtv.corp.google.com>
References: <1461976845-18228-1-git-send-email-sbeller@google.com>
	<1461976845-18228-7-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 03 01:28:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axNGY-0008Lk-La
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 01:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbcEBX2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 19:28:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51107 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932260AbcEBX2d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 19:28:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AC48017BA5;
	Mon,  2 May 2016 19:28:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TFla9PWARuQxBW5mvHoDPIAXMi8=; b=p0Sc8C
	OanfyPPfbMzc88PytO+R8lSiJPERMuVg4YWfwJb+XEIuuppIW7hYUG/0LrS9qHPy
	dCb5nov5fmuAOGy0sX8ZCXlz0m+YjA/L8oZwRiC7cbe6aOo7uvZxO7MLjyV8tmRj
	Czz4mUqDg/eVwnN/FaAJNavRkl46635F1vYGE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SmPf596+ckPAhLZwagk44F5PGukin1cp
	UudIqlZkpESLJ/xlEbDB4rO56zFRTYEqfHU7TtIJjLtEXh7+BXYE3DJkq+f8suhd
	UWmS9ZdFV9W/BbD1cpb1PCkvSFZAZgyFhOq9BbIhhNpZoqRrXokoMouV1Zo7IPPn
	4T8WkibRu+U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A567217BA4;
	Mon,  2 May 2016 19:28:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D968F17BA2;
	Mon,  2 May 2016 19:28:31 -0400 (EDT)
In-Reply-To: <1461976845-18228-7-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 29 Apr 2016 17:40:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 952DF01E-10BD-11E6-A76E-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293304>

Stefan Beller <sbeller@google.com> writes:

> Reroute the output of stdout to stderr as it is just informative
> messages, not to be consumed by machines.
>
> This should not regress any scripts that try to parse the
> current output, as the output is already internationalized
> and therefore unstable.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Sounds sensible.

>  git-submodule.sh           |  8 ++++----
>  t/t7400-submodule-basic.sh | 20 ++++++++++----------
>  2 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index f4d500e..3f67f4e 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -452,11 +452,11 @@ cmd_deinit()
>  				die "$(eval_gettext "Submodule work tree '\$displaypath' contains local modifications; use '-f' to discard them")"
>  			fi
>  			rm -rf "$sm_path" &&
> -			say "$(eval_gettext "Cleared directory '\$displaypath'")" ||
> -			say "$(eval_gettext "Could not remove submodule work tree '\$displaypath'")"
> +			say >&2 "$(eval_gettext "Cleared directory '\$displaypath'")" ||
> +			say >&2 "$(eval_gettext "Could not remove submodule work tree '\$displaypath'")"
>  		fi
>  
> -		mkdir "$sm_path" || say "$(eval_gettext "Could not create empty submodule directory '\$displaypath'")"
> +		mkdir "$sm_path" || say >&2 "$(eval_gettext "Could not create empty submodule directory '\$displaypath'")"
>  
>  		# Remove the .git/config entries (unless the user already did it)
>  		if test -n "$(git config --get-regexp submodule."$name\.")"
> @@ -465,7 +465,7 @@ cmd_deinit()
>  			# the user later decides to init this submodule again
>  			url=$(git config submodule."$name".url)
>  			git config --remove-section submodule."$name" 2>/dev/null &&
> -			say "$(eval_gettext "Submodule '\$name' (\$url) unregistered for path '\$displaypath'")"
> +			say >&2 "$(eval_gettext "Submodule '\$name' (\$url) unregistered for path '\$displaypath'")"
>  		fi
>  	done
>  }
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index a6231f1..53644da 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -935,7 +935,7 @@ test_expect_success 'submodule deinit from subdirectory' '
>  	mkdir -p sub &&
>  	(
>  		cd sub &&
> -		git submodule deinit ../init >../output
> +		git submodule deinit ../init 2>../output
>  	) &&
>  	grep "\\.\\./init" output &&
>  	test -z "$(git config --get-regexp "submodule\.example\.")" &&
> @@ -948,7 +948,7 @@ test_expect_success 'submodule deinit . deinits all initialized submodules' '
>  	git submodule update --init &&
>  	git config submodule.example.foo bar &&
>  	git config submodule.example2.frotz nitfol &&
> -	git submodule deinit . >actual &&
> +	git submodule deinit . 2>actual &&
>  	test -z "$(git config --get-regexp "submodule\.example\.")" &&
>  	test -z "$(git config --get-regexp "submodule\.example2\.")" &&
>  	test_i18ngrep "Cleared directory .init" actual &&
> @@ -959,7 +959,7 @@ test_expect_success 'submodule deinit . deinits all initialized submodules' '
>  test_expect_success 'submodule deinit deinits a submodule when its work tree is missing or empty' '
>  	git submodule update --init &&
>  	rm -rf init example2/* example2/.git &&
> -	git submodule deinit init example2 >actual &&
> +	git submodule deinit init example2 2>actual &&
>  	test -z "$(git config --get-regexp "submodule\.example\.")" &&
>  	test -z "$(git config --get-regexp "submodule\.example2\.")" &&
>  	test_i18ngrep ! "Cleared directory .init" actual &&
> @@ -973,7 +973,7 @@ test_expect_success 'submodule deinit fails when the submodule contains modifica
>  	test_must_fail git submodule deinit init &&
>  	test -n "$(git config --get-regexp "submodule\.example\.")" &&
>  	test -f example2/.git &&
> -	git submodule deinit -f init >actual &&
> +	git submodule deinit -f init 2>actual &&
>  	test -z "$(git config --get-regexp "submodule\.example\.")" &&
>  	test_i18ngrep "Cleared directory .init" actual &&
>  	rmdir init
> @@ -985,7 +985,7 @@ test_expect_success 'submodule deinit fails when the submodule contains untracke
>  	test_must_fail git submodule deinit init &&
>  	test -n "$(git config --get-regexp "submodule\.example\.")" &&
>  	test -f example2/.git &&
> -	git submodule deinit -f init >actual &&
> +	git submodule deinit -f init 2>actual &&
>  	test -z "$(git config --get-regexp "submodule\.example\.")" &&
>  	test_i18ngrep "Cleared directory .init" actual &&
>  	rmdir init
> @@ -1000,7 +1000,7 @@ test_expect_success 'submodule deinit fails when the submodule HEAD does not mat
>  	test_must_fail git submodule deinit init &&
>  	test -n "$(git config --get-regexp "submodule\.example\.")" &&
>  	test -f example2/.git &&
> -	git submodule deinit -f init >actual &&
> +	git submodule deinit -f init 2>actual &&
>  	test -z "$(git config --get-regexp "submodule\.example\.")" &&
>  	test_i18ngrep "Cleared directory .init" actual &&
>  	rmdir init
> @@ -1008,17 +1008,17 @@ test_expect_success 'submodule deinit fails when the submodule HEAD does not mat
>  
>  test_expect_success 'submodule deinit is silent when used on an uninitialized submodule' '
>  	git submodule update --init &&
> -	git submodule deinit init >actual &&
> +	git submodule deinit init 2>actual &&
>  	test_i18ngrep "Submodule .example. (.*) unregistered for path .init" actual &&
>  	test_i18ngrep "Cleared directory .init" actual &&
> -	git submodule deinit init >actual &&
> +	git submodule deinit init 2>actual &&
>  	test_i18ngrep ! "Submodule .example. (.*) unregistered for path .init" actual &&
>  	test_i18ngrep "Cleared directory .init" actual &&
> -	git submodule deinit . >actual &&
> +	git submodule deinit . 2>actual &&
>  	test_i18ngrep ! "Submodule .example. (.*) unregistered for path .init" actual &&
>  	test_i18ngrep "Submodule .example2. (.*) unregistered for path .example2" actual &&
>  	test_i18ngrep "Cleared directory .init" actual &&
> -	git submodule deinit . >actual &&
> +	git submodule deinit . 2>actual &&
>  	test_i18ngrep ! "Submodule .example. (.*) unregistered for path .init" actual &&
>  	test_i18ngrep ! "Submodule .example2. (.*) unregistered for path .example2" actual &&
>  	test_i18ngrep "Cleared directory .init" actual &&
