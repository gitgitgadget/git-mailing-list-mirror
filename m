From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Support pathspec magic :(exclude) and its short form :-
Date: Wed, 20 Nov 2013 15:48:24 -0800
Message-ID: <xmqqhab663ef.fsf@gitster.dls.corp.google.com>
References: <xmqqsix3z8ie.fsf@gitster.dls.corp.google.com>
	<1384911691-11664-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr, toralf.foerster@gmx.de
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 21 00:48:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjHVZ-0001sW-BL
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 00:48:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755512Ab3KTXs3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Nov 2013 18:48:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65225 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755403Ab3KTXs2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Nov 2013 18:48:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C33D8532AC;
	Wed, 20 Nov 2013 18:48:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Mux59/ikFVZL
	NPns5RpLoSwIkMM=; b=TEGQaNrITV19jmbnAqqe51xoZh+D/E46yEBtpfpH1hHT
	sbTGonRy2Do+PyifXSCqMGtztCrat2C16jifsJLFTavQT2PlYfQjLXPPrCkUxg2B
	8c0ktyTEES8cttCU1HS2vlzRk8IqoH35SBRtcSVPd4v05X06oD2rLuR0i4KEjro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qRpLgN
	ASDYPDIT7dJSOeLDhjeSHgbgePV3eBtAA2hpTi5lYZe+HPjr6PhldhtY5vNZNWA+
	T6pjEsPFPY6CLnt8mItMyW/f8u5QjBheuOGWsjnyK9JeyljPYS0T7NX4hjMwW8w3
	z9qgQPJSbpCx3D2sKsDp0Iq+FDZRyJVC0PWOY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B21F7532A9;
	Wed, 20 Nov 2013 18:48:27 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E2060532A8;
	Wed, 20 Nov 2013 18:48:26 -0500 (EST)
In-Reply-To: <1384911691-11664-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 20
 Nov 2013 08:41:31 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 402DB0F8-523E-11E3-9C13-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238107>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  This is yet another stab at the negative pathspec thing. It's not
>  ready yet (there are a few XXXs) but I could use some feedback
>  regarding the interface, or the behavior. It looks better this time
>  now that pathspec magic is supported (or maybe I'm just biased).
>
>  For :(glob) or :(icase) you're more likely to enable it for all
>  pathspec, i.e. --glob-pathspecs. But I expect :(exclude) to be typed
>  more often (it does not make sense to add --exclude-pathspecs to
>  exclude everything), which is why I add the short form for it.
>
>  We don't have many options that say "negative" in short form.
>  Either '!', '-' or '~'. '!' is already used for bash history expansi=
on.
>  ~ looks more like $HOME expansion. Which left me '-'.

I agree with your decision to reject ~, but "!not-this-pattern" is
very much consistent with the patterns used in .gitignore (and the
"--exclude <pattern>" option), so avoiding "!" and introducing an
inconsistent "-" only to appease bash leaves somewhat a funny taste
in my mouth.

>  Documentation/glossary-content.txt |  5 ++++
>  builtin/add.c                      |  5 +++-
>  dir.c                              | 50 ++++++++++++++++++++++++++++=
+++-----
>  pathspec.c                         |  9 ++++++-
>  pathspec.h                         |  4 ++-
>  tree-walk.c                        | 52 ++++++++++++++++++++++++++++=
+++++++---
>  6 files changed, 112 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/glossary-content.txt b/Documentation/gloss=
ary-content.txt
> index e470661..f7d7d8c 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -377,6 +377,11 @@ full pathname may have special meaning:
>   - Other consecutive asterisks are considered invalid.
>  +
>  Glob magic is incompatible with literal magic.
> +
> +exclude `-`;;
> +	After a path matches any non-exclude pathspec, it will be run
> +	through all exclude pathspec. If it matches, the path is
> +	ignored.
>  --
>  +
>  Currently only the slash `/` is recognized as the "magic signature",

No longer, no?  "magic signature" is a non-alphanumeric that follows
the ':' introducer, as opposed to "magic words" that are in ":(...)".

> diff --git a/builtin/add.c b/builtin/add.c
> index 226f758..0df73ae 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -540,10 +540,13 @@ int cmd_add(int argc, const char **argv, const =
char *prefix)
>  			       PATHSPEC_FROMTOP |
>  			       PATHSPEC_LITERAL |
>  			       PATHSPEC_GLOB |
> -			       PATHSPEC_ICASE);
> +			       PATHSPEC_ICASE |
> +			       PATHSPEC_EXCLUDE);
> =20
>  		for (i =3D 0; i < pathspec.nr; i++) {
>  			const char *path =3D pathspec.items[i].match;
> +			if (pathspec.items[i].magic & PATHSPEC_EXCLUDE)
> +				continue;
>  			if (!seen[i] &&
>  			    ((pathspec.items[i].magic &
>  			      (PATHSPEC_GLOB | PATHSPEC_ICASE)) ||

So "git add ':(exclude)junk/' '*.c'" to add all .c files except for
the ones in the 'junk/' directory may find that ':(exclude)junk/'
matched nothing (because there is no .c file in there), and that is
not an error.  It makes sense to me.

> diff --git a/dir.c b/dir.c
> index 23b6de4..e2df82f 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -126,10 +126,13 @@ static size_t common_prefix_len(const struct pa=
thspec *pathspec)
>  		       PATHSPEC_MAXDEPTH |
>  		       PATHSPEC_LITERAL |
>  		       PATHSPEC_GLOB |
> -		       PATHSPEC_ICASE);
> +		       PATHSPEC_ICASE |
> +		       PATHSPEC_EXCLUDE);
> =20
>  	for (n =3D 0; n < pathspec->nr; n++) {
>  		size_t i =3D 0, len =3D 0, item_len;
> +		if (pathspec->items[n].magic & PATHSPEC_EXCLUDE)
> +			continue;
>  		if (pathspec->items[n].magic & PATHSPEC_ICASE)
>  			item_len =3D pathspec->items[n].prefix;
>  		else

Likewise.  Exclusion does not participate in the early culling with
the common prefix.

> @@ -1375,11 +1407,17 @@ int read_directory(struct dir_struct *dir, co=
nst char *path, int len, const stru
>  			       PATHSPEC_MAXDEPTH |
>  			       PATHSPEC_LITERAL |
>  			       PATHSPEC_GLOB |
> -			       PATHSPEC_ICASE);
> +			       PATHSPEC_ICASE |
> +			       PATHSPEC_EXCLUDE);
> =20
>  	if (has_symlink_leading_path(path, len))
>  		return dir->nr;
> =20
> +	/*
> +	 * XXX: exclude patterns are treated like positive ones in
> +	 * create_simplify! This is not wrong, but may make path
> +	 * filtering less efficient.
> +	 */

True, but "git add ':(exclude)a/b/c' a/b" would not suffer.  And
those who do "git add ':(exclude)a/b' a/b/c" deserve it, no ;-)?

