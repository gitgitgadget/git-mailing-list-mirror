From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] diff-lib.c: adjust position of i-t-a entries in diff
Date: Mon, 23 Mar 2015 13:52:09 -0700
Message-ID: <xmqqy4mn8miu.fsf@gitster.dls.corp.google.com>
References: <1425910445-27383-2-git-send-email-pclouds@gmail.com>
	<1426514206-30949-1-git-send-email-pclouds@gmail.com>
	<5506F3A9.1020704@drmicha.warpmail.net>
	<xmqqa8zdrkpy.fsf@gitster.dls.corp.google.com>
	<20150317140704.GA7248@lanh>
	<xmqq1tknpkwd.fsf@gitster.dls.corp.google.com>
	<CACsJy8Beoz=qcHrOG=akCR+gOQRjBcsQHaXdL_=PW70BOf4q3g@mail.gmail.com>
	<xmqqtwxikpz6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 21:52:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ya9L2-0006X0-Fr
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 21:52:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782AbbCWUwl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Mar 2015 16:52:41 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55119 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752565AbbCWUwX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2015 16:52:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A48FB43E44;
	Mon, 23 Mar 2015 16:52:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=w+j8NkLB4mPp
	VqrQVcw/wP6dkjs=; b=Y7LjRWFzovHbKY9gsQGIUPY8ZyqwzQa3SDVJyyHUOjc+
	pWT0ja6R0pBemnXaCDd2ICWrWQvReIoHTffxCu7QRF6EIZ32Av18xW9dLDRSZLn5
	9TjuG49i0b4CMj74rEAm+lIu/wVOmPhrL/os/Vyc3tQKhiHq1ShZbBtL5ZBnuLM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Qm5l/2
	FWJ6TAsiAcpHxj2DXTj/7EfajI+4K6qho9gPhNVSmqiJatHr5se49+bzyc2SmOnK
	RgUYoelCeelSSZJoWedlnHz37FaC5kmo6dX7td/goqW47Vkam/1QtFSsM8rylOBn
	qErRnQ5XRcQwAE8CJ7zu3EdbMDYVG4vhTWZFs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9DEBD43E43;
	Mon, 23 Mar 2015 16:52:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EA78F43E36;
	Mon, 23 Mar 2015 16:52:10 -0400 (EDT)
In-Reply-To: <xmqqtwxikpz6.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 18 Mar 2015 13:30:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 79FEA6C6-D19E-11E4-BEBA-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266162>

Junio C Hamano <gitster@pobox.com> writes:

> Ah, wait.
>
> I suspect that it all cancels out.
> ...
> OK, so I think I can see how the result could work without
> invalidating the cache-tree entry that contains i-t-a entries.
>
> It might be even the right thing to do in general.  We can view that
> invalidation a workaround to achieve the old behaviour of diff-cache,
> which used to report that dir/ are different between HEAD and index.

So, we somehow left this hanging for a week without progress.  Here
is the version I am going to queue.

Thanks.

-- >8 --
=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
Date: Mon, 16 Mar 2015 20:56:46 +0700
Subject: [PATCH] diff-lib.c: adjust position of i-t-a entries in diff

Entries added by "git add -N" are reminder for the user so that they
don't forget to add them before committing. These entries appear in
the index even though they are not real. Their presence in the index
leads to a confusing "git status" like this:

    On branch master
    Changes to be committed:
            new file:   foo

    Changes not staged for commit:
            modified:   foo

If you do a "git commit", "foo" will not be included even though
"status" reports it as "to be committed". This patch changes the
output to become

    On branch master
    Changes not staged for commit:
            new file:   foo

    no changes added to commit

The two hunks in diff-lib.c adjust "diff-index" and "diff-files" so
that i-t-a entries appear as new files in diff-files and nothing in
diff-index.

Due to this change, diff-files may start to report "new files" for the
first time. "add -u" needs to be told about this or it will die in
denial, screaming "new files can't exist! Reality is wrong." Luckily,
it's the only one among run_diff_files() callers that needs fixing.

Now in the new world order, a hierarchy in the index that contain
i-t-a paths is written out as a tree object as if these i-t-a
entries do not exist, and comparing the index with such a tree
object that would result from writing out the hierarchy will result
in no difference.  Update a test in t2203 that expected the i-t-a
entries to appear as "added to the index" in the comparison to
instead expect no output.

An earlier change eec3e7e4 (cache-tree: invalidate i-t-a paths after
generating trees, 2012-12-16) becomes an unnecessary pessimization
in the new world order---a cache-tree in the index that corresponds
to a hierarchy with i-t-a paths can now be marked as valid and
record the object name of the tree that results from writing a tree
object out of that hierarchy, as it will compare equal to that tree.

Reverting the commit is left for the future, though, as it is purely
a performance issue and no longer affects correctness.

