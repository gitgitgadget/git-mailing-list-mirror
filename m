Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EEE6EB4A
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 18:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727203810; cv=none; b=XQJ7yzp2J3OQj319lORwfatFYGOTerznYk855z8f+pm9RB3VoR6WjWoWbXTWDMYP6k6JcC7CrSInjGscpBjR9DnxHayN0WAKJx4YfE+Is2rlx02rhYVtdFo+VYj8MaadhNivs3wM4KMAhsiLTHM6A4+JXNWtDI/0ObZlQ545zfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727203810; c=relaxed/simple;
	bh=KSwFaCoIl0x8/WtQm55yja+yBeEauHIWbpFcxRzjuJw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cuLgxpQaDo5Kqlr/U+9Tli9seK5LfcAma+mQNXmRgsh4sPpmGtxUK/OykrzuQ89voBeGfIe8G219Bl/lWfgBuNmhOtB6rQYmR/DWLv//WcQUYMSOa1WncgR9pffA2qgPQSS63w65dISezutZZ1MBKk9BjoWSJ5Fn7ThzrxrS6PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=imF4Sqnc; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="imF4Sqnc"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C3BD37D8A;
	Tue, 24 Sep 2024 14:50:07 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=KSwFaCoIl0x8/WtQm55yja+yBeEauHIWbpFcxR
	zjuJw=; b=imF4SqncLRoD7xrWFrpjSQdU48/BXzT/UXb/oKkyi/qNAzjpHl+xbK
	tCeIANU4aM8igPmTBbZE4DVtD2b8/YXWX14uBpcRsAmGT16NiqFdqh4toMogzQf7
	Hxx1zENCBOTwHaHIr9jNcg/1wuY9U87PAxUL+rMKKctuz2GXDDTH0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E686037D89;
	Tue, 24 Sep 2024 14:50:06 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7232E37D82;
	Tue, 24 Sep 2024 14:50:04 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 3/4] apply: remove the_repository global variable
In-Reply-To: <xmqq7cb0ucm0.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	24 Sep 2024 11:32:07 -0700")
References: <pull.1788.git.git.1727185364.gitgitgadget@gmail.com>
	<4ce463defa807fb99eef6ce7abcd758fc2065c13.1727185364.git.gitgitgadget@gmail.com>
	<xmqq7cb0ucm0.fsf@gitster.g>
Date: Tue, 24 Sep 2024 11:50:02 -0700
Message-ID: <xmqqtte4sx7p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CFBC26A0-7AA5-11EF-92DA-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

>> -	if (init_apply_state(&state, the_repository, prefix))
>> +	if (init_apply_state(&state, repo, prefix))
>>  		exit(128);
>
> Hmph, the reason why we do not segfault with this patch is because
> repo will _always_ be the_repository due to the previous change.
>
> I am not sure if [1/4] is an improvement, though.  We used to be
> able to tell if we were running in a repository, or we were running
> in "nongit" mode, by looking at the NULL-ness of repo (which was
> UNUSED because we weren't taking advantage of that).  
>
> With [1/4], it no longer is possible.  From the point of view of API
> to call into builtin implementations, it smells like a regression.

We can avoid the regression by passing the discovered "nongit" (aka
"are we outside of a repository?") bit separately, perhaps like
this.  With such a change, I do not mind this change too much, but
pretending that we do not depend on the_repository (by removing the
textual mention of the_repository), but still depending on
the_repository (which points at the_repo) may be losing a bigger
picture, the true reason why we want to reduce the dependence on
the_repository.  We still need "if the hash-algo is not initialized
fall back to SHA-1" code here, but that is an overly broad fallback
that we would rather want to tighten to something like "we know we
have no reasonable value to initialize hash-algo in the_repository
if we are outside a repository, so initialize hash-algo if we are
outside any repository" (leaving it an error not have hash-algo in
"repo" if we _are_ in a repository).
   
diff --git c/git.c w/git.c
index 2fbea24ec9..579c6fa36d 100644
--- c/git.c
+++ w/git.c
@@ -447,6 +447,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv, struct
 	struct stat st;
 	const char *prefix;
 	int run_setup = (p->option & (RUN_SETUP | RUN_SETUP_GENTLY));
+	int nongit = 0;
 
 	help = argc == 2 && !strcmp(argv[1], "-h");
 	if (help && (run_setup & RUN_SETUP))
@@ -456,8 +457,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv, struct
 	if (run_setup & RUN_SETUP) {
 		prefix = setup_git_directory();
 	} else if (run_setup & RUN_SETUP_GENTLY) {
-		int nongit_ok;
-		prefix = setup_git_directory_gently(&nongit_ok);
+		prefix = setup_git_directory_gently(&nongit);
 	} else {
 		prefix = NULL;
 	}
@@ -480,7 +480,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv, struct
 	trace2_cmd_name(p->cmd);
 
 	validate_cache_entries(repo->index);
-	status = p->fn(argc, argv, prefix, (p->option & RUN_SETUP)? repo : NULL);
+	status = p->fn(argc, argv, prefix, run_setup ? repo : NULL, nongit);
 	validate_cache_entries(repo->index);
 
 	if (status)
