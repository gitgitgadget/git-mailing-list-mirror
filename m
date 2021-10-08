Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D0BC433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 04:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B91D560EE3
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 04:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbhJHEEi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 00:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbhJHEEi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 00:04:38 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEABC061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 21:02:43 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id s11so1852352pgr.11
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 21:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ElXHIR4C4v4qi0Lx1PZkTuHcr/d0WnsHbcrb9uaWnAI=;
        b=P49oVQ1qTvjfekJUUEzbTeIZljBOFBw5Rvb8OS8dLBcAkbL/WnXnwket1BFESbBEGk
         unUQ33GpkSyQpynAGivyNOft5pEeWirv+WAo92gpacuWDAYHYFxfri/Ujw2LJhD7M055
         ILkXIaxV4oOZaFPHpMBIX/vyNAIrFKT7bqQP+pAPniPpY1ZydAyt9rbMpJqFKs4+Dt4X
         t04mdXOvuh4KRcID5ZibW7JKpGnNoFO53dsYQJXlqPXPMZ2oCo4xAiOXaqp/M6tJQ68p
         OQ2vnO0Sf3AdUjpHJuMfve9IbYmbBzJY/eeWxXjrpdcWKBa86sLR5Z8LZvjntwJ1IL+1
         Fl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ElXHIR4C4v4qi0Lx1PZkTuHcr/d0WnsHbcrb9uaWnAI=;
        b=VNyDVICDV96n6zgKVZvK+h1XOg1xueolKCYBvEqGeVLThxUgzDvcQhRm4L6zW9NTRF
         GOjlykrexqBjaskY1a3gL6WV6x7XOzwuw8v2HaVgWdBcbdoXRZuoY+OQHPx+H6hsSwWw
         iXkt+RDjZOuaoTk3PS0ToENqjfocuwgim7LQUuGhnak0TqdK79OlcricwFqnIypS0slg
         6smquxlVGCxOfOeaD2c4xOK7jGzlL7rIrFYO2JtP1TvVEThh3qtCNcS8zG/J2XgNKJyJ
         5XXr7scG5ciHLoCk9bJQGxOryryrCAQwFPrJH2clcroLmN3rQDe3LAQJivCWpwtd1YXM
         w1OQ==
X-Gm-Message-State: AOAM533cdx9oUP7rwM3bxoN+bylauOXgdkiVzD4KjIPOq2ugtGiylj8w
        hHqX0U+S71Y7i1hbiqmGE3YqiQ==
X-Google-Smtp-Source: ABdhPJwR4GcwWXeabj3vkPAHNRGbOltwr031yVvtQGmY02yhzXYL5AqH0vxRI2WEKTl6PF0RY8727Q==
X-Received: by 2002:a62:a510:0:b0:44c:569c:5c3f with SMTP id v16-20020a62a510000000b0044c569c5c3fmr7741020pfm.50.1633665762951;
        Thu, 07 Oct 2021 21:02:42 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:970b:a182:aca1:37a6])
        by smtp.gmail.com with ESMTPSA id h4sm801445pgn.6.2021.10.07.21.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 21:02:42 -0700 (PDT)
Date:   Thu, 7 Oct 2021 21:02:37 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 6/8] progress.c: add temporary variable from progress
 struct
Message-ID: <YV/C3SBBDWiZCAq1@google.com>
References: <cover-0.8-0000000000-20210722T125012Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
 <patch-v2-6.8-d4e9ff1de73-20210920T225701Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-6.8-d4e9ff1de73-20210920T225701Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 01:09:27AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> Add a temporary "progress" variable for the dereferenced p_progress
> pointer to a "struct progress *". Before 98a13647408 (trace2: log
> progress time and throughput, 2020-05-12) we didn't dereference
> "p_progress" in this function, now that we do it's easier to read the
> code if we work with a "progress" struct pointer like everywhere else,
> instead of a pointer to a pointer.

Thanks, this looks much nicer :)

> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>
