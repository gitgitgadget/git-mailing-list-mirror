Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B213815921B
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 19:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723231353; cv=none; b=Jma8zyR1n3VF6YT7OZhfaIp/zSv0ldLFnml3wpHh0HojCUyPtsNOUt+YsslnhgCIeK36ui9vL+kCiQW4EkvaMYY5fvph2YW398bS9JYoQ9PE/JsXd9cPbOKfiJZeWSJuOcQ7JmHifU5vQTqk2aowSegSh4fQ3rKsiyFLd/FcZY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723231353; c=relaxed/simple;
	bh=BsjyvdqV4Dqw7s/hbSWgG7sGKUJVlsmKnaD7e75X/Dw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kB6e/Dq4cumLAOC206p8rVVjc38quDTShj/9ntIK1B0LoMQ/m8pPJoPUtH0yWXj2JOsjfUyn0JKBm+YBMEzrplxBA6VK7Clf3nLbBxnAKdV+HwyUbCzB6bbBpMLx1hWw8KBzn4oM4k8qwnVra5HyWUlSV/hDHw4JXRlThSNIx40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VXZXqFM8; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VXZXqFM8"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 926961CE15;
	Fri,  9 Aug 2024 15:22:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=BsjyvdqV4Dqw7s/hbSWgG7sGKUJVlsmKnaD7e7
	5X/Dw=; b=VXZXqFM89ECjAUdSuSzdaxV2aHOsnL6KRoYgA1w+2owwcqhSr2pALC
	/bM6zhKTTyp6gSj4R4yuZeBHsOWwzk0CClOXJgpFb0Fn5imrISuK85iS3mdrmA/P
	PpBrd87ZTho8eJIICHZbXEQKBTtsyhasdd/BFLuB3FquHBIsa1G7I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 87ECF1CE14;
	Fri,  9 Aug 2024 15:22:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EE5EC1CE13;
	Fri,  9 Aug 2024 15:22:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  calvinwan@google.com,  spectral@google.com,
  emilyshaffer@google.com,  emrass@google.com,  rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 0/6] [RFC] Introduce cgit-rs, a Rust wrapper around
 libgit.a
In-Reply-To: <cover.1723054623.git.steadmon@google.com> (Josh Steadmon's
	message of "Wed, 7 Aug 2024 11:21:25 -0700")
References: <cover.1723054623.git.steadmon@google.com>
Date: Fri, 09 Aug 2024 12:22:28 -0700
Message-ID: <xmqqbk21cxhn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B854B2E2-5684-11EF-942B-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> We're sending this series as RFC because there is remaining work
> we'd like to do, but we'd like to get early feedback on this approach,
> and particularly to ask for advice on a few topics:

I am not sure how much this is reusable, after seeing comments that
"cgit-rs" may not be the best name for this thing and pathnames may
have to change, but I needed the following merge-fix to get this
into "seen" and have the result pass "make", due to interactions
with the ps/config-wo-the-repository topic.

 contrib/cgit-rs/public_symbol_export.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/contrib/cgit-rs/public_symbol_export.c b/contrib/cgit-rs/public_symbol_export.c
index 9641afca89..2732f5898e 100644
--- a/contrib/cgit-rs/public_symbol_export.c
+++ b/contrib/cgit-rs/public_symbol_export.c
@@ -9,6 +9,8 @@
 #include "setup.h"
 #include "version.h"
 
+extern struct repository *the_repository;
+
 #pragma GCC visibility push(default)
 
 const char *libgit_setup_git_directory(void)
@@ -18,7 +20,7 @@ const char *libgit_setup_git_directory(void)
 
 int libgit_config_get_int(const char *key, int *dest)
 {
-	return git_config_get_int(key, dest);
+	return repo_config_get_int(the_repository, key, dest);
 }
 
 void libgit_initialize_the_repository(void)
-- 
2.46.0-326-g1e046905fc

