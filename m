Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198BCC77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 21:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344048AbjD0VxD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 17:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjD0VxB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 17:53:01 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863682737
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 14:53:00 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1a69f686345so70318505ad.2
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 14:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682632380; x=1685224380;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bh2lbjfTHWIlNzuKe+Oqz2kw5c4utjVptjWPl95XY7E=;
        b=mk9M0ADuqBhtyVgZ16bD83EdrwPM267LF67IS8tREH0T8pMR5rWr5Fi5p9hi0gmour
         Tr+qr5xh3t5yPeLpxR2z4+n0J4AeucWIPk8ttNu4/yVdv/tRRHeBBxGMHvhfeBGelp7T
         BiCZl+bcOLpQewP2xOHBOVuR+aY+Zo79OWc1kkhjmjz4UngHSvmQhqNXvWOFdYrmEtdp
         2+RC2a8llnXwTiySIPu2ZEsewVpkOTScypKqn6KP1SIzIHIt97YdhpLMqxZwqUBh2led
         lh05u4FY1mceYKpcPCo9K5Q42KWdmX1Eso+SpIszpZuobnmzIyipxrUYHn5LMjRxI7oE
         zSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682632380; x=1685224380;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bh2lbjfTHWIlNzuKe+Oqz2kw5c4utjVptjWPl95XY7E=;
        b=UAcDallnhqVIND+dCd7tQdUQBTE0l6XLaT7Dr8vJc6pu3VPw9TfSUCE4jxga+RmnW5
         Zp9cyr1IuDzDMdHYkZGi5vYOFsHFaAF236C08lS/fb1eIpGGINm4LSA7iXYHwIh1nGKH
         9esuvI+TsMmzAUeFIkDUMEz0ZsPSkl8FqZTBGQPDx9ug4qNnqAjFvEbXKG865IyZViQN
         kMI5TEnDb6Y23R8l7DcTkY7Aq0hTIhzSg6phyx8ejR/eMbl+lqNjAv2y0u+CP7dQ6tNs
         0xPTHCKrFQYwDOU99w2G7hJkoq2hIQ1i0b+p3G7kmPAc4GVwzvF5hNDVJGtjLp9H6anz
         UlxQ==
X-Gm-Message-State: AC+VfDwbLvIJfyzRbkLzmmh0qqhM5gvXBGRXM74kIMYR33bfZpx6z6DK
        yPEU4BGIKNXTqMsguEVtZPU=
X-Google-Smtp-Source: ACHHUZ6Wx83EebSw00YGDVe+G10Bdj5UVTF2kQnlu7fxJyFgbpzhFm5pjIfD+IF6FtsPqGvtakD41w==
X-Received: by 2002:a17:903:238c:b0:1a8:ce:afd1 with SMTP id v12-20020a170903238c00b001a800ceafd1mr2854408plh.20.1682632379882;
        Thu, 27 Apr 2023 14:52:59 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id jd21-20020a170903261500b0019b0afc24e8sm12062937plb.250.2023.04.27.14.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 14:52:59 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v2 6/8] fetch: move option related variables into main
 function
References: <cover.1681906948.git.ps@pks.im> <cover.1682593865.git.ps@pks.im>
        <cfe84129abe5f93282e1305ec6139fb105481b2e.1682593865.git.ps@pks.im>
Date:   Thu, 27 Apr 2023 14:52:59 -0700
In-Reply-To: <cfe84129abe5f93282e1305ec6139fb105481b2e.1682593865.git.ps@pks.im>
        (Patrick Steinhardt's message of "Thu, 27 Apr 2023 13:13:29 +0200")
Message-ID: <xmqqedo5hu10.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> The options of git-fetch(1) which we pass to `parse_options()` are
> declared globally in `builtin/fetch.c`. This means we're forced to use
> global variables for all the options, which is more likely to cause
> confusion than explicitly passing state around.
>
> Refactor the code to move the options into `cmd_fetch()`. Move variables
> that were previously forced to be declared globally and which are only
> used by `cmd_fetch()` into function-local scope.

Very well done.
