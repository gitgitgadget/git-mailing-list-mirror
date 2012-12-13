From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] cache-tree: invalidate i-t-a paths after
 generating trees
Date: Wed, 12 Dec 2012 18:04:00 -0800
Message-ID: <7v4njq1ze7.fsf@alter.siamese.dyndns.org>
References: <7vip89bz4v.fsf@alter.siamese.dyndns.org>
 <1355362747-13474-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathon Mah <me@JonathonMah.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 03:04:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tiy9v-000282-V7
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 03:04:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755453Ab2LMCEG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Dec 2012 21:04:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64271 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754635Ab2LMCEE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Dec 2012 21:04:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8EDAACD7;
	Wed, 12 Dec 2012 21:04:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=FHr1FGwM5OQU
	VdacaOz6ix5raDw=; b=O15/F0DHZFvN79FCH723PJRHGTHRQpx0s1ca/n/DBYTN
	qzVvtwx4OIMVSQvjIjSAsBoMimxAX8UnOPjavTB3K/llnFcRMzye5YeK6YNL02PS
	B7XuBzzu32u7XOc8RPxE8lIHk+S4OPLXQ7JqURWKQ0bShZjSfr9QWdXw4lqLgAg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qrcqig
	h76B1cYViZ+oopBvzBTE6ekdcm1KptX3ivjPugf/LVwTJJiBjD8YMmdWZD0Prq5o
	5eReLpqn0zFhr1P0tXJaDcheKMAYm50Ss8FgJud3/CUgd8h4MjXvnWcVNNadj0FZ
	YHVhfXJuRjgIKaZ8n/F0Ipqfje6WezANgzw3Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA2DEACD6;
	Wed, 12 Dec 2012 21:04:03 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E7B7ACD0; Wed, 12 Dec 2012
 21:04:02 -0500 (EST)
In-Reply-To: <1355362747-13474-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 13 Dec
 2012 08:39:06 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5D95CE1A-44C9-11E2-B8FE-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211433>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Intent-to-add entries used to forbid writing trees so it was not a
> problem. After commit 3f6d56d (commit: ignore intent-to-add entries
> instead of refusing - 2012-02-07), we can generate trees from an inde=
x
> with i-t-a entries.
>
> However, the commit forgets to invalidate all paths leading to i-t-a
> entries. With fully valid cache-tree (e.g. after commit or
> write-tree), diff operations may prefer cache-tree to index and not
> see i-t-a entries in the index, because cache-tree does not have them=
=2E
>
> Reported-by: Jonathon Mah <me@JonathonMah.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  This version ensures that entry_count can only be >=3D -1 after
>  update_one returns. Not ideal but good enough.
>
>  cache-tree.c          | 40 ++++++++++++++++++++++++++++++++++++----
>  t/t2203-add-intent.sh | 20 ++++++++++++++++++++
>  2 files changed, 56 insertions(+), 4 deletions(-)
>
> diff --git a/cache-tree.c b/cache-tree.c
> index 28ed657..1fbc81a 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -248,6 +248,7 @@ static int update_one(struct cache_tree *it,
>  	int missing_ok =3D flags & WRITE_TREE_MISSING_OK;
>  	int dryrun =3D flags & WRITE_TREE_DRY_RUN;
>  	int i;
> +	int to_invalidate =3D 0;
> =20
>  	if (0 <=3D it->entry_count && has_sha1_file(it->sha1))
>  		return it->entry_count;
> @@ -324,7 +325,14 @@ static int update_one(struct cache_tree *it,
>  			if (!sub)
>  				die("cache-tree.c: '%.*s' in '%s' not found",
>  				    entlen, path + baselen, path);
> -			i +=3D sub->cache_tree->entry_count - 1;
> +			i--; /* this entry is already counted in "sub" */

Huh?

The "-1" in the original is the bog-standard compensation for the
for(;;i++) loop.

> +			if (sub->cache_tree->entry_count < 0) {
> +				i -=3D sub->cache_tree->entry_count;
> +				sub->cache_tree->entry_count =3D -1;
> +				to_invalidate =3D 1;
> +			}
> +			else
> +				i +=3D sub->cache_tree->entry_count;

While the rewritten version is not *wrong* per-se, I have a feeling
that it may be much easier to read if written like this:

	if (sub->cache_tree_entry_count < 0) {
		to_invalidate =3D 1;
                to_skip =3D 0 - sub->cache_tree_entry_count;
		sub->cache_tree_entry_count =3D -1;
	} else {
		to_skip =3D sub->cache_tree_entry_count;
	}
        i +=3D to_skip - 1;

> @@ -360,7 +383,7 @@ static int update_one(struct cache_tree *it,
>  	}
> =20
>  	strbuf_release(&buffer);
> -	it->entry_count =3D i;
> +	it->entry_count =3D to_invalidate ? -i : i;
>  #if DEBUG
>  	fprintf(stderr, "cache-tree update-one (%d ent, %d subtree) %s\n",
>  		it->entry_count, it->subtree_nr,
> @@ -381,6 +404,15 @@ int cache_tree_update(struct cache_tree *it,
>  	i =3D update_one(it, cache, entries, "", 0, flags);
>  	if (i < 0)
>  		return i;
> +	/*
> +	 * update_one() uses negative entry_count as a way to mark an
> +	 * entry invalid _and_ pass the number of entries back to
> +	 * itself at the parent level. This is for internal use and
> +	 * should not be leaked out after the top-level update_one
> +	 * exits.
> +	 */
> +	if (it->entry_count < 0)
> +		it->entry_count =3D -1;

Nice.  I think what entry_count means immediately after update_one()
returned should be commented near the beginning of that function,
too, though.

Thanks.
