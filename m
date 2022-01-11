Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17352C433F5
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 19:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235864AbiAKT2m (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 14:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbiAKT2k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 14:28:40 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F7BC06173F
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 11:28:40 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id u8so294729iol.5
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 11:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=h6dLKjgt8wKSMrkS/tttkrvYD6kwWFP0KkpGVy8qBA0=;
        b=j7m20dgnYMVLj+ZOe8ko2jCblsL7zUMedhBVeh7MjDbpNe1tlhSOyQP3UAIVSQEbqO
         sBA5fjPKBt8hlCJRcAWCtCc27M2RhFIhIx8XzGSfVahmXCJsnG5HVzD2M9JEFou2JStY
         8fQYN/SHHSCEtAZsy0h5usVKnK3eKJmo65LaGZ5OAbW8D2rkmUuXXWLyE1JtrYZufyfg
         Us3bVwYnibtw+FCKZfvP/iXHOPNUUi9RGoAtwy/u8/gcx1gAnamQOqSWIvZWs9cQCSyL
         RxoXhVG5knUemL/ecvvP+DF/i+M6uaAi10iPdLQDvcG93psaUKruCRxNb3A0KfJCB+uw
         mMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=h6dLKjgt8wKSMrkS/tttkrvYD6kwWFP0KkpGVy8qBA0=;
        b=7qXZqzT+Oavjjud+lKJ+1qm1iCaVATGPY6u203Bcux6rGehABkbYHpG0Nt6nvg6SId
         zaZ8hv780azSu4VqX5tA+z0zfi9iWjLhzu9bV7hLbDV+lTNXioLb5eVsYF2KNBNbxSiO
         0Dh6gQ/qlTZcknXglDHd/kYwHF/vLeqWQYA+RRxI9V9MLgoCXccL93nVw0reuRh2vZBj
         EWiPiFc6QnRGKdvYysoJtauevCCN07Rj0QJQN0vdLUIaS4JhdEBpPvdWqbwYppSTCf6L
         PG3ZNJbemW+1TsvTprA/up8wxV6EmbCjMyNXv7yXVAvLEJrV7QHop1AOO8qSBZnznxQA
         ROlQ==
X-Gm-Message-State: AOAM530e2RebbaEBoEKitlQzqwtPRe3k7jyqZaAt86GsDNm7Ix6b/lZE
        2+A9//BGfJD8KgoqcX3nImeYzQ==
X-Google-Smtp-Source: ABdhPJyuLCslru0So00URBD2+ocE6hqJHFyKjbXQ4N9tQTaoG0824vza8Jrm18gKDNgavLiDqx2T7g==
X-Received: by 2002:a02:ba0f:: with SMTP id z15mr1647846jan.149.1641929320163;
        Tue, 11 Jan 2022 11:28:40 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a12sm6704208iow.46.2022.01.11.11.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 11:28:39 -0800 (PST)
Date:   Tue, 11 Jan 2022 14:28:39 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 3/3] reftable tests: avoid "int" overflow, use "uint64_t"
Message-ID: <Yd3aZ5Q9Ph0H+Ijn@nand.local>
References: <cover-0.3-00000000000-20220111T163908Z-avarab@gmail.com>
 <patch-3.3-93112305523-20220111T163908Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-3.3-93112305523-20220111T163908Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 11, 2022 at 05:40:23PM +0100, Ævar Arnfjörð Bjarmason wrote:
> diff --git a/reftable/merged_test.c b/reftable/merged_test.c
> index 24461e8a802..b87ff495dfd 100644
> --- a/reftable/merged_test.c
> +++ b/reftable/merged_test.c
> @@ -24,8 +24,8 @@ license that can be found in the LICENSE file or at
>  static void write_test_table(struct strbuf *buf,
>  			     struct reftable_ref_record refs[], int n)
>  {
> -	int min = 0xffffffff;
> -	int max = 0;
> +	uint64_t min = 0xffffffff;
> +	uint64_t max = 0;

Han-Wen: it looks like the loop below the context here is to set the
min/max of update_index over all of the ref records?

If so, making these comparisons all unsigned makes sense to me. In
practice it's probably fine at least from a signedness perspective,
since the compiler _should_ be coercing both operands to unsigned.

But perhaps not so from a width perspective, if sizeof(int) != 8 (though
I suspect in practice that we are unlikely to have enough possible
values of update_index for that to matter).

In any case, you're only setting the lower half of `min` high. Maybe:

    uint64_t min = ~0ul;

instead?

Thanks,
Taylor
