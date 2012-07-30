From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve tests for detached worktree in git-submodule
Date: Mon, 30 Jul 2012 11:09:45 -0700
Message-ID: <7vfw89qfx2.fsf@alter.siamese.dyndns.org>
References: <7vsjc9qh33.fsf@alter.siamese.dyndns.org>
 <1343670719-3635-1-git-send-email-dangra@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Daniel =?utf-8?Q?Gra=C3=B1a?= <dangra@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 20:09:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvuPj-0001Fb-LJ
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 20:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754567Ab2G3SJt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jul 2012 14:09:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58591 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754528Ab2G3SJt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jul 2012 14:09:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C97E8339;
	Mon, 30 Jul 2012 14:09:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+TdxjGbV64mu
	+amj+KZf30zLM7s=; b=Q+UDw3/MpPNSugPu97WYBadLct87TmVTKztTS/28dtdg
	tmpLBGNTskmjC9SDxFouu5A39dpqMsy+jpxAwYxvOPLn+d8JXzVwiVal4I75A28O
	DnZjwvnsfNRvoWC9ZMJAE+3lrLHpzLE6VfGFZ5PmKl5zNh/23u1JHJAco5oZ35E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Z0cVxP
	C9yaCJ3pbJ9SYzjUTDRrJT5ylRN1ncgnHEsqBL+t7/UbtddP0FPwaMgJ7YGYCJOw
	r7bNzuZZHBiRix57COLbqqjJ3IeEPQX0csE6jBXKgbzzo6OkvV8SjS7YbERTEBP7
	9X9WQImLH2gqa7/cmA+cwxzgrzwXN7aYyGSHQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08C3C8338;
	Mon, 30 Jul 2012 14:09:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5DAE28337; Mon, 30 Jul 2012
 14:09:47 -0400 (EDT)
In-Reply-To: <1343670719-3635-1-git-send-email-dangra@gmail.com> ("Daniel
 =?utf-8?Q?Gra=C3=B1a=22's?= message of "Mon, 30 Jul 2012 14:51:59 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BF5396C2-DA71-11E1-AED3-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202599>

Daniel Gra=C3=B1a <dangra@gmail.com> writes:

> * Check submodule is correctly initialized and updated after cloning =
=2Edotfiles
>
> Signed-off-by: Daniel Gra=C3=B1a <dangra@gmail.com>
> ---

Thanks.

> @@ -23,14 +27,27 @@ test_expect_success 'submodule on detached workin=
g tree' '
>  		git clone --bare ../remote .dotfiles &&
>  		git submodule add ../bundle1 .vim/bundle/sogood &&
>  		test_commit "sogood" &&
> +		(
> +			unset GIT_WORK_TREE GIT_DIR &&
> +			cd .vim/bundle/sogood &&
> +			git rev-parse --verify HEAD >actual &&
> +			test_cmp ../../../../expect actual
> +		) &&
>  		git push origin master
> -	) &&
> +	)

I do not think you meant to break the && chain here on purpose.
I'll queue with a minor fix-up here.

>  	mkdir home2 &&
>  	(
>  		cd home2 &&
> -		export GIT_WORK_TREE=3D"$(pwd)" GIT_DIR=3D"$(pwd)/.dotfiles" &&
>  		git clone --bare ../remote .dotfiles &&
> -		git submodule update --init
> +		export GIT_WORK_TREE=3D"$(pwd)" GIT_DIR=3D"$(pwd)/.dotfiles" &&
> +		git checkout master &&
> +		git submodule update --init &&
> +		(
> +			unset GIT_WORK_TREE GIT_DIR &&
> +			cd .vim/bundle/sogood &&
> +			git rev-parse --verify HEAD >actual &&
> +			test_cmp ../../../../expect actual
> +		)
>  	)
>  '
> =20
> @@ -42,6 +59,7 @@ test_expect_success 'submodule on detached working =
pointed by core.worktree' '
>  		git clone --bare ../remote "$GIT_DIR" &&
>  		git config core.bare false &&
>  		git config core.worktree .. &&
> +		git checkout master &&
>  		git submodule add ../bundle1 .vim/bundle/dupe &&
>  		test_commit "dupe" &&
>  		git push origin master
> @@ -52,9 +70,8 @@ test_expect_success 'submodule on detached working =
pointed by core.worktree' '
>  		git config core.bare false &&
>  		git config core.worktree .. &&
>  		git pull &&
> -		git submodule update &&
> -		git submodule status &&
> -		test -d .vim/bundle/dupe
> +		git submodule update --init &&
> +		test -e .vim/bundle/dupe/shoot.t
>  	)
>  '
