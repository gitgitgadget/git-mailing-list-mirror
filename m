Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C9AC433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 15:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349787AbiCUPFa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 11:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238929AbiCUPF2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 11:05:28 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548D23464A
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 08:04:03 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a8so30436705ejc.8
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 08:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=XWUWbG5FsxwZuFtysg4s6eTlNev3OEWyppm8IWBbco0=;
        b=kyEwpOHlRaS3RQpgeU5yBFOc1M7vIAVb9OABc26xe75GSS44YmonXs6dIC+849/tdM
         1gJJNx0rnhfZKeS8qWtTd10ek9db5uu7kwjHPIWXNB4Sy7FdWNIfID0sPY84v7n9fXWu
         moWx3rjT6e36tSy/cEvn/x2/crXHdzgp/vy8nQp/Sq9bDVFJ3XhO6jAlYzEaq/Ap9rZm
         O4EfymJyJ+qPBrBvbc+o8tB58xQj7IaazmPzsyGtCP0CtE9YRoOP7RfXwFubOn9JLmOn
         Us7F0Qcb/oU/Qt8Mias33vZgceO6QVjFErGnQ9M8JPz5ml1iziiSoHOKwroXBkdOu325
         GaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=XWUWbG5FsxwZuFtysg4s6eTlNev3OEWyppm8IWBbco0=;
        b=JiLe5bCGRIsscwt+AANgC4a8fWXmZ6RBgdgZGwAph92w08IoccRaPtDG4NreqZN7zn
         6HO3OFE0dHXAzZ3ysermjwxS+zZgkmo0ndL/3BBC2Se0eV/YNluOQ9UR0lif13A9QN0b
         BDDHVBPK/I/Xrqw6I4ro8cOi0DXa/a/UoLOqPqGmWLrxJoBmHkkYQBOKP9mZfpR5Ud07
         9u5yRgwj28QR1CGyNpQtlLiuRuLp274LZQU/R9fgTGJHLN/6HLWNoBu91DunLEmSFkai
         hYVxy/Qs3XXASkn6y92IYs9aEFCmor38BCaTAipj3hksaNNQzalsdxWXC3pItUgBkS9q
         WSoA==
X-Gm-Message-State: AOAM530hujoswnfL6BRtHqWd3+KWRQpkVaHZePR3ZhM7HCPDlC1dHQI+
        Hk0de04w88oEhN01mUzTV7kPCXaS5yE=
X-Google-Smtp-Source: ABdhPJzuRVp7/eVeBPrLE/V9dr+46JonfvAw+2GRtg0pftidh9UiQAD8JSH55OJzPhZ2tzd+dwU9TA==
X-Received: by 2002:a17:906:5d04:b0:6db:7262:570e with SMTP id g4-20020a1709065d0400b006db7262570emr21571729ejt.8.1647875041494;
        Mon, 21 Mar 2022 08:04:01 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e10-20020a170906748a00b006dfaff31e88sm4551213ejl.125.2022.03.21.08.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 08:04:00 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nWJZg-000Z1t-4U;
        Mon, 21 Mar 2022 16:04:00 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        nksingh85@gmail.com, ps@pks.im,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: [PATCH v2 3/7] update-index: use the bulk-checkin infrastructure
Date:   Mon, 21 Mar 2022 16:01:00 +0100
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
 <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
 <54797dbc52060b7fa913642cd5266f7e159a5bc9.1647760561.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <54797dbc52060b7fa913642cd5266f7e159a5bc9.1647760561.git.gitgitgadget@gmail.com>
Message-ID: <220321.865yo79wkf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Mar 20 2022, Neeraj Singh via GitGitGadget wrote:

> From: Neeraj Singh <neerajsi@microsoft.com>
>
> The update-index functionality is used internally by 'git stash push' to
> setup the internal stashed commit.
>
> This change enables bulk-checkin for update-index infrastructure to
> speed up adding new objects to the object database by leveraging the
> batch fsync functionality.
>
> There is some risk with this change, since under batch fsync, the object
> files will be in a tmp-objdir until update-index is complete.  This
> usage is unlikely, since any tool invoking update-index and expecting to
> see objects would have to synchronize with the update-index process
> after passing it a file path.
>
> Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
> ---
>  builtin/update-index.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 75d646377cc..38e9d7e88cb 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -5,6 +5,7 @@
>   */
>  #define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "cache.h"
> +#include "bulk-checkin.h"
>  #include "config.h"
>  #include "lockfile.h"
>  #include "quote.h"
> @@ -1110,6 +1111,9 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>  
>  	the_index.updated_skipworktree = 1;
>  
> +	/* we might be adding many objects to the object database */
> +	plug_bulk_checkin();
> +

Shouldn't this be after parse_options_start()?
