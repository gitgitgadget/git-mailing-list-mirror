Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DBEC4BA3B
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 10:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D9124695
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 10:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IobP6kWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgB0Kng (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 05:43:36 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:33397 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728680AbgB0Kng (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 05:43:36 -0500
Received: by mail-wr1-f48.google.com with SMTP id x7so190867wrr.0
        for <git@vger.kernel.org>; Thu, 27 Feb 2020 02:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OzEnpAZWf3wxpejIOQUUXHF3FqvY76gUqqbeEubudHM=;
        b=IobP6kWpzV9UB4q37GHKjSlNme33tfpSgUPPGPdtaWD0HN4TrGpXgNDV23rsDRNlB1
         kWQMeTaXMGYBs95lFB3Ifpe3W/C+H36fFHlCpmiK4SzLndg81wNLv4oWJ4L0EioNfm0L
         qgMqpb/VGDf2wVugqVEblOrNOhjDBxOoK3ndlCfMoWB3d88dRnVs9wuBkCoXXtj9PZwS
         qRxaUqf9WqqoRg5aFbZcyOhgYwnJlObUfj8Nk0TgkG9HR/Il1sjBF6LnXbURodCOr7vf
         LymsQ3GoGOdxo3ObFXocF9oClA9NmJU8GL/JQHkiWSNwYHyU70ipaPtkCZp7REEJOH0r
         VuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OzEnpAZWf3wxpejIOQUUXHF3FqvY76gUqqbeEubudHM=;
        b=IZYbGucnsw+lCJmCog7Norb/A/RG+gPhS7QxjXIdh95+DYN02mT4mFjQAKVdvEGMW8
         jLcoP+0QjRXwn1AI3oVEv37axiv9sDzm72k33G8YWVNAeCJyeJA0TiJJQD0qX/vsI8PF
         7Zch3YzXlB7ThLurD1xGJdfhyXUSU8r0Dhr/xjS6vUw4WMHyoGEIbbT5WLlSlrVj9pU+
         lEYfARKKJZi4ycvtcGKr5BI/ebAk+T7ivrog6cd7datbs1OneTOe00HpHXWzaxHIda7z
         7jERbRsbbkrqkwfKfL0hBoIxK3ugCTwT7kuWy7nRqmRtI6Unljv72zpMgcguPFUA3T2I
         icqQ==
X-Gm-Message-State: APjAAAUCC3FGqEyWz/0JR6dGZ7lneaf7MNa0BmcKGP0NMdx3xtlClTDj
        EHx/i0tPm6xFJrkBXRSWIeQ=
X-Google-Smtp-Source: APXvYqyNaT4ez5stLTagaGuEQqFKLJjrjjpQX19zBqC+tVeQ4bTVamuGyNrl1KLhM5XGjcguMJKTAQ==
X-Received: by 2002:a5d:4807:: with SMTP id l7mr4146497wrq.250.1582800212989;
        Thu, 27 Feb 2020 02:43:32 -0800 (PST)
Received: from feanor (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id z14sm7410552wru.31.2020.02.27.02.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 02:43:32 -0800 (PST)
Date:   Thu, 27 Feb 2020 11:43:30 +0100
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Spurious GIT_DIR set when in a worktree [was Re: Nested submodule
 status bug]
Message-ID: <20200227104330.hp7zf2suquxsf6zw@feanor>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Thu, 27 Feb 2020 11:32:04 +0100
References: <20200214224242.knmzkwx7ls4sote7@doriath>
 <0123F1ED-C421-4C1F-896B-E54C9D345A34@gmail.com>
 <20200226172338.unembhjhog36sqj7@mithrim>
 <20200227100557.ydouc4n3jphzbits@feanor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200227100557.ydouc4n3jphzbits@feanor>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Ok, so using GIT_TRACE and GIT_TRACE_STATUS and doing some debugging I
> understand the cause of the bug. When using the alias,
> the GIT_DIR environment is set to the bar module:
>     GIT_DIR=/tmp/test/foo/.git/modules/bar
> and is exported.
> 
> That's explain why in `baz` the status report the status of the `bar`
> directory.

And looking at setup.c:760 it appears that `set_git_dir` (which set up among
other things the GIT_DIR env) is called because we are in a worktree.

More precisely: we have discovered a git dir (a git file), so we call
setup_discovered_git_dir, which itself calls setup_explicit_git_dir because
we are in a work tree environment. And set_up_explicit_git_dir calls
set_git_dir.


So I don't know what's the proper way to fix this. Keep track when we add
ourselves the GIT_DIR rather than when it is already provided and remove it
before executing a shell alias? Don't run the full configuration setup when
we are executing a shell alias anyway?

I am adding Nguyễn Thái Ngọc Duy to the discussion (I hope this is the
proper etiquette).

Best regards,
Damien
