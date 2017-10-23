Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95F3C202DD
	for <e@80x24.org>; Mon, 23 Oct 2017 03:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751146AbdJWDep (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Oct 2017 23:34:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61622 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751082AbdJWDeo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Oct 2017 23:34:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E707AD717;
        Sun, 22 Oct 2017 23:34:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yu67OhlrYje8
        7zSO7nnGGdJxuB8=; b=ViUEAPNb96bbrU7td6jsUmm8sTw4nge5F51i9DBmiRjk
        WNmXVC+8K7MOfYohpjRj5cXRKjK4eAIegv6pNlxqkIiE5bF3EQkmfWxL6R/X3XVW
        zLw62MbF7d+iHD2B9GMjxlGh/JbQSSYLxpZ+KoWi9tp3NXaSR/ewfqNPMrhAiFo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ACL4X4
        R5BwNCiyRv2FIhyU/ojXPgxk8Kxn0OLlYGyHHHmLGVTAFzG+hWPpZU1nCuTmjWg8
        D7kwbMfQ2oACG8oeNzW3tz7CD5b5Xj1jaUmyu+uPF0inrcEGKKRDk94u5bT6IOd/
        idUP4c7rRUgbTSG+V399DOa7GJl67XfB1uKsA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 76269AD716;
        Sun, 22 Oct 2017 23:34:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D68BAAD715;
        Sun, 22 Oct 2017 23:34:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jameson Miller <jameson.miller81@gmail.com>
Cc:     bmwill@google.com, git@vger.kernel.org, jamill@microsoft.com,
        peff@peff.net, sbeller@google.com
Subject: Re: [PATCH v3 1/4] status: add option to show ignored files differently
References: <20171005205443.206900-1-jameson.miller81@gmail.com>
        <20171019160601.9382-1-jamill@microsoft.com>
        <20171019160601.9382-2-jamill@microsoft.com>
Date:   Mon, 23 Oct 2017 12:34:41 +0900
In-Reply-To: <20171019160601.9382-2-jamill@microsoft.com> (Jameson Miller's
        message of "Thu, 19 Oct 2017 12:05:58 -0400")
Message-ID: <xmqqzi8ibkq6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1B9E19A2-B7A3-11E7-9298-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jameson Miller <jameson.miller81@gmail.com> writes:

> Teach the status command more flexibility in how ignored files are
> reported. Currently, the reporting of ignored files and untracked
> files are linked. You cannot control how ignored files are reported
> independently of how untracked files are reported (i.e. `all` vs
> `normal`). This makes it impossible to show untracked files with the
> `all` option, but show ignored files with the `normal` option.
>=20
> This work 1) adds the ability to control the reporting of ignored
> files independently of untracked files and 2) introduces the concept
> of status reporting ignored paths that explicitly match an ignored
> pattern. ...
>
> When status is set to report matching ignored files, it has the
> following behavior. Ignored files and directories that explicitly
> match an exclude pattern are reported. If an ignored directory matches
> an exclude pattern, then the path of the directory is returned. If a
> directory does not match an exclude pattern, but all of its contents
> are ignored, then the contained files are reported instead of the
> directory.

Thanks for an updated log message.  Very nicely explained.

