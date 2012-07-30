From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve tests for detached worktree in git-submodule
Date: Mon, 30 Jul 2012 10:02:04 -0700
Message-ID: <7v6295rxmb.fsf@alter.siamese.dyndns.org>
References: <1343664610-479-1-git-send-email-dangra@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Daniel =?utf-8?Q?Gra=C3=B1a?= <dangra@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 19:02:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvtMF-0006zu-O3
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 19:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754126Ab2G3RCJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jul 2012 13:02:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57417 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753932Ab2G3RCI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jul 2012 13:02:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B351A91ED;
	Mon, 30 Jul 2012 13:02:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=r8Le9qTZxq45
	AMdf06mZ3OSa+VQ=; b=f4OQrFNPPrrSdX0Bd12zIOW1ObiNaAAujWDRPUAhH40H
	DIp7QjnWsUswLqdOTdIJF9Pakjcw2c1oqO5NxIMq/VYqlVxEGKZQRwbzpQ3NbepE
	lnEqHhTQVCNtglHF+LpjCgM7b/nxYPyMewE2HscU+Fl5jDucsXWy/J7x6YELTsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=XW1so7
	jPJf+AK+kxKU8QJsR4FuxQEVZyGLQ+ULBOXtl6eotyBRwX59x35Zw2C8gRk+4R7w
	PAWz/je6lzmLmrSEbDLUXTTUO8/lvWLhLMLU+bap6Lm+gR3ZihBEiRkR9Nd/Pm02
	tF3s0BUsKw8o2iRIuPiEpIoLCYa8AJizgxwMY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A06B391EC;
	Mon, 30 Jul 2012 13:02:07 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BFFE391EB; Mon, 30 Jul 2012
 13:02:06 -0400 (EDT)
In-Reply-To: <1343664610-479-1-git-send-email-dangra@gmail.com> ("Daniel
 =?utf-8?Q?Gra=C3=B1a=22's?= message of "Mon, 30 Jul 2012 13:10:10 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4B05B16E-DA68-11E1-927A-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202582>

Daniel Gra=C3=B1a <dangra@gmail.com> writes:

> Signed-off-by: Daniel Gra=C3=B1a <dangra@gmail.com>
> ---
>  t/t7409-submodule-detached-worktree.sh |   31 ++++++++++++++++++++++=
++-------
>  1 files changed, 24 insertions(+), 7 deletions(-)
>
> diff --git a/t/t7409-submodule-detached-worktree.sh b/t/t7409-submodu=
le-detached-worktree.sh
> index db75642..d88f400 100755
> --- a/t/t7409-submodule-detached-worktree.sh
> +++ b/t/t7409-submodule-detached-worktree.sh
> @@ -15,7 +15,11 @@ TEST_NO_CREATE_REPO=3D1
>  test_expect_success 'submodule on detached working tree' '
>  	git init --bare remote &&
>  	test_create_repo bundle1 &&
> -	(cd bundle1 && test_commit "shoot") &&
> +	(
> +		cd bundle1 &&
> +		test_commit "shoot" &&
> +		git rev-list --max-count=3D1 HEAD > "$TRASH_DIRECTORY/expect"

Better written as

	git rev-parse --verify HEAD >../expect

methinks.

> +	) &&
>  	mkdir home &&
>  	(
>  		cd home &&
> @@ -23,14 +27,27 @@ test_expect_success 'submodule on detached workin=
g tree' '
>  		git clone --bare ../remote .dotfiles &&
>  		git submodule add ../bundle1 .vim/bundle/sogood &&
>  		test_commit "sogood" &&
> +		(
> +			unset GIT_WORK_TREE GIT_DIR &&
> +			cd .vim/bundle/sogood &&
> +			git rev-list --max-count=3D1 HEAD > actual &&
> +			test_cmp actual "$TRASH_DIRECTORY/expect"

Likewise.

	git rev-parse --verify HEAD >actual &&
        test_cmp ../expect actual

As test_cmp turns into "diff -u", comparing expect against actual
(instead of the other way around) shows the deviation in a more
readable way when your test fails.

> +		) &&
>  		git push origin master
> -	) &&
> +	)
>  	mkdir home2 &&
>  	(
>  		cd home2 &&
> -		export GIT_WORK_TREE=3D"$(pwd)" GIT_DIR=3D"$(pwd)/.dotfiles" &&
>  		git clone --bare ../remote .dotfiles &&
> -		git submodule update --init
> +		export GIT_WORK_TREE=3D"$(pwd)" GIT_DIR=3D"$(pwd)/.dotfiles" &&

So you used to clone with the two environment variables in effect to
create the .otfiles, but now you don't use them while cloning.  That
makes more sense to me, especially the .otfiles is created "bare".

> +		git checkout master &&

So you populate the newly created home2 working tree out of the .otfile=
s
repository in it.

> +		git submodule update --init &&
> +		(
> +			unset GIT_WORK_TREE GIT_DIR &&
> +			cd .vim/bundle/sogood &&
> +			git rev-list --max-count=3D1 HEAD > actual &&
> +			test_cmp actual "$TRASH_DIRECTORY/expect"

Likewise.

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

Is the "existence" the only thing you care about?  That's not all
that different from the old test that only checked the existence of
the directory dupe, no?

>  	)
>  '
