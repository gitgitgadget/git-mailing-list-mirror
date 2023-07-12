Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA4FC0015E
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 23:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbjGLXhf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 19:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbjGLXha (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 19:37:30 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672DE119
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:37:29 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-579ed2829a8so79842997b3.1
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689205048; x=1691797048;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wYOqEpL2Z/+DnKbJAY8EkUxleHIkpot0l0LMNLD1uIg=;
        b=TfWqd1zYYUgTFo3MkN0rw39oUlEt/tFNDyZJMbDbiLbQuIzRgNBARibc7UcuVWld0u
         6Jk5+aj6cZyoZ9iHQJKGj4WSoD6UU+7ArjRmBx0nKLRq6kUQ5iT8KPEqwYTKWsqzmfs0
         wCAEDXZT++w2dWn7lUl/efjYwqqWFAoGPd0sZXAaXX8rO0536p90ngakG5dL6SOydEFq
         HCeyW9FEoaifXEp3F1RnyT3NcdkNggOBwEunNrMt1M1AOOL8jP/NGGQyHA4nNEmDuwN+
         csul1pHplUbgSRUdrkTwvBIg4NHn1zzY9X2vEXju6EA7gjWtmxFbHCCvv1e4+GV1WRbw
         1yaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689205048; x=1691797048;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wYOqEpL2Z/+DnKbJAY8EkUxleHIkpot0l0LMNLD1uIg=;
        b=XtdoydE8GZ5Lmf9BpXe85BT+V7XxaWoBeyH5omJtamVugUdC9OMqwBj1Gffw21C/C0
         BunH9MxRFbNXkZBdm7ka3gNG2k8DgxQwOZKnI3eRgGAnxzCY6Kd04QdL8lmFKxbH4j6k
         enVsQhlvd7k2QJGDEU4jPeHevxkzHc5NeynmdPW9rFCLWojOCC2/p4nImCPXaMI2x/NE
         BN6QsFgXdyD45usdPj5GDmEUUCk1iDeIZE8noOdohiVSbhSLT5j+qncUJTFrVFMZN0Zh
         UHoBhkBh86aqXIl7pYWXogSmu9uCneMqtQOAVTb6ioGkQ39ridtl7OUM2gBNbYiygp4E
         HDlQ==
X-Gm-Message-State: ABy/qLbb2JN5ja7wSmY7c12TdKVQ1aW8X1o03SaDi7epIvrLEH6JNrUY
        7epdSeKec+vZh1EHQ0oDTHWvPUnptQMoormQRsuBgw==
X-Google-Smtp-Source: APBJJlHrHnvz7rmmD9RUvyDwHnktF7G1AKowcjJjqx4STCSlU2af5A0xMAAIYaRsF/dYw/DIMvrGkA==
X-Received: by 2002:a0d:d816:0:b0:570:670c:7fe3 with SMTP id a22-20020a0dd816000000b00570670c7fe3mr71591ywe.46.1689205048492;
        Wed, 12 Jul 2023 16:37:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s126-20020a0dd084000000b0057a918d6644sm1444407ywd.128.2023.07.12.16.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 16:37:28 -0700 (PDT)
Date:   Wed, 12 Jul 2023 19:37:27 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Subject: [PATCH 01/20] packfile.c: prevent overflow in
 `nth_packed_object_id()`
Message-ID: <5e92582e2912806e0068af97c265fb50e8bbe54f.1689205042.git.me@ttaylorr.com>
References: <cover.1689205042.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1689205042.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 37fec86a83 (packfile: abstract away hash constant values,
2018-05-02), `nth_packed_object_id()` started using the variable
`the_hash_algo->rawsz` instead of a fixed constant when trying to
compute an offset into the ".idx" file for some object position.

This can lead to surprising truncation when looking for an object
towards the end of a large enough pack, like the following:

    (gdb) p hashsz
    $1 = 20
    (gdb) p n
    $2 = 215043814
    (gdb) p hashsz * n
    $3 = 5908984

, which is a debugger session broken on a known-bad call to the
`nth_packed_object_id()` function.

This behavior predates 37fec86a83, and is original to the v2 index
format, via: 74e34e1fca (sha1_file.c: learn about index version 2,
2007-04-09).

This is due to §6.4.4.1 of the C99 standard, which states that an
untyped integer constant will take the first type in which the value can
be accurately represented, among `int`, `long int`, and `long long int`.

Since 20 can be represented as an `int`, and `n` is a 32-bit unsigned
integer, the resulting computation is defined by §6.3.1.8, and the
(signed) integer value representing `n` is converted to an unsigned
type, meaning that `20 * n` (for `n` having type `uint32_t`) is
equivalent to a multiplication between two unsigned 32-bit integers.

When multiplying a sufficiently large `n`, the resulting value can
exceed 2^32-1, wrapping around and producing an invalid result. Let's
follow the example in f86f769550e (compute pack .idx byte offsets using
size_t, 2020-11-13) and replace this computation with `st_mult()`, which
will ensure that the computation is done using 64-bits.

While here, guard the corresponding computation for packs with v1
indexes, too. Though the likelihood of seeing a bug there is much
smaller, since (a) v1 indexes are generated far less frequently than v2
indexes, and (b) they all correspond to packs no larger than 2 GiB, so
having enough objects to trigger this overflow is unlikely if not
impossible.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 packfile.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/packfile.c b/packfile.c
index c2e753ef8f..89220f0e03 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1920,10 +1920,10 @@ int nth_packed_object_id(struct object_id *oid,
 		return -1;
 	index += 4 * 256;
 	if (p->index_version == 1) {
-		oidread(oid, index + (hashsz + 4) * n + 4);
+		oidread(oid, index + st_add(st_mult(hashsz + 4, n), 4));
 	} else {
 		index += 8;
-		oidread(oid, index + hashsz * n);
+		oidread(oid, index + st_mult(hashsz, n));
 	}
 	return 0;
 }
-- 
2.41.0.347.g7b976b8871f

