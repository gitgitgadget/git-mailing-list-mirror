From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] tree_entry_interesting: make recursive mode
 default
Date: Sat, 14 Jan 2012 19:12:03 -0800
Message-ID: <7v8vl9wtfg.fsf@alter.siamese.dyndns.org>
References: <1326341371-16628-1-git-send-email-pclouds@gmail.com>
 <1326533003-19686-1-git-send-email-pclouds@gmail.com>
 <1326533003-19686-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 15 04:12:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmGWK-0001xo-Iw
	for gcvg-git-2@lo.gmane.org; Sun, 15 Jan 2012 04:12:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754606Ab2AODMJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Jan 2012 22:12:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39246 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753517Ab2AODMH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Jan 2012 22:12:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 82A377358;
	Sat, 14 Jan 2012 22:12:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=a2zsfxl5uD4W
	a7GiVqYxHkF/7Gk=; b=tPQikpm6FMsHIjsGHB1O3x7XS5eUi2GctYXRmshBBw9V
	P5uDm3rVndLjud9MynVJYfbFj2BrX59i/ZlYMWrGIhavQMI1qWGe9eFX+yhbaOfK
	76YhwXdzyfN0aFwnojgxqh7PrVy9EZwjMx6nemaoBWCH2jSkzTCmgvrdxw12LKc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=s/ncTR
	PIrrU+c1GPC9z393V3wM4e3IxL5QuqtVYUNEXxQf+RAyAtjw2MCpU/PjEDmXwbI3
	qE3dxudA027zv0TEFSNft/ghGP1jVjJirIuX28PgAQyt6X0gwWw1fR8b5I/OXUbU
	m+w3fEiVN91NWnP/9ZE05FbvqyF2aq5VfcodM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7873E7357;
	Sat, 14 Jan 2012 22:12:05 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C22497355; Sat, 14 Jan 2012
 22:12:04 -0500 (EST)
In-Reply-To: <1326533003-19686-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 14 Jan
 2012 16:23:23 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B3589778-3F26-11E1-8BA6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188589>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This patch decouples the use of recursive field. The max_depth featur=
e
> switch is now controlled by max_depth_valid field. diff-tree recursio=
n
> is controlled by onelevel_only, which makes it recursive by default.

> diff --git a/builtin/grep.c b/builtin/grep.c
> index 9ce064a..c081bf4 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -1051,7 +1051,7 @@ int cmd_grep(int argc, const char **argv, const=
 char *prefix)
>  	paths =3D get_pathspec(prefix, argv + i);
>  	init_pathspec(&pathspec, paths);
>  	pathspec.max_depth =3D opt.max_depth;
> -	pathspec.recursive =3D 1;
> +	pathspec.max_depth_valid =3D 1;

We initialize opt.max_depth to "-1" (unlimited) and then let it be
overridden by the command line, and we set it to pathspec, so max_depth=
 is
always valid, even when it is "-1", and is to be honoured.

