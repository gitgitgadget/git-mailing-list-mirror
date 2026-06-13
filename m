Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA88E256C61
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781359776; cv=none; b=o+Z8qubbklLrxpdL/MNwL9r5JEl5a1VDRlKUru5RTiVxAK61AhAd44kGg0G3BOq1dqpoLZvWfU+au4oUvHStPCj3g9nTMsU76ZQVIzAojQ4vkU07nm0j487ugW5Iz0OxK0xLl5J1UdmGAwynZcdkFVw2WH5PRs2AKot3CQvbc28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781359776; c=relaxed/simple;
	bh=RwtbdHwVWMFT4D83o+Vxph0on54bfN5N2u4p7BJmUj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBLqw6L071Bvr9LPF+X4OpVUqK+YC4UePcd5crZujBORncfadeehHkctNDSeZj80N4nkscJwcABE2hqg6RJHx7xQv8AMapcRSibjGISuQgD3c0Vnrl1graAFfVLwJJC/0ngJreCmxYzi1bvuv6l2VQeQsfwWXlE57qmJ6C2QTno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=eTqeIoN1; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="eTqeIoN1"
Date: Sat, 13 Jun 2026 22:09:06 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1781359772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n/PBkLSenZlONB9MuHfTBJFQe7+KgmVK7U+gbhGI264=;
	b=eTqeIoN1IuYPI3pXo/yPizl5dS99XOWdtg2uoDIFqn9pYO8QUDyEhUgHyhrl0MT7/Y5TCd
	zkI632eZ2hm2Qq9iWytEJVmW4IsLHsQMYq5F0h3rD1DIFP4HM7TU5e2gX2BGqbmOWpvTUy
	jdwJjwT6wg6sz9IW6P6ypU4k2AoqkP/zdpCe+wB9l7Ug7UpzXa4MFU0zNYJm1BGH2w1+NU
	28wnQpA9vksS+FfyM5w1+qaOPPJIXfwSiMWoMuZJeJkenKKEN8fx2/xcV/ER3KsaL7NuF3
	Z5ikcdlCMSJ0JxguVSsgPUcxZ1Jz9FoQIBe9tQmfE/clxsjE6uECcKpSJ7LHRA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im
Subject: [RFC PATCH 2/2] doc: advise batching patch rerolls
Message-ID: <8166623d1599fca2cd4614889e4a69b2006c12c1.1781358364.git.wy@wyuan.org>
References: <cover.1781358364.git.wy@wyuan.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781358364.git.wy@wyuan.org>
X-Migadu-Flow: FLOW_OUT

Contributors often need guidance on how quickly to send later iterations
of a patch series. Add a rough default of no more than one new version
of the same series per day so feedback can be batched and reviewers have
time to comment.

Mention factors that can affect the timing, such as series size, review
depth, substantial rework, and how close the topic is to being accepted.

Signed-off-by: Weijie Yuan <wy@wyuan.org>
---
 Documentation/MyFirstContribution.adoc | 15 +++++++++++++++
 Documentation/SubmittingPatches        |  7 ++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index 59891e3c14..9d76c72d05 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -1416,6 +1416,21 @@ previous one" patches over 2 days), reviewers would strongly prefer if a
 single polished version came 2 days later instead, and that version with
 fewer mistakes were the only one they would need to review.
 
+This consideration applies not only when going from the initial patch to v2, but
+also to later iterations of the same series. There is no fixed rule for how long
+to wait before sending a new version. A useful default is to send at most one
+new version of the same patch series per day. This gives multiple reviewers time
+to comment, lets you batch feedback together, and gives you time to think
+through the comments you received.
+
+The right timing depends on the topic and the feedback. Larger series usually
+need more review time. If the only comments so far are minor, such as typo
+fixes, it often makes sense to wait a little longer in case deeper reviews are
+still coming. If the comments require substantial rework, sending a new version
+sooner may save reviewers from spending time on a version you already know will
+change significantly. If the topic is close to being accepted and the remaining
+comments are small, a quicker new version may also be fine.
+
 
 [[reviewing]]
 === Responding to Reviews
diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index d8ad7fb73e..1bc2684c54 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -59,6 +59,10 @@ It is often beneficial to allow some time for reviewers to provide
 feedback before sending a new version, rather than sending an updated
 series immediately after receiving a review. This helps collect broader
 input and avoids unnecessary churn from many rapid iterations.
++
+As a rough default, avoid sending more than one new version of the same
+series per day, while considering the size of the series, the depth of
+review, and how close the topic is to being accepted.
 
 . These early update iterations are expected to be full replacements,
   not incremental updates on top of what you posted already.  If you
@@ -645,7 +649,8 @@ letter" message (see below), the first patch, or the respective preceding patch.
 Here is a link:MyFirstContribution.html#v2-git-send-email[step-by-step guide] on
 how to submit updated versions of a patch series.  Before sending another
 version, make sure you have answered meaningful review comments in the existing
-discussion.
+discussion.  Also give reviewers enough time to comment before sending another
+version.
 
 If your log message (including your name on the
 `Signed-off-by:` trailer) is not writable in ASCII, make sure that
-- 
2.54.0