> +static void handle_ignored_arg(struct wt_status *s)
> +{
> +	if (!ignored_arg)
> +		; /* default already initialized */
> +	else if (!strcmp(ignored_arg, "traditional"))
> +		s->show_ignored_mode =3D SHOW_TRADITIONAL_IGNORED;
> +	else if (!strcmp(ignored_arg, "no"))
> +		s->show_ignored_mode =3D SHOW_NO_IGNORED;
> +	else if (!strcmp(ignored_arg, "matching"))
> +		s->show_ignored_mode =3D SHOW_MATCHING_IGNORED;
> +	else
> +		die(_("Invalid ignored mode '%s'"), ignored_arg);
> +}
> =20
>  static void handle_untracked_files_arg(struct wt_status *s)
>  {
> @@ -1363,8 +1376,10 @@ int cmd_status(int argc, const char **argv, cons=
t char *prefix)
>  		  N_("mode"),
>  		  N_("show untracked files, optional modes: all, normal, no. (Defaul=
t: all)"),
>  		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
> -		OPT_BOOL(0, "ignored", &show_ignored_in_status,
> -			 N_("show ignored files")),
> +		{ OPTION_STRING, 0, "ignored", &ignored_arg,
> +		  N_("mode"),
> +		  N_("show ignored files, optional modes: traditional, matching, no.=
 (Default: traditional)"),
> +		  PARSE_OPT_OPTARG, NULL, (intptr_t)"traditional" },

We used to use "show_ignored_in_status" variable that can be either
0 (when no --ignored is given, or an explicit --no-ignored is given,
on the command line) or 1 (when --ignored is given on the command
line).

We still allow "--ignored" without value for backward compatibility,
but=20

    $ git status -uall --ignored \*.c

may trigger die() from handle_ignored_arg().  I wonder if this is
something we care about.

	... goes and digs ...

OK, because of PARSE_OPT_OPTARG, the above is safe; "*.c" is not
mistaken as the value given to the --ignored option.  It also means
that

    $ git status -uno --ignored matching

would not mean what a na=C3=AFve reader may expect and does not error
out, even though

    $ git status -uno --ignored=3Dmatching

would.  Which is something we eventually might care about, but that
is how parse-options PARSE_OPT_OPTARG works, and I consider "fixing"
it is totally out of the scope of this series (e.g. the next option
"--ignore-submodules" below shares exactly the same issue).

>  		{ OPTION_STRING, 0, "ignore-submodules", &ignore_submodule_arg, N_("=
when"),
>  		  N_("ignore changes to submodules, optional when: all, dirty, untra=
cked. (Default: all)"),
>  		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },

> diff --git a/wt-status.c b/wt-status.c
> index 6f730ee8f2..8301c84946 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -660,10 +660,15 @@ static void wt_status_collect_untracked(struct wt=
_status *s)
>  	if (s->show_untracked_files !=3D SHOW_ALL_UNTRACKED_FILES)
>  		dir.flags |=3D
>  			DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
> -	if (s->show_ignored_files)
> +	if (s->show_ignored_mode) {

Now we no longer use show_ignored_files that was a boolean yes/no,
and instead use an enum show_ignored_mode, we'd better spell this
out like so:

	if (s->show_ignored_mode =3D=3D SHOW_NO_IGNORED) {

>  		dir.flags |=3D DIR_SHOW_IGNORED_TOO;
> -	else
> +
> +		if (s->show_ignored_mode =3D=3D SHOW_MATCHING_IGNORED)
> +			dir.flags |=3D DIR_SHOW_IGNORED_TOO_MODE_MATCHING;

Mental note: the old "show_ignored_files is true" case is now split
into two, i.e. traditional vs matching.  When matching is used,
dir.flags gets a new bit, i.e. DIR_SHOW_IGNORED_TOO_MODE_MATCHING.
Lack of that bit means dir.c helpers should behave as before.

> +	} else {
>  		dir.untracked =3D the_index.untracked;
> +	}
> +
>  	setup_standard_excludes(&dir);
> =20
>  	fill_directory(&dir, &the_index, &s->pathspec);
> @@ -1621,7 +1626,7 @@ static void wt_longstatus_print(struct wt_status =
*s)
>  	}
>  	if (s->show_untracked_files) {
>  		wt_longstatus_print_other(s, &s->untracked, _("Untracked files"), "a=
dd");
> -		if (s->show_ignored_files)
> +		if (s->show_ignored_mode)

Likewise, i.e.

	if (s->show_ignored_mode =3D=3D SHOW_NO_IGNORED)

>  			wt_longstatus_print_other(s, &s->ignored, _("Ignored files"), "add =
-f");
>  		if (advice_status_u_option && 2000 < s->untracked_in_ms) {
>  			status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");

> diff --git a/dir.c b/dir.c
> index 1d17b800cf..b9af87eca9 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1389,6 +1389,30 @@ static enum path_treatment treat_directory(struc=
t dir_struct *dir,
>  	case index_nonexistent:
>  		if (dir->flags & DIR_SHOW_OTHER_DIRECTORIES)
>  			break;
> +		if (exclude &&
> +			(dir->flags & DIR_SHOW_IGNORED_TOO) &&
> +			(dir->flags & DIR_SHOW_IGNORED_TOO_MODE_MATCHING)) {

It somehow feels superfluous to check both TOO and TOO_MODE_MATCHING
here (IOW, wouldn't the latter be superset of the former?  Is there
a valid case where the latter is set but not the former?), but it is
perhaps OK as belt-and-suspenders sanity.

> +			/*
> +			 * This is an excluded directory and we are
> +			 * showing ignored paths that match an exclude
> +			 * pattern.  (e.g. show directory as ignored
> +			 * only if it matches an exclude pattern).
> +			 * This path will either be 'path_excluded`
> +			 * (if we are showing empty directories or if
> +			 * the directory is not empty), or will be
> +			 * 'path_none' (empty directory, and we are
> +			 * not showing empty directories).
> +			 */

The only caller of treat_directory() calls us when the path we are
seeing (sans trailing '/' that was added immediately before we were
called) passed "is_excluded()" check in the caller, so at this
point, the directory in question is being excluded because it
matched an exclude pattern.  IOW, if we are a/b/c, a pattern such as
"a/b/*" may have said we are excluded and made the call to this
function.  Do we need to ensure that a pattern like "a/*" is not
what excluded us?  Or IGNORED_TOO_MODE_MATCHING also should show
"a/b/c" when a pattern "a/*" matched it as "ignored because it
matched an exclude pattern"?

> +			if (!(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
> +				return path_excluded;
> +
> +			if (read_directory_recursive(dir, istate, dirname, len,
> +						     untracked, 1, 1, pathspec) =3D=3D path_excluded)
> +				return path_excluded;
> +
> +			return path_none;
> +		}

... I guess we won't get into such a situation because this codepath
will return only _excluded or _none when we are handing "a/b" which
is already excluded "a/*", and does not cause the caller to recurse
into "a/b/c" in the first place.  So the updated code looks fine.

>  		if (!(dir->flags & DIR_NO_GITLINKS)) {
>  			unsigned char sha1[20];
>  			if (resolve_gitlink_ref(dirname, "HEAD", sha1) =3D=3D 0)
> diff --git a/dir.h b/dir.h
> index e3717055d1..57b0943dae 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -152,7 +152,8 @@ struct dir_struct {
>  		DIR_COLLECT_IGNORED =3D 1<<4,
>  		DIR_SHOW_IGNORED_TOO =3D 1<<5,
>  		DIR_COLLECT_KILLED_ONLY =3D 1<<6,
> -		DIR_KEEP_UNTRACKED_CONTENTS =3D 1<<7
> +		DIR_KEEP_UNTRACKED_CONTENTS =3D 1<<7,
> +		DIR_SHOW_IGNORED_TOO_MODE_MATCHING =3D 1<<8
>  	} flags;
>  	struct dir_entry **entries;
>  	struct dir_entry **ignored;
