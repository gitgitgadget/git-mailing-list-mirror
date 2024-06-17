Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A923217C7B3
	for <git@vger.kernel.org>; Mon, 17 Jun 2024 19:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718652837; cv=none; b=N+0WFjykonwsvwA5jv+JQ+P61gcr6IIMIKkQr51nZ75l7Zw0u3CkLqemcnkj56AyBe7AKTfEujTDk4F51+b2GnnykWnGbmioifHH6GggIm3OoI0qDFipM70OPFhj0dZf0WsCOAivJgUvWmyX+zzluevVn1N9iND0+IMYQllaA2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718652837; c=relaxed/simple;
	bh=lJcoJixNtZnZpk6TT34JDeRNFCNa2W0topy+JwE+Nec=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D+O4U+SmhWAQWIe9et37u5SLSifpbSJKPuGvnylocLHmbp3W20FtwMrujw/z+1EdNyxLkjjKpn+AHNh+5dJq96rd9QVJ0F/3d6bPqQulbdF/9yqTm2mXiYx7KjaESiaRQwC6UOxfTjVfeu8O8rwDPjmEiCr/oNYfug71/aMYDiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WPyIi7rj; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WPyIi7rj"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 32A493593B;
	Mon, 17 Jun 2024 15:33:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=lJcoJixNtZnZ
	pk6TT34JDeRNFCNa2W0topy+JwE+Nec=; b=WPyIi7rjzklkvU7Vvv4SDuxrh1bG
	PdbN4RNRMnz1fVpqAu7cDkXu6/Uj1inz/B0YoMNKblQTZtAzjzxeMR1SnIdle5Mf
	JuxTlAZQEr6efR/y2AxKkpEhAuGykJqDWb8SVGj2ZZkYIc6d/1mKTd9XVd+RkqoT
	0hCaUjaRHgwMUao=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2B6C63593A;
	Mon, 17 Jun 2024 15:33:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BAD6935935;
	Mon, 17 Jun 2024 15:33:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Miguel_=C3=81ngel_Pastor_Olivar_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Miguel =?utf-8?Q?=C3=81ngel?= Pastor Olivar
 <miguelinlas3@gmail.com>,  Miguel =?utf-8?Q?=C3=81ngel?= Pastor Olivar
 <migue@github.com>
