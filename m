Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98C8C433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 16:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDEB2611C1
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 16:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241293AbhJOQ2N (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 12:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241288AbhJOQ2L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 12:28:11 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6DCC061762
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 09:26:05 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 75so9073315pga.3
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 09:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iX8DQGR+wZfe1hK0LR5zirg9mkHcUsoO3JauJemKYTU=;
        b=Gw0PiG2rSuYm9997ajccCCEu5yF3rB5GxdR7A9e1woomjfvncpe3lKUOm62IR/+1/y
         yV1FpKK8sHK1cPl1dOfwR5sZeo3yhd6Ky2bNW+R6d9smgDZ9ALd34Hajp6zxMnyezyoJ
         fsdNS5rMCALdfZ8qqWCZUmOMHsYvhgIZqaTsO7uAZI+LTvE/l+Y+fYwbwx0+41iQuNK1
         8flLwKDHJbeX1tvAfNlMckmJmxTTnQM5o/SvqGFGQLOMDCl+/Pxy1OuNh+xKlLvZQ2hN
         hqvNb6U3nODqPRwWwwPbupz6OiBHsiAbTtGQVDUCDA1xF6YvOghk03+gq4fNWWAVN/AW
         1/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iX8DQGR+wZfe1hK0LR5zirg9mkHcUsoO3JauJemKYTU=;
        b=LdaEpgoe6il28XZfnXCvaZuw1D0HHLFqdavux8TWxzee728AMXz7IH/W5X6iHSOAhq
         vLHOO+KSHtq20cS/zWZ+dCoWgSEExaMSzaxxqqfaFbfzrfT/eMm8tjyXgjHoF/DbJtws
         HGhB/B4o2fXZT0R3qQcq+J6f7jFd/Lt2R81R/EEtiAUSb/25O6wlKyJVsUYjPFdQu+PN
         eS1zMuCOgXDnaaap1pAx6r7EgvP1UFU4O/cLg6qMnsSkVEyPs63NA5CUdPDHP3VvftiE
         K9rZLY4TkNyAu78YVHKfHMoHR3BUw+w5ADLUgmFAfdZztYqaaBeyq45D/0xRvBuDW/my
         JJIQ==
X-Gm-Message-State: AOAM532YXYJDCrUG4KIv8GPxO6pSK4X9KlWrOhdeFOAxRy1tzwM8UOBy
        fbG8gOVaqcBKwtxtF2tlNYauwQ==
X-Google-Smtp-Source: ABdhPJxdhzIWkziX2NqYqo7l1KiZBxrkXd3Lc3mYEmXJ8/v3YGwkIXkI8pp3TJ0u/k/3/YuL8HepZA==
X-Received: by 2002:a62:7dd0:0:b0:44c:b0b8:6eaa with SMTP id y199-20020a627dd0000000b0044cb0b86eaamr12728688pfc.73.1634315164658;
        Fri, 15 Oct 2021 09:26:04 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cc2f:afb0:ab09:f218])
        by smtp.gmail.com with ESMTPSA id w9sm5579291pjk.28.2021.10.15.09.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 09:26:04 -0700 (PDT)
Date:   Fri, 15 Oct 2021 09:25:59 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 05/13] hooks: convert 'post-checkout' hook to hook
 library
Message-ID: <YWmrl6wMaEnTMsmX@google.com>
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
 <patch-v2-05.13-a4df96c1719-20211015T093918Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-05.13-a4df96c1719-20211015T093918Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 12, 2021 at 03:30:30PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> Move the running of the 'post-checkout' hook away from run-command.h
> to the new hook.h library. For "worktree" this requires a change to it
> to run the hooks from a given directory.
> 
> We could strictly speaking skip the "absolute_path" flag and just
> check if "dir" is specified, but let's split them up for clarity, as
> well as for any future user who'd like to set "dir" but not implicitly
> change the argument to an absolute path.
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -28,6 +28,7 @@
>  #include "sparse-index.h"
>  #include "csum-file.h"
>  #include "promisor-remote.h"
> +#include "hook.h"

Hum, is this a stray line? I don't see any other change in read-cache.c?

Otherwise, the change looks reasonable to me.