> @@ -427,6 +430,10 @@ void parse_pathspec(struct pathspec *pathspec,
>  		pathspec->magic |=3D item[i].magic;
>  	}
> =20
> +	if (nr_exclude =3D=3D n)
> +		die(_("There is nothing to exclude from by :(exclude) patterns.\n"
> +		      "Perhaps you forgot to add either ':/' or '.' ?"));

;-).

> +enum interesting tree_entry_interesting(const struct name_entry *ent=
ry,
> +					struct strbuf *base, int base_offset,
> +					const struct pathspec *ps)
> +{
> +	enum interesting positive, negative;
> +	positive =3D tree_entry_interesting_1(entry, base, base_offset, ps,=
 0);
> +
> +	/*
> +	 *   #  | positive | negative | result
> +	 * -----+----------+----------+-------
> +	 * 1..4 |   -1     |    *     |  -1
> +	 * 5..8 |    0     |    *     |   0
> +	 *   9  |    1     |   -1     |   1
> +	 *  10  |    1     |    0     |   1
> +	 *  11  |    1     |    1     |   0
> +	 *  12  |    1     |    2     |   0
> +	 *  13  |    2     |   -1     |   2
> +	 *  14  |    2     |    0     |   2
> +	 *  15  |    2     |    1     |   0
> +	 *  16  |    2     |    2     |  -1
> +	 */

Not sure what this case-table means...

> +	if (!(ps->magic & PATHSPEC_EXCLUDE) ||
> +	    positive <=3D entry_not_interesting) /* #1..#8 */
> +		return positive;
> +
> +	negative =3D tree_entry_interesting_1(entry, base, base_offset, ps,=
 1);
> +
> +	if (negative <=3D entry_not_interesting)	 /* #9, #10, #13, #14 */
> +		return positive;
> +	if ((positive =3D=3D entry_interesting &&
> +	     negative >=3D entry_interesting) || /* #11, #12 */
> +	    (positive =3D=3D all_entries_interesting &&
> +	     negative =3D=3D entry_interesting)) /* #15 */
> +		return entry_not_interesting;
> +	return all_entries_not_interesting; /* #16 */
> +}
