Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AED139CFE
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 18:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718304541; cv=none; b=BdfSR9taJW6jBpHN+mDPAOqZ0a27B3z3h3NnoDOmSQo+tI5PRhoYo2XQP7EYQScrssDKJbM2vqa3O2vysKJenONCWBbZAX5SKL/AMRDpbS9Y+kCHdtdlrZGavOrOnbytw12XM0YFocYnX5VJPuX+HqUBqU/lsg7nX1u9FSLzPOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718304541; c=relaxed/simple;
	bh=7fyGbn1quE1Pn+uFij/cEvQE88viRm+uVJghM3U9fDI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hcKRLK+vGQyQkuVWWb2EWuytaL7kkgc93pHry2At9FBOplsOaEySGsbibpkckUr2Stnm/nqIY3/CiMz9vuz6pvnZZnWiTIkU5hROJJ5RQNaU+XpD3lgDIuOcPmOo7lErI6OebnUhysp9AZNHBRMQwS5iy1JgSiQ6mdZupBVyBPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=IpxEpUWP; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IpxEpUWP"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3BA1D37EEF;
	Thu, 13 Jun 2024 14:48:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7fyGbn1quE1Pn+uFij/cEvQE88viRm+uVJghM3
	U9fDI=; b=IpxEpUWPJm3UeZMgUkUS3vMiFJu1jiffKuGhdlCUj5Jc9XuifwKh94
	iyPp0oEUfPH7GnGe1DYPlv1GDlimRpSLJGuHUi/6nAzS2J1vCOdA524muP0hJN/q
	RVdnr2sFMtTRepcnA38KQBKk3Oga9mPsgvOHjBUb7D14v9Y3SE9pU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3403C37EEE;
	Thu, 13 Jun 2024 14:48:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9F79137EEA;
	Thu, 13 Jun 2024 14:48:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
  "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 00/20] Introduce `USE_THE_REPOSITORY_VARIABLE` macro
In-Reply-To: <xmqqcyoklo26.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	13 Jun 2024 11:01:21 -0700")
References: <cover.1718106284.git.ps@pks.im> <cover.1718259125.git.ps@pks.im>
	<xmqqcyoklo26.fsf@gitster.g>
Date: Thu, 13 Jun 2024 11:48:54 -0700
Message-ID: <xmqqfrtgk7ah.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 96263FDE-29B5-11EF-AFDB-C38742FD603B-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> this is the second version of my patch series that introduce a new
>> `USE_THE_REPOSITORY_VARIABLE` macro. If undefined, then declarations
>> like `the_repository`, `the_hash_algo` and a subset of functions that
>> implicitly depend on either of these are hidden away.
>
> ;-)

Two things.

(1) This stupid change was needed to please "make sparse", or we'd
    get this:

    repository.c:21:19: error: symbol 'the_repository' was not declared. Should it be static?
    gmake: *** [Makefile:3259: repository.sp] Error 1

 repository.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git c/repository.c w/repository.c
index 95d10cc4a0..22ef85b0b3 100644
--- c/repository.c
+++ w/repository.c
@@ -18,6 +18,8 @@
 
 /* The main repository */
 static struct repository the_repo;
+
+extern struct repository *the_repository;
 struct repository *the_repository = &the_repo;
 
 /*


(2) Aside from a few trivial and expected textual conflicts to be
    resolved, there were a few new files added that needed
    merge-fixes, with which I have this topic at the tip of the
    'seen' branch.

 index-info.c   | 2 ++
 pseudo-merge.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/index-info.c b/index-info.c
index 5d61e61e28..791380f910 100644
--- a/index-info.c
+++ b/index-info.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "index-info.h"
 #include "hash.h"
diff --git a/pseudo-merge.c b/pseudo-merge.c
index e3e0393f11..f0fde13c47 100644
--- a/pseudo-merge.c
+++ b/pseudo-merge.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "pseudo-merge.h"
 #include "date.h"
-- 
2.45.2-683-gddb3e810f1