Subject: Re: [PATCH 1/2] cat-file: configurable number of symlink resolutions
In-Reply-To: <cbf38c7281de33289f622c9926c75744323311af.1718615028.git.gitgitgadget@gmail.com>
	("Miguel =?utf-8?Q?=C3=81ngel?= Pastor Olivar via GitGitGadget"'s message
 of "Mon, 17
	Jun 2024 09:03:47 +0000")
References: <pull.1751.git.1718615028.gitgitgadget@gmail.com>
	<cbf38c7281de33289f622c9926c75744323311af.1718615028.git.gitgitgadget@gmail.com>
Date: Mon, 17 Jun 2024 12:33:50 -0700
Message-ID: <xmqqwmmn5ppd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 86CF2874-2CE0-11EF-A318-C38742FD603B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

"Miguel =C3=81ngel Pastor Olivar via GitGitGadget"
<gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/config/core.txt b/Documentation/config/core.=
txt
> index 93d65e1dfd2..ca2d1eede52 100644
> --- a/Documentation/config/core.txt
> +++ b/Documentation/config/core.txt
> @@ -757,3 +757,8 @@ core.maxTreeDepth::
>  	tree (e.g., "a/b/cde/f" has a depth of 4). This is a fail-safe
>  	to allow Git to abort cleanly, and should not generally need to
>  	be adjusted. The default is 4096.
> +
> +core.maxSymlinkDepth::
> +	The maximum number of symlinks Git is willing to resolve while
> +	looking for a tree entry.
> +	The default is GET_TREE_ENTRY_FOLLOW_SYMLINKS_MAX_LINKS.
> \ No newline at end of file

Style: please do not end our text files with an incomplete line.

Regarding the patch contents, this is an end-user facing document.
How would they learn what the actual value is?

Is there a "valid range" the users are allowed to set this value to?
If so, what is the range?  What do users get when they set it outside
the allowed range?  Do they get warned?  Do they get die()?  Is the
value silently ignored?

If there is no upper limit for the "valid range", how does a user
set it to "infinity", and what's the downside of doing so?  What
happens when the user sets it to 0, or a negative value, if there is
no lower limit for the "valid range"?  The questions in this
paragraph your updated documentation text do not have to answer if
your "valid range" does have both upper and lower limit, but the
documentation must answer questions in the previous paragraph.

> diff --git a/config.c b/config.c
> index abce05b7744..d69e9a3ae6b 100644
> --- a/config.c
> +++ b/config.c
> @@ -1682,6 +1682,11 @@ static int git_default_core_config(const char *v=
ar, const char *value,
>  		return 0;
>  	}
> =20
> +	if (!strcmp(var, "core.maxsymlinkdepth")) {
> +		max_symlink_depth =3D git_config_int(var, value, ctx->kvi);
> +		return 0;
> +	}
> +
>  	/* Add other config variables here and to Documentation/config.txt. *=
/
>  	return platform_core_config(var, value, ctx, cb);
>  }
> diff --git a/environment.c b/environment.c
> index 701d5151354..6d7a5001eb1 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -95,6 +95,7 @@ int max_allowed_tree_depth =3D
>  #else
>  	2048;
>  #endif
> +int max_symlink_depth =3D -1;

Why set it to -1 here, instead of initializing it to the
GET_TREE_ENTRY_FOLLOW_SYMLINKS?  By introducing a configuration
variable (which by the way I am not convinced is necessarily a good
idea to begin with), you are surfacing that built-in default value
as a more prominent thing, not hidden away in a little corner of
tree-walk.c implementation detail.  If you do define a "valid range
of values", the code that parses core.maxsymlinkdepth in config.c
may want to learn what the value of GET_TREE_ENTRY_FOLLOW_SYMLINKS
is, which means the symbol may need to be visible in some common
header file anyway.

By the way, this is not a new problem this patch introduces, as the
default GET_TREE_ENTRY_FOLLOW_SYMLINKS came from 275721c2
(tree-walk: learn get_tree_entry_follow_symlinks, 2015-05-20), but I
wonder if the default number should somehow be aligned with the
other upper limit, SYMREF_MAXDEPTH for a symbolic ref pointing at
another symbolic ref pointing at yet another ...

> +test_expect_success 'git cat-file --batch --follow-symlink stop resolv=
ing symlinks' '
> +	printf "loop 22\nHEAD:link-to-symlink-3\n">expect &&
> +	printf 'HEAD:link-to-symlink-3' | git -c core.maxsymlinkdepth=3D1 cat=
-file --batch=3D"%(objectname) %(objecttype) %(objectsize)" --follow-syml=
inks > actual &&

Style: a redirection operator needs a single SP before it and no SP
between it and its target, i.e.

	printf "loop 22..." >expect &&
	printf "HEAD:link ..." |
        git ... cat-file ... >actual &&

Also fold overly long line after "|" pipeline.

> diff --git a/tree-walk.c b/tree-walk.c
> index 6565d9ad993..3ec2302309e 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -664,7 +664,12 @@ enum get_oid_result get_tree_entry_follow_symlinks=
(struct repository *r,
>  	struct object_id current_tree_oid;
>  	struct strbuf namebuf =3D STRBUF_INIT;
>  	struct tree_desc t;
> -	int follows_remaining =3D GET_TREE_ENTRY_FOLLOW_SYMLINKS_MAX_LINKS;
> +	int follows_remaining =3D
> +		max_symlink_depth > -1 &&
> +				max_symlink_depth <=3D
> +					GET_TREE_ENTRY_FOLLOW_SYMLINKS_MAX_LINKS ?
> +			max_symlink_depth :
> +			GET_TREE_ENTRY_FOLLOW_SYMLINKS_MAX_LINKS;

Strange indentation.

If you range-limit at the place the configuration was parsed, you do
not have to do any of this here, but if you insist hiding
GET_TREE_ENTRY_FOLLOW_SYMLINKS_MAX_LINKS from others (yet still use
it in the end-user facing documentation???), then

	int follows_remaining =3D
		(-1 < max_symlink_depth &&
		 max_symlink_depth <=3D GET_TREE_ENTRY_FOLLOW_SYMLINKS_MAX_LINKS)
		? max_symlink_depth
		: GET_TREE_ENTRY_FOLLOW_SYMLINKS_MAX_LINKS;

or perhaps a lot easier to read form, i.e.

	int follows_remaining =3D max_symlink_depth;

        if (follows_remaining < -1 ||
            GET_TREE_ENTRY_FOLLOW_SYMLINKS_MAX_LINKS < follows_remaining)
		follows_remaining =3D GET_TREE_ENTRY_FOLLOW_SYMLINKS_MAX_LINKS;

>  	init_tree_desc(&t, NULL, NULL, 0UL);
>  	strbuf_addstr(&namebuf, name);


Thanks.
