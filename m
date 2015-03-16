From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH v2] diff-lib.c: adjust position of i-t-a entries in diff
Date: Mon, 16 Mar 2015 16:15:53 +0100
Message-ID: <5506F3A9.1020704@drmicha.warpmail.net>
References: <1425910445-27383-2-git-send-email-pclouds@gmail.com> <1426514206-30949-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 16 16:16:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXWkP-0003LS-9y
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 16:16:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbbCPPQA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Mar 2015 11:16:00 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:42970 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757129AbbCPPP4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Mar 2015 11:15:56 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 564C6212AA
	for <git@vger.kernel.org>; Mon, 16 Mar 2015 11:15:53 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 16 Mar 2015 11:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=+lfEtOooFJ1+kyhNof8hn2
	jH/9A=; b=LOKhujGhXzcZLDPUAiO3cp3QLn4qpQ0J8v/AJo/1zeAPouqENPnKTH
	2tzxdAwZvkK3jRNnvDzHUa7sF4vxmM5If2fPenAskR5OSz2noB8lMIGb6sthZwRL
	7jLM354v8r35KaS98m7PJlyb6ZaIMfqo1B7miSAWXOnyuTz2XfCX0=
X-Sasl-enc: wJFU2mVLEYeUaftws2u0KK8GMzgalIE4qXDZmK3YAmUE 1426518955
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id AF8D8C002A5;
	Mon, 16 Mar 2015 11:15:54 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <1426514206-30949-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265565>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy venit, vidit, dixit 16.03.201=
5 14:56:
> Entries added by "git add -N" are reminder for the user so that they
> don't forget to add them before committing. These entries appear in
> the index even though they are not real. Their presence in the index
> leads to a confusing "git status" like this:
>=20
>     On branch master
>     Changes to be committed:
>             new file:   foo
>=20
>     Changes not staged for commit:
>             modified:   foo
>=20
> If you do a "git commit", "foo" will not be included even though
> "status" reports it as "to be committed". This patch changes the
> output to become
>=20
>     On branch master
>     Changes not staged for commit:
>             new file:   foo
>=20
>     no changes added to commit
>=20
> The two hunks in diff-lib.c adjust "diff-index" and "diff-files" so
> that i-t-a entries appear as new files in diff-files and nothing in
> diff-index.
>=20
> Due to this change, diff-files may start to report "new files" for th=
e
> first time. "add -u" needs to be told about this or it will die in
> denial, screaming "new files can't exist! Reality is wrong." Luckily,
> it's the only one among run_diff_files() callers that needs fixing.
>=20
> The test "cache-tree invalidates i-t-a paths" is marked failure
> because I don't think removing "--cached" from "git diff" is the righ=
t
> fix. This test relies on "diff --cached" behavior but the behavior no=
w
> has changed. We may need to revisit this test at some point in future=
=2E

I can't quite follow that reasoning. If the test describes expected
behavior which the patch breaks, then we should not apply the patch. If
the patch changes behavior in an expected way, then we should change th=
e
test to match.

