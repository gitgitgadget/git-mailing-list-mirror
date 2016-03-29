From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] submodule update: align reporting path for custom command execution
Date: Tue, 29 Mar 2016 16:57:19 -0700
Message-ID: <xmqqfuv8vnvk.fsf@gitster.mtv.corp.google.com>
References: <1459292558-5840-1-git-send-email-sbeller@google.com>
	<1459292558-5840-5-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jacob.keller@gmail.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 01:57:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al3Vn-00059O-64
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 01:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756938AbcC2X5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 19:57:23 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:57433 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753174AbcC2X5W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 19:57:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 91D6351772;
	Tue, 29 Mar 2016 19:57:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WYsNdSA+S1ZTyM0TT4Xgw96m5sg=; b=kTVj1Q
	pIqXHq6eX387Y6ZlnJxbTGNKcKpZ856dEaeRWdy+YX37slzJW9DqsDSK77CMaROO
	QBEK5wcPtkuceA9hdFHCgJYuPsTnFRwIcuggfobToksSttaQqvTGdIjKwf7uotl+
	o3nRKb/0106Mc/WnwSwQ/h2sMmtVReU+aTY/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WrsxVzeLMoelq/gVD/kHO29jc3CnUj8Q
	U2Y//s9A9m4R5yNE+umGEwR0kVAPvbUf3mpTnXDSJexyzgiGSUt/+f2xtbagT8oG
	wAEY0UtvmlQi6agXKOCgBPHJ64ebnFvG8FGhitw6F4WSvcXymSKh400KccrJf0gs
	sn047/RoZNs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 89D4C51771;
	Tue, 29 Mar 2016 19:57:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 08EEE51770;
	Tue, 29 Mar 2016 19:57:20 -0400 (EDT)
In-Reply-To: <1459292558-5840-5-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 29 Mar 2016 16:02:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F9C8E688-F609-11E5-B1B1-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290229>

Stefan Beller <sbeller@google.com> writes:

> In the predefined actions (merge, rebase, none, checkout), we use
> the display path, which is relative to the current working directory.
> Also use the display path when running a custom command.

Very sensible.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  git-submodule.sh            |  4 ++--
>  t/t7406-submodule-update.sh | 29 ++++++++++++++++++++++++++---
>  2 files changed, 28 insertions(+), 5 deletions(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 11ed32a..be2a2b5 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -803,8 +803,8 @@ Maybe you want to use 'update --init'?")"
>  				;;
>  			!*)
>  				command="${update_module#!}"
> -				die_msg="$(eval_gettext "Execution of '\$command \$sha1' failed in submodule path '\$prefix\$sm_path'")"
> -				say_msg="$(eval_gettext "Submodule path '\$prefix\$sm_path': '\$command \$sha1'")"
> +				die_msg="$(eval_gettext "Execution of '\$command \$sha1' failed in submodule path '\$displaypath'")"
> +				say_msg="$(eval_gettext "Submodule path '\$displaypath': '\$command \$sha1'")"
>  				must_die_on_failure=yes
>  				;;
>  			*)
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index 9a4ba41..f062065 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -344,16 +344,39 @@ test_expect_success 'submodule update - command in .git/config' '
>  	)
>  '
>  
> +cat << EOF >expect
> +Execution of 'false $submodulesha1' failed in submodule path 'submodule'
> +EOF
> +
>  test_expect_success 'submodule update - command in .git/config catches failure' '
>  	(cd super &&
>  	 git config submodule.submodule.update "!false"
>  	) &&
>  	(cd super/submodule &&
> -	  git reset --hard HEAD^
> +	  git reset --hard $submodulesha1^
>  	) &&
>  	(cd super &&
> -	 test_must_fail git submodule update submodule
> -	)
> +	 test_must_fail git submodule update submodule 2>../actual
> +	) &&
> +	test_cmp actual expect
> +'
> +
> +cat << EOF >expect
> +Execution of 'false $submodulesha1' failed in submodule path '../submodule'
> +EOF
> +
> +test_expect_success 'submodule update - command in .git/config catches failure -- subdirectory' '
> +	(cd super &&
> +	 git config submodule.submodule.update "!false"
> +	) &&
> +	(cd super/submodule &&
> +	  git reset --hard $submodulesha1^
> +	) &&
> +	(cd super &&
> +	 mkdir tmp && cd tmp &&
> +	 test_must_fail git submodule update ../submodule 2>../../actual
> +	) &&
> +	test_cmp actual expect
>  '
>  
>  test_expect_success 'submodule init does not copy command into .git/config' '
