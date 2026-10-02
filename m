Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858944DE720
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 15:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955958; cv=none; b=bJgVo0oSSsHYH4A5VS/TrVb7VzurwMlNfMWNkiRRgTZTDpvWS9sz4vXkN4IdeurHIh/71XmO5so/ux5J44cjnnycYQ+bkhJehS55Zfj5Z/npbSKTyY9oiE0jpBDLtvqBMLFU8N1v31BuUL89UWdxdPvL4gbwMgV1BGWD0xANWsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955958; c=relaxed/simple;
	bh=7z2hxEAL72x78wyoXj6y83Iwhv3C/6B/S5by76igl7Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rBa+BITuMy4raVTsTriFoelYmDZQrBioEe0HRtnndUHKgDORHO/0xShf0QB+vEdTHwWIQJi3FYLe47X1OCOk3JKX6IBA246AmrilkS7m/j3fJ4YwkiS8cvpbTIrxyKMYLTuIBpVDNIIf79jlp/bBY2UOIFtbU+HKvm5uGcb4E4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=w0qDENe8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AojOTiNv; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="w0qDENe8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AojOTiNv"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id B9D461D000E0
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 11:45:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 02 Oct 2026 11:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790955955; x=1791042355; bh=TTjk02pZSa
	XuFvWQQjVSdF8ikiV8eC1iMeA6sDeGEjw=; b=w0qDENe87z7ZNr2mxsdaf/YuJ9
	FLYj1SigDMK/aCIFWHxS/8ujDZ14TeisAqGGLSmkkmXifS8ASS8VGBU/mg9FfMHT
	rwxgB+fV4cJpMBYtSS7CcbVfeTbNxSDbQgRyI4e6A4ikT1tVYVD17daQ0QnfB3Ge
	RWv40E6xt0rADYjIeVcIyfjqSogKhbhrsaSR5rlHAjBP8YEpagmGJL03saDZZ7Oq
	UFnIFs0W4oeWVscgb1Dg7VhYW3dcAwlfsVnlWQcLCzWjmZ3zjq7LJWmlWciCt9FY
	XdkRzQX29Y/lWr/YSyVISQ0B2LtRIC4rdSm67EQCAjflK6uCdwJdBCZqsK6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790955955; x=1791042355; bh=TTjk02pZSaXuFvWQQjVSdF8ikiV8eC1iMeA
	6sDeGEjw=; b=AojOTiNvOeRgmAwhxAWIm71svo+vmGZO5slCQyiq0YBbvj0HydT
	xhEJTLW5zxGqGlZKCMZEjaHGKzzsdl9f+uvQINnkjKMPyeUNQNQ3kM+u5x6iT9vx
	nHkmeqAGZboBv9SnAZQH5lEvLp91I3S76dg+eorJ6FHTdI+YtqfJd0Eyw7tt7T1k
	5Ds2zNPl8aAE1FRRv3bAwyqKqYTZqLGkeKDDMzb+5HQDbLOknMOjQ9VVvsEvjdgp
	7+c7iLA4NVYKdpwGWz7lZGV7NZentYDESzv/BSDyvpG2kgY+mUaxzZ9lK0UE0jp7
	0+K9jaNBitmSEpiBy/+RB2ZG/ZdzpkmEEuw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790955955; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:thiyFgohR6HZcFubpSlnRV0nlmb1FGIvWURJcOpoGzCZkEg
	w2lRozv/Bi1lTbwBEk7Vw1FedKa5JI0NiIAan3Vr6+fKworCGzu2oD01pO75Nc3P
	0/hMFk/bN0n5eYh9pS6EQsYudK5f+LllBo8iqbCXFRKnz9eCs2PQvFs+AXSxjB/c
	3nlQijPrr49BjeG3bEXqWlm1sCQMk9oWZYItBZaI83XAsLkyFSpNsSVdgirClp4f
	dbxlFNYZj7HpjHBaFwBofj9e27iymp6qRg0AhDqxwlJqaGGw6JZVlaQcQ6IsxH5s
	7pUpEtUHDXDuOFJzqpVpy6iaBTikeLYA6bBK14Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:XXl95/a6NZASIBKpLhJZj5NRxN/m2NAkSWP/2s8+ddo=:7z2hxEAL72x78wyoXj6y83Iwhv3C/6B/S5by76igl7Q=;
X-ME-Sender: <xms:s9G_avam8jtxDg7IuQxhF8uVCiPmf8Hl1tlFU2rUTEtqYMrdVT0a1w>
    <xme:s9G_al0S7HgHL05LTTc6r7Tpmeo-EGgbbekcZ5A6tEPg2zIthl-3VPySsvMD35G4m
    Nwb-WLaPgpJP4SCi-lXxAjfg3WajnzwKtlY6sAfRVZX_3u2mMzcOA>
