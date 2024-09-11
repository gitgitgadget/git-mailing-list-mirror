Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559A51AC8B9
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 17:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726074210; cv=none; b=nuomw/Yl8d93QCm4yBft69zFzNMJ7TVZa7B7AyKfsUy8fOmez1YrX2C5S7IgmyKmnJEV4rHrOCjOoNWNKW1E6rYtoDCI+M+bS6JJfhwCWuUiWWoKHgt26uOByH4Er9hvpEmzYbHg9xLTFpWhP7NiG2+HPKDJpwBPhrfnhnsFNOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726074210; c=relaxed/simple;
	bh=eGBChvGJS/kOLPJLkfJm8kb4xg0jfY0Lud8VJeqvx9g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sy6+gT3SPXAxhOzlrVGfN9p6NWmE0WfFN+4opvy38Hr9qntIo2+XI7rP4meRjAn88Ozls3sUbbOESGXVEpOfYk5Lj0JPEw3p2NowYAWBNRRqqaRjBDTci5YJCB7QSO4s9HMbYSaRoKhpvz6JdExqwJuAGEldMbbPWgiUf3c6GlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=G/1DVPgP; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="G/1DVPgP"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B4F91B001;
	Wed, 11 Sep 2024 13:03:28 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=eGBChvGJS/kOLPJLkfJm8kb4xg0jfY0Lud8VJe
	qvx9g=; b=G/1DVPgPo2w+PT+8WXVaIhedBgolaRm0Etu/UKVUb1l/jA2A7InUgh
	7a3yb5opUqTG1Oopg+QToNbzrWUGyx6gyMJHzQkdYlo6OvDDyW96kZxj2z6ZM6/p
	haudGTZ7e1bkNR6udplPddEpe74ocquRRANwbcYTtbk9JA09KlS1M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 115731B000;
	Wed, 11 Sep 2024 13:03:28 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 56F521AFFF;
	Wed, 11 Sep 2024 13:03:27 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Han Jiang <jhcarl0814@gmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 4/4] remote: check branch names
In-Reply-To: <dba31245607f85c48947da60fe0955a6ed3e2c43.1726067917.git.gitgitgadget@gmail.com>
	(Phillip Wood via GitGitGadget's message of "Wed, 11 Sep 2024 15:18:37
	+0000")
References: <pull.1789.git.1726067917.gitgitgadget@gmail.com>
	<dba31245607f85c48947da60fe0955a6ed3e2c43.1726067917.git.gitgitgadget@gmail.com>
Date: Wed, 11 Sep 2024 10:03:26 -0700
Message-ID: <xmqqfrq686n5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C35F30F0-705F-11EF-AA46-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static int check_branch_names(const char **branches)
> +{
> +	int ret = 0;
> +
> +	for (const char **b = branches; *b; b++) {
> +		if (check_refname_format(*b, REFNAME_ALLOW_ONELEVEL |
> +						REFNAME_REFSPEC_PATTERN))
> +			ret = error(_("invalid branch name '%s'"), *b);
> +	}
> +
> +	return ret;
> +}

This implementation is inconsistent with what "git branch new HEAD"
uses to check the validity of "new", which is in this call chain:

    builtin/branch.c:cmd_branch()
    -> branch.c:create_branch()
       -> branch.c:validate_new_branchname()
          -> branch.c:validate_branchname()
             -> object-name.c:strbuf_check_branch_ref()

At least, we should prepend "refs/heads/" to *b, so that we can
reject "refs/heads/HEAD".  The authoritative logic in the above
however may further evolve, and we need to make sure that these two
checks from drifting away from each other over time.  We probably
should refactor the leaf function in the above call chain so that
both places can use it (the main difference is that you allow '*' in
yours when calling check_refname_format()).

    Side note: we *should* lose "strbuf_" from its name, as it is
               not about string manipulation but the "strbuf'-ness
               of the function is merely that as the side effect of
               checking it computes a full refname and it happens to
               use strbuf as a mechanism to return it.

Something like the patch attached at the end.

>  static const char mirror_advice[] =
>  N_("--mirror is dangerous and deprecated; please\n"
>     "\t use --mirror=fetch or --mirror=push instead");
> @@ -203,6 +216,9 @@ static int add(int argc, const char **argv, const char *prefix)
>  	if (!valid_remote_name(name))
>  		die(_("'%s' is not a valid remote name"), name);
>  
> +	if (check_branch_names(track.v))
> +		exit(128);
> +

Seeing that the loop in check_branch_names() is brand new and you
could have iterated over a string-list just as easily, I somehow
doubt that step [3/4] was fully warranted.

> @@ -1601,6 +1617,9 @@ static int set_remote_branches(const char *remotename, const char **branches,
>  		exit(2);
>  	}
>  
> +	if (check_branch_names(branches))
> +		exit(128);

But here you are already passed "const char *branches[]" to this caller,
and it would be hassle to turn it into string_list, so [3/4] is fine
after all.



 object-name.h |  2 ++
 object-name.c | 23 +++++++++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git i/object-name.h w/object-name.h
index 8dba4a47a4..fa70d42044 100644
--- i/object-name.h
+++ w/object-name.h
@@ -130,4 +130,6 @@ struct object *repo_peel_to_type(struct repository *r,
 /* used when the code does not know or care what the default abbrev is */
 #define FALLBACK_DEFAULT_ABBREV 7
 
+/* Check if "name" is allowed as a branch */ 
+int valid_branch_name(const char *name, int allow_wildcard);
 #endif /* OBJECT_NAME_H */
diff --git i/object-name.c w/object-name.c
index 09c1bd93a3..e3bed5a664 100644
--- i/object-name.c
+++ w/object-name.c
@@ -1747,7 +1747,8 @@ void strbuf_branchname(struct strbuf *sb, const char *name, unsigned allowed)
 	strbuf_add(sb, name + used, len - used);
 }
 
-int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
+static int full_ref_from_branch_name_internal(struct strbuf *sb, const char *name,
+					      int crf_flags)
 {
 	if (startup_info->have_repository)
 		strbuf_branchname(sb, name, INTERPRET_BRANCH_LOCAL);
@@ -1766,7 +1767,25 @@ int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
 	    !strcmp(sb->buf, "refs/heads/HEAD"))
 		return -1;
 
-	return check_refname_format(sb->buf, 0);
+	return check_refname_format(sb->buf, crf_flags);
+}
+
+/* NEEDSWORK: rename this to full_ref_from_branch_name */
+int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
+{
+	return full_ref_from_branch_name_internal(sb, name, 0);
+}
+
+int valid_branch_name(const char *name, int allow_wildcard)
+{
+	struct strbuf sb = STRBUF_INIT;
+	int ret;
+	int flags;
+
+	flags = allow_wildcard ? REFNAME_REFSPEC_PATTERN : 0;
+	ret = full_ref_from_branch_name_internal(&sb, name, flags);
+	strbuf_release(&sb);
+	return ret;
 }
 
 void object_context_release(struct object_context *ctx)
