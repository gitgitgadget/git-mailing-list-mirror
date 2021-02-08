Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55760C43381
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 22:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2570F64EA4
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 22:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhBHW2G (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 17:28:06 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50964 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbhBHW1q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 17:27:46 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7F741123BFA;
        Mon,  8 Feb 2021 17:27:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SJGozPBmgVyTHIczUFzB8O/uLDA=; b=IjJptT
        R7kaDf+VB5W1l+gQ4WhoeiIoT4SZnhCqkxNeGZUv7HOIpAIlliUYWR7qjnggn7OB
        UhVQDLC5mgcEa0QLLVoH6+AjAO/h1eqgb5yIFIZLUK2/zHWeZTghDbsM7/I+JISp
        U6JBUYa3haPKyRApTWA1HoqzQp5l4sc0VJm2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=B7Wv6A9C6s5ft37eQGssv+i6NIkJU7dS
        Q9L+YS64/1rbQz1cXjjVZmSPvpT0dZ8FdzapUFuAx/fQ8v//cKZ/sPzPKSTjdTh/
        DsDlzap6lIzhALddqTlOS//idtdLwLOsU98y2yvs133wmfC2T6BLUZfKtxTzoT1c
        TLXYQOgKD1g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 78ADC123BF9;
        Mon,  8 Feb 2021 17:27:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C1B7D123BF7;
        Mon,  8 Feb 2021 17:27:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, l.s.r@web.de,
        szeder.dev@gmail.com, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 12/17] chunk-format: create read chunk API
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
        <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
        <d8d8e9e2aa3faf0fdda5dc688fb92e924fec423a.1611759716.git.gitgitgadget@gmail.com>
        <xmqqczxf4d2k.fsf@gitster.c.googlers.com>
        <1278de82-417c-a6ee-a5fe-055fa0ef1903@gmail.com>
        <xmqqeehu1f1q.fsf@gitster.c.googlers.com>
Date:   Mon, 08 Feb 2021 14:26:58 -0800
In-Reply-To: <xmqqeehu1f1q.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 05 Feb 2021 11:37:53 -0800")
Message-ID: <xmqqh7mm42ml.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C31F8232-6A5C-11EB-8E44-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The users of pair_chunk() presumably are not ready to (or simply do
> not want to) process the data immediately by using read_chunk() with
> callback, but when they get ready to process the data, unlike
> read_chunk callbacks, they do not get to learn how much they ought
> to process---all they learn is the address of the beginning of the
> chunk.  I do not see a way to write pair_chunk() users safely to
> guarantee that they do not overrun at the tail end of the chunk they
> are processing.

I've read through v3 and found it mostly done, but the above
question still stands.  I find it questionable why callers of
pair_chunk() only can learn where a chunk data begins, without
being able to learn how big the region of memory is.  IOW, why
can we get away without doing something like this?  The users
of pair_chunk() won't even know when they overrun the end of
the data the are given without something like this, no?

Thanks.

+struct memory_region {
+	const unsigned char *p;
+	size_t sz;
+};
+
 static int pair_chunk_fn(const unsigned char *chunk_start,
                          size_t chunk_size,
                          void *data)
 {
-        const unsigned char **p = data;
-        *p = chunk_start;
+        struct memory_region *x = data;
+        x->p = chunk_start;
+        x->sz = chunk_size;
         return 0;
 }



 int pair_chunk(struct chunkfile *cf,
                uint32_t chunk_id,
-                const unsigned char **p)
+                const unsigned char **p,
+                size_t *sz)
 {
+        int ret;
+        struct memory_region x;
=        return read_chunk(cf, chunk_id, pair_chunk_fn, &x);
+        ret = read_chunk(cf, chunk_id, pair_chunk_fn, &x);
+        *p = x.p;
+        *sz = x.sz;
+        return ret;
 }

