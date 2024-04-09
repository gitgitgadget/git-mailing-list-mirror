Received: from smtp.roethke.info (smtp.roethke.info [46.232.251.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8526412D1E7
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 12:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.232.251.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712665245; cv=none; b=mWmXUkUcaQjP5A0MDMICVyjFovd/Gz4F4HOrMQAtBTkkUm62BqKz/bKGSc5cSqPe7hp+gjk90VLMYnAS9q7FBofvXQH8jKXH6ct8I1LdDTfAkh3cFD2P6bIavvMheolSBQxE2mhneuMYzkbQI8qKamlbP1fDziumw9ZFpkTZrLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712665245; c=relaxed/simple;
	bh=dU0Z15geqm/DMs/YNzI0OWF7uPmNmWIm/XwIPZp8p98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TwDPokd519NGFGRbU50YsMLNgVs/qyEslPtk6fMpFQb0fIHhIlT9bOx/bnsp2RVvbqRcMH+2uCvoderUdxC7gSReVHf/MZB53pLXaVlutWYLMSZONtHVYT3xXYyAo6Wc717DbPfZyqTA4ef9uy8ECSLXDoDhNOzLpazgpIJDqcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=roethke.info; spf=pass smtp.mailfrom=roethke.info; dkim=pass (4096-bit key) header.d=roethke.info header.i=@roethke.info header.b=XHMSJQvH; arc=none smtp.client-ip=46.232.251.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=roethke.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=roethke.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=roethke.info header.i=@roethke.info header.b="XHMSJQvH"
Received: from localhost (unknown [IPv6:2a01:41e1:151f:e600:8468:9962:e0b9:9e30])
	by smtp.roethke.info (Postfix) with ESMTPA id A65061E0004A;
	Tue,  9 Apr 2024 12:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=roethke.info;
	s=20200807; t=1712665235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gcqzsYbw/BLdXVRUJNEWp2foL1JjAPrmC+SgNAa4P4Y=;
	b=XHMSJQvHOQGHW9DTRGuy+UJ9oh04dJ1eHCEenhW6ChtbmmOFyC4RPJDLzfjOwvG/FnUo8o
	us0JrGsdvWChyrjm/a8wyY4TECsWVl6RhFXV2MelvcStKbzs2XyGpWmG+qMmoLmByLeFp2
	BkHsRdwgrB3gMoI4Kx5Mr6Gh3EFo0pcYROKdbvu4VTOtvsYeBu0OX12LTTrMcEpzktKigc
	lXUxCVvvUsbMHXCWWKVhgW3TZl9s6oZGmJF28ykVBTPMVebX6AXbSawkaL4KG21Vs6NviW
	rKuJuiB34+30s0WR21IKOeHIZh9PbfD57X3hTHUkS9Jg/yNN9h4amgu2WvWqJAiJ0NXQH+
	+k+6ZMKEnD0eAnF/SSe28MRrSaf+S5KSjUhTaSvAY+hU8WSCc2oDNuwos3K75B13q0koyr
	H1twtVl8i5EaW1DPqG+grY5wUJwQflYOp4drdCFuklFbKGPrE65aPMyBX9B4M1NW2XzP0r
	Kz+/ebvCuWW8/GnrSYE0TmCnh7eherw/Fb7VWcB2wnaQlTfcrLba8xzPIEO8YSVt9cFGmZ
	cl8HDx+uHo5v6D8NURJjA/RQPG4EfbFxI/rTl2xFtXlN9tfeGg7zKjP33YJ8Nkcn4sdvLh
	aHqxSrwArO78oZJ+zocykL55tzFZwpdl7Wj/SNHODfPVmKDfe7VGE=
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=marcel@roethke.info smtp.mailfrom=marcel@roethke.info
From: =?UTF-8?q?Marcel=20R=C3=B6thke?= <marcel@roethke.info>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Marcel=20R=C3=B6thke?= <marcel@roethke.info>
Subject: [PATCH v3] rerere: fix crashes due to unmatched opening conflict markers
Date: Tue,  9 Apr 2024 14:13:51 +0200
Message-ID: <20240409121708.131542-2-marcel@roethke.info>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240218194603.1210895-1-marcel@roethke.info>
References: <20240218194603.1210895-1-marcel@roethke.info>
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
Interdiff against v2:
  diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
  index fb53dddf79..1e80f76860 100755
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
  +	git rebase --continue
  +'
  +
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
index fb53dddf79..1e80f76860 100755
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
+	git rebase --continue
+'
+
 test_done
--
2.44.0

