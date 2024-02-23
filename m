Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349CF12B6A
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 06:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708670292; cv=none; b=rMay7SnWPa4+PVQ+qYY+9I6VOT/mB+ssXdexLrKEBvZOHvJ/Ra483h96HNWrv8ut8N5f12p05G/lAHXl1rF3WpKoDGAQrAH5Z0+l84Dc49nBjOVprpKrGulzHy+HuCI0TGnzTqmC5kPT/opFKZGOa1dDm4GJgDNHfLuBDZdZPow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708670292; c=relaxed/simple;
	bh=QfR8kmtn4wKdWBO1ZIEC6OMwfoe4nTZt94RnjynwKlk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UZViObqLPCgruFD4Jhut8Nw3Rl87sm7j4szrsh2MyUz1mV94LDYqv3ohid0sngrxo9rI/4ygUnH7GuhIizPFmLU3SieZqdyjR8QHGVIGKBVu67FpOmKTdJsUO9WEuhLfvHwOASyicxRijtIifqs/5X7rYKqNLskeHgY/uVmPW0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nBEEX27f; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nBEEX27f"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id EAD0A1ECF6;
	Fri, 23 Feb 2024 01:38:03 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=QfR8kmtn4wKdWBO1ZIEC6OMwfoe4nTZt94Rnjy
	nwKlk=; b=nBEEX27feRmFnBwTT9tQAadGved7BHhmEUNbh8eT13yyIUihpE8uLW
	Ynibpa6f2wXzzSMXzJz3RrMHqKxfUC+MuJrgTzHzkBhhNtazYZkQ2aAVejb+9cBD
	0BfA+vRpnW8nDOuG9FHu9bDMC+xVnnruY4n6O/TG9tZhz8P3u+pUc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D5F7E1ECF5;
	Fri, 23 Feb 2024 01:38:03 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F33281ECF2;
	Fri, 23 Feb 2024 01:37:59 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Jeff Hostetler
 <git@jeffhostetler.com>,  Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH v2 01/16] name-hash: add index_dir_find()
In-Reply-To: <03b07d9c25edb951db4de518212f8a3e9e184e49.1708658300.git.gitgitgadget@gmail.com>
	(Jeff Hostetler via GitGitGadget's message of "Fri, 23 Feb 2024
	03:18:05 +0000")
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
	<pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
	<03b07d9c25edb951db4de518212f8a3e9e184e49.1708658300.git.gitgitgadget@gmail.com>
Date: Thu, 22 Feb 2024 22:37:58 -0800
Message-ID: <xmqqy1bb1y9l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 164A2FEC-D216-11EE-8063-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jeff Hostetler <jeffhostetler@github.com>
>
> Replace the index_dir_exists() function with index_dir_find() and
> change the API to take an optional strbuf to return the canonical
> spelling of the matched directory prefix.
>
> Create an index_dir_exists() wrapper macro for existing callers.
>
> The existing index_dir_exists() returns a boolean to indicate if
> there is a case-insensitive match in the directory name-hash, but
> it doesn't tell the caller the exact spelling of that match.
>
> The new version also copies the matched spelling to a provided strbuf.
> This lets the caller, for example, then call index_name_pos() with the
> correct case to search the cache-entry array for the real insertion
> position.

The usual way to compose a log message of this project is to

 - Give an observation on how the current system work in the present
   tense (so no need to say "Currently X is Y", just "X is Y"), and
   discuss what you perceive as a problem in it.

 - Propose a solution (optional---often, problem description
   trivially leads to an obvious solution in reader's minds).

 - Give commands to the codebase to "become like so".

in this order.

I think the third paragraph you wrote should come at the beginning,
then the first (now second) paragraph should describe more clearly
that index_dir_find() is a new function and what it does (perhaps by
reusing what is in the "The new version also..."  paragraph),
without mentioning index_dir_exists().

The second (now third) paragraph then can talk about reimplementing
index_dir_exists() in terms of index_dir_find().

The patch text looks good.

Thanks.

> -int index_dir_exists(struct index_state *istate, const char *name, int namelen)
> +int index_dir_find(struct index_state *istate, const char *name, int namelen,
> +		   struct strbuf *canonical_path)
>  {
>  	struct dir_entry *dir;
>  
>  	lazy_init_name_hash(istate);
>  	expand_to_path(istate, name, namelen, 0);
>  	dir = find_dir_entry(istate, name, namelen);
> +
> +	if (canonical_path && dir && dir->nr) {
> +		strbuf_reset(canonical_path);
> +		strbuf_add(canonical_path, dir->name, dir->namelen);
> +	}
> +
>  	return dir && dir->nr;
>  }
>  
> diff --git a/name-hash.h b/name-hash.h
> index b1b4b0fb337..0cbfc428631 100644
> --- a/name-hash.h
> +++ b/name-hash.h
> @@ -4,7 +4,12 @@
>  struct cache_entry;
>  struct index_state;
>  
> -int index_dir_exists(struct index_state *istate, const char *name, int namelen);
> +
> +int index_dir_find(struct index_state *istate, const char *name, int namelen,
> +		   struct strbuf *canonical_path);
> +
> +#define index_dir_exists(i, n, l) index_dir_find((i), (n), (l), NULL)
> +
>  void adjust_dirname_case(struct index_state *istate, char *name);
>  struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int igncase);
