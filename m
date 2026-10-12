Received: from smtp110.iad3b.emailsrvr.com (smtp110.iad3b.emailsrvr.com [146.20.161.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA90637BE6F
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 04:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791778628; cv=none; b=HY0oc8bYnopOJ54bW8VkTTbEr23Uj48U/I/WELkVNmaN4C+PdhdJQqvb2zQsapNYHvSBv/JoF9emRiFdxBpYQ0y4cKRpKp7kc/YgX52coPWF4GoFN7QEmfvn1byt2ycyPQqPVGyelCp1cppW7i3qkbsl7+lPEM0udo1pR3yGuWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791778628; c=relaxed/simple;
	bh=zMg0ZiF+hqnITSqEZR17EPJfCH/ogSNJdADf2AJmtGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dz0j2PXqWVcdKTtdCT8Ml+OgDDj9JLRMvEC4qJOaOltzdTQTIB8itGwv2A3ZWdueEw0Fb+LoIjAKAnkuoJOqNUdUnZzGDqo+C12HDpEPnor1yHRg4oEzs93VCbSzGbIOodvmV6jZETm/T12xBIrwLGpYAxNekVDRFLMgAP8StdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org; spf=pass smtp.mailfrom=jonsimons.org; dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b=aZh1RIXJ; arc=none smtp.client-ip=146.20.161.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b="aZh1RIXJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jonsimons.org;
	s=20200911-u7gnnm7o; t=1791774033;
	bh=zMg0ZiF+hqnITSqEZR17EPJfCH/ogSNJdADf2AJmtGQ=;
	h=From:To:Subject:Date:From;
	b=aZh1RIXJvOISLIesE3PIDSZnjw0CyoynIPQEQPtLtTqO55mj23MkiKxOWr8UzGfCm
	 GOwNR/+Mb8okedep+EPqGauAHkjqJ2Fml7fSKOum8GTrqwZMqhk28x4a5IQA77Xpu2
	 AKW7kYeRy1tp09shE43Zpct3Ay9oZeF3fcaBJFSI=
X-Auth-ID: jon@jonsimons.org
Received: by smtp14.relay.iad3b.emailsrvr.com (Authenticated sender: jon-AT-jonsimons.org) with ESMTPSA id 4ABE4E0334;
	Sun, 11 Oct 2026 23:00:33 -0400 (EDT)
From: Jon Simons <jon@jonsimons.org>
To: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Cc: Jon Simons <jon@jonsimons.org>
Subject: [PATCH v2] SubmittingPatches: avoid add-failing-test-then-fix anti-pattern
Date: Sun, 11 Oct 2026 23:00:29 -0400
Message-ID: <20261012030029.12200-1-jon@jonsimons.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261011153206.72386-1-jon@jonsimons.org>
References: <20261011153206.72386-1-jon@jonsimons.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 620fd428-2aa9-45ae-898a-537f823307bf-1-1

Document the preference to avoid the 'add a failing test and fix it in
a subsequent commit' anti-pattern.  Although such a sequence is fine
for local development, reviewers instead prefer a single commit that
introduces the test together with its code change [1].

The goal of this addition is to capture the preference in writing, with
hopes of optimizing future review flows by reducing back-and-forths to
the list.

[1] A couple examples of feedback, with rationale for avoiding
    the pattern, from August 2025 here:

    - https://lore.kernel.org/git/xmqqqzxpzo8b.fsf@gitster.g/
    - https://lore.kernel.org/git/xmqqfrdk3aqy.fsf@gitster.g/

Signed-off-by: Jon Simons <jon@jonsimons.org>
---
 Documentation/SubmittingPatches | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index c60855f706..3238a33932 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -271,6 +271,15 @@ fixed by accident to avoid regression.  Also, try merging your work to
 that are still in flight may have unexpected interactions with what
 you are trying to do in your topic.
 
+A bugfix patch should include tests in test_expect_success() blocks that
+demonstrate the breakage when the code change that implements the fix is
+omitted.  Submit tests as `test_expect_success` in the same commit as
+your code change that fixes the bug.  A separate commit that only changes
+`test_expect_failure` to `test_expect_success` can leave the behavior
+being tested out of the diff context, making the fix harder to review.
+Reviewers who want to verify that your test reproduces the bug can
+temporarily undo the code changes while keeping the test.
+
 Pushing to a fork of https://github.com/git/git will use their CI
 integration to test your changes on Linux, Mac and Windows. See the
 <<GHCI,GitHub CI>> section for details.
-- 
2.55.0

