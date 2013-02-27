From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] describe: Exclude --all --match=PATTERN
Date: Wed, 27 Feb 2013 12:20:07 -0800
Message-ID: <7v1uc1jyq0.fsf@alter.siamese.dyndns.org>
References: <20130225053152.GI5688@biohazard-cafe.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Greg Price <price@MIT.EDU>
X-From: git-owner@vger.kernel.org Wed Feb 27 21:20:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAnUW-0007yg-6A
	for gcvg-git-2@plane.gmane.org; Wed, 27 Feb 2013 21:20:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754541Ab3B0UUN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Feb 2013 15:20:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53459 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752945Ab3B0UUL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Feb 2013 15:20:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42573B43C;
	Wed, 27 Feb 2013 15:20:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ONhmXeklWyw/
	ObfFZ3boEZ+wN0Y=; b=ZeMT25Ps8+T1KnslQo0UcRravJsfJwFpsKFsmLcHnsC8
	9fcRw5mJIpQLWx+TqER7FiCtObNCFTU75J+t0dcrdWTokK/XkMX9nZEmbHD/q+1X
	kUwZMvqLlNDxrX/U9HCZpjlpvO9FD8Z27DLcMQm4kVBLUSmQZnTwoJmCOhla0n8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=P60JFe
	jCvRofHql6Q8SHhC2Qy83O5NI9mksUqMiPmEVhbjuST/Xjifnk323rce5au7Jvni
	Vp2f1/v4ROnKK8T3GtGjPHyRLW0Ru+Jq0xk3XvO/+eUFUMR21U5tsNhs86BqlyxN
	DQZr/3QSO4sZWvwQENLuM6Ld0uOv+UFBWVjMA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 352A7B43A;
	Wed, 27 Feb 2013 15:20:10 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7E907B42F; Wed, 27 Feb 2013
 15:20:09 -0500 (EST)
In-Reply-To: <20130225053152.GI5688@biohazard-cafe.mit.edu> (Greg Price's
 message of "Mon, 25 Feb 2013 00:31:52 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1547BEAA-811B-11E2-B6A2-2B642E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217222>

Greg Price <price@MIT.EDU> writes:

> Currently when --all is passed, the effect of --match is only
> to demote non-matching tags to be treated like non-tags.  This
> is puzzling behavior and not consistent with the documentation,
> especially with the suggested usage of avoiding information leaks.
> The combination of --all and --match is an oxymoron anyway, so
> just forbid it.

I am not sure if this is (1) "behaviour is sometimes useful in
narrow cases but is not explained well", (2) "behaviour does not
make sense in any situation", or (3) "the combination can make sense
if corrected, but the current behaviour is buggy".  If it is (2) or
(3), I think it makes sense to forbid the combination. Also, if it
is (3), we should later come up with an improved behaviour and then
re-enable the combination.

Without "--all" the command considers only the annotated tags to
base the descripion on, and with "--all", a ref that is not
annotated tags can be used as a base, but with a lower priority (if
an annotated tag can describe a given commit, that tag is used).

So na=C3=AFvely I would expect "--all" and "--match" to base the
description on refs that match the pattern without limiting the
choice of base to annotated tags, and refs that do not match the
given pattern should not appear even as the last resort.  It appears
to me that the current situation is (3).

Will queue and cook in 'next'; thanks.

>
> Signed-off-by: Greg Price <price@mit.edu>
> ---
> This should be applied after the preceding patch; I mistakenly omitte=
d
> the '1/2' in its subject line.
>
>  Documentation/git-describe.txt | 3 ++-
>  builtin/describe.c             | 3 +++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-describe.txt b/Documentation/git-descr=
ibe.txt
> index 711040d..fd5d8f2 100644
> --- a/Documentation/git-describe.txt
> +++ b/Documentation/git-describe.txt
> @@ -83,7 +83,8 @@ OPTIONS
>  --match <pattern>::
>  	Only consider tags matching the given `glob(7)` pattern,
>  	excluding the "refs/tags/" prefix.  This can be used to avoid
> -	leaking private tags from the repository.
> +	leaking private tags from the repository.  This option is
> +	incompatible with `--all`.
> =20
>  --always::
>  	Show uniquely abbreviated commit object as fallback.
> diff --git a/builtin/describe.c b/builtin/describe.c
> index 04c185b..90a72af 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -435,6 +435,9 @@ int cmd_describe(int argc, const char **argv, con=
st char *prefix)
>  	if (longformat && abbrev =3D=3D 0)
>  		die(_("--long is incompatible with --abbrev=3D0"));
> =20
> +	if (pattern && all)
> +		die(_("--match is incompatible with --all"));
> +
>  	if (contains) {
>  		const char **args =3D xmalloc((7 + argc) * sizeof(char *));
>  		int i =3D 0;
