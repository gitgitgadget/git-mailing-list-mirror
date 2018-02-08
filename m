Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3E451F404
	for <e@80x24.org>; Thu,  8 Feb 2018 22:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751079AbeBHWOZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 17:14:25 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40491 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbeBHWOY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 17:14:24 -0500
Received: by mail-wr0-f194.google.com with SMTP id o76so3187582wrb.7
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 14:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5QYgvpr9FyuUpW3aEbhj5It0vTmzvUjEK6+g+cwOxqs=;
        b=IDCDeYluDZ8TNN7H7TplMcLohpfwx21KVTsg53Q0o0+LsQFMO1tQ2sjOUphZErtwCB
         jI+kdqxHlFlsu5cfN/lwIZJy4Kk5eZh3tuWzguIlsWmJfZc8wJnOeOdJzh40n/Bk9oEV
         d4QNmjWQH5ZORCapuaa9AcrG1Kr+BPMZAYnsD6bH+m5/ax1bkWjVK6+gdIFmymjAZT03
         Q2iSEZGLkRxtYY0qQV2FvSeUrnU8YGaoLgs0whBnHsuhruRTN/ll1ZZdtM1+1V8LjsmY
         M0XCxIJu2L+RHnDWnNv4loZe4LpayJBfYSGelh89sP7d1ylSDV2T3MfyixHVC+rBXARR
         SfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5QYgvpr9FyuUpW3aEbhj5It0vTmzvUjEK6+g+cwOxqs=;
        b=WYZu0461/NxiRVQikjVWOM8J91D6mD8vQUCrEPvSqxfeCcOHeWSz4NR8lYTZDON+9b
         r1EzmY3R7mHkhhO4w8ecHBEVKPBJMTJ3qO1s/krQh+RkUVaPYSn2KLu+Qa8/Hz+8TbDg
         jj3YOZJJJyA8hjkSd1Q2jN+N3hhttPMgXhQbyU+UFqNb21e7pxQQuuPYA8YJ+PmTVPkj
         YCyV2ZQzdx+XzVCu28mZ+G/TbocphIILHEsFawpfcnh46vSZ+ztLd7iDRWNHhVIhRYXf
         tCwf0G2zWJBVbFaUPssRX9nT1wprzX60Eyez97YjttvcBCtOn9ekdnM2bF+oUSG2AFTR
         lsRg==
X-Gm-Message-State: APf1xPC32BhcsOxumRfI9WVIAGXLRNuf9Zzd3tjPgyb++6ZSFrLTjIxP
        qQovm7KB7PJQL7zz+fwEH0E=
X-Google-Smtp-Source: AH8x226IuvZGiY+lddh3ZSIMingtxgLEbCSiC8uTRs0msitIl/GAuJ1aD4lGx0UT6/J9WNZm4v+TEQ==
X-Received: by 10.223.143.4 with SMTP id p4mr544713wrb.261.1518128063060;
        Thu, 08 Feb 2018 14:14:23 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a137sm904052wme.15.2018.02.08.14.14.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Feb 2018 14:14:22 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        peff@peff.net, jonathantanmy@google.com, sbeller@google.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v3 04/14] commit-graph: implement write_commit_graph()
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
        <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
        <1518122258-157281-5-git-send-email-dstolee@microsoft.com>
Date:   Thu, 08 Feb 2018 14:14:21 -0800
In-Reply-To: <1518122258-157281-5-git-send-email-dstolee@microsoft.com>
        (Derrick Stolee's message of "Thu, 8 Feb 2018 15:37:28 -0500")
Message-ID: <xmqqtvurp1s2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> +char* get_commit_graph_filename_hash(const char *pack_dir,

Asterisk sticks to the identifier, not type, in our codebase.

> +				     struct object_id *hash)
> +{
> +	size_t len;
> +	struct strbuf path = STRBUF_INIT;
> +	strbuf_addstr(&path, pack_dir);
> +	strbuf_addstr(&path, "/graph-");
> +	strbuf_addstr(&path, oid_to_hex(hash));
> +	strbuf_addstr(&path, ".graph");

Use of strbuf_addf() would make it easier to read and maintain, no?

> +
> +	return strbuf_detach(&path, &len);
> +}
> +
> +static void write_graph_chunk_fanout(struct sha1file *f,
> +				     struct commit **commits,
> +				     int nr_commits)
> +{
> +	uint32_t i, count = 0;
> +	struct commit **list = commits;
> +	struct commit **last = commits + nr_commits;
> +
> +	/*
> +	 * Write the first-level table (the list is sorted,
> +	 * but we use a 256-entry lookup to be able to avoid
> +	 * having to do eight extra binary search iterations).
> +	 */
> +	for (i = 0; i < 256; i++) {
> +		while (list < last) {
> +			if ((*list)->object.oid.hash[0] != i)
> +				break;
> +			count++;
> +			list++;
> +		}

If count and list are always incremented in unison, perhaps you do
not need an extra variable "last".  If typeof(nr_commits) is wider
than typeof(count), this loop and the next write-be32 is screwed
anyway ;-)

This comment probably applies equally to some other uses of the same
"compute last pointer to compare with running pointer for
termination" pattern in this patch.

> +		sha1write_be32(f, count);
> +	}
> +}

> +static int if_packed_commit_add_to_list(const struct object_id *oid,

That is a strange name.  "collect packed commits", perhaps?

> +					struct packed_git *pack,
> +					uint32_t pos,
> +					void *data)
> +{
> +	struct packed_oid_list *list = (struct packed_oid_list*)data;
> +	enum object_type type;
> +	unsigned long size;
> +	void *inner_data;
> +	off_t offset = nth_packed_object_offset(pack, pos);
> +	inner_data = unpack_entry(pack, offset, &type, &size);
> +
> +	if (inner_data)
> +		free(inner_data);
> +
> +	if (type != OBJ_COMMIT)
> +		return 0;
> +
> +	ALLOC_GROW(list->list, list->nr + 1, list->alloc);

This probably will become inefficient in large repositories.  You
know you'll be walking all the pack files, and total number of
objects in a packfile can be read cheaply, so it may make sense to
make a rough guestimate of the number of commits (e.g. 15-25% of the
total number of objects) in the repository and allocate the list
upfront, instead of a hardcoded 1024.

