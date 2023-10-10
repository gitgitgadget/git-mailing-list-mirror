Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E066CD98C0
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 23:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjJJXug (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 19:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjJJXuf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 19:50:35 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5339593
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 16:50:34 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-77575531382so408916585a.3
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 16:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696981833; x=1697586633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r4WiVenVL/swnlvQLdhtAERHB5C6nYf19GsoXzRJV8k=;
        b=ssj7kkThMwpGcoXjqYffcYQQLenTllMwGh5vR9iTZkeJUgNUGjosByIcShHR/0L+WT
         /YM0UllTFivYzhUOSkexy3NqDfqHusElLMoUccAetPbE1Wt1atmPX7l7hxMgBpJXkxzU
         shQQiCQYe9xEi8P3H72d4tm47Pm9uv8h6JbISLjOPQdMpQr/kfPN8Qn7PyUerj01PYbF
         PT/BB02vHQejo0UorNVgDRofMhu2Vl500bTE81d/a3w5uctMPGBthv+QfO2BVQf8WdMZ
         oDvIUOy6AD+3NH9evlBBUIK3JrPudmM6YM1136J1sKutmkrQUBReRQhcROLoZuk0SyIO
         9ekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696981833; x=1697586633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4WiVenVL/swnlvQLdhtAERHB5C6nYf19GsoXzRJV8k=;
        b=p7oKTrjWtMlIhhf5olcAkOUxrl3/JqOaMUTv+Wu3JqfnViSVZhr39ecsyX85//Tchk
         y3PYQdwZeRQscAnZht6PoKRAM8u2gOegMoRwTVV1v1t4yNxF4WwyBs4YM19pjqd6/5v3
         bbdhXttJn5uHNAnsHZI0XirDUuAjcmd2Q5fj8Z5MGR1WjOcni5qA/YeuotvbWpv798tD
         7ybiZDsa1OnLhqb3JIXRPb0KQAgIx7ofA0k2SIQ75AmpIvvQnPRYGbeKB5vNvmgdiNRJ
         u21ajow9B08V8zQCBIaHzz6xnJJu4jD0BIsq/78Y25mwORe9sLYAdoPQXAUa1zc4SgDv
         dDew==
X-Gm-Message-State: AOJu0YyJt9ExxJumLe3f0g7BJ1rNQyvizH7CGdfw8Z8yUkPMqP/+uMr1
        wwDSUiZheZI1YCKg6l6/vO/WBJu6sdArQzaewrh0ig==
X-Google-Smtp-Source: AGHT+IEZ7/6/x2mS2GjvjAty/fIBsB/irIfSi8bCeu/0YiJbZhXJmVj9X0XXBQRE1RM5FDfJVsD7Sg==
X-Received: by 2002:a0c:f2cf:0:b0:65a:fa53:ed07 with SMTP id c15-20020a0cf2cf000000b0065afa53ed07mr19602465qvm.59.1696981833351;
        Tue, 10 Oct 2023 16:50:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id es5-20020a056214192500b0065af24495easm8239qvb.51.2023.10.10.16.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 16:50:32 -0700 (PDT)
Date:   Tue, 10 Oct 2023 19:50:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 03/20] midx: stop ignoring malformed oid fanout chunk
Message-ID: <ZSXjR6BjvaokNwPe@nand.local>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
 <20231009205919.GC3282181@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009205919.GC3282181@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 09, 2023 at 04:59:19PM -0400, Jeff King wrote:
> When we load the oid-fanout chunk, our callback checks that its size is
> reasonable and returns an error if not. However, the caller only checks
> our return value against CHUNK_NOT_FOUND, so we end up ignoring the
> error completely! Using a too-small fanout table means we end up
> accessing random memory for the fanout and segfault.
>
> We can fix this by checking for any non-zero return value, rather than
> just CHUNK_NOT_FOUND, and adjusting our error message to cover both
> cases. We could handle each error code individually, but there's not
> much point for such a rare case. The extra message produced in the
> callback makes it clear what is going on.
>
> The same pattern is used in the adjacent code. Those cases are actually
> OK for now because they do not use a custom callback, so the only error
> they can get is CHUNK_NOT_FOUND. But let's convert them, as this is an
> accident waiting to happen (especially as we convert some of them away
> from pair_chunk). The error messages are more verbose, but it should be
> rare for a user to see these anyway.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  midx.c                      | 16 ++++++++--------
>  t/t5319-multi-pack-index.sh | 20 +++++++++++++++++++-
>  2 files changed, 27 insertions(+), 9 deletions(-)
>
> diff --git a/midx.c b/midx.c
> index 3165218ab5..21d7dd15ef 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -143,14 +143,14 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
>  				   MIDX_HEADER_SIZE, m->num_chunks))
>  		goto cleanup_fail;
>
> -	if (pair_chunk_unsafe(cf, MIDX_CHUNKID_PACKNAMES, &m->chunk_pack_names) == CHUNK_NOT_FOUND)
> -		die(_("multi-pack-index missing required pack-name chunk"));
> -	if (read_chunk(cf, MIDX_CHUNKID_OIDFANOUT, midx_read_oid_fanout, m) == CHUNK_NOT_FOUND)
> -		die(_("multi-pack-index missing required OID fanout chunk"));
> -	if (pair_chunk_unsafe(cf, MIDX_CHUNKID_OIDLOOKUP, &m->chunk_oid_lookup) == CHUNK_NOT_FOUND)
> -		die(_("multi-pack-index missing required OID lookup chunk"));
> -	if (pair_chunk_unsafe(cf, MIDX_CHUNKID_OBJECTOFFSETS, &m->chunk_object_offsets) == CHUNK_NOT_FOUND)
> -		die(_("multi-pack-index missing required object offsets chunk"));
> +	if (pair_chunk_unsafe(cf, MIDX_CHUNKID_PACKNAMES, &m->chunk_pack_names))
> +		die(_("multi-pack-index required pack-name chunk missing or corrupted"));
> +	if (read_chunk(cf, MIDX_CHUNKID_OIDFANOUT, midx_read_oid_fanout, m))
> +		die(_("multi-pack-index required OID fanout chunk missing or corrupted"));
> +	if (pair_chunk_unsafe(cf, MIDX_CHUNKID_OIDLOOKUP, &m->chunk_oid_lookup))
> +		die(_("multi-pack-index required OID lookup chunk missing or corrupted"));
> +	if (pair_chunk_unsafe(cf, MIDX_CHUNKID_OBJECTOFFSETS, &m->chunk_object_offsets))
> +		die(_("multi-pack-index required object offsets chunk missing or corrupted"));

All makes sense. I have a mild preference for "missing or corrupt" over
"missing or corrupted", but it's mild enough that I wouldn't be sad if
you kept it as-is ;-).

I do wonder if translators would be happy with:

      die(_("multi-pack-index required %s chunk missing or corrupt"),
          "OID fanout");

or if that is assuming too much about the languages that we translate
into.

> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> index 1bcc02004d..b8fe85aeba 100755
> --- a/t/t5319-multi-pack-index.sh
> +++ b/t/t5319-multi-pack-index.sh

The rest of the patch is looking good...

Thanks,
Taylor
