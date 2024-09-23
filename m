Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC691A01BF
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 19:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727120291; cv=none; b=jFIvxT2Ix7TVGg1TQjTnTFmf1rIAd60YuZdMG0Llmi7jo+tcxbbp2t8qVn/kOVysklwKH8lNRoqGyeO9tqB2XjoYOU0uL9eboO0jVNOilVeQWWmvReh0J0/kiWuV/VxB5tQGleVMCJqxQgjlSDJGukOR0ma8s978iMhJvboyX20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727120291; c=relaxed/simple;
	bh=pcOVcKTGU20WSRBpSUTwhmxYOlu9JkXM5xcWdpcJ6iw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rDC5qOg/N1wGjNPSpCZw6PIqK7flFHl9Auub4zueHPDDHC8VsJyB1MvdR7I8mN6BQ/a/RsiH6+WiIBS9m01p0lkUt/LYNLw7SsCjuWsYuxeW4+1m5nx+TvjQCO0z4qwCkjmViqT3c6GxjmCYTO3RYUoAF7631g+VxlSQaOpHnqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=UDE984xu; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UDE984xu"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 60D1A29B03;
	Mon, 23 Sep 2024 15:38:08 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=pcOVcKTGU20W
	SRBpSUTwhmxYOlu9JkXM5xcWdpcJ6iw=; b=UDE984xu+RoTSYa9RR76paABrSAn
	LqMZwlb7Yk/tmBP9nD7lqYVzotxQvfHQHIaVQFZvUn6pEs/88QViOydBBcieALT/
	j6b5oDxzpY1HHop9tVaraAGkUCEYxIU1fz6qyYtlArSJRxLVwGt+gn+3e+URwWYn
	jfnPkGz5HxcAz10=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4531929B02;
	Mon, 23 Sep 2024 15:38:08 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D108629B00;
	Mon, 23 Sep 2024 15:38:06 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Nicolas Guichard via GitGitGadget" <gitgitgadget@gmail.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org,  Nicolas Guichard <nicolas@guichard.eu>
