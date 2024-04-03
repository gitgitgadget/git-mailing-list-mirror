Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F392152DE7
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 17:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712165366; cv=none; b=npsBE02c0YP77yJLKsKv/JTg33KmY1l8XI7zLMDeq6rdIZfEJoXJMV+yugS/wdofMAvvHV6EAM8voR2wjYRJTaY0vZLUqG+IAWzWKp2mbZLQ6Ot43ORSv8UcjA4dXmkLbAVUxpEX1UkH0wNZyoLsvEzPY6dAFoSkBLyaYwwjSDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712165366; c=relaxed/simple;
	bh=KGqYO8nugAF7x6Voml1YwQ750ZOmKBD1gDzWa20k0is=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SUsAxdBhDxMDK8J8kJjZK4+wBeNgwE1IAOFDNSY+/U3pDM83pnqfaSMYDPurgtXEMLGfNo9lgcTHjnIIA5lXsdVExTs8h4gE3UeOKbb1C9rYXtY7OW/bjOAa1J77IlwPZR6EgyJRCO0ZMswP8zHazKaeuPs8rRZti88iqGIxGso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=lntcIr+N; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lntcIr+N"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D88E7301C9;
	Wed,  3 Apr 2024 13:29:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=KGqYO8nugAF7
	x6Voml1YwQ750ZOmKBD1gDzWa20k0is=; b=lntcIr+NFFh102gVuRL9SUpi08d5
	nFuGiXlEOoy7AmVWyTX2dt1Jai/Db8QstfWcscL0sV9ojBfNEYIyh8PPsyTHP5A5
	KzrsU9/CYAYebtHgeXOf77me1kOWoM8mXPG7yGMfouAu4K9iNsUuerkt/QDv36RF
	wzhm1RDLsr5f0cQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D1543301C8;
	Wed,  3 Apr 2024 13:29:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5CE19301C7;
	Wed,  3 Apr 2024 13:29:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jasmin Oster <JOster@anexia.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git-merge: --no-commit is not respected on a fresh repository
In-Reply-To: <22efe19e-de44-4b6d-8e8b-57e2bddb321e@anexia.com> (Jasmin Oster's
	message of "Wed, 3 Apr 2024 13:26:53 +0000")
References: <22efe19e-de44-4b6d-8e8b-57e2bddb321e@anexia.com>
Date: Wed, 03 Apr 2024 10:29:14 -0700
Message-ID: <xmqqv84y73th.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 B2271252-F1DF-11EE-8293-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Jasmin Oster <JOster@anexia.com> writes:

> 1. Create a new repository: $ git init
> 2. Add a remote: $ git remote add foo ../<path-to-another-repo>
> 3. Fetch everything: $ git fetch --all
> 4. Initiate a subtree merge: $ git merge -s our --no-commit=C2=A0foo/ma=
in

This is expected.  We are not creating any new commit, so it is
following the --no-commit option to the letter.  Obviously it is
different from what you expected to see, though ;-)

The "merge into void" first came to "git pull $URL $branch" (no
other options) where people tried to pull into a freshly created
repository, where it was very clear that they wanted to have a copy
of the upstream branch.  The "git pull" implementation of the
"pulling into void" feature forgot that curious users may give
"--no-commit", and just always fast-forwarded to the merged commit
without checking if such an option was given.

The behaviour you are seeing was inherited into "git merge".  It
also always fast-forwards to the merged commit, ignoring the option.

In either case, there is no new commit created.  The history you are
seeing is the exact history of the upstream.  If you want to
dissociate your history from theirs and start your history anew:

    $ git merge foo/main
    $ git checkout --orphan master

would give you an unborn branch "master", with the merge result in
the working tree and in the index, without any history behind it.
If you wanted to, you can then rename it to main from this state
with:

    $ git branch -M master main

We could make it more explicit with a patch like the following, but
it probably is not worth it.  I dunno.

 builtin/merge.c | 2 ++
 builtin/pull.c  | 2 ++
 2 files changed, 4 insertions(+)

diff --git c/builtin/merge.c w/builtin/merge.c
index 1cbd6a899c..1c3165e99a 100644
--- c/builtin/merge.c
+++ w/builtin/merge.c
@@ -1434,6 +1434,8 @@ int cmd_merge(int argc, const char **argv, const ch=
ar *prefix)
 		struct object_id *remote_head_oid;
 		if (squash)
 			die(_("Squash commit into empty head not supported yet"));
+		if (!option_commit)
+			die(_("--no-commit into empty head not supported"));
 		if (fast_forward =3D=3D FF_NO)
 			die(_("Non-fast-forward commit does not make sense into "
 			    "an empty head"));
diff --git c/builtin/pull.c w/builtin/pull.c
index 72cbb76d52..98c11ecc55 100644
--- c/builtin/pull.c
+++ w/builtin/pull.c
@@ -1097,6 +1097,8 @@ int cmd_pull(int argc, const char **argv, const cha=
r *prefix)
 	if (is_null_oid(&orig_head)) {
 		if (merge_heads.nr > 1)
 			die(_("Cannot merge multiple branches into empty head."));
+		if (opt_commit && !strcmp("--no-commit", opt_commit))
+			die(_("--no-commit into empty head not supported"));
 		ret =3D pull_into_void(merge_heads.oid, &curr_head);
 		goto cleanup;
 	}
