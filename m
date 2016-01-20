From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/7] log: add --rename-notes to correct renames per commit
Date: Wed, 20 Jan 2016 15:29:56 -0800
Message-ID: <xmqqoacf3k3v.fsf@gitster.mtv.corp.google.com>
References: <1453287968-26000-1-git-send-email-pclouds@gmail.com>
	<1453287968-26000-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 00:30:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aM2CS-0007xa-6D
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 00:30:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752941AbcATXaA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jan 2016 18:30:00 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54490 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751821AbcATX36 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jan 2016 18:29:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E64473E8F6;
	Wed, 20 Jan 2016 18:29:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3oF2szvpk5H6
	EuTbpBFKsMjM6Do=; b=Y9n3y40ocnow4S/U1ZCaccvgI8z118i1ZNIDJ1SnvgeU
	uygZBaQC3R/T6/xudQSju2TuB6PPFvU0DReEU/wLw4dPcqWpZw/KuaAaeVyPg1px
	7X44q/KhsWZjg8gnnHWdjNaShl9yP0JdSk+jbwPdjFDplzDdeIHl1oDYX+A8nDU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xjzdtZ
	epSVJCcfV8EWGzGH9w6WZtIWdKbKAzN3Q5wAoiIA/a6NjBvRMQokfKVTwK9I4McK
	McqQH4pLgmaulvycWgWLNmJiDlcB+Q6Zl+rvhUaL5fo2mBynTfxZ/6StV7Z19vir
	TmeCRQdbV7iwPYG0dypr7k4kcB8ZIoDsruvnM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DCC383E8F5;
	Wed, 20 Jan 2016 18:29:57 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 497213E8F4;
	Wed, 20 Jan 2016 18:29:57 -0500 (EST)
In-Reply-To: <1453287968-26000-5-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 20
 Jan 2016 18:06:05 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B78A2E7A-BFCD-11E5-8183-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284483>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> For simplicity, the note of commit A implies rename correction betwee=
n
> A^ and A. If parents are manipulated (e.g. "git log --reflog") then
> the rename output may surprise people.

I do not think "git log --reflog" attempts to show changes to bring
the tree of @{2} into the shape of @{1}, even though for traversal
purposes it pretends as if @{1}'s parent is @{2}.  So I am not sure
what you are trying to say in the above sentence.

A path limited "git log -- path1/ path2/..." also manipulates the
commit->parents for traversal purposes, but I think the patch is
still produced against the true parents (there is a call to
get_saved_parents() in log_tree_diff() that shows the change for a
given commit), and in that context, commit A that has notes about
the change to bring the tree of commit A^ to its tree still makes
sense.

I'd be more worried about "git log -m -p"--the diff against the
second and subsequent parents would not want to use the notes that
describes the change between the first parent and the resulting
merge.


>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/pretty-options.txt |  5 +++++
>  log-tree.c                       | 32 ++++++++++++++++++++++++++++++=
++
>  revision.c                       | 10 ++++++++++
>  revision.h                       |  1 +
>  t/t4001-diff-rename.sh           | 24 ++++++++++++++++++++++++
>  5 files changed, 72 insertions(+)
>
> diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-=
options.txt
> index 4b659ac..15a2971 100644
> --- a/Documentation/pretty-options.txt
> +++ b/Documentation/pretty-options.txt
> @@ -75,6 +75,11 @@ being displayed. Examples: "--notes=3Dfoo" will sh=
ow only notes from
>  --[no-]standard-notes::
>  	These options are deprecated. Use the above --notes/--no-notes
>  	options instead.
> +
> +--rename-notes=3D<ref>::
> +	Get per-commit rename instructions from notes. See option
> +	`--rename-file` for more information. If both `--rename-notes`
> +	and `--rename-file` are specified, the last one takes effect.
>  endif::git-rev-list[]
> =20
>  --show-signature::
> diff --git a/log-tree.c b/log-tree.c
> index f70a30e..e5766a6 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -788,6 +788,36 @@ static int do_diff_combined(struct rev_info *opt=
, struct commit *commit)
>  	return !opt->loginfo;
>  }
> =20
> +static void populate_rename_notes(struct rev_info *opt, const struct=
 object_id *oid)
