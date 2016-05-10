From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] worktree: simplify prefixing paths
Date: Tue, 10 May 2016 16:07:11 -0700
Message-ID: <xmqqvb2lldgg.fsf@gitster.mtv.corp.google.com>
References: <20160510141416.GA22672@lanh>
	<20160510141553.22967-1-pclouds@gmail.com>
	<20160510141553.22967-7-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	rethab.ch@gmail.com, rappazzo@gmail.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 11 01:07:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0GkN-0005zm-U6
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 01:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbcEJXHR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2016 19:07:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58308 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751293AbcEJXHQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2016 19:07:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6E65E1AF35;
	Tue, 10 May 2016 19:07:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=rpzGmefx2fmM
	lM8E5T6bNvvY2KY=; b=T411Ikbucp23X9Wyh+4x/HfJ0b6ADMomoJqa80lg098w
	iVrrYLOkt9Grgq/0J2jd59zU7jJfMXfJK8kGtB9FMrpEyvLFA91vwtSjiUehzwz7
	ZfsFZlzs78h420VoOo9cNDzsf71RiOGdsMDFri0TVYHWeD5I5APKOm/pRbQtTVU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=gxseEm
	f9yE1FIsz8x8/7Mxs4GIKgJOME6UqffV6BFTGf/F5KbyCtNjpcckPh/HKJzKKNv1
	A6VClmNJNT+fdqGZOpo76nzLFoPscFbLxfQdYxtfR3EVIoujLzEWnuM8YPafRBnX
	YjV9wnMK6hPdLILZdJV2ixlzo4CI1SC1MItkI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 649D61AF34;
	Tue, 10 May 2016 19:07:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C91BE1AF33;
	Tue, 10 May 2016 19:07:13 -0400 (EDT)
In-Reply-To: <20160510141553.22967-7-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
	Duy"'s message of "Tue, 10 May 2016 21:15:53 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EEB285E0-1703-11E6-A402-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294206>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

This changes semantics, doesn't it?  prefix_filename() seems to do a
lot more than just strbuf_vadd("%s%s", prefix, filename); would do.

It may be a good change (e.g. turn '\' into '/' on Windows), but
this is way more than "simplify prefixing".  It is something else
whose effect needs to be explained.

>  builtin/worktree.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index b53f802..f9dac37 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -337,7 +337,7 @@ static int add(int ac, const char **av, const cha=
r *prefix)
>  	if (ac < 1 || ac > 2)
>  		usage_with_options(worktree_usage, options);
> =20
> -	path =3D prefix ? prefix_filename(prefix, strlen(prefix), av[0]) : =
av[0];
> +	path =3D prefix_filename(prefix, strlen(prefix), av[0]);
>  	branch =3D ac < 2 ? "HEAD" : av[1];
> =20
>  	opts.force_new_branch =3D !!new_branch_force;
> @@ -467,6 +467,8 @@ int cmd_worktree(int ac, const char **av, const c=
har *prefix)
> =20
>  	if (ac < 2)
>  		usage_with_options(worktree_usage, options);
> +	if (!prefix)
> +		prefix =3D "";
>  	if (!strcmp(av[1], "add"))
>  		return add(ac - 1, av + 1, prefix);
>  	if (!strcmp(av[1], "prune"))