X-ME-Received: <xmr:s9G_avVnPV28eoSU91IdT5YpKoUp9xHtLYyy_sZoqlkd2-z7ONmy80UBC20GXEOxNZlA7xgEJ51ASX0N1uO00SQg--2SbYsL5ZrV>
X-ME-Proxy-Cause: dmFkZTERuFJR5OstwcPwCTNn8mtNxqsqLjg+wNtJvRPhoPs3SGxuhz03orxC2+VDcsEQLb
    +1FGh7YMeGoIuzgB+e4Ir3J46JCfYIIkR0t5Jg39FGa2oQYq6opAiscuT6DdIvHBFaySto
    vgcCQFO1khrEhQf9axyaV/mAW47eZqU96lVY6+E2oYbrRyQZzt7NAtwnKeR2HYNELZRooJ
    79ihwfAlVSHbzLPZ9PErYSvc5r8NLCPxgJ5d6XOLCPwza9mvl02f/ZCSka5OZ+Kvjdr3mq
    NTZaIuAXPuN1tdGQ7Ve0AAYfcyoqjkFWCAyax9Vin0jBv46kOpwec1uVjonB4f6RtJkgng
    bG9roeN9WFZ0XkhR1VJR1HPgbaZeWtiCZ72mnuSnfOo2ygsAIuZE/cpII4poPiLIomX3vn
    aviz2t1eC6O76AOhjDmcGZWIDHC4J8aHR5AvZ1pOcYPoMl/0D7mNSIbCVoWOUAJw6zrH7g
    gEkkR2KLx58HLfyJ4/LtRzJvYyGvsdGwENUnQcGi+GiFe3MD5I5PgD9KhblCzRlz9Flm8n
    7qFhIWewdXxHMD2XGdVUERGhFUla6Sglf9tF+i0j8lFZM+b7yBqdyOmapXLc2jjamAKB+5
    fhQNSsLsMo/CVDIfE860E0ZjLWvmFdKxy569CFBHcnhe5PadAQlvmX73tTOw
X-ME-Proxy: <xmx:s9G_avXkMRMEKy2yu8cbvLV92hwvux9KrHDxmvkDbjFBeq6JBDNTJg>
    <xmx:s9G_aucVMPLDVrfet4RXYq8Y4Ze5P0E8feYnYtCY4hd8QQW8udY2Tg>
    <xmx:s9G_aoVerN-t58wnlChAUrQ76iAMpRqnU9FSDarCHLfIdn-HRkNnlw>
    <xmx:s9G_anfGvv_9HLCK9mQzTP4WyVsU-rZ_sVQd56az2nQb3g_yP2CPVA>
    <xmx:s9G_aidkX3vlMBnxzyL-Gsb_8m5_BaPk7dBIGd_ZYPwqQV7KUbOaeUnu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 11:45:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Scott Chacon <scott@gitbutler.net>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] tree-sha256: hash the contents of a tree with
 SHA-256
In-Reply-To: <20261002081846.25144-2-scott@gitbutler.net> (Scott Chacon's
	message of "Fri, 2 Oct 2026 10:18:43 +0200")
References: <20261002081846.25144-1-scott@gitbutler.net>
	<20261002081846.25144-2-scott@gitbutler.net>
Date: Fri, 02 Oct 2026 08:45:53 -0700
Message-ID: <xmqqtsn4yuku.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Scott Chacon <scott@gitbutler.net> writes:

> Add a way to compute a SHA-256 digest of the contents of a tree that
> doesn't depend on the object format, so that it can be put in the
> signed payload. Each blob in the tree, recursively, becomes one record, 
> and the digest is SHA-256 over the records sorted by path:
>
>   <hex sha256 of content> SP <path> NUL

Would three trees, one records a blob with a single word "hello" at
a path as an executable regular file, another records the same blob
at the same path but as a non-executable regular file, and the third
records a symbolic link whose target is "hello", hash to the same
result?  Should they?

> +static int hash_tree(struct repository *r, const struct object_id *oid,
> +		     const char *prefix, struct oid_array *chain,
> +		     struct walk *walk, unsigned char *digest)
> +{
> +	const struct git_hash_algo *sha256 = &hash_algos[GIT_HASH_SHA256];
> +	struct git_hash_ctx outer;
> +	struct collect c = { 0 };
> +	struct pathspec pathspec = { 0 };
> +	struct strbuf value = STRBUF_INIT;
> +	struct tree *tree;
> +	int ret = 0;
> +
> +	tree = repo_parse_tree_indirect(r, oid);
> +	if (!tree)
> +		return error(_("unable to read tree for %s in %s"),
> +			     oid_to_hex(oid), *prefix ? prefix : ".");
> +	if (read_tree(r, tree, &pathspec, collect_entry, &c))
> +		return error(_("unable to read tree %s"),
> +			     oid_to_hex(&tree->object.oid));
> +	QSORT(c.items, c.nr, record_cmp);

I am somewhat torn but moderately against this sorting there.  If
we have two tree objects that would result in the same checkout,
but one is corrupt in such a way that whose entries are not sorted
correctly, we want them to hash to a different value to signal that,
don't we?

> +	git_hash_init(&outer, sha256);
> +	for (size_t i = 0; i < c.nr; i++) {
> +		struct record *rec = &c.items[i];
> +
> +		strbuf_reset(&value);
> +		if (!rec->submodule) {
> +			struct git_hash_ctx ctx;
> +			unsigned char blob_digest[GIT_MAX_RAWSZ];
> +			enum object_type type;
> +			size_t size;
> +			void *data;
> +
> +			data = odb_read_object(r->objects, &rec->oid, &type, &size);
> +			if (!data || type != OBJ_BLOB) {
> +				free(data);
> +				ret = error(_("unable to read blob %s for %s%s"),
> +					    oid_to_hex(&rec->oid), prefix, rec->path);
> +				break;
> +			}
> +			git_hash_init(&ctx, sha256);
> +			git_hash_update(&ctx, data, size);
> +			git_hash_final(blob_digest, &ctx);
> +			free(data);
> +			strbuf_addstr(&value, hash_to_hex_algop(blob_digest, sha256));

This forces us to read the inflated blob contents as a whole in-core
before we hash.  I wonder if we can use the streaming interface like
how archive-{tar,zip}.c uses odb_stream_from_object() to read the
contents in smaller chunks?  Instead of writing the contents out
like they do, we would instead hash the bytes here.