Helped-by: Michael J Gruber <git@drmicha.warpmail.net>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/add.c           |  1 +
 diff-lib.c              | 12 ++++++++++++
 t/t2203-add-intent.sh   | 23 +++++++++++++++++++----
 t/t4011-diff-symlink.sh | 10 ++++++----
 4 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 3390933..ee370b0 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -63,6 +63,7 @@ static void update_callback(struct diff_queue_struct =
*q,
 		switch (fix_unmerged_status(p, data)) {
 		default:
 			die(_("unexpected diff status %c"), p->status);
+		case DIFF_STATUS_ADDED:
 		case DIFF_STATUS_MODIFIED:
 		case DIFF_STATUS_TYPE_CHANGED:
 			if (add_file_to_index(&the_index, path, data->flags)) {
diff --git a/diff-lib.c b/diff-lib.c
index a85c497..714501a 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -212,6 +212,11 @@ int run_diff_files(struct rev_info *revs, unsigned=
 int option)
 					       ce->sha1, !is_null_sha1(ce->sha1),
 					       ce->name, 0);
 				continue;
+			} else if (ce->ce_flags & CE_INTENT_TO_ADD) {
+				diff_addremove(&revs->diffopt, '+', ce->ce_mode,
+					       EMPTY_BLOB_SHA1_BIN, 0,
+					       ce->name, 0);
+				continue;
 			}
=20
 			changed =3D match_stat_with_submodule(&revs->diffopt, ce, &st,
@@ -376,6 +381,13 @@ static void do_oneway_diff(struct unpack_trees_opt=
ions *o,
 	struct rev_info *revs =3D o->unpack_data;
 	int match_missing, cached;
=20
+	/* i-t-a entries do not actually exist in the index */
+	if (idx && (idx->ce_flags & CE_INTENT_TO_ADD)) {
+		idx =3D NULL;
+		if (!tree)
+			return;	/* nothing to diff.. */
+	}
+
 	/* if the entry is not checked out, don't examine work tree */
 	cached =3D o->index_only ||
 		(idx && ((idx->ce_flags & CE_VALID) || ce_skip_worktree(idx)));
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 2a4a749..7c641bf 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -5,10 +5,24 @@ test_description=3D'Intent to add'
 . ./test-lib.sh
=20
 test_expect_success 'intent to add' '
+	test_commit 1 &&
+	git rm 1.t &&
+	echo hello >1.t &&
 	echo hello >file &&
 	echo hello >elif &&
 	git add -N file &&
-	git add elif
+	git add elif &&
+	git add -N 1.t
+'
+
+test_expect_success 'git status' '
+	git status --porcelain | grep -v actual >actual &&
+	cat >expect <<-\EOF &&
+	DA 1.t
+	A  elif
+	 A file
+	EOF
+	test_cmp expect actual
 '
=20
 test_expect_success 'check result of "add -N"' '
@@ -43,7 +57,8 @@ test_expect_success 'i-t-a entry is simply ignored' '
 	git add -N nitfol &&
 	git commit -m second &&
 	test $(git ls-tree HEAD -- nitfol | wc -l) =3D 0 &&
-	test $(git diff --name-only HEAD -- nitfol | wc -l) =3D 1
+	test $(git diff --name-only HEAD -- nitfol | wc -l) =3D 0 &&
+	test $(git diff --name-only -- nitfol | wc -l) =3D 1
 '
=20
 test_expect_success 'can commit with an unrelated i-t-a entry in index=
' '
@@ -72,13 +87,13 @@ test_expect_success 'cache-tree invalidates i-t-a p=
aths' '
 	: >dir/bar &&
 	git add -N dir/bar &&
 	git diff --cached --name-only >actual &&
-	echo dir/bar >expect &&
+	>expect &&
 	test_cmp expect actual &&
=20
 	git write-tree >/dev/null &&
=20
 	git diff --cached --name-only >actual &&
-	echo dir/bar >expect &&
+	>expect &&
 	test_cmp expect actual
 '
=20
diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
index 13e7f62..7452fce 100755
--- a/t/t4011-diff-symlink.sh
+++ b/t/t4011-diff-symlink.sh
@@ -139,11 +139,13 @@ test_expect_success SYMLINKS 'setup symlinks with=
 attributes' '
 test_expect_success SYMLINKS 'symlinks do not respect userdiff config =
by path' '
 	cat >expect <<-\EOF &&
 	diff --git a/file.bin b/file.bin
-	index e69de29..d95f3ad 100644
-	Binary files a/file.bin and b/file.bin differ
+	new file mode 100644
+	index 0000000..d95f3ad
+	Binary files /dev/null and b/file.bin differ
 	diff --git a/link.bin b/link.bin
-	index e69de29..dce41ec 120000
-	--- a/link.bin
+	new file mode 120000
+	index 0000000..dce41ec
+	--- /dev/null
 	+++ b/link.bin
 	@@ -0,0 +1 @@
 	+file.bin
--=20
2.3.4-437-g9384a34
