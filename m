Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A9FC43142
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49BBC64E12
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbhCDAYN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353082AbhCDADH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 19:03:07 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC0EC06178C
        for <git@vger.kernel.org>; Wed,  3 Mar 2021 15:45:34 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id k15so8358047qtx.15
        for <git@vger.kernel.org>; Wed, 03 Mar 2021 15:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=OdCeLpO7fqCuTeCSWq9Bkc+hVrbLJ5krU3iWiw33THA=;
        b=SZZnY4JeCfCJYqEfl3LK9Sw3t1PAtS3A+8Aet965tAbPe44Uat4EFHv9tlzEOGD9eq
         Z16zeNhmMgQVraiynnz2qYWBkz+9VKU5s5XHXy15mCimx3FZnQUU6EO5pB4OY2MngemR
         5IRkPg21qayybwkx9JgdLSPfpqowiUIV7i8nzN38BOMU+xBOadxkHBxeF6r9dL9YYFmT
         6tAaJzPBDgO95rlmUddyVuA+Qr8460HiJGmABR4nmXTXk1Pklx/EA1mdBKXdhaw0bJoI
         6n4MtJl5q6ES+JXX5grxisRVH8qP+FP+0XbpssKuBrcJFjourPZgNIXlNQUSpS6tOH+q
         foyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OdCeLpO7fqCuTeCSWq9Bkc+hVrbLJ5krU3iWiw33THA=;
        b=c4OhJ7Mrei1xHf0EU5qBo8eDZhfWNZ4x+9fd7Nj1HHTcPF+w5EqwSqsP31bmBKX7ER
         EcexUCKG1b87gSsBimWt8VjJlSLKeSsnyCimlS51eWf7G7cVzMUjbzPTyjGMDx3N3ifk
         /D8mOikkdgcmH34GPaSZpV1g9oujlfteQ82Jb87lGa4caYQPjW6i5Ge2Ci3d+HfDvxbR
         NaffqouCivqXSxRHLAse7lPrXd9QMys3QiuLlzGZGorkBc+wRom/t4gHLiDyLe0xWQz2
         vbSUVURhUtBODM/QyWlqGLGcrgekrJe9pLx75qvNTWnMcZKPk0nJT9kZNzFxU6oMfI7c
         3KDA==
X-Gm-Message-State: AOAM5313aZnJwqOoXHrlZI49RcZnXKvHrCow2nl4/IZF6qelNSROSN8W
        hIWQbCncm1Fa7FD0FYUaIapJOqAW6vIwSsqEM+fE
X-Google-Smtp-Source: ABdhPJwB/UYYdEosn+tv+4Yeb2mEeKefN8c6qJEVf4VKd/mD5/dxo0dyS2bjE/cx6KhxW2X5QI/y5L6tjxPRxBltcmLS
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:bf12:: with SMTP id
 m18mr1449671qvi.40.1614815133888; Wed, 03 Mar 2021 15:45:33 -0800 (PST)
Date:   Wed,  3 Mar 2021 15:45:30 -0800
In-Reply-To: <CA+cU71=FfReSG411Feo=vmkw4MdK4KDgokP1jH6uwOkC_0AbYA@mail.gmail.com>
Message-Id: <20210303234530.3122368-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CA+cU71=FfReSG411Feo=vmkw4MdK4KDgokP1jH6uwOkC_0AbYA@mail.gmail.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: Re: Can I convince the diff algorithm to behave better?
From:   Jonathan Tan <jonathantanmy@google.com>
To:     tom@ritter.vg
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I know that git includes four diff algorithms; in my testing patience
> or histogram exacerbated the problem; and none of them improved upon
> it.  If anyone has suggestions I'd be curious to know if there's
> anything that could be done...

In your particular case, I can't think of anything, but in general, if
one of the lines weren't repeated, you might be able to use the
--anchored option.
