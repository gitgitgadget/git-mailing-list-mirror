Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B296C433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 03:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 002666103E
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 03:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbhJVDj6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 23:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbhJVDj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 23:39:57 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13832C061764
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 20:37:41 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id ls14-20020a17090b350e00b001a00e2251c8so2049108pjb.4
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 20:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OOnl3EW5pGhLCA423CIxEam/e+H9CNbE2C/7gNApA9k=;
        b=BJvU6DL9Ywcci/AWtP2gucGEwgoRC9lLW3TprijjlZCDQ3ZUboIryLxWZdWnTiWcLh
         Z6E/TIZQVYwOT3B5hTvlV83ac/SuuZQgqZg4g4cOAGuqH1HV6KJ+nGkbPkBeq68YNWzF
         AiBx7EEsRKMVAoI79/afWxDNGZtV3o8ZQ7QG5kl/g48gRN19/2Q7ApEzjnK28LS+sSxs
         JG4EpDvRtkuh3fQXX0JVbn3PoADMgIveR6jVfL9TO7F75Sb+ulYuv8N86Ek3MHALGmJP
         YLpma105iTe+idrRx3WOvoWNf10/kIbowvBvzl8LL5hUa8j/T+cn0vGMhrMpNBWhNXqC
         tP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OOnl3EW5pGhLCA423CIxEam/e+H9CNbE2C/7gNApA9k=;
        b=LVmwY0FahQT1eFl87JWejfthgRUm0VGR4NSjaEuFoRI2YHwYBV6/31tRwGDu6a+Oz+
         ozNUEcWcjNG1QZX8Qd+FCuP4/j0jpngh/YSD7HZ6lpujZyZTx35BXAlsuyfWX0a2AXog
         Nuute5m/TBz53FuqKKr8b+zrXtqqlndG//aWzJtyzjIYzX8ajPHnIedX4Ua6RznW6tgJ
         sylfxmaTsAMnx//W/PY1CffcHIwHJwoxXpi1sE0Y98WaKGxMuF4fs7JGr0qhT6hZhJYZ
         PDN3Idc3ip2Km5ag3b2SpK18azI+jCM4e/UT1nezdyBwSNkSxFW7NjGYKWtlVRKXW4aw
         PzCw==
X-Gm-Message-State: AOAM532T2bNuJyTJEEJFy5DYHC7Fox5MuACuv1NhB7tbbImYBVgZWzpg
        MU5mB5qKuMpkKy7SgcFBkRRWPJ6vCZ9Qsw==
X-Google-Smtp-Source: ABdhPJz6NEI1fWSmaF9smAJMbvVIbQvZhv3YlSCZ5ejLf8W4D30R5HFS658GT6aS4mpN4D3kLtKnEw==
X-Received: by 2002:a17:90b:2514:: with SMTP id ns20mr4739518pjb.210.1634873860306;
        Thu, 21 Oct 2021 20:37:40 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:3866:91e2:ded9:17f2])
        by smtp.gmail.com with ESMTPSA id j198sm6856829pgc.4.2021.10.21.20.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 20:37:39 -0700 (PDT)
Date:   Thu, 21 Oct 2021 20:37:35 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v3 08/10] pack-bitmap-write.c: don't return without
 stop_progress()
Message-ID: <YXIx/8Hl+BG7HFV9@google.com>
References: <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
 <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com>
 <patch-v3-08.10-e0a3510dd88-20211013T222329Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v3-08.10-e0a3510dd88-20211013T222329Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 14, 2021 at 12:28:24AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> Fix a bug that's been here since 7cc8f971085 (pack-objects: implement
> bitmap writing, 2013-12-21), we did not call stop_progress() if we
> reached the early exit in this function.
> 
> We could call stop_progress() before we return, but better yet is to
> defer calling start_progress() until we need it.
> 
> This will matter in a subsequent commit where we BUG(...) out if this
> happens, and matters now e.g. because we don't have a corresponding
> "region_end" for the progress trace2 event.
> 
> Suggested-by: SZEDER Gábor <szeder.dev@gmail.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Very nice redo.
Reviewed-by: Emily Shaffer <emilyshaffer@google.com>
