Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957D87F
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 00:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KEE6jIgr"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F07199E
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 16:22:44 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 412091CF733;
	Thu,  9 Nov 2023 19:22:43 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=GJGfkrN0Cd5JA0QJxj92n4xB6SB5QHc7LSOK3I
	nUZKk=; b=KEE6jIgrtcDzLonQ1DUrU0+HrjeGq0CquLM/gtPgzuvMkzQwkpSBcB
	D1UKqFQU7GHHPmSVDyPfWpjfh69cfGbuhRYQ6gbTMq8JCDUqG+VaAK9K1VoZtl2m
	k8goFcc+2SV6nRfZQineN6AFIanQcW0G+BTBxXKHs0CPC+wA5N4zs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 383D21CF732;
	Thu,  9 Nov 2023 19:22:43 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 88ECB1CF72F;
	Thu,  9 Nov 2023 19:22:42 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  Victoria Dye <vdye@github.com>
Subject: Re: [PATCH] glossary: add definitions for dereference & peel
In-Reply-To: <pull.1610.git.1699574277143.gitgitgadget@gmail.com> (Victoria
	Dye via GitGitGadget's message of "Thu, 09 Nov 2023 23:57:57 +0000")
References: <pull.1610.git.1699574277143.gitgitgadget@gmail.com>
Date: Fri, 10 Nov 2023 09:22:41 +0900
Message-ID: <xmqq1qcyxxri.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 437A71F2-7F5F-11EE-996F-25B3960A682E-77302942!pb-smtp2.pobox.com

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -125,6 +124,24 @@ to point at the new commit.
>  	dangling object has no references to it from any
>  	reference or <<def_object,object>> in the <<def_repository,repository>>.
>  
> +[[def_dereference]]dereference::
> +	Referring to a <<def_symref,symbolic ref>>: the action of accessing the
> +	<<def_ref,reference>> pointed at by a symbolic ref. Recursive
> +	dereferencing involves repeating the aforementioned process on the
> +	resulting ref until a non-symbolic reference is found.
> ++
> +Referring to a <<def_tag_object,tag object>>: the action of accessing the
> +<<def_object,object>> a tag points at. Tags are recursively dereferenced by
> +repeating the operation on the result object until the result has either a
> +specified <<def_object_type,object type>> (where applicable) or any non-"tag"
> +object type.
> ++

All of the above makes sense.

I would casually mention "peeling" here with cross reference,
if I were writing this section.  There already is enough cross
reference in the other direction pointing this way.

> +Referring to a <<def_commit_object,commit object>>: the action of accessing
> +the commit's tree object. Commits cannot be dereferenced recursively.

I personally consider this is weird misuse of the verb and is rarely
used, but we see it in the description of tree-ish below.

> +Unless otherwise specified, "dereferencing" as it used in the context of Git
> +commands or protocols is implicitly recursive.

Nice to see this spelled out like this.

> @@ -444,6 +461,12 @@ exclude;;
>  	of the logical predecessor(s) in the line of development, i.e. its
>  	parents.
>  
> +[[def_peel]]peel::
> +	Synonym for object <<def_dereference,dereference>>. Most commonly used
> +	in the context of tags, where it refers to the process of recursively
> +	dereferencing a <<def_tag_object,tag object>> until the result object's
> +	<<def_object_type,type>> is something other than "tag".

"object dereference" is not defined anywhere (yet).  "Most commonly
used in the context of tags" implies that objects other than tags
can be "peeled" and "object dereference" is a word to refer to
peeling either "commit" or "tag", but we would want to be a bit more
clear and explicit.  Let's either define "object dereference", or
better yet, avoid saying "object dereference" here and instead say
something like: "Synonym for dereference when used on tags and
commits".

I've never seen "peel" used for commits, though.  So another
improvement might be to say "peel" is "an act of dereferencing a
tag" here.

Thanks.
