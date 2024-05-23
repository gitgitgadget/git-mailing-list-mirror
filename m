Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829B217577
	for <git@vger.kernel.org>; Thu, 23 May 2024 21:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716500797; cv=none; b=NNnQuokhkxm6yD63iFHISfvYqlPwgdDG4dsD68gxidNmonXxyO+NBDJqqjoQVNAqd613UkEp67CsIokMFikc2Cs/6AFFG/iihlgJJ/VvGMp2yz1HKnUNA/hH+vJTL1h4sEz0lhI6sF/UeTCV2OsSvtNF9edbhMxiIhpRGVE20p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716500797; c=relaxed/simple;
	bh=QBZfBhZ8TXEma+s4Fr36OBB7yVgISaEHncwQk1x7Flk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pHS6CCU3HPzDSN/D2ZvEateFDv6LVEl+yJN9WOYjP0EG1iuoi6WM98MkE3sxLknD8FZ4UCbfclmv2nO7dJUY/W/kDVjBnfjROZ2Fkm8JPUK7XA8pbhcAcsW5ChvoZgu7FZT/IaUetvRgOxzVW7vOGyzswCOpz4F1guJt6HQxAys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z0nu+BCx; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z0nu+BCx"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2074123054;
	Thu, 23 May 2024 17:46:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=QBZfBhZ8TXEma+s4Fr36OBB7yVgISaEHncwQk1
	x7Flk=; b=Z0nu+BCxjpakLeCl6WTXVjEe392EAedo8+gDQQFu9a8FtWZiqAb9YW
	+MSMhkp4xSFpTj2tuE9LAD7CInnaPA5ZuY5TB9sce92Ph5dUL1PZ7ABV1JEpJ0xR
	hSEFageMoQbD0FIoRYaW12VsHzl8ct079BFY+7hkC/Hzhd2zBSU4U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 187A323053;
	Thu, 23 May 2024 17:46:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C29AB23051;
	Thu, 23 May 2024 17:46:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2 0/6] update-ref: add symref support for --stdin
In-Reply-To: <CAPig+cT6_j80vh_HEjg6HWKXpkv-huggudShh_RgzLSKvV_bOA@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 23 May 2024 13:59:43 -0400")
References: <20240514124411.1037019-1-knayak@gitlab.com>
	<20240522090326.1268326-1-knayak@gitlab.com>
	<xmqqbk4wy3ji.fsf@gitster.g>
	<CAOLa=ZS31CuL8kDODNfM5L8gXN6RUOG5uEP5Q9JzEuaxtLEZ8g@mail.gmail.com>
	<xmqqr0dsv6e8.fsf@gitster.g>
	<CAPig+cT6_j80vh_HEjg6HWKXpkv-huggudShh_RgzLSKvV_bOA@mail.gmail.com>
Date: Thu, 23 May 2024 14:46:24 -0700
Message-ID: <xmqqbk4wrykv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E774F89E-194D-11EF-B77B-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

>> (and at the end of the patch for a single patch topic).
>
> This could indeed lead to less visual clutter for the single-patch topic.

So here is how such a change looks like.  I actually have this as a
two-patch series in my tree, but here is in squashed-into-one form.

The log-tree.c:show_log() function has a logic to create inter/range
diff at its end.  This function is called early by log_tree_diff(),
which is responsible for showing a single commit (log message,
auxiliary info like diffstat, and the patch, right before the
signature mark "-- " which is given by the format-patch itself).

We move that inter/range logic out into a helper function and call
it at the original place (which is [1/2] step of the two patch
series), which is a no-op refactoring.

In the second step, we remove the call out of show_log(), and
instead call it at the end of the log_tree_commit() after
log_tree_diff() did its thing.  This removes the inter/range diff
out of the "auxiliary info" section between "---" and the patch and
moves it at the end of the patch text, still before the signature
mark "-- ".  As this makes inter/range diff no longer part of the
runs of "commentary block"s, calls to next_commentary_block() is
removed from the show_diff_of_diff() helper.

As expected, this requires adjustment to t/t4014-format-patch.sh but
the fallout is surprisingly small.  It may be either an indication
that our test coverage for the feature is sketchy, or the tests were
written robustly, anticipating that somebody someday may want to
move things around in the output this way.


 log-tree.c              |  7 +++----
 t/t4014-format-patch.sh | 17 +++++++++++------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git c/log-tree.c w/log-tree.c
index e7cd2c491f..f28c4d0bb0 100644
--- c/log-tree.c
+++ w/log-tree.c
@@ -684,7 +684,6 @@ static void show_diff_of_diff(struct rev_info *opt)
 		memcpy(&dq, &diff_queued_diff, sizeof(diff_queued_diff));
 		DIFF_QUEUE_CLEAR(&diff_queued_diff);
 
-		next_commentary_block(opt, NULL);
 		fprintf_ln(opt->diffopt.file, "%s", opt->idiff_title);
 		show_interdiff(opt->idiff_oid1, opt->idiff_oid2, 2,
 			       &opt->diffopt);
@@ -704,7 +703,6 @@ static void show_diff_of_diff(struct rev_info *opt)
 		memcpy(&dq, &diff_queued_diff, sizeof(diff_queued_diff));
 		DIFF_QUEUE_CLEAR(&diff_queued_diff);
 
-		next_commentary_block(opt, NULL);
 		fprintf_ln(opt->diffopt.file, "%s", opt->rdiff_title);
 		/*
 		 * Pass minimum required diff-options to range-diff; others
@@ -903,8 +901,6 @@ void show_log(struct rev_info *opt)
 	strbuf_release(&msgbuf);
 	free(ctx.notes_message);
 	free(ctx.after_subject);
-
-	show_diff_of_diff(opt);
 }
 
 int log_tree_diff_flush(struct rev_info *opt)
@@ -1176,6 +1172,9 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
 	opt->loginfo = NULL;
 	maybe_flush_or_die(opt->diffopt.file, "stdout");
 	opt->diffopt.no_free = no_free;
+	if (shown)
+		show_diff_of_diff(opt);
+
 	diff_free(&opt->diffopt);
 	return shown;
 }
diff --git c/t/t4014-format-patch.sh w/t/t4014-format-patch.sh
index ba85b582c5..c0c5eccb7c 100755
--- c/t/t4014-format-patch.sh
+++ w/t/t4014-format-patch.sh
@@ -2482,13 +2482,18 @@ test_expect_success 'interdiff: reroll-count with a integer' '
 '
 
 test_expect_success 'interdiff: solo-patch' '
-	cat >expect <<-\EOF &&
-	  +fleep
-
-	EOF
 	git format-patch --interdiff=boop~2 -1 boop &&
-	test_grep "^Interdiff:$" 0001-fleep.patch &&
-	sed "1,/^  @@ /d; /^$/q" 0001-fleep.patch >actual &&
+
+	# remove up to the last "patch" output line,
+	# and remove everything below the signature mark.
+	sed -e "1,/^+fleep\$/d" -e "/^-- /,\$d" 0001-fleep.patch >actual &&
+
+	# fabricate Interdiff output.
+	git diff boop~2 boop >inter &&
+	{
+		echo "Interdiff:" &&
+		sed -e "s/^/  /" inter
+	} >expect &&
 	test_cmp expect actual
 '
 