Subject: Re: [PATCH 2/2] rebase-merges: try and use branch names as labels
In-Reply-To: <9afe428927d71df360929238c50284d4c59beaea.1726943880.git.gitgitgadget@gmail.com>
	(Nicolas Guichard via GitGitGadget's message of "Sat, 21 Sep 2024
	18:38:00 +0000")
References: <pull.1784.git.git.1726943880.gitgitgadget@gmail.com>
	<9afe428927d71df360929238c50284d4c59beaea.1726943880.git.gitgitgadget@gmail.com>
Date: Mon, 23 Sep 2024 12:38:04 -0700
Message-ID: <xmqq34lq17qb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 5B782450-79E3-11EF-B536-9B0F950A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Running

    git blame -L'/^static int make_script_with_merges/,/^}/' sequencer.c

tells me that the code range this patch touches and the function
whose feature this patch extends was mostly introduced in 1644c73c
(rebase-helper --make-script: introduce a flag to rebase merges,
2018-04-25) by Johannes Schindelin (CC'ed), so let's ask input from
him as an area expert.

Thanks.

"Nicolas Guichard via GitGitGadget" <gitgitgadget@gmail.com> writes:
> From: Nicolas Guichard <nicolas@guichard.eu>
>
> When interactively rebasing merge commits, the commit message is parsed=
 to
> extract a probably meaningful label name. For instance if the merge com=
mit
> is =E2=80=9CMerge branch 'feature0'=E2=80=9D, then the rebase script wi=
ll have thes lines:
> ```
> label feature0
>
> merge -C $sha feature0 # =E2=80=9CMerge branch 'feature0'
> ```
>
> This heuristic fails in the case of octopus merges or when the merge co=
mmit
> message is actually unrelated to the parent commits.
>
> An example that combines both is:
> ```
> *---.   967bfa4 (HEAD -> integration) Integration
> |\ \ \
> | | | * 2135be1 (feature2, feat2) Feature 2
> | |_|/
> |/| |
> | | * c88b01a Feature 1
> | |/
> |/|
> | * 75f3139 (feat0) Feature 0
> |/
> * 25c86d0 (main) Initial commit
> ```
> yields the labels Integration, Integration-2 and Integration-3.
>
> Fix this by using a branch name for each merge commit's parent that is =
the
> tip of at least one branch, and falling back to a label derived from th=
e
> merge commit message otherwise.
> In the example above, the labels become feat0, Integration and feature2=
.
>
> Signed-off-by: Nicolas Guichard <nicolas@guichard.eu>
> ---
>  sequencer.c                   | 25 +++++++++++++++++--------
>  t/t3404-rebase-interactive.sh |  4 ++--
>  t/t3430-rebase-merges.sh      | 12 ++++++------
>  3 files changed, 25 insertions(+), 16 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index e5eb6f8cd76..a092bd05692 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -5833,7 +5833,7 @@ static int make_script_with_merges(struct pretty_=
print_context *pp,
>  	int root_with_onto =3D flags & TODO_LIST_ROOT_WITH_ONTO;
>  	int skipped_commit =3D 0;
>  	struct strbuf buf =3D STRBUF_INIT, oneline =3D STRBUF_INIT;
> -	struct strbuf label =3D STRBUF_INIT;
> +	struct strbuf label_from_message =3D STRBUF_INIT;
>  	struct commit_list *commits =3D NULL, **tail =3D &commits, *iter;
>  	struct commit_list *tips =3D NULL, **tips_tail =3D &tips;
>  	struct commit *commit;
> @@ -5856,6 +5856,7 @@ static int make_script_with_merges(struct pretty_=
print_context *pp,
>  	oidmap_init(&state.commit2label, 0);
>  	hashmap_init(&state.labels, labels_cmp, NULL, 0);
>  	strbuf_init(&state.buf, 32);
> +	load_branch_decorations();
> =20
>  	if (revs->cmdline.nr && (revs->cmdline.rev[0].flags & BOTTOM)) {
>  		struct labels_entry *onto_label_entry;
> @@ -5916,18 +5917,18 @@ static int make_script_with_merges(struct prett=
y_print_context *pp,
>  			continue;
>  		}
> =20
> -		/* Create a label */
> -		strbuf_reset(&label);
> +		/* Create a label from the commit message */
> +		strbuf_reset(&label_from_message);
>  		if (skip_prefix(oneline.buf, "Merge ", &p1) &&
>  		    (p1 =3D strchr(p1, '\'')) &&
>  		    (p2 =3D strchr(++p1, '\'')))
> -			strbuf_add(&label, p1, p2 - p1);
> +			strbuf_add(&label_from_message, p1, p2 - p1);
>  		else if (skip_prefix(oneline.buf, "Merge pull request ",
>  				     &p1) &&
>  			 (p1 =3D strstr(p1, " from ")))
> -			strbuf_addstr(&label, p1 + strlen(" from "));
> +			strbuf_addstr(&label_from_message, p1 + strlen(" from "));
>  		else
> -			strbuf_addbuf(&label, &oneline);
> +			strbuf_addbuf(&label_from_message, &oneline);
> =20
>  		strbuf_reset(&buf);
>  		strbuf_addf(&buf, "%s -C %s",
> @@ -5935,6 +5936,14 @@ static int make_script_with_merges(struct pretty=
_print_context *pp,
> =20
>  		/* label the tips of merged branches */
>  		for (; to_merge; to_merge =3D to_merge->next) {
> +			const char *label =3D label_from_message.buf;
> +			const struct name_decoration *decoration =3D
> +				get_name_decoration(&to_merge->item->object);
> +
> +			if (decoration)
> +				skip_prefix(decoration->name, "refs/heads/",
> +					    &label);
> +
>  			oid =3D &to_merge->item->object.oid;
>  			strbuf_addch(&buf, ' ');
> =20
> @@ -5947,7 +5956,7 @@ static int make_script_with_merges(struct pretty_=
print_context *pp,
>  			tips_tail =3D &commit_list_insert(to_merge->item,
>  							tips_tail)->next;
> =20
> -			strbuf_addstr(&buf, label_oid(oid, label.buf, &state));
> +			strbuf_addstr(&buf, label_oid(oid, label, &state));
>  		}
>  		strbuf_addf(&buf, " # %s", oneline.buf);
> =20
> @@ -6055,7 +6064,7 @@ static int make_script_with_merges(struct pretty_=
print_context *pp,
>  	free_commit_list(commits);
>  	free_commit_list(tips);
> =20
> -	strbuf_release(&label);
> +	strbuf_release(&label_from_message);
>  	strbuf_release(&oneline);
>  	strbuf_release(&buf);
> =20
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
.sh
> index f171af3061d..4896a801ee2 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1870,7 +1870,7 @@ test_expect_success '--update-refs adds commands =
with --rebase-merges' '
>  		pick $(git log -1 --format=3D%h branch2~1) F
>  		pick $(git log -1 --format=3D%h branch2) I
>  		update-ref refs/heads/branch2
> -		label merge
> +		label branch2
>  		reset onto
>  		pick $(git log -1 --format=3D%h refs/heads/second) J
>  		update-ref refs/heads/second
> @@ -1881,7 +1881,7 @@ test_expect_success '--update-refs adds commands =
with --rebase-merges' '
>  		update-ref refs/heads/third
>  		pick $(git log -1 --format=3D%h HEAD~2) M
>  		update-ref refs/heads/no-conflict-branch
> -		merge -C $(git log -1 --format=3D%h HEAD~1) merge # merge
> +		merge -C $(git log -1 --format=3D%h HEAD~1) branch2 # merge
>  		update-ref refs/heads/merge-branch
>  		EOF
> =20
> diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
> index 2aa8593f77a..cb891eeb5fd 100755
> --- a/t/t3430-rebase-merges.sh
> +++ b/t/t3430-rebase-merges.sh
> @@ -108,19 +108,19 @@ test_expect_success 'generate correct todo list' =
'
> =20
>  	reset onto
>  	pick $b B
> -	label E
> +	label first
> =20
>  	reset onto
>  	pick $c C
>  	label branch-point
>  	pick $f F
>  	pick $g G
> -	label H
> +	label second
> =20
>  	reset branch-point # C
>  	pick $d D
> -	merge -C $e E # E
> -	merge -C $h H # H
> +	merge -C $e first # E
> +	merge -C $h second # H
> =20
>  	EOF
> =20
> @@ -462,11 +462,11 @@ test_expect_success 'A root commit can be a cousi=
n, treat it that way' '
>  '
> =20
>  test_expect_success 'labels that are object IDs are rewritten' '
> -	git checkout -b third B &&
> +	git checkout --detach B &&
>  	test_commit I &&
>  	third=3D$(git rev-parse HEAD) &&
>  	git checkout -b labels main &&
> -	git merge --no-commit third &&
> +	git merge --no-commit $third &&
>  	test_tick &&
>  	git commit -m "Merge commit '\''$third'\'' into labels" &&
>  	echo noop >script-from-scratch &&
