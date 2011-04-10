From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] grep: convert to use the new get_pathspec()
Date: Sat, 09 Apr 2011 17:56:50 -0700
Message-ID: <7v7hb2zzxp.fsf@alter.siamese.dyndns.org>
References: <1302368060-23827-1-git-send-email-pclouds@gmail.com>
 <1302368060-23827-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 10 02:57:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8ixw-00072n-4A
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 02:57:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380Ab1DJA5F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Apr 2011 20:57:05 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42062 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271Ab1DJA5D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Apr 2011 20:57:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5194A5EFC;
	Sat,  9 Apr 2011 20:58:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=IYqODuxcKUiR
	FtW2ScyK33OMWi8=; b=x7TEWn55i8tbaN8CmPnm2DOqT1XEzbiSEPLX30FilqgG
	ngE/xBWW48pZbvMY54NPdp3aE2LqtUSHmypaXYZnBtt0lzONTfrjNK+gSdiRz8l4
	QdbNZxG3DcpBs+TALO5zqkSjYoykclaKYUnsICQZQeJIoMJylbbixu1eegaa4PI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=nGhsWG
	5dQ9nMVovYJ7W5QEY9Yc67KNMoSQroHgaxydmb/vAba8gKre8EYNM3oYS0kZlCgg
	mEQsK1m1Zmn1Kj+Ug0Mfbx7U/RsJ7BfY5GeK/zRn6GeWkcz6fzD68xTlxKZYC4we
	u17nRCJLqpKpXq1olHbMOGtutR4p5gPDwPsCM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1E77F5EF8;
	Sat,  9 Apr 2011 20:58:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E2C715EF5; Sat,  9 Apr 2011
 20:58:48 -0400 (EDT)
In-Reply-To: <1302368060-23827-6-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 9 Apr
 2011 23:54:20 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B43883BA-630D-11E0-998A-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171227>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> ---
>  builtin/grep.c |   10 +---------
>  1 files changed, 1 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 2826ca8..af16deb 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -734,7 +734,6 @@ int cmd_grep(int argc, const char **argv, const c=
har *prefix)
>  	const char *show_in_pager =3D NULL, *default_pager =3D "dummy";
>  	struct grep_opt opt;
>  	struct object_array list =3D OBJECT_ARRAY_INIT;
> -	const char **paths =3D NULL;
>  	struct pathspec pathspec;
>  	struct string_list path_list =3D STRING_LIST_INIT_NODUP;
>  	int i;
> @@ -956,14 +955,7 @@ int cmd_grep(int argc, const char **argv, const =
char *prefix)
>  			verify_filename(prefix, argv[j]);
>  	}
> =20
> -	if (i < argc)
> -		paths =3D get_pathspec_old(prefix, argv + i);
> -	else if (prefix) {
> -		paths =3D xcalloc(2, sizeof(const char *));
> -		paths[0] =3D prefix;
> -		paths[1] =3D NULL;
> -	}
> -	init_pathspec(&pathspec, paths);
> +	get_pathspec(&pathspec, prefix, argc - i, argv + i);

This assumes that the new API function will default to "if run without
pathspec, the calling command wants to limit to cwd", doesn't it?

That is why I mentioned that the caller would need to pass a hint as to
what should happen in that case in my earlier message.  Probably the ne=
w
API function should be something like:

    setup_pathspec(&pathspec, prefix, argc, argv, opts)

where opts is a bitmask to carry that hint (or a pointer to a structure
that caller to carry a set of hints richer than a bitmask can express),
and "add -u" and "grep" should set PATHSPEC_DEFAULT_LOCAL in the bitmas=
k.
The call to setup_pathspec() from the log family would not want "no use=
r
specified pathspec means limited to local" semantics.

Then when somebody wants to flip the "add -u" default in future version=
s,
the call from "add -u" codepath can instead use PATHSPEC_DEFAULT_TREEWI=
DE
(or perhaps the lack of PATHSPEC_DEFAULT_LOCAL bit may mean tree-wide)
there.
