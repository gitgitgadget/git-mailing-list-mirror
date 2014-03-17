From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] log: add --nonlinear-barrier to help see non-linear history
Date: Mon, 17 Mar 2014 13:32:56 -0700
Message-ID: <xmqqob14d0qv.fsf@gitster.dls.corp.google.com>
References: <1391867417-979-1-git-send-email-pclouds@gmail.com>
	<1395060676-23144-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 21:33:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPeDc-0007hy-Vm
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 21:33:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbaCQUdD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Mar 2014 16:33:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61455 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750716AbaCQUdB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Mar 2014 16:33:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C32FF75534;
	Mon, 17 Mar 2014 16:33:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=h4A1VQB3IHv7
	NXb9dzJTypsDcIs=; b=jCBGbmA0niBpW3dHJO7CzAbiFOdfbL/IaYLQy4oD2zva
	2hzIAzS/r0ZCV2PLs8Z9oZM6u/6dCtp+ZGkDI67Upowx5sOTTWIsa6FdPVulN+SH
	MKAeTJoUuifa/ouQp/sEtI928nMQvBT9WK0lubkGS08akB4urQZngCu0kUNn4/o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=u6NlTq
	C64lDa/vK8B1HjW/YFbaicFVuw0h7h2IR2VqJV4UVniGYn2rv6psRguV9O5CydTs
	M8vLk/ZIWvQ9a3odp2INU46rfka9LEERw47HGpvYVOfrPvkvwC/EGU0xAFvwKvTt
	xuDI7XYvYHNt2OpYEB0bTj8ZTLU0r47j6CRzc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AEEA375533;
	Mon, 17 Mar 2014 16:33:00 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C61E07552F;
	Mon, 17 Mar 2014 16:32:59 -0400 (EDT)
In-Reply-To: <1395060676-23144-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 17
 Mar 2014 19:51:16 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 54995958-AE13-11E3-94E5-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244279>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  v2 renames the option name to --nonlinear-barrier and fixes using it
>  with --dense. Best used with --no-merges to see patch series.

I think that the earlier name "show linear-break" is more easily
understood than the new name, but maybe that is just me.  It's not
like you are blocking something from going forward with a barrier,
and internally it is called a "break-bar".

>  Documentation/rev-list-options.txt |  7 ++++++
>  log-tree.c                         |  4 +++
>  revision.c                         | 51 ++++++++++++++++++++++++++++=
+++++++---
>  revision.h                         |  6 +++++
>  4 files changed, 65 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-l=
ist-options.txt
> index 03533af..435aa2d 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -750,6 +750,13 @@ This enables parent rewriting, see 'History Simp=
lification' below.
>  This implies the `--topo-order` option by default, but the
>  `--date-order` option may also be specified.
> =20
> +--nonlinear-barrier[=3D<barrier>]::
> +	When --graph is not used, all history branches are flatten and

s/flatten and/flattened and it/, perhaps?

> +	could be hard to see that the two consecutive commits do not
> +	belong to a linear branch. This option puts a barrier in
> +	between them in that case. If `<barrier>` is specified, it
> +	is the string that will be shown instead of the default one.
> +
>  ifdef::git-rev-list[]
>  --count::
>  	Print a number stating how many commits would have been
> diff --git a/log-tree.c b/log-tree.c
> index 08970bf..17862f6 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -805,12 +805,16 @@ int log_tree_commit(struct rev_info *opt, struc=
t commit *commit)
>  	if (opt->line_level_traverse)
>  		return line_log_print(opt, commit);
> =20
> +	if (opt->track_linear && !opt->linear && !opt->reverse_output_stage=
)
> +		printf("\n%s\n", opt->break_bar);
>  	shown =3D log_tree_diff(opt, commit, &log);
>  	if (!shown && opt->loginfo && opt->always_show_header) {
>  		log.parent =3D NULL;
>  		show_log(opt);
>  		shown =3D 1;
>  	}
> +	if (opt->track_linear && !opt->linear && opt->reverse_output_stage)
> +		printf("\n%s\n", opt->break_bar);

Each time get_revision() returns a commit, it is inspected and
opt->linear is updated, this function is called and we show the
break in the single-strand-of-pearls if this is not a parent of the
commit we showed immediately before.  If we are showing the commit
in reverse, we have to go the other way around, showing the commit
and then the break.

OK.  It makes sense to me.

>  	opt->loginfo =3D NULL;
>  	maybe_flush_or_die(stdout, "stdout");
>  	return shown;

Does this new feature interact with -z format output in any way?
Should it, and if so how?

> diff --git a/revision.c b/revision.c
> index a68fde6..0a4849e 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1832,6 +1832,12 @@ static int handle_revision_opt(struct rev_info=
 *revs, int argc, const char **arg
>  		revs->notes_opt.use_default_notes =3D 1;
>  	} else if (!strcmp(arg, "--show-signature")) {
>  		revs->show_signature =3D 1;
> +	} else if (!strcmp(arg, "--nonlinear-barrier")) {
> +		revs->track_linear =3D 1;
> +		revs->break_bar =3D "                    ..........";
> +	} else if (starts_with(arg, "--nonlinear-barrier=3D")) {
> +		revs->track_linear =3D 1;
> +		revs->break_bar =3D xstrdup(arg + 20);
>  	} else if (starts_with(arg, "--show-notes=3D") ||
>  		   starts_with(arg, "--notes=3D")) {
>  		struct strbuf buf =3D STRBUF_INIT;
> @@ -2897,6 +2903,32 @@ enum commit_action simplify_commit(struct rev_=
info *revs, struct commit *commit)
>  	return action;
>  }
> =20
> +define_commit_slab(saved_linear, int);
> +
> +static void track_linear(struct rev_info *revs, struct commit *commi=
t)
> +{
> +	struct commit_list *p =3D revs->previous_parents;
> +
> +	if (p) {
> +		int got_parent =3D 0;
> +		for (; p && !got_parent; p =3D p->next)
> +			got_parent =3D !hashcmp(p->item->object.sha1,
> +					      commit->object.sha1);
> +		revs->linear =3D got_parent;
> +		free_commit_list(revs->previous_parents);
> +	} else
> +		revs->linear =3D 1;
> +	if (revs->reverse) {
> +		if (!revs->saved_linear_slab) {
> +			revs->saved_linear_slab =3D xmalloc(sizeof(struct saved_linear));
> +			init_saved_linear(revs->saved_linear_slab);
> +		}
> +
> +		*saved_linear_at(revs->saved_linear_slab, commit) =3D revs->linear=
;
> +	}
> +	revs->previous_parents =3D copy_commit_list(commit->parents);

We are showing commit, and the parents (after history
simplification) of the commit we showed before this commit is kept
in previous-parents.  If we are one of them, we are showing
linearly, which makes sense.  While we are accumulating the output
in the forward direction in preparation for later emitting them in
reverse, we need to save away the linear-ness bit somewhere, and a
slab is a logical place to save that, which also makes sense.  But
why do you need a full int?  Doesn't an unsigned char wide enough?

I also wondered if the saved-parents slab we already have can be
easily reused for this, but it probably would not help.

I do not quite understand the "if we do not have previous parents"
bit, though.  Is it meant to trigger only at the very beginning?

Thanks.
