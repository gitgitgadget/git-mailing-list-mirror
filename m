From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] worktree: fix "add -B"
Date: Mon, 15 Feb 2016 15:53:53 -0800
Message-ID: <xmqq8u2lo7hq.fsf@gitster.mtv.corp.google.com>
References: <20160215094154.GA11698@lanh>
	<1455543333-25814-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	kirill.likhodedov@jetbrains.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 00:54:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVSxr-0005PP-Ml
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 00:54:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127AbcBOXx4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2016 18:53:56 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59152 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752444AbcBOXxz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Feb 2016 18:53:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C6FA245AF5;
	Mon, 15 Feb 2016 18:53:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=BK61Ju3v/4Fo
	Poo1cN4iIuZwAMc=; b=sh/2CIeM8ApjD737Ywk8fwWNLYe6jvDojmiWCKBEAe3g
	Vt8CskZYmCUV9+AVS7R+7KyPAmwjpKoaTbeZ3q6n/kXCLuLfVezAtRyGB2zqCfqd
	U643gTo/zQiiCTq+TpNdA+wOqNEKxvFtBcvn4fLO/IdOK1L85UZAa9PaNyZlfkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=oWitBs
	aRzvr4j3mSAY0Erzaaw/sjEWYDj79NJnEilQI8kMZolPFKOyFNaQSvarUFv+oABy
	OrKLuUVF5frafFNC5kSDwRHBX4NAxq+v5V4zC2HCUfpzDB4zfPQoUNPiVl9nEZ8R
	BJeGosDdxI4Ik2SwCL9PqRveOGihK3vbJdZQg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BC07445AF3;
	Mon, 15 Feb 2016 18:53:54 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 39D8A45AF2;
	Mon, 15 Feb 2016 18:53:54 -0500 (EST)
In-Reply-To: <1455543333-25814-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 15
 Feb 2016 20:35:32 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5EC26772-D43F-11E5-96EF-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286292>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Current code does not update "symref" when -B is used. This string
> contains the new HEAD. Because it's empty "git worktree add -B" fails=
 at
> symbolic-ref step.
>
> Because branch creation is already done before calling add_worktree()=
,
> -B is equivalent to -b from add_worktree() point of view. We do not n=
eed
> the special case for -B.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Complete patch.
>
>  builtin/worktree.c      | 4 +---
>  t/t2025-worktree-add.sh | 8 ++++++++
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 475b958..6b9c946 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -201,9 +201,7 @@ static int add_worktree(const char *path, const c=
har *refname,
>  		die(_("'%s' already exists"), path);
> =20
>  	/* is 'refname' a branch or commit? */
> -	if (opts->force_new_branch) /* definitely a branch */
> -		;
> -	else if (!opts->detach && !strbuf_check_branch_ref(&symref, refname=
) &&
> +	if (!opts->detach && !strbuf_check_branch_ref(&symref, refname) &&
>  		 ref_exists(symref.buf)) { /* it's a branch */

Makes a reader wonder why the original thought it was OK to do
nothing when -B is given here.

What does symref.buf have at this point in the codeflow?  Will it
always an existing branch?  In what case can it be the name of a
branch that does not yet exist?

Thanks.

>  		if (!opts->force)
>  			die_if_checked_out(symref.buf);
> diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> index 0a804da..a4d36c0 100755
> --- a/t/t2025-worktree-add.sh
> +++ b/t/t2025-worktree-add.sh
> @@ -193,6 +193,14 @@ test_expect_success '"add" -B/--detach mutually =
exclusive' '
>  	test_must_fail git worktree add -B poodle --detach bamboo master
>  '
> =20
> +test_expect_success 'add -B' '
> +	git worktree add -B poodle bamboo2 master^ &&
> +	git -C bamboo2 symbolic-ref HEAD >actual &&
> +	echo refs/heads/poodle >expected &&
> +	test_cmp expected actual &&
> +	test_cmp_rev master^ poodle
> +'
> +
>  test_expect_success 'local clone from linked checkout' '
>  	git clone --local here here-clone &&
>  	( cd here-clone && git fsck )