> Helped-by: Michael J Gruber <git@drmicha.warpmail.net>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/add.c           |  1 +
>  diff-lib.c              | 12 ++++++++++++
>  t/t2203-add-intent.sh   | 21 ++++++++++++++++++---
>  t/t4011-diff-symlink.sh | 10 ++++++----
>  4 files changed, 37 insertions(+), 7 deletions(-)
>=20
> diff --git a/builtin/add.c b/builtin/add.c
> index 3390933..ee370b0 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -63,6 +63,7 @@ static void update_callback(struct diff_queue_struc=
t *q,
>  		switch (fix_unmerged_status(p, data)) {
>  		default:
>  			die(_("unexpected diff status %c"), p->status);
> +		case DIFF_STATUS_ADDED:
>  		case DIFF_STATUS_MODIFIED:
>  		case DIFF_STATUS_TYPE_CHANGED:
>  			if (add_file_to_index(&the_index, path, data->flags)) {
> diff --git a/diff-lib.c b/diff-lib.c
> index a85c497..714501a 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -212,6 +212,11 @@ int run_diff_files(struct rev_info *revs, unsign=
ed int option)
>  					       ce->sha1, !is_null_sha1(ce->sha1),
>  					       ce->name, 0);
>  				continue;
> +			} else if (ce->ce_flags & CE_INTENT_TO_ADD) {
> +				diff_addremove(&revs->diffopt, '+', ce->ce_mode,
> +					       EMPTY_BLOB_SHA1_BIN, 0,
> +					       ce->name, 0);
> +				continue;
>  			}
> =20
>  			changed =3D match_stat_with_submodule(&revs->diffopt, ce, &st,
> @@ -376,6 +381,13 @@ static void do_oneway_diff(struct unpack_trees_o=
ptions *o,
>  	struct rev_info *revs =3D o->unpack_data;
>  	int match_missing, cached;
> =20
> +	/* i-t-a entries do not actually exist in the index */
> +	if (idx && (idx->ce_flags & CE_INTENT_TO_ADD)) {
> +		idx =3D NULL;
> +		if (!tree)
> +			return;	/* nothing to diff.. */
> +	}
> +
>  	/* if the entry is not checked out, don't examine work tree */
>  	cached =3D o->index_only ||
>  		(idx && ((idx->ce_flags & CE_VALID) || ce_skip_worktree(idx)));
> diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
> index 2a4a749..42827b8 100755
> --- a/t/t2203-add-intent.sh
> +++ b/t/t2203-add-intent.sh
> @@ -5,10 +5,24 @@ test_description=3D'Intent to add'
>  . ./test-lib.sh
> =20
>  test_expect_success 'intent to add' '
> +	test_commit 1 &&
> +	git rm 1.t &&
> +	echo hello >1.t &&
>  	echo hello >file &&
>  	echo hello >elif &&
>  	git add -N file &&
> -	git add elif
> +	git add elif &&
> +	git add -N 1.t
> +'
> +
> +test_expect_success 'git status' '
> +	git status --porcelain | grep -v actual >actual &&
> +	cat >expect <<-\EOF &&
> +	DA 1.t
> +	A  elif
> +	 A file
> +	EOF
> +	test_cmp expect actual
>  '
> =20
>  test_expect_success 'check result of "add -N"' '
> @@ -43,7 +57,8 @@ test_expect_success 'i-t-a entry is simply ignored'=
 '
>  	git add -N nitfol &&
>  	git commit -m second &&
>  	test $(git ls-tree HEAD -- nitfol | wc -l) =3D 0 &&
> -	test $(git diff --name-only HEAD -- nitfol | wc -l) =3D 1
> +	test $(git diff --name-only HEAD -- nitfol | wc -l) =3D 0 &&
> +	test $(git diff --name-only -- nitfol | wc -l) =3D 1
>  '
> =20
>  test_expect_success 'can commit with an unrelated i-t-a entry in ind=
ex' '
> @@ -62,7 +77,7 @@ test_expect_success 'can "commit -a" with an i-t-a =
entry' '
>  	git commit -a -m all
>  '
> =20
> -test_expect_success 'cache-tree invalidates i-t-a paths' '
> +test_expect_failure 'cache-tree invalidates i-t-a paths' '
>  	git reset --hard &&
>  	mkdir dir &&
>  	: >dir/foo &&
> diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
> index 13e7f62..7452fce 100755
> --- a/t/t4011-diff-symlink.sh
> +++ b/t/t4011-diff-symlink.sh
> @@ -139,11 +139,13 @@ test_expect_success SYMLINKS 'setup symlinks wi=
th attributes' '
>  test_expect_success SYMLINKS 'symlinks do not respect userdiff confi=
g by path' '
>  	cat >expect <<-\EOF &&
>  	diff --git a/file.bin b/file.bin
> -	index e69de29..d95f3ad 100644
> -	Binary files a/file.bin and b/file.bin differ
> +	new file mode 100644
> +	index 0000000..d95f3ad
> +	Binary files /dev/null and b/file.bin differ
>  	diff --git a/link.bin b/link.bin
> -	index e69de29..dce41ec 120000
> -	--- a/link.bin
> +	new file mode 120000
> +	index 0000000..dce41ec
> +	--- /dev/null
>  	+++ b/link.bin
>  	@@ -0,0 +1 @@
>  	+file.bin
>=20
