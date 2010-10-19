From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] builtins: check for startup_info->help, print and
 exit early
Date: Tue, 19 Oct 2010 09:33:07 -0700
Message-ID: <7vvd4y16t8.fsf@alter.siamese.dyndns.org>
References: <1287495320-27278-1-git-send-email-pclouds@gmail.com>
 <1287495320-27278-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 18:33:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8F7p-0005R8-Ty
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 18:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755605Ab0JSQdQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Oct 2010 12:33:16 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49332 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755566Ab0JSQdQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Oct 2010 12:33:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FB77E0F91;
	Tue, 19 Oct 2010 12:33:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=McdgDIaXqia3
	2VeinwevpZevXoQ=; b=lBBobpzPa3nkLHaUSgTAM19j7d2QH3I73cnSITCo/M3I
	m+Ogb7XHZD2v/6fpHkwBk0v65+kMHPBbo1ZvOhk/j0s+2GSIrbFS8KG1p4cxN0BT
	WQDdRUxSUAHb8RlRHxknHZdsoJy9dFCp0+VRW2ysdO4xrD9zUyaLGZHtpnXOLiw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=tp6LTT
	/Y6FBg3/fAoAQZzJg2dUfoqv7qU2gfrHfxKmCWPMEqYpex6rwvra4+LOpwOcuueJ
	GjRUpgXLlu6czXuLz5cYT9dI+YZEURHiJch7uvMzKYTUU2VWPiSZzEv/qsEggfV9
	0uyDl7B5F59uESsTEbekWFuj4Y+jSjwc6yCE0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 68AFBE0F90;
	Tue, 19 Oct 2010 12:33:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4EFFBE0F8E; Tue, 19 Oct
 2010 12:33:09 -0400 (EDT)
In-Reply-To: <1287495320-27278-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Tue\, 19 Oct
 2010 20\:35\:20 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 90BC42C4-DB9E-11DF-977A-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159336>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> These commands need more than just git_config() before parsing
> commmand line arguments. Some of these activities will unconditionall=
y
> look into a repository. When startup_info->help is TRUE, no repositor=
y
> is set up and the caller expects callees to print help usage and exit=
,
> no more.
>
> Do as expected.
> ---

No sign-off given to any of the three patches...

> diff --git a/builtin/branch.c b/builtin/branch.c
> index 87976f0..9f152ed 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -667,6 +667,9 @@ int cmd_branch(int argc, const char **argv, const=
 char *prefix)
>  		OPT_END(),
>  	};
> =20
> +	if (startup_info->help)
> +		usage_with_options(builtin_branch_usage, options);
> +
>  	git_config(git_branch_config, NULL);

I can just say:

    $ cd / && git branch -h
    usage: git branch [options] ...

without your patch just fine (and no I am not insane to make / controll=
ed
by git).

The same for checkout-index, commit, ls-files, etc.

> diff --git a/builtin/gc.c b/builtin/gc.c
> index c304638..f040171 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -191,6 +191,9 @@ int cmd_gc(int argc, const char **argv, const cha=
r *prefix)
> =20
>  	git_config(gc_config, NULL);
> =20
> +	if (startup_info->help)
> +		usage_with_options(builtin_gc_usage, builtin_gc_options);
> +
>  	if (pack_refs < 0)
>  		pack_refs =3D !is_bare_repository();

This one is curious.  Why do you need a call to git_config() in "gc" on=
ly?
You don't do that for e.g. "branch".

While I do not see anything glaringly wrong with this change, I am not
sure I am getting the point of these patches.
