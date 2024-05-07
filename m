Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747FE6BFD5
	for <git@vger.kernel.org>; Tue,  7 May 2024 06:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715061907; cv=none; b=Tz8dTlBqTur9DUKxpUDeluSFxLfNa8u9DqVduhFWqZAp/wP+4g07Cammk8IQyalYhy14gTm/I5daAzn54b+WCS1Ysi6YC82JOvJ2wch7k9Wd4mfByhkACohm6BBzsMK6Z+LaSYNTED8kasUqmIq8pSjYDF89TWE7R4TCke7qSNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715061907; c=relaxed/simple;
	bh=fZe9GG2JNGJBT9ErN5B5lBEs6mIKF57l0h5+G1voha0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RkKUfwdIcPVTA2Po2whrjWJOkG4iLl+U2uONuN21tYaacIX3n6kdj+oLVSlEpksTMWUSFKfXUz5IVUp2fLCLbVTz+JOIl0nRJtfHzZ5wf+to3wvf+CWFBF9amM9iJF6rS0W17SMi6ehJIezcoIDt/dj3Fl4f1EBbXxTb8uuX9A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uwG6QjZk; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uwG6QjZk"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C0D6E31CA5;
	Tue,  7 May 2024 02:05:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=fZe9GG2JNGJBT9ErN5B5lBEs6mIKF57l0h5+G1
	voha0=; b=uwG6QjZktNMmLItZGwXkczyzsYADTSOtK1ESK7q0sJQuD5hwa1rUA/
	6rMXbf6ruPnBy2d4vI+Z+pK3xkNTX1qdnt17dctu5n2HvbfWCFfSAV6XodqmbhB2
	OKBuGc5hoUu6VN7N1/Hm0ukjSEH58mrLEE8O1hnawEOvzVRYFglvo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AA6C031CA4;
	Tue,  7 May 2024 02:05:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E649531CA2;
	Tue,  7 May 2024 02:05:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2024, #02; Fri, 3)
In-Reply-To: <xmqqy18mwpog.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	06 May 2024 15:17:35 -0700")
References: <xmqqa5l64e0i.fsf@gitster.g> <ZjihN01c8gWX0s9H@tanuki>
	<xmqqy18mwpog.fsf@gitster.g>
Date: Mon, 06 May 2024 23:05:00 -0700
Message-ID: <xmqqh6fatawj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BDD86C3C-0C37-11EF-9210-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

>>> * ps/undecided-is-not-necessarily-sha1 (2024-04-30) 13 commits
>>> ...
>> Interesting, I couldn't reproduce this issue when rebasing the patches
>> onto "seen". There were merge conflicts though, both with
>> jc/no-default-attr-tree-in-bare and ps/the-index-is-no-more. So maybe
>> there was a mismerge involved somewhere?
>
> That is very possible.

Yeah, I think I botched the merge.  Somehow my resolution had an
unneeded "|| !is_null_oid()" in the result, but the right resolution
of course should look like below.

Thanks.

diff --git c/attr.c w/attr.c
index 3afd477380..f3dd2de12d 100644
--- c/attr.c
+++ w/attr.c
@@ -1214,53 +1214,31 @@ void set_git_attr_source(const char *tree_object_name)
 static int compute_default_attr_source(struct object_id *attr_source)
 {
 	int ignore_bad_attr_tree = 0;
 
 	if (!default_attr_source_tree_object_name)
 		default_attr_source_tree_object_name = getenv(GIT_ATTR_SOURCE_ENVIRONMENT);
 
 	if (!default_attr_source_tree_object_name && git_attr_tree) {
 		default_attr_source_tree_object_name = git_attr_tree;
 		ignore_bad_attr_tree = 1;
 	}
 
-<<<<<<< HEAD
-	if (!default_attr_source_tree_object_name || !is_null_oid(attr_source))
-		return;
-||||||| 00e10ef10e
-	if (!default_attr_source_tree_object_name &&
-	    startup_info->have_repository &&
-	    is_bare_repository()) {
-		default_attr_source_tree_object_name = "HEAD";
-		ignore_bad_attr_tree = 1;
-	}
-
-	if (!default_attr_source_tree_object_name || !is_null_oid(attr_source))
-		return;
-=======
-	if (!default_attr_source_tree_object_name &&
-	    startup_info->have_repository &&
-	    is_bare_repository()) {
-		default_attr_source_tree_object_name = "HEAD";
-		ignore_bad_attr_tree = 1;
-	}
-
 	if (!default_attr_source_tree_object_name)
 		return 0;
 
 	if (!startup_info->have_repository) {
 		if (!ignore_bad_attr_tree)
 			die(_("cannot use --attr-source or GIT_ATTR_SOURCE without repo"));
 		return 0;
 	}
->>>>>>> ps/undecided-is-not-necessarily-sha1@{1}
 
 	if (repo_get_oid_treeish(the_repository,
 				 default_attr_source_tree_object_name,
 				 attr_source)) {
 		if (!ignore_bad_attr_tree)
 			die(_("bad --attr-source or GIT_ATTR_SOURCE"));
 		return 0;
 	}
 
 	return 1;
 }
