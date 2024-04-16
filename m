Received: from smtp.roethke.info (smtp.roethke.info [46.232.251.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D21C128820
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 10:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.232.251.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264857; cv=none; b=F9KN8EhBwFKPUi51y4Bz3fOKZbYf9BTPEGObjY7WgLarSG83Lzdy/y60bnNYDtmO8SUdOsmVNSJf3w3VPynN7qwlkeWp+Nap/XhwGewlGEHhbz4rYNVtf5SY+kmIyX1lyfs/Z7CBY3Lep7+aVrcWFnFyPdEABkBR6R6ZO7Fjgzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264857; c=relaxed/simple;
	bh=2TQajf7rzNxlikFDYwNfRIk+tT+k5qIM/PAqxwd6tPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MLkrhk7hvluMdc2MkX0nwd+YIS16cM5cDaLwUTe3zyVY6ouAglv0hmQb+6B6I15EMSg/Wf7S6xopkfPjUBrolqFWSw0y9p7WuAWRuthYbVUnWF70EbIOdLWaOGlDwTQcCYJ7S8uSRfU0aQOkwr6hmZk0fgD8AvRo8jhf0TTJt3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=roethke.info; spf=pass smtp.mailfrom=roethke.info; dkim=pass (4096-bit key) header.d=roethke.info header.i=@roethke.info header.b=yzTC0KlJ; arc=none smtp.client-ip=46.232.251.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=roethke.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=roethke.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=roethke.info header.i=@roethke.info header.b="yzTC0KlJ"
Received: from localhost (unknown [IPv6:2a01:41e1:2136:c500:8b0:fa85:2e1e:5dda])
	by smtp.roethke.info (Postfix) with ESMTPA id C796A1E0004A;
	Tue, 16 Apr 2024 10:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=roethke.info;
	s=20200807; t=1713264852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y78lZvShFvY9GZoN/fmZctb9MBQBOwWJ8GrJAXCNysc=;
	b=yzTC0KlJbjtIkUmKg5AX5384zYK+UurEs6S3EmiiOL/jhlDB0j2BR7rVxHBo7NZxO2El6H
	o9h9jp5FcFEo3Q8nYDW1aqg3/v0WR0ib2TKobZhGAAVIjVQLBBNPKxQ7qbkVCwjcfI4tJQ
	yN6KL9D+/SIcvkMdeRvp3PjZu/eeMDCCy7lKXeP+1h0VyHKTMvKwbqCvjMlEEri6qBO3PK
	0gwRP3aUPa/i2ubGgk+B8B6Ek4p1YKT82yPG+PAneby0PmDzyMiTHePfxL/tAXVhvcOaPT
	fpHwn2HnNneQzAcoOvl6Vmrew0G2/8x40ihGaIl0fkyf2TBMJRf1XfRBECxrBEqVjg61z5
	t0yAawagWOZG9h0XVZFBIWkXruIL2wry2mEn9BD+Vf6nIGAhAK1XmnhnrBNzDDMb/M7eMl
	6RBwCVH2t99kvpptXlNZ95vafI57U/L+Woa8wRefRQfTDV7c13mf/Ka/sNhDohCt5zw1Sq
	Ce9jRNJpK4X+hBh3VmeKAuMARBNvQYxctgLwi0TC4Bo24P7d/appgUSFmpCPRhvyBwmukc
	BfisT/xpW1wyK6WdB7qI4f0/yAJu+kxvUWMYlalmrthz8A7KMMDYU4NgIG9Hq6QJ7OIlWm
	puFoLyipM8aQf0OC4Ok+tC/fxBo8f6xGmRDV3/IGRQ5O72PRniVZM=
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=marcel@roethke.info smtp.mailfrom=marcel@roethke.info
From: =?UTF-8?q?Marcel=20R=C3=B6thke?= <marcel@roethke.info>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Marcel=20R=C3=B6thke?= <marcel@roethke.info>
Subject: [PATCH v4] rerere: fix crashes due to unmatched opening conflict markers
Date: Tue, 16 Apr 2024 12:52:48 +0200
Message-ID: <20240416105320.1113401-1-marcel@roethke.info>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409121708.131542-2-marcel@roethke.info>
References: <20240409121708.131542-2-marcel@roethke.info>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When rerere handles a conflict with an unmatched opening conflict marker
in a file with other conflicts, it will fail create a preimage and also
fail allocate the status member of struct rerere_dir. Currently the
status member is allocated after the error handling. This will lead to a
SEGFAULT when the status member is accessed during cleanup of the failed
parse.

Additionally, in subsequent executions of rerere, after removing the
MERGE_RR.lock manually, rerere crashes for a similar reason. MERGE_RR
points to a conflict id that has no preimage, therefore the status
member is not allocated and a SEGFAULT happens when trying to check if a
preimage exists.

Solve this by making sure the status field is allocated correctly and add
tests to prevent the bug from reoccurring.

This does not fix the root cause, failing to parse stray conflict
markers, but I don't think we can do much better than recognizing it,
printing an error, and moving on gracefully.

Signed-off-by: Marcel Röthke <marcel@roethke.info>
---
Interdiff against v3:
  diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
  index 1e80f76860..b0a3e84984 100755
  --- a/t/t4200-rerere.sh
  +++ b/t/t4200-rerere.sh
  @@ -731,7 +731,7 @@ test_expect_success 'rerere does not crash with unmatched conflict marker' '
   	bar
   	EOF
   	git add test &&
  -	git rebase --continue
  +	test_must_fail git rebase --continue
   '

   test_done

 rerere.c          |  5 ++++
 t/t4200-rerere.sh | 63 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/rerere.c b/rerere.c
index ca7e77ba68..4683d6cbb1 100644
--- a/rerere.c
+++ b/rerere.c
@@ -219,6 +219,11 @@ static void read_rr(struct repository *r, struct string_list *rr)
 		buf.buf[hexsz] = '\0';
 		id = new_rerere_id_hex(buf.buf);
 		id->variant = variant;
+		/*
+		 * make sure id->collection->status has enough space
+		 * for the variant we are interested in
+		 */
+		fit_variant(id->collection, variant);
 		string_list_insert(rr, path)->util = id;
 	}
 	strbuf_release(&buf);
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index fb53dddf79..b0a3e84984 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -671,4 +671,67 @@ test_expect_success 'test simple stage 1 handling' '
 	)
 '

