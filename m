Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0390B2C11E7
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 21:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764710204; cv=none; b=DyIYIoFcz5IV8IbGR+d7DyFPAOcTL90hgVUE6hb85SLamQXrsprGJoAJp0kcTVk20iaX0at8eSVlOAHoHjYeA+TjqWTPuSTdUs2Sqyv+FJpMASgAhzeZ4Pat2oQMQw6bjm5kqyynIAu2nsdgKEFkr86Pg9VmriFuBzjSDgdoCCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764710204; c=relaxed/simple;
	bh=K5Cx0EeSjGCCZlsaIIC9Ghm4V/oUr40NeYXSmTkir8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JHuVq83Z1uPUa5jF0hj6QWpBBhDpoaJWTevqQqSsv5Pv0RkrKTQsEkZI6hGg3jZMayWtIjSchrn2Wt6hzdzP2zoBF9ZlWF2qM5Nq+gutCvx59+sXi3JmIcSScht8DL2YCgXSVilmHS1oPcx0eK2BXUywPNT5sZeffu0rMC2VB1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Swho4j66; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Swho4j66"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764710188; x=1765314988; i=l.s.r@web.de;
	bh=GrhMaTpu240j1wVSzOfR6hmw1gyEdA4p9b9RtQkCwcU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Swho4j667Wz2QdmVDsil8EqnNiEEugEL6+dnBXlC0HChym4u6TzuF/Ilgj5YUTq1
	 qUJH/zjcM3omUUAYFI44+ClZsVuDa2ABCxDF9hzdeqrXSAxaJVHpXEDTiVf4esX9y
	 FwUuYr1Zpq/IPodDGsyTt1AYbJ5hFNl5SgrbpR4I+FrjvOQ6GW3ecApbXKB1mEHV7
	 ZjoQy9cbTw9CVXO3/7MpA+o6lM1wcHMVDZYnoSPnJ0IvObyaLZcjpxpyEc1LCXgJh
	 iXnaD9q5+7lbYiC9wvvAkeS2+mk6GKRXwEMGg1cOj6mzFLSuAZykD6gL2kISxSXKa
	 cHsTC12/2le40nm0iA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.23.3]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MAcpg-1vFaQm1EfA-0084K9; Tue, 02
 Dec 2025 22:16:28 +0100
Message-ID: <f2e187bb-c765-4cc3-a0a0-1fbaec9a14e2@web.de>
Date: Tue, 2 Dec 2025 22:16:27 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] diff-index: don't queue unchanged filepairs with
 diff_change()
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, "D. Ben Knoble" <ben.knoble@gmail.com>,
 Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <aa28974b-ec73-4562-bfc8-4745ad58b55a@web.de>
 <xmqq5xarcsb8.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq5xarcsb8.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S1Bu2Hvgn6xfBvusbVeQNrd8Vz4xkgcbFk+fNjjGygnmJ2UFXBj
 KTTxr56ZoK5EOQYlDND9F1gkPDMTJ1Mt03PMHYaxHpAyDeTve1fByYoaRQ1IwRcelav6e37
 Wd1PZIb+RXOG9Ut8tO8MtEZP4Frl3FfnKJDeWBT+2p6+wiwAYkaj4/fVsgCHDMdciLekp2X
 usxuZzNJJ6aiDaWatJq3A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QRT0faO3HUo=;6gdPURDj+HqTzCYkpR5jtWfsrst
 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

On 11/30/25 7:02 PM, Junio C Hamano wrote:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
>> Add a new streamlined function for queuing unchanged filepairs and
>> use it in show_modified(), which is called by diff_cache() via
>> oneway_diff() and do_oneway_diff().  It allocates only a single filespe=
c
>> for each filepair and uses it twice with reference counting.  This has =
a
>> measurable effect if there are a lot of them, like in the Linux repo:
>>
>> Benchmark 1: ./git_v2.52.0 -C ../linux diff --cached --find-copies-hard=
er
>>   Time (mean =C2=B1 =CF=83):      31.8 ms =C2=B1   0.2 ms    [User: 24.=
2 ms, System: 6.3 ms]
>>   Range (min =E2=80=A6 max):    31.5 ms =E2=80=A6  32.3 ms    85 runs
>>
>> Benchmark 2: ./git -C ../linux diff --cached --find-copies-harder
>>   Time (mean =C2=B1 =CF=83):      23.9 ms =C2=B1   0.2 ms    [User: 18.=
1 ms, System: 4.6 ms]
>>   Range (min =E2=80=A6 max):    23.5 ms =E2=80=A6  24.4 ms    111 runs
>>
>> Summary
>>   ./git -C ../linux diff --cached --find-copies-harder ran
>>     1.33 =C2=B1 0.01 times faster than ./git_v2.52.0 -C ../linux diff -=
-cached --find-copies-harder
>=20
> Nice.  Is this technique only applicable to diff-index among the
> three diff plumbing siblings?  I suspect diff-files is an oddball
> in that on the working tree side we do not necessarily have the
> blob object names
Indeed:
- git diff-files compares index and working tree,
- a copy is a new file with contents from an old file,
- git ignores new files in the working tree.

So in theory git diff-files can only detect copies in the other
direction.  Or is there a way I'm missing?  In practice, however, it
doesn't do that reliably because it simply skips up-to-date index
entries.  Oops.

=2D-- >8 ---
Subject: [PATCH v2 2/1] diff-files: fix copy detection

Copy detection cannot work when comparing the index to the working tree
because Git ignores files that it is not explicitly told to track.  It
should work in the other direction, though, i.e. for a reverse diff of
the deletion of a copy from the index.