> +{
> +	static char *last_note;
> +	enum object_type type;
> +	unsigned long size;
> +	const unsigned char *sha1;
> +
> +	if (!opt->rename_notes)
> +		return;
> +
> +	/*
> +	 * "--rename-notes=3Dabc --rename-file=3Ddef" is specified in this
> +	 * order, --rename-file wins.
> +	 */
> +	if (opt->diffopt.manual_renames !=3D NULL &&
> +	    opt->diffopt.manual_renames !=3D last_note)
> +		return;
> +
> +	free(last_note);
> +	opt->diffopt.manual_renames =3D NULL;
> +
> +	sha1 =3D get_note(opt->rename_notes, oid->hash);
> +	if (!sha1)
> +		return;
> +
> +	last_note =3D read_sha1_file(sha1, &type, &size);
> +	if (type =3D=3D OBJ_BLOB)
> +		opt->diffopt.manual_renames =3D last_note;
> +}
> +
>  /*
>   * Show the diff of a commit.
>   *
> @@ -805,6 +835,8 @@ static int log_tree_diff(struct rev_info *opt, st=
ruct commit *commit, struct log
>  	parse_commit_or_die(commit);
>  	oid =3D &commit->tree->object.oid;
> =20
> +	populate_rename_notes(opt, &commit->object.oid);
> +
>  	/* Root commit? */
>  	parents =3D get_saved_parents(opt, commit);
>  	if (!parents) {
> diff --git a/revision.c b/revision.c
> index 14daefb..20346c1 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1958,6 +1958,16 @@ static int handle_revision_opt(struct rev_info=
 *revs, int argc, const char **arg
>  		revs->notes_opt.use_default_notes =3D 1;
>  	} else if (!strcmp(arg, "--no-standard-notes")) {
>  		revs->notes_opt.use_default_notes =3D 0;
> +	} else if (skip_prefix(arg, "--rename-notes=3D", &optarg)) {
> +		struct strbuf buf =3D STRBUF_INIT;
> +		struct notes_tree *nt;
> +
> +		strbuf_addstr(&buf, optarg);
> +		expand_notes_ref(&buf);
> +		revs->rename_notes =3D nt =3D xcalloc(1, sizeof(*nt));
> +		init_notes(nt, buf.buf, NULL, 0);
> +		strbuf_release(&buf);
> +		revs->diffopt.manual_renames =3D NULL;
>  	} else if (!strcmp(arg, "--oneline")) {
>  		revs->verbose_header =3D 1;
>  		get_commit_format("oneline", revs);
> diff --git a/revision.h b/revision.h
> index 23857c0..db2f225 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -189,6 +189,7 @@ struct rev_info {
>  	/* diff info for patches and for paths limiting */
>  	struct diff_options diffopt;
>  	struct diff_options pruning;
> +	struct notes_tree *rename_notes;
> =20
>  	struct reflog_walk_info *reflog_info;
>  	struct decoration children;
> diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
> index ab9a666..21d9378 100755
> --- a/t/t4001-diff-rename.sh
> +++ b/t/t4001-diff-rename.sh
> @@ -189,4 +189,28 @@ test_expect_success 'manual rename correction' '
>  	)
>  '
> =20
> +test_expect_success 'rename correction from notes' '
> +	(
> +		cd correct-rename &&
> +		git show --summary -M HEAD | grep rename >actual &&
> +		cat >expected <<-\EOF &&
> +		 rename old-one =3D> new-one (100%)
> +		 rename old-two =3D> new-two (100%)
> +		EOF
> +		test_cmp expected actual &&
> +
> +		cat >correction <<-\EOF &&
> +		old-one =3D> new-two
> +		old-two =3D> new-one
> +		EOF
> +		git notes --ref=3Drename add -F correction HEAD &&
> +		git show --summary -M --rename-notes=3Drename HEAD | grep rename >=
actual &&
> +		cat >expected <<-\EOF &&
> +		 rename old-two =3D> new-one (100%)
> +		 rename old-one =3D> new-two (100%)
> +		EOF
> +		test_cmp expected actual
> +	)
> +'
> +
>  test_done
