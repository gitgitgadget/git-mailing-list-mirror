From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] branch: introduce --set-upstream-to
Date: Tue, 10 Jul 2012 10:26:47 -0700
Message-ID: <7vehojil2g.fsf@alter.siamese.dyndns.org>
References: <1341939181-8962-1-git-send-email-cmn@elego.de>
 <1341939181-8962-2-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Tue Jul 10 19:26:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoeD9-00087s-JI
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 19:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754281Ab2GJR0u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jul 2012 13:26:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42407 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752840Ab2GJR0t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jul 2012 13:26:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FB4F8257;
	Tue, 10 Jul 2012 13:26:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=D7Nau5txBho8
	hono+6eukH3uXmU=; b=vOzt70UAlvO/+W6XhYZk/Cg9Vklnl0coDPQ8KZkYBFM2
	f5GVIu9zM9VICv5azu0weEETsikwXxmIgfaWYhIO3kaJ27glem9ukYuMHDLj/opd
	KFLOqD9ItCf9nlflGcYP6cwRwX2iITZ4xkzAzEokMPSaNgoARQnrAcKNzQheSBc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jOh1Mb
	mElMSh0LwOpmFf4JD9JoECDmXq/M+jGlExDOy9JUnQR8X0K0PlwAliSQT3KY33Ov
	f5FQVOyh5yhSgoD67cuov0PMO5bG6ztc5A28AIxBfqxCo4+NQOpbZ9nS/2ZG/e7v
	zE7dvLwJGiUZQxwEVrLKmCVSZqHk30fiBvLDM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3666D8256;
	Tue, 10 Jul 2012 13:26:49 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B4E388255; Tue, 10 Jul 2012
 13:26:48 -0400 (EDT)
In-Reply-To: <1341939181-8962-2-git-send-email-cmn@elego.de> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Tue, 10 Jul 2012 18:52:59
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6E136C00-CAB4-11E1-8F9C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201266>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> diff --git a/builtin/branch.c b/builtin/branch.c
> index 0e060f2..c886fc0 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -713,6 +713,7 @@ int cmd_branch(int argc, const char **argv, const=
 char *prefix)
>  	int verbose =3D 0, abbrev =3D -1, detached =3D 0;
>  	int reflog =3D 0, edit_description =3D 0;
>  	int quiet =3D 0;
> +	const char *new_upstream =3D NULL;
>  	enum branch_track track;
>  	int kinds =3D REF_LOCAL_BRANCH;
>  	struct commit_list *with_commit =3D NULL;
> @@ -726,6 +727,7 @@ int cmd_branch(int argc, const char **argv, const=
 char *prefix)
>  			BRANCH_TRACK_EXPLICIT),
>  		OPT_SET_INT( 0, "set-upstream",  &track, "change upstream info",
>  			BRANCH_TRACK_OVERRIDE),
> +		OPT_STRING('u', "set-upstream-to", &new_upstream, "upstream", "cha=
nge the upstream info"),
>  		OPT__COLOR(&branch_use_color, "use colored output"),
>  		OPT_SET_INT('r', "remotes",     &kinds, "act on remote-tracking br=
anches",
>  			REF_REMOTE_BRANCH),
> @@ -794,10 +796,10 @@ int cmd_branch(int argc, const char **argv, con=
st char *prefix)
>  	argc =3D parse_options(argc, argv, prefix, options, builtin_branch_=
usage,
>  			     0);
> =20
> -	if (!delete && !rename && !edit_description && argc =3D=3D 0)
> +	if (!delete && !rename && !edit_description && !new_upstream && arg=
c =3D=3D 0)
>  		list =3D 1;
> =20
> -	if (!!delete + !!rename + !!force_create + !!list > 1)
> +	if (!!delete + !!rename + !!force_create + !!list + !!new_upstream =
> 1)
>  		usage_with_options(builtin_branch_usage, options);

It probably is an error to have track and new_upstream together.

The remainder of [Patch 1/3] looked entirely sensible, including the
proposed log message (modulo missing sign-off).

Thanks.
