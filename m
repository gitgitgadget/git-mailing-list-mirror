Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38CD3C38
	for <git@vger.kernel.org>; Sun, 14 Dec 2025 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765727832; cv=none; b=IH8RATCpN7KWgCWNdGlGtJEVLGUIRJw3sCNcku61fbbY+wPXDJs3sywzow71CknkfvLyFvCXgnEYd/2TuiRRfPGe1zO9uwiOaMClQZPxNjjzX2yNUYfnsDYqE5a1fmczC6ZYhtElD09oPaE9iu8PPx2RN0p2nK21CaO3MiZ5wwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765727832; c=relaxed/simple;
	bh=PSRh3LlRuQ7OpU3LTx0a5TA/CZ090g/bD6lLJDwfIUI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=adg5OrqyhrUXqFmA9PyO6hGzloOc9I2+q3YON0gdfxNMRmSZh1njAY1MBPWbJgaUaJciugc6iNvADzxMQlgFxg3POcp1kLSjdNbOHkL5wDkpPMWz06/X8RNSltNkxkNNJrtnwn70Jh6Ymhv/MnDSpBdTbh2K+kkqCyOBP023SHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=WUO2/H8J; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="WUO2/H8J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765727826; x=1766332626; i=l.s.r@web.de;
	bh=Q/gjf9/Tfr1VILNKSjnKlALNI8uRQl56cI0L9Z8CqE0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WUO2/H8JdViqvkZJybhRb346EACsLZKsKJFWYwG35zIaQeaKF2/JIj35jYPj7DVR
	 z4mu/8Xr6DDhD2NAJHbMWIzzeKVxxc/75l6S5h9ioAELda1WPSpZgopgy14Ep5BPW
	 98nRxAz4JVpJSs76lDwJ+snL+baAMEbbihUDMQ4nG414Y4CAxDpqoLajzMaLvS/Dz
	 X4YgdfzTrWwltyLdYqSVSrt6rVFQfgj5d30t2FrUycHn7EARrG2LMWglYtK92iCFz
	 l7I6BtusrBm+kNK0ECIFxKIPQIfxRCdco193J0CggVucPiZAjlIKx3QHY+nrIG8lt
	 Rn6cXrjTQsdSDa3DpA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.27.139]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MREzA-1vgp0Q25Ho-00Qjcx for
 <git@vger.kernel.org>; Sun, 14 Dec 2025 16:57:06 +0100
Message-ID: <4b06a448-0935-4f2a-9061-238c7cc800c3@web.de>
Date: Sun, 14 Dec 2025 16:57:06 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH RESEND] diff-files: fix copy detection
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jI6XSC4WJZmQevdIZ4aRnDa+8D8ioTAycn/VQNTPxE41kFeLNCN
 i6RZBHsJlYDw+iTIw2zO6oWw//Ff89jxFz4imv8FWADkDek2cYo6oc/Xh/59vsPJEpg4JrF
 A9s/DjtKpP9aopqOt7LU4wB3xwoOY60I99MhQk6kJRwtGFk5qvDXvgpuMQhvte8/kEJxnDp
 l5b+8nsp944oXrcgRb+Mg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Zpk1U7y9rvU=;rVvxuJSGGfpigP62YOoXbNl6utV
 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

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
Original submission:
https://lore.kernel.org/git/f2e187bb-c765-4cc3-a0a0-1fbaec9a14e2@web.de/

 diff-lib.c          | 12 +++++++++---
 t/t4007-rename-3.sh | 23 ++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 8e624f38c6..5307390ff3 100644
=2D-- a/diff-lib.c
+++ b/diff-lib.c
@@ -226,8 +226,12 @@ void run_diff_files(struct rev_info *revs, unsigned i=
nt option)
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
@@ -272,8 +276,10 @@ void run_diff_files(struct rev_info *revs, unsigned i=
nt option)
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
diff --git a/t/t4007-rename-3.sh b/t/t4007-rename-3.sh
index 3fc81bcd76..1012a370dd 100755
=2D-- a/t/t4007-rename-3.sh
+++ b/t/t4007-rename-3.sh
@@ -67,7 +67,28 @@ test_expect_success 'copy, limited to a subtree' '
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
=2D-=20
2.52.0
