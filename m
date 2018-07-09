Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DE0D1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 19:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933667AbeGITIS (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 15:08:18 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36664 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932937AbeGITIR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 15:08:17 -0400
Received: by mail-wm0-f66.google.com with SMTP id s14-v6so21853594wmc.1
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 12:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QuV9yEZF0vTx/Em6c2sek0VrxdJ83UHxPkv6EFnHUAQ=;
        b=Yokwa1O5QJ758/kanbOBUs4C0kEEAP31YqDChZcA/RNCR8eq8B5C6+PwIkOzT3P/i8
         IZPq+6iOODv0R7MpFKBVVdWdpf+IXTXv7tvrmYfIO/USA9u25GZ2FB29+TcL2NKq7RIR
         ZnOUcdP7JVrufcycubZDOWOcANnN5On42HyteK5s46dZRtbBQ7PcwKEBFiSNu+r0On3Z
         jD1eO/PhlQM+guwj1zWZyhhrvAP9E0urD8GiQZaR6m2NRWwqpnvGQhLVW3uS8dn4igkM
         Tiaf5jT+VZ7zj0AYUONcsXuvj60JNDTiwGNF7HkDXmvF6zJHjdqhyvH3eb9sbl3n4/3S
         3QXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QuV9yEZF0vTx/Em6c2sek0VrxdJ83UHxPkv6EFnHUAQ=;
        b=QB5M/NKqprXkbKwWjucEtyGqDFrYOJkHlmUe5v+pTp55dkzBIYqw9Rnfd7DGtkXFdn
         UW7vpKfNpLxrMiQeVYjoe60BlgN4K+31uVGHJ91vsxYEPS6pa+itfcMTPhwTV4ZKmoBD
         tQnF2xsc9DnSRz8WUWR6jtjqdx+qTHTOUEAbr1/MpClBVnQ8aVZCxW2Q5C92V1dqac39
         jdDz+DuFYXOkKH3uOAXSVJ+SDNAk2fgCIGyEW+N+5zw+ab1RtUsOfOxeL5+M/LapYBh1
         UDgaQu/Xv0MsxvcmGy5RRYwsF7aygiQbzHvIs32K2J244T6OulKS+jHnpyyiJurG8ld4
         kwcQ==
X-Gm-Message-State: APt69E15vN86mb7/QngtYHWXwjXeNfPBS0MWGLBXQ2NRYltc9pNUeaWL
        TCHqX0JnN7dSGqoGxiR0ZtE=
X-Google-Smtp-Source: AAOMgpfnHVtJTUiFsM/96D3rO3sO/OZjNwkCLOM2fadGBW+0OUQl+MJAa27kOKu8laJsXm8oQOmRjw==
X-Received: by 2002:a1c:a813:: with SMTP id r19-v6mr4984612wme.100.1531163295993;
        Mon, 09 Jul 2018 12:08:15 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t9-v6sm12578350wmh.41.2018.07.09.12.08.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 12:08:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, dstolee@microsoft.com
Subject: Re: [PATCH v3 06/24] multi-pack-index: load into memory
References: <20180625143434.89044-1-dstolee@microsoft.com>
        <20180706005321.124643-1-dstolee@microsoft.com>
        <20180706005321.124643-7-dstolee@microsoft.com>
Date:   Mon, 09 Jul 2018 12:08:14 -0700
In-Reply-To: <20180706005321.124643-7-dstolee@microsoft.com> (Derrick Stolee's
        message of "Thu, 5 Jul 2018 20:53:03 -0400")
Message-ID: <xmqq36wsdy75.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> +struct multi_pack_index *load_multi_pack_index(const char *object_dir)
> +{
> +	struct multi_pack_index *m = NULL;
> +	int fd;
> +	struct stat st;
> +	size_t midx_size;
> +	void *midx_map = NULL;
> +	uint32_t hash_version;
> +	char *midx_name = get_midx_filename(object_dir);
> +
> +	fd = git_open(midx_name);
> +
> +	if (fd < 0)
> +		goto cleanup_fail;
> +	if (fstat(fd, &st)) {
> +		error_errno(_("failed to read %s"), midx_name);
> +		goto cleanup_fail;
> +	}
> +
> +	midx_size = xsize_t(st.st_size);
> +
> +	if (midx_size < MIDX_MIN_SIZE) {
> +		close(fd);

With the use of "do things normally and jump to cleanup-fail label"
pattern, I think you do not want the close() here (unless you also
assign -1 to fd yourself, but that is a pointless workaround).
Another goto we see above after fstat() failure correctly omits it.

> +		error(_("multi-pack-index file %s is too small"), midx_name);
> +		goto cleanup_fail;
> +	}
> +
> +	FREE_AND_NULL(midx_name);

This correctly calls free-and-null not just free (otherwise we'd
break the cleanup-fail procedure below), which is good.

> +	midx_map = xmmap(NULL, midx_size, PROT_READ, MAP_PRIVATE, fd, 0);
> +
> +	m = xcalloc(1, sizeof(*m) + strlen(object_dir) + 1);
> +	strcpy(m->object_dir, object_dir);

Hmph, I thought we had FLEX_ALLOC_*() convenience functions exactly
for doing things like this more safely.

> +	m->fd = fd;
> +	m->data = midx_map;
> +	m->data_len = midx_size;
> +
> +	m->signature = get_be32(m->data);
> +	if (m->signature != MIDX_SIGNATURE) {
> +		error(_("multi-pack-index signature 0x%08x does not match signature 0x%08x"),
> +		      m->signature, MIDX_SIGNATURE);
> +		goto cleanup_fail;
> +	}
> +
> +	m->version = m->data[MIDX_BYTE_FILE_VERSION];
> +	if (m->version != MIDX_VERSION) {
> +		error(_("multi-pack-index version %d not recognized"),
> +		      m->version);
> +		goto cleanup_fail;
> +	}
> +
> +	hash_version = m->data[MIDX_BYTE_HASH_VERSION];
> +	if (hash_version != MIDX_HASH_VERSION) {
> +		error(_("hash version %u does not match"), hash_version);
> +		goto cleanup_fail;
> +	}
> +	m->hash_len = MIDX_HASH_LEN;
> +
> +	m->num_chunks = m->data[MIDX_BYTE_NUM_CHUNKS];
> +
> +	m->num_packs = get_be32(m->data + MIDX_BYTE_NUM_PACKS);
> +
> +	return m;

> +cleanup_fail:
> +	/* no need to check for NULL when freeing */

I wonder who the target reader of this comment is.  We certainly are
not in the business of C language newbies.

If this _were_ a commit that looked like this:

	-	if (ptr)
	-		free(ptr);
	+	/* no need to check for NULL when freeing */
	+	free(ptr);

then it might be more understandable, but it still is wrong (such a
comment does not help understanding the new code, which is the only
thing the people who read the comment sees, without knowing what was
there previously---it belongs to the commit log message as a rationale
to make that change).

> diff --git a/midx.h b/midx.h
> index dbdbe9f873..2d83dd9ec1 100644
> --- a/midx.h
> +++ b/midx.h
> @@ -1,6 +1,10 @@
>  #ifndef __MIDX_H__
>  #define __MIDX_H__
>  
> +struct multi_pack_index;

I actually was quite surprised that this struct is defined in
object-store.h and not here.  It feels the other way around.

The raw_object_store needs to know that such an in-core structure
might exist as an optional feature in an object store, but as an
optional feature, I suspect that it has a pointer to an instance of
multi_pack_index, instead of embedding the struct itself in it, so I
would have expected to see an "I am only telling you that there is a
struct with this name, but I am leaving it opaque as you do not have
any business looking inside the struct yourself.  You only need to
be aware of the type's existence and a pointer to it so that you can
call helpers that know what's inside and that should be sufficient
for your needs." decl like this in object-store.h and instead an
actual implementation in here.