d1f2d7e8ca (Make run_diff_index() use unpack_trees(), not read_tree(),
2008-01-19) broke it with a seemingly stray change to run_diff_files().

We didn't notice because there's no test for that.  But even if we had
one, it might have gone unnoticed because the breakage only happens
with index preloading, which requires at least 1000 entries (more than
most test repos have) and is racy because it runs in parallel with the
actual command.

Fix copy detection by queuing up-to-date and skip-worktree entries using
diff_same().

While at it, use diff_same() also for queuing unchanged files not
flagged as up-to-date, i.e. clean submodules and entries where
preloading was not done at all or not quickly enough.  It uses less
memory than diff_change() and doesn't unnecessarily set the diff flag
has_changes.

Add two tests to cover running both without and with preloading.  The
first one passes reliably with the original code.  The second one
enables preloading and thus is racy.  It has a good chance to pass even
without the fix, but fails within seconds when running the test script
with --stress.  With the fix it runs fine for several minutes, until
my patience runs out.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Patch formatted with -U9 for easier review of the second hunk.

 diff-lib.c          | 12 +++++++++---
 t/t4007-rename-3.sh | 23 ++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 8e624f38c6..5307390ff3 100644
=2D-- a/diff-lib.c
+++ b/diff-lib.c
@@ -220,20 +220,24 @@ void run_diff_files(struct rev_info *revs, unsigned =
int option)
 			 * from the desired stage.
 			 */
 			pair =3D diff_unmerge(&revs->diffopt, ce->name);
 			if (wt_mode)
 				pair->two->mode =3D wt_mode;
 			if (ce_stage(ce) !=3D diff_unmerged_stage)
 				continue;
 		}
=20
-		if (ce_uptodate(ce) || ce_skip_worktree(ce))
+		if (ce_uptodate(ce) || ce_skip_worktree(ce)) {
+			if (revs->diffopt.flags.find_copies_harder)
+				diff_same(&revs->diffopt, ce->ce_mode,
+					  &ce->oid, ce->name);
 			continue;
+		}
=20
 		/*
 		 * When CE_VALID is set (via "update-index --assume-unchanged"
 		 * or via adding paths while core.ignorestat is set to true),
 		 * the user has promised that the working tree file for that
 		 * path will not be modified.  When CE_FSMONITOR_VALID is true,
 		 * the fsmonitor knows that the path hasn't been modified since
 		 * we refreshed the cached stat information.  In either case,
 		 * we do not have to stat to see if the path has been removed
@@ -266,20 +270,22 @@ void run_diff_files(struct rev_info *revs, unsigned =
int option)
=20
 			changed =3D match_stat_with_submodule(&revs->diffopt, ce, &st,
 							    ce_option, &dirty_submodule);
 			newmode =3D ce_mode_from_stat(ce, st.st_mode);
 		}
=20
 		if (!changed && !dirty_submodule) {
 			ce_mark_uptodate(ce);
 			mark_fsmonitor_valid(istate, ce);
-			if (!revs->diffopt.flags.find_copies_harder)
-				continue;
+			if (revs->diffopt.flags.find_copies_harder)
+				diff_same(&revs->diffopt, newmode,
+					  &ce->oid, ce->name);
+			continue;
 		}
 		oldmode =3D ce->ce_mode;
 		old_oid =3D &ce->oid;
 		new_oid =3D changed ? null_oid(the_hash_algo) : &ce->oid;
 		diff_change(&revs->diffopt, oldmode, newmode,
 			    old_oid, new_oid,
 			    !is_null_oid(old_oid),
 			    !is_null_oid(new_oid),
 			    ce->name, 0, dirty_submodule);
diff --git a/t/t4007-rename-3.sh b/t/t4007-rename-3.sh
index 3fc81bcd76..1012a370dd 100755
=2D-- a/t/t4007-rename-3.sh
+++ b/t/t4007-rename-3.sh
@@ -61,19 +61,40 @@ cat >expected <<EOF
 :000000 100644 $ZERO_OID $blob A	path1/COPYING
 EOF
=20
 test_expect_success 'copy, limited to a subtree' '
 	git diff-index -C --find-copies-harder $tree path1 >current &&
 	compare_diff_raw current expected
 '
=20
 test_expect_success 'tweak work tree' '
-	rm -f path0/COPYING &&
+	rm -f path0/COPYING
+'
+
+cat >expected <<EOF
+:100644 100644 $blob $blob C100	path1/COPYING	path0/COPYING
+EOF
+
+# The cache has path0/COPYING and path1/COPYING, the working tree only
+# path1/COPYING.  This is a deletion -- we don't treat deduplication
+# specially.  In reverse it should be detected as a copy, though.
+test_expect_success 'copy detection, files to index' '
+	git diff-files -C --find-copies-harder -R >current &&
+	compare_diff_raw current expected
+'
+
+test_expect_success 'copy detection, files to preloaded index' '
+	GIT_TEST_PRELOAD_INDEX=3D1 \
+	git diff-files -C --find-copies-harder -R >current &&
+	compare_diff_raw current expected
+'
+
+test_expect_success 'tweak index' '
 	git update-index --remove path0/COPYING
 '
 # In the tree, there is only path0/COPYING.  In the cache, path0 does
 # not have COPYING anymore and path1 has COPYING which is a copy of
 # path0/COPYING.  Showing the full tree with cache should tell us about
 # the rename.
=20
 cat >expected <<EOF
 :100644 100644 $blob $blob R100	path0/COPYING	path1/COPYING
=2D-=20
2.52.0

