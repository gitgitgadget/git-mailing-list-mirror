From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCHv4] submodule update: allow custom update command
Date: Wed, 03 Jul 2013 10:17:50 -0700
Message-ID: <7v4ncbh8ap.fsf@alter.siamese.dyndns.org>
References: <51D3064C.80901@web.de>
	<1372842122-15568-1-git-send-email-judge.packham@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, iveqy@iveqy.com,
	stefan.naewe@atlas-elektronik.com, hvoigt@hvoigt.net
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 19:18:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuQgt-0001UW-Kx
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 19:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755530Ab3GCRR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 13:17:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50708 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753169Ab3GCRRz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 13:17:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20FD82D18D;
	Wed,  3 Jul 2013 17:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vaDhWN4HSbJ7eBa5s4G71GFRuxk=; b=ZI99Eo
	Ee5MMw8pRZuAgV6hSDgyqEmg9M21HXmrYpbyfI74huoJ2UdcQLXzm/5wn/n7AHxE
	ICxPlS8bNY62pVyXXU1IGvoYXFHKafxfR1uNSsWim1g2XX3b+tMJUze9FX8HTeZG
	43xoRSRGC3sMdC2ieKqep7uJG4/nsUItWKHy0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=itU8p3bZtdyQvbS1k2n+5JTaFOol4LLJ
	/TRl4hEh5joQInTe2y3VlnBdxt1gsI5fO/B1RRAs4UpRyVnIaoFbF0ww6ChRT4Iu
	8ciQrh7BHbM5P5qzIRdHZZpLqwjjJwetoYTZfJFqlnBIP8tyqTTtAiA4nQ966i+n
	kdG5IEx1EsQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A62E72D18A;
	Wed,  3 Jul 2013 17:17:53 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 59C622D183;
	Wed,  3 Jul 2013 17:17:52 +0000 (UTC)
In-Reply-To: <1372842122-15568-1-git-send-email-judge.packham@gmail.com>
	(Chris Packham's message of "Wed, 3 Jul 2013 21:02:02 +1200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7E44E38C-E404-11E2-8E81-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229498>

Chris Packham <judge.packham@gmail.com> writes:

> Users can set submodule.$name.update to '!command' which will cause
> 'command' to be run instead of checkout/merge/rebase.  This allows the
> user some finer grained control over how the update is done. The primary
> motivation for this was interoperability with stgit however being able
> to intercept the submodule update process may prove useful for
> integrating with or extensions to other tools.
>
> Signed-off-by: Chris Packham <judge.packham@gmail.com>
> ---
> v4 adds a couple of simple tests - an equivalent of update=checkout and a test
> to make sure we detect a failure reported by the update command.

I think this can drop RFC/ now ;-)

Will replace what was queued and merge to 'next' unless I hear
otherwise within a few days.

Thanks.

>
>  Documentation/git-submodule.txt |  4 +++-
>  git-submodule.sh                |  6 ++++++
>  t/t7406-submodule-update.sh     | 29 +++++++++++++++++++++++++++++
>  3 files changed, 38 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index e576713..2f18f7d 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -159,7 +159,9 @@ update::
>  	This will make the submodules HEAD be detached unless `--rebase` or
>  	`--merge` is specified or the key `submodule.$name.update` is set to
>  	`rebase`, `merge` or `none`. `none` can be overridden by specifying
> -	`--checkout`.
> +	`--checkout`. Setting the key `submodule.$name.update` to `!command`
> +	will cause `command` to be run. `command` can be any arbitrary shell
> +	command that takes a single argument, namely the sha1 to update to.
>  +
>  If the submodule is not yet initialized, and you just want to use the
>  setting as stored in .gitmodules, you can automatically initialize the
> diff --git a/git-submodule.sh b/git-submodule.sh
> index eb58c8e..e7579f0 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -799,6 +799,12 @@ Maybe you want to use 'update --init'?")"
>  				say_msg="$(eval_gettext "Submodule path '\$prefix\$sm_path': merged in '\$sha1'")"
>  				must_die_on_failure=yes
>  				;;
> +			!*)
> +				command="${update_module#!}"
> +				die_msg="$(eval_gettext "Execution of '\$command \$sha1' failed in submodule  path '\$prefix\$sm_path'")"
> +				say_msg="$(eval_gettext "Submodule path '\$prefix\$sm_path': '\$command \$sha1'")"
> +				must_die_on_failure=yes
> +				;;
>  			*)
>  				command="git checkout $subforce -q"
>  				die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$prefix\$sm_path'")"
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index a4ffea0..48d1279 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -279,6 +279,35 @@ test_expect_success 'submodule update - checkout in .git/config' '
>  	)
>  '
>  
> +test_expect_success 'submodule update - command in .git/config' '
> +	(cd super &&
> +	 git config submodule.submodule.update "!git checkout"
> +	) &&
> +	(cd super/submodule &&
> +	  git reset --hard HEAD^
> +	) &&
> +	(cd super &&
> +	 (cd submodule &&
> +	  compare_head
> +	 ) &&
> +	 git submodule update submodule &&
> +	 cd submodule &&
> +	 ! compare_head
> +	)
> +'
> +
> +test_expect_success 'submodule update - command in .git/config catches failure' '
> +	(cd super &&
> +	 git config submodule.submodule.update "!false"
> +	) &&
> +	(cd super/submodule &&
> +	  git reset --hard HEAD^
> +	) &&
> +	(cd super &&
> +	 test_must_fail git submodule update submodule
> +	)
> +'
> +
>  test_expect_success 'submodule init picks up rebase' '
>  	(cd super &&
>  	 git config -f .gitmodules submodule.rebasing.update rebase &&