+test_expect_success 'rerere does not crash with missing preimage' '
+	git config rerere.enabled true &&
+
+	echo bar >test &&
+	git add test &&
+	git commit -m "one" &&
+	git branch rerere_no_crash &&
+
+	echo foo >>test &&
+	git add test &&
+	git commit -m "two" &&
+
+	git checkout rerere_no_crash &&
+	echo "bar" >>test &&
+	git add test &&
+	git commit -m "three" &&
+
+	test_must_fail git rebase main &&
+	rm .git/rr-cache/*/preimage &&
+	git rebase --abort
+'
+
+test_expect_success 'rerere does not crash with unmatched conflict marker' '
+	git config rerere.enabled true &&
+
+	echo bar >test &&
+	git add test &&
+	git commit -m "one" &&
+	git branch rerere_no_preimage &&
+
+	cat >test <<-EOF &&
+	test
+	bar
+	foobar
+	EOF
+	git add test &&
+	git commit -m "two" &&
+
+	git checkout rerere_no_preimage &&
+	echo "bar" >>test &&
+	git add test &&
+	git commit -m "three" &&
+
+	cat >test <<-EOF &&
+	foobar
+	bar
+	bar
+	EOF
+	git add test &&
+	git commit -m "four" &&
+
+	test_must_fail git rebase main &&
+	cat >test <<-EOF &&
+	test
+	bar
+	<<<<<<< HEAD
+	foobar
+	bar
+	EOF
+	git add test &&
+	test_must_fail git rebase --continue
+'
+
 test_done
--
2.44.0

