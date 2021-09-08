Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78ADCC433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 02:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5356160F6D
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 02:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347164AbhIHCwM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 22:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345390AbhIHCwH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 22:52:07 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACADC061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 19:50:59 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id v16so759197ilo.10
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 19:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rK/feyPrB8gxKxbUSpEEZJfeYnMiHq3X0UAszYIGIks=;
        b=J4tHpl3Vgwc1FBTnWSVbLZb1GPFRndP+YwTF4uIuEDkNhSd3VEUSbw1D2oRC6ukDoD
         Lw9Oq9fU6cf4+2fdT0zbJSQbbH4W4K04jYfyT2I9FiHb+jXRubghkwS+qMebpFyw34TF
         id3q4f0Mxo9r0QJdkm1m2Oc5joqPopDXusqH7KEzQA4nsAkenBj+h+i7lx1r4Vx7gpkw
         JvIgFLWRoUAhXrOo8qV7rGBRaiarrgNQwQWT1GWBL4gPeU/Hcydp4dUlv/5B7xprkQeW
         9id+mNhYBGCNHFDJnURK4cTczJk3LACzDk+lWWwN7H/OrRhmFRAj8ZVE1Bco7b9OQaHz
         CgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rK/feyPrB8gxKxbUSpEEZJfeYnMiHq3X0UAszYIGIks=;
        b=Pbq790uKzTWaZ8rcAjBu9aZXOVsZ6Q3yh3Ie7uvyjC+h4pmJaXgyYopy2bLlsk/abc
         MJ7k9b/4PZRbG35yVxzfOgy0ShiexINiOkVyh2TgNDeK112yH9r+bqDy6kGLCoQBNP/E
         5ZmpIbibU+dPmxqgE9lfr86sJL1Kew9wcCjU/q+8rtz5homjpEG5bAW4MeUL9AmZOzxS
         HKtE2I9gF+L4VQOIfehSCYn1U4+0WWDSIKUree1UpxKwqE81N6w92GpK3AydpT/7PxgW
         9fAq53h5dxjYzwL4I5CxkVqitTxpHR63uYNaXfrrGGpxyLNkOEEhK3myTjnkeog4227O
         uiEw==
X-Gm-Message-State: AOAM532CX7nB9a3MiXHj9j0AqPOGHP0iZFjcg+FUx3otMiTcXdsQQPHc
        +pFd/Z6BhNMWV+DUWlGwMHHhuHGNjKoq6bAe
X-Google-Smtp-Source: ABdhPJweVv4yNUCaMZYExrw0i0HAMg52UZRCeEwrwFoudPoUz5Q0O3KGtrmBVq7VIPgMhm3GoSbiuA==
X-Received: by 2002:a05:6e02:1aa5:: with SMTP id l5mr1064289ilv.271.1631069459286;
        Tue, 07 Sep 2021 19:50:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l25sm423680iob.41.2021.09.07.19.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 19:50:58 -0700 (PDT)
Date:   Tue, 7 Sep 2021 22:50:58 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] pack-write: skip *.rev work when not writing *.rev
Message-ID: <YTglEreI7nFCII/b@nand.local>
References: <9f40019eb3d3315cb03440e6237bced4feb6cf67.1617116623.git.me@ttaylorr.com>
 <patch-1.1-366ba928bd-20210908T010743Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-366ba928bd-20210908T010743Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 08, 2021 at 03:08:03AM +0200, Ævar Arnfjörð Bjarmason wrote:
> Fix a performance regression introduced in a587b5a786 (pack-write.c:
> extract 'write_rev_file_order', 2021-03-30) and stop needlessly
> allocating the "pack_order" array and sorting it with
> "pack_order_cmp()", only to throw that work away when we discover that
> we're not writing *.rev files after all.
>
> This redundant work was not present in the original version of this
> code added in 8ef50d9958 (pack-write.c: prepare to write 'pack-*.rev'
> files, 2021-01-25). There we'd call write_rev_file() from
> e.g. finish_tmp_packfile(), but we'd "return NULL" early in
> write_rev_file() if not doing a "WRITE_REV" or "WRITE_REV_VERIFY".
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  pack-write.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/pack-write.c b/pack-write.c
> index f1fc3ecafa..1883848e7c 100644
> --- a/pack-write.c
> +++ b/pack-write.c
> @@ -224,6 +224,9 @@ const char *write_rev_file(const char *rev_name,
>  	uint32_t i;
>  	const char *ret;
>
> +	if (!(flags & WRITE_REV) && !(flags & WRITE_REV_VERIFY))
> +		return NULL;
> +

Great catch! This fix as-is is obviously correct, but it does make the
same checks in write_rev_file_order redundant as a result.

If we call write_rev_file() without WRITE_REV, then we'll never call
write_rev_file_order(). The other caller of write_rev_file_order() is
from midx.c:write_midx_reverse_index(), which is only called by
write_midx_internal() where it is guarded by a similar conditional.

So I think we could probably either:

  - remove the check from write_rev_file_order() altogether, moving it
    to write_rev_file() like you did here, or

  - remove the check from write_rev_file_order() and elevate it to the
    caller which is missing the check in finish_tmp_packfile()

Of the two, I think the former is more appealing (since no other
functions called by finish_tmp_packfile() are guarded like that; they
conditionally behave as noops depending on `flags`).

But what you wrote here is just fine as-is, so the above are just some
optional ideas for potential improvements.

Thanks,
Taylor