> diff --git a/dir.c b/dir.c
> index 0a78d00..5af3567 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -258,7 +258,7 @@ int match_pathspec_depth(const struct pathspec *p=
s,
>  	int i, retval =3D 0;
> =20
>  	if (!ps->nr) {
> -		if (!ps->recursive || ps->max_depth =3D=3D -1)
> +		if (!ps->max_depth_valid || ps->max_depth =3D=3D -1)
>  			return MATCHED_RECURSIVELY;
>  		if (within_depth(name, namelen, 0, ps->max_depth))

When there is no pathspec given, if we do not have a valid depth limite=
r,
or a valid depth limiter says "-1" (unlimited), it is always a match.
Otherwise we have check the depth. Looks correct.


> @@ -275,7 +275,7 @@ int match_pathspec_depth(const struct pathspec *p=
s,
>  		if (seen && seen[i] =3D=3D MATCHED_EXACTLY)
>  			continue;
>  		how =3D match_pathspec_item(ps->items+i, prefix, name, namelen);
> -		if (ps->recursive && ps->max_depth !=3D -1 &&
> +		if (ps->max_depth_valid && ps->max_depth !=3D -1 &&
>  		    how && how !=3D MATCHED_FNMATCH) {
>  			int len =3D ps->items[i].len;
>  			if (name[len] =3D=3D '/')

Likewise. When there is a max_depth defined from the caller, and we did
not get the desired match, we check if we can go deeper to retry the
match. Looks correct.

These assume that tree-diff (the sole user of onelevel_only) never call=
s
into this function and ask to limit the recursion, though. Is it a good
thing for the longer-term code health?

In any case, both of the above seem to work without max_depth_valid.  I=
f
the caller does not want to use depth limiting, it can set max_depth to
"-1", and all the code after this patch that check ps->max_depth_valid =
can
pretend that max_depth_valid is set to 1, no?

> diff --git a/tree-diff.c b/tree-diff.c
> index 28ad6db..fbc683c 100644
> --- a/tree-diff.c
> +++ b/tree-diff.c
> @@ -137,8 +137,7 @@ int diff_tree(struct tree_desc *t1, struct tree_d=
esc *t2,
>  	enum interesting t2_match =3D entry_not_interesting;
> =20
>  	/* Enable recursion indefinitely */
> -	opt->pathspec.recursive =3D DIFF_OPT_TST(opt, RECURSIVE);
> -	opt->pathspec.max_depth =3D -1;
> +	opt->pathspec.onelevel_only =3D !DIFF_OPT_TST(opt, RECURSIVE);

The comment "Enable recursion indefinitely" seems stale (not a problem
with this change).

> diff --git a/tree-walk.c b/tree-walk.c
> index 492c7cd..fdecacc 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -588,7 +588,7 @@ enum interesting tree_entry_interesting(const str=
uct name_entry *entry,
>  		entry_not_interesting : all_entries_not_interesting;
> =20
>  	if (!ps->nr) {
> -		if (!ps->recursive || ps->max_depth =3D=3D -1)
> +		if (!ps->max_depth_valid || ps->max_depth =3D=3D -1)
>  			return all_entries_interesting;
>  		return within_depth(base->buf + base_offset, baselen,
>  				    !!S_ISDIR(entry->mode),

When there is no pathspec given, if we do not have a valid depth limite=
r
(i.e. caller is diff-tree), or a valid depth limiter says "-1" (unlimit=
ed),=20
everything in this tree is interesting. If we have depth limit, we need=
 to
check it.

But how would onelevel_only option interact with this codepath? We used=
 to
have recursive =3D=3D false and max_depth =3D=3D -1 in a non-recursive =
diff-tree,
so the old code would have returned all_entries_interesting. Now we rel=
y
on max_depth_valid being invalid. Again, wouldn't this work without
max_depth_valid if max_depth is set to "-1" in diff-tree?

> @@ -609,7 +609,7 @@ enum interesting tree_entry_interesting(const str=
uct name_entry *entry,
>  			if (!match_dir_prefix(base_str, match, matchlen))
>  				goto match_wildcards;
> =20
> -			if (!ps->recursive || ps->max_depth =3D=3D -1)
> +			if (!ps->max_depth_valid || ps->max_depth =3D=3D -1)
>  				return all_entries_interesting;
>  			return within_depth(base_str + matchlen + 1,

Likewise. Everything is interesting in a matched entry, when not
depth-limited. Otherwise we would need to check the depth. Looks correc=
t.

Again, how would onelevel_only option interact with this part?

> @@ -634,7 +634,7 @@ enum interesting tree_entry_interesting(const str=
uct name_entry *entry,
>  				 * Match all directories. We'll try to
>  				 * match files later on.
>  				 */
> -				if (ps->recursive && S_ISDIR(entry->mode))
> +				if (!ps->onelevel_only && S_ISDIR(entry->mode))
>  					return entry_interesting;
>  			}
> =20
> @@ -665,7 +665,7 @@ match_wildcards:
>  		 * in future, see
>  		 * http://thread.gmane.org/gmane.comp.version-control.git/163757/f=
ocus=3D163840
>  		 */
> -		if (ps->recursive && S_ISDIR(entry->mode))
> +		if (!ps->onelevel_only && S_ISDIR(entry->mode))
>  			return entry_interesting;
>  	}
>  	return never_interesting; /* No matches */

Before we had recursive and max_depth. Now you have three instead of tw=
o.
The only thing we are trying to say with these three is if we want to
allow unlimited recursion, no recursion or recursion limited to a certa=
in
depth. An integer option ought to work, and various codepaths that used=
 to
look at the old two variables are converted to look at only just a few =
of
the new three variables, and never all three of them.

That makes my head hurt and makes me suspect there is something
fundamentally wrong in the patch.  Sigh...
