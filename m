Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7183261665
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 21:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707860597; cv=none; b=eJMIo2nMimMteE3dDXLl3W8kYs0ZQpzPw40SEaYYgxEMFTUHTcQ2teNuiZbtao+Bf3vLOAfdNSMYqpTpLXjQRTWHYDGsw+bBQK8eu3SjAD5grGNp7yuwxRb02BVvYzNLBwOilLXhq//0BZUXm+xs43wnhGl+kgIrOLrqoUFgYu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707860597; c=relaxed/simple;
	bh=jibJShu6+lJov/IjqUXj0e3I41NZbJxD1CGz+jRfSDs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D5heFULko6yhcOmm3MxKQqupQ1JJLp2DPqaT0nGSi+qenNQ256sZawbZ1iJ89mvWFOYW7fLDLuOXPvVKvuf7xe7XCBDTxgxe/hFxuDg2mazn7989HFK6814W3BH8RijWhfMFIVrv5tYmZ1pKZTH6hbA1oRCWuuX+AHcG1l9DQtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BsGJlorn; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BsGJlorn"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D2B771C7722;
	Tue, 13 Feb 2024 16:43:13 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=jibJShu6+lJov/IjqUXj0e3I41NZbJxD1CGz+j
	RfSDs=; b=BsGJlornsTxQSivF0vzkjND12+kk0sQ1/MV6m4kEk8HGvkZJaYTA7Q
	iJIC3x4++RAzTbGc+TU7rqCg4Egqf89CQu1r2kJZ9Esrn5CWDqqYo6reHWm9vFd4
	+yFJbqTsMVQu0IJzXsGuDetHSEetp6h6KcDyVuQCniknrJpNBdXWY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C86F21C7721;
	Tue, 13 Feb 2024 16:43:13 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3378F1C7720;
	Tue, 13 Feb 2024 16:43:13 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH 02/12] name-hash: add index_dir_exists2()
In-Reply-To: <3464545fe3feceb08408618c77a70cc95745bfe9.1707857541.git.gitgitgadget@gmail.com>
	(Jeff Hostetler via GitGitGadget's message of "Tue, 13 Feb 2024
	20:52:11 +0000")
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
	<3464545fe3feceb08408618c77a70cc95745bfe9.1707857541.git.gitgitgadget@gmail.com>
Date: Tue, 13 Feb 2024 13:43:12 -0800
Message-ID: <xmqqeddg2g7j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E35B200A-CAB8-11EE-9959-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jeff Hostetler <jeffhostetler@github.com>
>
> Create a new version of index_dir_exists() to return the canonical
> spelling of the matched directory prefix.
>
> The existing index_dir_exists() returns a boolean to indicate if
> there is a case-insensitive match in the directory name-hash, but
> it doesn't tell the caller the exact spelling of that match.
>
> The new version also copies the matched spelling to a provided strbuf.
> This lets the caller, for example, then call index_name_pos() with the
> correct case to search the cache-entry array for the real insertion
> position.
>
> Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
> ---
>  name-hash.c | 16 ++++++++++++++++
>  name-hash.h |  2 ++
>  2 files changed, 18 insertions(+)
>
> diff --git a/name-hash.c b/name-hash.c
> index 251f036eef6..d735c81acb3 100644
> --- a/name-hash.c
> +++ b/name-hash.c
> @@ -694,6 +694,22 @@ int index_dir_exists(struct index_state *istate, const char *name, int namelen)
>  	dir = find_dir_entry(istate, name, namelen);
>  	return dir && dir->nr;
>  }
> +int index_dir_exists2(struct index_state *istate, const char *name, int namelen,
> +		      struct strbuf *canonical_path)
> +{
> +	struct dir_entry *dir;
> +
> +	strbuf_init(canonical_path, namelen+1);
> +
> +	lazy_init_name_hash(istate);
> +	expand_to_path(istate, name, namelen, 0);
> +	dir = find_dir_entry(istate, name, namelen);
> +
> +	if (dir && dir->nr)
> +		strbuf_add(canonical_path, dir->name, dir->namelen);
> +
> +	return dir && dir->nr;
> +}
>  
>  void adjust_dirname_case(struct index_state *istate, char *name)

Missing inter-function blank line, before the new function.

I wonder if we can avoid such repetition---the body of
index_dir_exists() is 100% shared with this new function.

Isn't it extremely unusual to receive "struct strbuf *" and call
strbuf_init() on it?  It means that the caller is expected to have a
strbuf and pass a pointer to it, but also it is expected to leave
the strbuf uninitialized.

I'd understand if it calls strbuf_reset(), but it may not even be
necessary, if we make it responsibility of the caller to pass a
valid strbuf to be appended into.

	int index_dir_find(struct index_state *istate,
			   const char *name, int namelen,
			   struct strbuf *canonical_path)
	{
                struct dir_entry *dir;

                lazy_init_name_hash(istate);
                expand_to_path(istate, name, namelen, 0);
                dir = find_dir_entry(istate, name, namelen);

                if (canonical_path && dir && dir->nr) {
			// strbuf_reset(canonical_path); ???
                	strbuf_add(canonical_path, dir->name, dir->namelen);
		}
                return dir && dir->nr;
	}

Then we can do

	#define index_dir_exists(i, n, l) index_dir_find((i), (n), (l), NULL)

in the header for existing callers.

>  {
> diff --git a/name-hash.h b/name-hash.h
> index b1b4b0fb337..2fcac5c4870 100644
> --- a/name-hash.h
> +++ b/name-hash.h
> @@ -5,6 +5,8 @@ struct cache_entry;
>  struct index_state;
>  
>  int index_dir_exists(struct index_state *istate, const char *name, int namelen);
> +int index_dir_exists2(struct index_state *istate, const char *name, int namelen,
> +		      struct strbuf *canonical_path);
>  void adjust_dirname_case(struct index_state *istate, char *name);
>  struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int igncase);
