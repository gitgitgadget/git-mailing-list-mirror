Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AB7C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 22:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 403E260F46
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 22:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbhHaWDP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 18:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbhHaWDO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 18:03:14 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5CBC061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 15:02:18 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id l6-20020a170902ec0600b0013882202041so86274pld.15
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 15:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eu5fKKiSJalfFGj/cQH3Mj4PkmaoDFLkQHuqw1vNASE=;
        b=JJOQITghyZ31IONX6kb/8QKxlI2TbpOWQqEsI5sta9bG8XTsTerJkvOm7fyx37ja5N
         IEd3yRLDRDltTvHISPyb733Y6kNTTpohwTUNYpHYtyjegkz/z/kbest7b0T7f2idP4oR
         vg2lwSU8+YLhD+z5LydjzlpIzSMws0p/l0KBZ3VCEJDfHDnxva9rk7pdtAfDmq9QAf4U
         53GKTGcH6R/t0N8TbFV4sZBm6+9uUQhtrUWX2TfyX3DqNMzfpCyOYtsZMnER8AV0zj0u
         qWoV+KoA4miJvnARhKiZp5Qhun1mOEdeXRNipV0DkbgTmfPeYvzRTJHwAx7Q31spegkt
         Ok2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eu5fKKiSJalfFGj/cQH3Mj4PkmaoDFLkQHuqw1vNASE=;
        b=hqLjcjPg9wTYKvvMIEzbHehUeI1C1pTqwq1a+ntiUvoyd2z25bwzxFh+42LPNr5/mh
         syqCzHIS8+wvOPV+aQKLI2gDs5kjip74l/1KqZa+wkQvrZn60MKL9RFvRE/jWa44lBvk
         DW4AKCdK2w2COPp8AIXvpDucoraW7me5fzN3eNdsme/j3LYsPOEe8N3eFLTSlqdgrMAD
         9VTH1iGe0Vx7zdOqhJY6ZvEksBHVZE5UGoAWnNTmfkqg9/qJElLDcqes56YofJ7TDRlH
         5CR/sQLgJs8nChqLhfPC2OhCdOepLoA7n/UqV3nJOtyFrjAThL4Io3zIXeAESJFyqyYX
         eDFA==
X-Gm-Message-State: AOAM531m6BuySvfSZE9m9Ca+/GW8EmfDgybwl2To2lpXBgeYnPU8u7xQ
        1dweLB2Kg5js20sm2I7FinQvv3Fv++PAcBrBWOvY
X-Google-Smtp-Source: ABdhPJx1qMhvPlECdMLgJkKTYe1+2/SWURl09xUNjRlTSGVKxRo71w8fBOeBBLVS9zjyzoBlAVvbHSrsPvkWN1SPdkLT
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a63:b950:: with SMTP id
 v16mr28853259pgo.328.1630447338124; Tue, 31 Aug 2021 15:02:18 -0700 (PDT)
Date:   Tue, 31 Aug 2021 15:02:08 -0700
In-Reply-To: <xmqq35qr7mq5.fsf@gitster.g>
Message-Id: <20210831220208.3924051-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq35qr7mq5.fsf@gitster.g>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: Re: What's cooking in git.git (Aug 2021, #09; Sun, 29)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, kim@eagain.st,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * ka/want-ref-in-namespace (2021-08-13) 3 commits
>  - docs: clarify the interaction of transfer.hideRefs and namespaces
>  - upload-pack.c: treat want-ref relative to namespace
>  - t5730: introduce fetch command helper
> 
>  "git upload-pack" which runs on the other side of "git fetch"
>  forgot to take the ref namespaces into account when handling
>  want-ref requests.

Sorry for not being able to look at this until now, but:

Reviewed-by: Jonathan Tan <jonathantanmy@google.com>

Thanks for addressing my comment about the failing tests to be written
in success/failure pairs [1] - I see that that has been done in patch 2.

[1] https://lore.kernel.org/git/20210802210644.3432544-1-jonathantanmy@google.com/
