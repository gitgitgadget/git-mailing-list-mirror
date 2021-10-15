Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD03FC433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 16:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA7FB611C1
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 16:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241299AbhJOQ2v (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 12:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241310AbhJOQ2u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 12:28:50 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E50C06176E
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 09:26:42 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id g5so6728087plg.1
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 09:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DvLw5O0GhWNg6XQ3VPL1C0mDrs46UAXOL7JVtzPO75s=;
        b=FzF5VO/JCXvDdbv3EJaib6PyTuWZA2y7UwFKovGo9S9l3NBB/Rw8+GkCBfN1iCP3DA
         1lSyMZXA40+65cJtdD4QLpg16u/3QqakbfVy9oTWY1Dec10poBUpBC3eXqgrnv01Ekum
         frp2ht0YqPQ3NphlNGQ4vwPTm9Iai7nWRDMeX/i6cdJ5uWQi56CehG8lR3BGUf4cgdy0
         oVHdl/HHA5yRFT45A1KAoPPTptu4SLtZvCjBGhPZBSRoH9b6xI6ktTUCSC6n19YWou+s
         FeXRLxBaaOcOMT4DUPpQJqizAm0tXVSEgWZzgOBDbLymdZh6UCyMixFfm2OJ0/G9avOs
         PW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DvLw5O0GhWNg6XQ3VPL1C0mDrs46UAXOL7JVtzPO75s=;
        b=ub/+TNVUgKxMDGNCnJ+ete5g4GXoVDX8yImuJCS1FIWNElXy/AywaD7mqZQZOud+0i
         3T6Y/iXtRun9NYxcNemR8Sy6/qLGTQdrmO0Esw4lqcS789NfRA8rRVbHqBvWburFxYXz
         jy+9SzXsgU+VR50gyeSKmwhWWD7XGmFXNG7n56o2L50uqAJ3imQG3U3B8C1ddXO1/Rlm
         d7J7iIoIvhJbglDnbK/t8DLq2eMZEfCl4khJOTEzi51evIocuXfOesSz3DVlZ/WY1iFQ
         W1OLX58lDFsC1eZSoaSRnZsdgUKQoi61m08PBXI0JPv9hUsHkk++DfIPyM54LmjzPF+e
         VNEg==
X-Gm-Message-State: AOAM530Jvam/DFAcaBMELqq4SXP1u1mO3ojTSnjU7KhUfnCNQXRI4T4h
        GlQh24ietG5TAtvHbhX9lKmnWJ2qC116sA==
X-Google-Smtp-Source: ABdhPJxdF9evQ4mH/1U8VYvSJkwqDXuoJrDkLZ+E9k3BMKFdwHcra0l/+eP14X2Rw3igM8oBr97i8g==
X-Received: by 2002:a17:90a:ad98:: with SMTP id s24mr28953069pjq.122.1634315201378;
        Fri, 15 Oct 2021 09:26:41 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cc2f:afb0:ab09:f218])
        by smtp.gmail.com with ESMTPSA id i123sm5412429pfg.157.2021.10.15.09.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 09:26:40 -0700 (PDT)
Date:   Fri, 15 Oct 2021 09:26:35 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 07/13] git hook run: add an --ignore-missing flag
Message-ID: <YWmruzO9sdYvVIPP@google.com>
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
 <patch-v2-07.13-328767015b1-20211015T093918Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-07.13-328767015b1-20211015T093918Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 12, 2021 at 03:30:32PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> For certain one-shot hooks we'd like to optimistically run them, and
> not complain if they don't exist. This will be used by send-email in a
> subsequent commit.

Aha, this is what I was looking for in the earlier commit. Feel free to
disregard those complaints. ;)

> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>
