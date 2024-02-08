Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753136A015
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 23:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707434125; cv=none; b=ihMxivL4N25JLgtDFx20e6X9M2RbilAWN4ztVemmlnWyxxwB2KAQld8ODYMrSTwtCADj6T55FiDXYn+iHN6SqBYz2F67G15jXoDUkGjmkDYAYeSihqGVUxCgsSQ7znom5KqK5MRLE2dSw/Z9BVdUYg4FfUswk3sFYO08JkMpl5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707434125; c=relaxed/simple;
	bh=63TtBBfq3Zzj7YxjwgjHjUlUg5FbKj12B24TDRlNXTU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i0HUtwwevG1beexcOX6OJ6HjhtYC+uRotO3sVPWIBpOxZhJ6E7BB6+07mgg6uGch3pl5mb46bl4HQui61qfLAE4TIyvLtimWa0D4m/djtKs72ppsfML0X/T90YtR+eNdmkV9pnejrNUt493qU8yTXQA2+dqL4ov1AAFLPZG8c/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=feV37AAM; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="feV37AAM"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5E7AA34FAE;
	Thu,  8 Feb 2024 18:15:17 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=63TtBBfq3Zzj7YxjwgjHjUlUg5FbKj12B24TDR
	lNXTU=; b=feV37AAMC56zMPHWH+WuzIctdMAvikaHkdzGVbgBJnHUW+1OMNcsE6
	4dERAR9WrLFVg4ZpE2MQXb1U/93eJk/zLH7f90VtdRLUaU0ZiBC9zC6uLD6JH+AF
	Qnhb/eA7Jb/AFxsE4iWIgx8lfAuEYbulQCbCya9gfGHsPQh68oUSE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4FEE834FAD;
	Thu,  8 Feb 2024 18:15:17 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E84C734FAC;
	Thu,  8 Feb 2024 18:15:13 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  John Cai
 <johncai86@gmail.com>,  Linus Arver <linusa@google.com>
Subject: Re: [PATCH v2 0/4] rev-list: allow missing tips with --missing
In-Reply-To: <20240208135055.2705260-1-christian.couder@gmail.com> (Christian
	Couder's message of "Thu, 8 Feb 2024 14:50:51 +0100")
References: <20240208135055.2705260-1-christian.couder@gmail.com>
Date: Thu, 08 Feb 2024 15:15:12 -0800
Message-ID: <xmqq7cjemttr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E9E8CF24-C6D7-11EE-9474-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

> # Patch overview
>
> Patches 1/4 (revision: clarify a 'return NULL' in get_reference()),
> 2/4 (oidset: refactor oidset_insert_from_set()) and 
> 3/4 (t6022: fix 'test' style and 'even though' typo) are very small
> preparatory cleanups.
>
> Patch 4/4 (rev-list: allow missing tips with --missing=[print|allow*])
> allows git-rev-list(1) with `--missing=<arg>` when <arg> is not
> 'error' to not fail if some tips it is passed are missing.

Thanks.  There is an existing test that makes a bad assumption and
fails with these patches.  We may need something like this patch as
a preliminary fix before these four patches.

----- >8 ---------- >8 ---------- >8 ---------- >8 -----
Subject: [PATCH] t9210: do not rely on lazy fetching to fail

With "rev-list --missing=print $start", where "$start" is a 40-hex
object name, the object may or may not be lazily fetched from the
promisor.  Make sure it fails by forcing dereference of "$start"
at that point.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t9210-scalar.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index 4432a30d10..428339e342 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -154,7 +154,14 @@ test_expect_success 'scalar clone' '
 		test_cmp expect actual &&
 
 		test_path_is_missing 1/2 &&
-		test_must_fail git rev-list --missing=print $second &&
+
+		# This relies on the fact that the presence of "--missing"
+		# on the command line forces lazy fetching off before
+		# "$second^{blob}" gets parsed.  Without "^{blob}", a
+		# bare object name "$second" is taken into the queue and
+		# the command may not fail with a fixed "rev-list --missing".
+		test_must_fail git rev-list --missing=print "$second^{blob}" -- &&
+
 		git rev-list $second &&
 		git cat-file blob $second >actual &&
 		echo "second" >expect &&
-- 
2.43.0-581-g5216f8f5c4

