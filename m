Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F28C433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 05:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A18560EB4
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 05:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244779AbhIQFQP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 01:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhIQFQO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 01:16:14 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB4EC061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 22:14:52 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z94so25223891ede.8
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 22:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gRf+69UoVrfJARI54fmlSP7wMY5OPtxxpMI4KoPqAEw=;
        b=cjAQqTADsCwSKiAuEWukjT6Bix7tx8Rotb/lWSsLrGqN8ARoSaDbrruSalg+rTwMN9
         YCy5r6lVWUSsn3hUl6KaSde2tfUL/FzJr4Mn3LWARIvnb61eHgQyd0xc1ptrSALHN1mG
         DQg4K9Lnh01ttAniRX0LGHDwxyLdsK39WZPyDdIGnZUgn0IQXM1rDmObiTPk19E3/33Z
         jA2H97/cKQIBep5XxDQd8ludi69swBue5IazoGCJpmhqNUCqhxdC6MJ5GCKyTLQFVexh
         M6VoHNtQgjjxKI/oXvUVwQlsd9t4BL4fcGfNRpGRpL39ss5O/htQlq9QMNK2GukWePTj
         AITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gRf+69UoVrfJARI54fmlSP7wMY5OPtxxpMI4KoPqAEw=;
        b=yuFo2mEUmsJXrEX0QXIvjDle18tuSa6YIyP6jeRX3/kdoxTRaEn5IoIdZNWWsvwtCo
         /DwKzaam3Al48lQb6w8DXeL7Kb/2CS15woeTcnJICSZ+O49/jR/Nb4dZxtYr/kzU3QRU
         ERSnsRGQmZcnrph6RYhVEmme7uT4S8/T0ChR//nV+YHKijJ562nzkbBDNSrMYuoKgCWn
         IdIH3T8GHCTKZhTSFehjaNi+f9zZb+Dzr/CmRx1d97SyIuthl4TAsi553deStJepVy8X
         C0IVutMpKxomfkXGk7viGzmepZKLE0rqLYAKZ5kFY0PwBeu2E7QLiffch9D3ZhG8X45x
         rn1w==
X-Gm-Message-State: AOAM5316zkAVvg8UJvpptIZE9/z/CwkR7Znd7ReBHXJVNZS05tndzSl9
        qm8x77jpbPnw0HZayvDkTMM=
X-Google-Smtp-Source: ABdhPJwTkkuFZF/aJKTbt0XKfIlT8p/s3caMlB41tZLNLE+8syIHvOEVG39W5xpO5n5eyp4FeytAPw==
X-Received: by 2002:a17:907:75da:: with SMTP id jl26mr10237368ejc.300.1631855691383;
        Thu, 16 Sep 2021 22:14:51 -0700 (PDT)
Received: from szeder.dev (94-21-37-152.pool.digikabel.hu. [94.21.37.152])
        by smtp.gmail.com with ESMTPSA id d3sm2160919edv.87.2021.09.16.22.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 22:14:51 -0700 (PDT)
Date:   Fri, 17 Sep 2021 07:14:48 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 11/25] pack-bitmap-write.c: add a missing stop_progress()
Message-ID: <20210917051448.GB2118053@szeder.dev>
References: <YNKWsTsQgB2Ijxu7@nand.local>
 <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
 <patch-11.25-7f5b71fe1be-20210623T155626Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-11.25-7f5b71fe1be-20210623T155626Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 23, 2021 at 07:48:11PM +0200, Ævar Arnfjörð Bjarmason wrote:
> Fix a bug that's been here since 7cc8f971085 (pack-objects: implement
> bitmap writing, 2013-12-21), we did not call stop_progress() if we
> reached the early exit in this function. This will matter in a
> subsequent commit where we BUG(...) out if this happens, and matters
> now e.g. because we don't have a corresponding "region_end" for the
> progress trace2 event.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  pack-bitmap-write.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
> index 88d9e696a54..6e110e41ea4 100644
> --- a/pack-bitmap-write.c
> +++ b/pack-bitmap-write.c
> @@ -550,6 +550,7 @@ void bitmap_writer_select_commits(struct commit **indexed_commits,
>  	if (indexed_commits_nr < 100) {
>  		for (i = 0; i < indexed_commits_nr; ++i)
>  			push_bitmapped_commit(indexed_commits[i]);
> +		stop_progress(&writer.progress);
>  		return;
>  	}

When I found this bug I fixed it differently: with your patch there
are no display() calls at all between start_progress() and this new
stop_progress(), indicating that a stop_progress() is not missing but
rather the start_progress is in the wrong place:

  ---  >8  ---

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 88d9e696a5..f0b4044e2b 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -544,15 +544,15 @@ void bitmap_writer_select_commits(struct commit **indexed_commits,
 
 	QSORT(indexed_commits, indexed_commits_nr, date_compare);
 
-	if (writer.show_progress)
-		writer.progress = start_progress("Selecting bitmap commits", 0);
-
 	if (indexed_commits_nr < 100) {
 		for (i = 0; i < indexed_commits_nr; ++i)
 			push_bitmapped_commit(indexed_commits[i]);
 		return;
 	}
 
+	if (writer.show_progress)
+		writer.progress = start_progress("Selecting bitmap commits", 0);
+
 	for (;;) {
 		struct commit *chosen = NULL;
 
  ---  8<  ---

And I don't think it's worth adding display() calls to that loop,
because it has so few iterations and it does barely anything per
iteration.

