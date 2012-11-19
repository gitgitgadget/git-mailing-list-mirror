From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] pathspec: save the non-wildcard length part
Date: Mon, 19 Nov 2012 12:48:35 -0800
Message-ID: <7v6251wao5.fsf@alter.siamese.dyndns.org>
References: <1353229989-13075-1-git-send-email-pclouds@gmail.com>
 <1353229989-13075-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 22:22:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TaYnO-0001mf-VO
	for gcvg-git-2@plane.gmane.org; Mon, 19 Nov 2012 22:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925Ab2KSVWH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Nov 2012 16:22:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36698 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751559Ab2KSVWF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Nov 2012 16:22:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C97C99EFF;
	Mon, 19 Nov 2012 16:22:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=qxTxr7K2ccT81oItK/2Q8I9EU
	cc=; b=K+Ong54zGkfC2s01GVO1hElpvRN9G9hKW3x8132qTGnPqQi8bnnqcW9bt
	4isZLGinjlWiPgPbHXprJ9vR/xNkXBvqnaSYv2Agm+sF8uYiApOcItxHhnq45Fuy
	SFc9VW4JhKV+/IuR/nfefv4xSvRb5gofFy7cg8xGDnQHxUpRRE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=clGaS3KBHv+wdcGhwMC
	1oFQdeowFWLgq8SZKU/+mckXo7nVXLfkUMwZcUxnq2fM6tlz1CBjaGTdJ238nm7R
	fjX61cTrr9BnAuZiSAZ5ke2ISdgOXRpmtdiDJ6cNusHgp45Vl6GUfn9erSg7j259
	6yIHMykFHBndJdumxu11YWg4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B82459EFE;
	Mon, 19 Nov 2012 16:22:04 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DCDA79EFD; Mon, 19 Nov 2012
 16:22:03 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 29E5024E-328F-11E2-B957-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210055>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> We marks pathspec with wildcards with the field use_wildcard. We coul=
d

s/marks/mark;

> do better by saving the length of the non-wildcard part, which can be
> for optimizations such as f9f6e2c (exclude: do strcmp as much as

s/for /used &/;

> possible before fnmatch - 2012-06-07)
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

The code looks straightforward and correct.  Thanks.

> ---
>  builtin/ls-files.c | 2 +-
>  builtin/ls-tree.c  | 2 +-
>  cache.h            | 2 +-
>  dir.c              | 6 +++---
>  tree-walk.c        | 4 ++--
>  5 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index b5434af..4a9ee69 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -337,7 +337,7 @@ void overlay_tree_on_cache(const char *tree_name,=
 const char *prefix)
>  		matchbuf[0] =3D prefix;
>  		matchbuf[1] =3D NULL;
>  		init_pathspec(&pathspec, matchbuf);
> -		pathspec.items[0].use_wildcard =3D 0;
> +		pathspec.items[0].nowildcard_len =3D pathspec.items[0].len;
>  	} else
>  		init_pathspec(&pathspec, NULL);
>  	if (read_tree(tree, 1, &pathspec))
> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> index 235c17c..fb76e38 100644
> --- a/builtin/ls-tree.c
> +++ b/builtin/ls-tree.c
> @@ -168,7 +168,7 @@ int cmd_ls_tree(int argc, const char **argv, cons=
t char *prefix)
> =20
>  	init_pathspec(&pathspec, get_pathspec(prefix, argv + 1));
>  	for (i =3D 0; i < pathspec.nr; i++)
> -		pathspec.items[i].use_wildcard =3D 0;
> +		pathspec.items[i].nowildcard_len =3D pathspec.items[i].len;
>  	pathspec.has_wildcard =3D 0;
>  	tree =3D parse_tree_indirect(sha1);
>  	if (!tree)
> diff --git a/cache.h b/cache.h
> index dbd8018..bf031f1 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -482,7 +482,7 @@ struct pathspec {
>  	struct pathspec_item {
>  		const char *match;
>  		int len;
> -		unsigned int use_wildcard:1;
> +		int nowildcard_len;
>  	} *items;
>  };
> =20
> diff --git a/dir.c b/dir.c
> index 5a83aa7..c391d46 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -230,7 +230,7 @@ static int match_pathspec_item(const struct paths=
pec_item *item, int prefix,
>  			return MATCHED_RECURSIVELY;
>  	}
> =20
> -	if (item->use_wildcard && !fnmatch(match, name, 0))
> +	if (item->nowildcard_len < item->len && !fnmatch(match, name, 0))
>  		return MATCHED_FNMATCH;
> =20
>  	return 0;
> @@ -1429,8 +1429,8 @@ int init_pathspec(struct pathspec *pathspec, co=
nst char **paths)
> =20
>  		item->match =3D path;
>  		item->len =3D strlen(path);
> -		item->use_wildcard =3D !no_wildcard(path);
> -		if (item->use_wildcard)
> +		item->nowildcard_len =3D simple_length(path);
> +		if (item->nowildcard_len < item->len)
>  			pathspec->has_wildcard =3D 1;
>  	}
> =20
> diff --git a/tree-walk.c b/tree-walk.c
> index 3f54c02..af871c5 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -626,7 +626,7 @@ enum interesting tree_entry_interesting(const str=
uct name_entry *entry,
>  					&never_interesting))
>  				return entry_interesting;
> =20
> -			if (item->use_wildcard) {
> +			if (item->nowildcard_len < item->len) {
>  				if (!fnmatch(match + baselen, entry->path, 0))
>  					return entry_interesting;
> =20
> @@ -642,7 +642,7 @@ enum interesting tree_entry_interesting(const str=
uct name_entry *entry,
>  		}
> =20
>  match_wildcards:
> -		if (!item->use_wildcard)
> +		if (item->nowildcard_len =3D=3D item->len)
>  			continue;
> =20
>  		/*
