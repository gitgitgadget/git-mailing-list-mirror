From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] checkout: verify new branch name's validity early
Date: Mon, 27 Aug 2012 20:55:17 -0700
Message-ID: <7vr4qroel6.fsf@alter.siamese.dyndns.org>
References: <1346120981-27234-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, =?utf-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 28 05:55:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6Ctq-0000yG-8U
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 05:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389Ab2H1DzV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Aug 2012 23:55:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64682 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750894Ab2H1DzU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Aug 2012 23:55:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 756709321;
	Mon, 27 Aug 2012 23:55:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=qMLKos3DVcUL
	wigsLOGfGQJ14ns=; b=Yd7hrVqM/r/ZxlEHY5i48ItwM/N5jnQFb66p5Uib48Du
	0fctWG+SJPxmViwGYteInbQzO7iVT8NG2y+bJQOFxt1j9NyyB7Ct5wcgZImUE82v
	99j6ClAnYe43yaIxAFegOp4AuE4LnCp24+dDdxmYPRcqTHrHee7AKUZYDiSHTXY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=u0kUI/
	4BlB9QhMk6l9p32zId/hkc9LZR4WY6o7Svr8TI2x/uL6GrHeQdIjKV482qDFZNbV
	jdjIsXvnf3KGbJtzCq0UXVYXkJoOWP96XRvKGWcRlegDUJcAwtr0xV/Kq3+LgQ57
	AOGOgAG5kPQRB5EQB7JDS++M2CyqmQdM4Eg7U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 60D8C9320;
	Mon, 27 Aug 2012 23:55:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 90CDC931F; Mon, 27 Aug 2012
 23:55:18 -0400 (EDT)
In-Reply-To: <1346120981-27234-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 28 Aug
 2012 09:29:41 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2EB9C794-F0C4-11E1-9850-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204399>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> If the new branch name to -b/-B happens to be missing, the next
> argument may be mistaken as branch name and no longer recognized by
> checkout as argument. This may lead to confusing error messages.
>
> By checking branch name early and printing out the invalid name, user=
s
> may realize they forgot to specify branch name.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  On Tue, Aug 28, 2012 at 12:03 AM, Junio C Hamano <gitster@pobox.com>=
 wrote:
>  > Ideally you would want
>  >
>  >         fatal: "-t" is not an acceptable name for a branch
>  >
>  > in this case; if it is cumbersome to arrange, at the very least,
>  >
>  >         updating paths is incompatible with checking out the branc=
h "-t".
>  >
>  > would be clearer.
>
>  Fair enough. It turns out we do check branch name's validity. It's
>  just too late.

The surrounding code is somewhat tricky and the code structure is
brittle; there are places that update the opts.new_branch so the new
location of this check has to be after them, and there is one
codepath that having a bad value in it does not matter.

I had to check the code outside the context of this patch a few
times to convince myself that this patch does not break them.  I'll
queue the patch as-is for now, but we probably would want to see how
we can structure it to be less brittle.

Thanks.

>  builtin/checkout.c         | 20 ++++++++++----------
>  t/t2018-checkout-branch.sh |  5 +++++
>  2 files changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index d812219..03b0f25 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1049,6 +1049,16 @@ int cmd_checkout(int argc, const char **argv, =
const char *prefix)
>  	if (opts.track =3D=3D BRANCH_TRACK_UNSPECIFIED)
>  		opts.track =3D git_branch_track;
> =20
> +	if (opts.new_branch) {
> +		struct strbuf buf =3D STRBUF_INIT;
> +
> +		opts.branch_exists =3D validate_new_branchname(opts.new_branch, &b=
uf,
> +							     !!opts.new_branch_force,
> +							     !!opts.new_branch_force);
> +
> +		strbuf_release(&buf);
> +	}
> +
>  	if (argc) {
>  		const char **pathspec =3D get_pathspec(prefix, argv);
> =20
> @@ -1079,16 +1089,6 @@ int cmd_checkout(int argc, const char **argv, =
const char *prefix)
>  	if (patch_mode)
>  		return interactive_checkout(new.name, NULL, &opts);
> =20
> -	if (opts.new_branch) {
> -		struct strbuf buf =3D STRBUF_INIT;
> -
> -		opts.branch_exists =3D validate_new_branchname(opts.new_branch, &b=
uf,
> -							     !!opts.new_branch_force,
> -							     !!opts.new_branch_force);
> -
> -		strbuf_release(&buf);
> -	}
> -
>  	if (new.name && !new.commit) {
>  		die(_("Cannot switch branch to a non-commit."));
>  	}
> diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
> index 2741262..48ab6a2 100755
> --- a/t/t2018-checkout-branch.sh
> +++ b/t/t2018-checkout-branch.sh
> @@ -198,4 +198,9 @@ test_expect_success 'checkout -B to the current b=
ranch works' '
>  	test_dirty_mergeable
>  '
> =20
> +test_expect_success 'checkout -b checks branch validitity early' '
> +	test_must_fail git checkout -b -t origin/master 2>err &&
> +	grep "not a valid branch name" err
> +'
> +
>  test_done
