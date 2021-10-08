Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7708C433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 04:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFB7D6109F
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 04:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbhJHEGl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 00:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236418AbhJHEGk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 00:06:40 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCE1C061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 21:04:45 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n2so5273867plk.12
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 21:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nLZStneIEf/dA+BgEZ/aQw6M3oVacVBU+svmPRDJSy0=;
        b=SxPoUHhvAy5+yqV/67MTODHZC8o9+dTLV+Tn8rGOPPCq1uEq3JOr0vz0fcXm69RsrY
         Z2nzNQxAkVhDUP++hupcQL6qeWqfZetfpMjYHEG674NNPMBDq5QvurBofRtsTid+5jlV
         XUzwdn3eLB0NaRPmAgjckTkJwV8qVqbwbFxJUwKVys5aSQ3Ls1B7jxtHBy85JeVXed/y
         SbMLWWVQcaTOIccnLL9QkbPsXlQ1lEBhAorosmuoJ+S8kg0uKF9x7CMezhNgH3HdOOoD
         t4ajBQQo2TcCz0XuDxwPmL+gWFL/s586ByrltAzQCB7qevaN2u1G/SRCpH6cz1iCsQQd
         2hkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nLZStneIEf/dA+BgEZ/aQw6M3oVacVBU+svmPRDJSy0=;
        b=l7sc+IhA0M0A4KNye3kNJ2foXeelCpngbhMo1MlLeOW1+kOxOcKTie/vJkReAZic9r
         QO4xfRi7oqRFgqh+oIaaIcQVN/DThvgTMX0ucuzSfBRK736geqNR1UwcZ3eWv/mYSYWe
         1kbH1y3ioeRPboUbCNJjPf81foyTMPe3rt7ZScZU+jWv9JTXfw6tLXSPGr7d2q4N/ra2
         084v9EHPsp/1ocEus9cpPVFiSR97a/PCDyioVP2NvQcQfxSFInGFsapbYIDxhFzJgtUi
         BKYIGY0V6VMy3KcyAyyQVqK/u3TwYI05PbftdqREJFBwccSCKwMibEbdAQZSGDFoQq9w
         tVIg==
X-Gm-Message-State: AOAM531ogZPXBHLVb4UYYt4tN95nzT+4DnhWH/Tjfa0eFXNMxYJuB/Od
        1jCiGhPtEIC12PGqQ1wc77NyWQ==
X-Google-Smtp-Source: ABdhPJy+XvHUcjCFUB15xdg4mP+2zI0qF1kyKlY0EzJAsVzmWvHWt0+nLeKPbpEh+dnfZ8p8goaZtw==
X-Received: by 2002:a17:90b:3ecc:: with SMTP id rm12mr9211535pjb.48.1633665884946;
        Thu, 07 Oct 2021 21:04:44 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:970b:a182:aca1:37a6])
        by smtp.gmail.com with ESMTPSA id z7sm856123pff.23.2021.10.07.21.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 21:04:44 -0700 (PDT)
Date:   Thu, 7 Oct 2021 21:04:39 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 7/8] pack-bitmap-write.c: add a missing stop_progress()
Message-ID: <YV/DV95BkT85a2xl@google.com>
References: <cover-0.8-0000000000-20210722T125012Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
 <patch-v2-7.8-a3f133ca7ad-20210920T225701Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-7.8-a3f133ca7ad-20210920T225701Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 01:09:28AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> Fix a bug that's been here since 7cc8f971085 (pack-objects: implement
> bitmap writing, 2013-12-21), we did not call stop_progress() if we
> reached the early exit in this function. This will matter in a
> subsequent commit where we BUG(...) out if this happens, and matters
> now e.g. because we don't have a corresponding "region_end" for the
> progress trace2 event.

Sounds like this was the only place we were calling start_progress()
without a stop_progress(), then? Or at least the only place that is
exercised by the test suite. Wow. I'm proud of Git contributor base :)

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>

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
>  
> -- 
> 2.33.0.1098.gf02a64c1a2d
> 
