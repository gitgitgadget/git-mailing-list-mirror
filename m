Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1187C7618E
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 18:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbjDZSO7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 14:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjDZSO6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 14:14:58 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A1444B5
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 11:14:56 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b4dfead1bso6209334b3a.3
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 11:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682532896; x=1685124896;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ri0bBEjm5s+a/gKuB0L9oXqUjUppyosIHZpXMRBGxiA=;
        b=I7o5dWZdZ9aa3heaYSGVqv7UIurDnnXLeU6ct3Pohr7nA5iqRtfs9SfsvghdjML99N
         5YzxmisCAX3OMAlQxWYrRCRQXXmx681yw82YTSfVCIyFWe9QutGUDP4Af287QrZZmHy9
         NDD8qwgWSxRkGNlKczymzkjkOyrKe6Mvlu+V/GW6YyoN7bhc9E4mBZVI7zzj8zps4bLE
         GQqbrUOBvbbgIEFCeiJYXY7MD7XrFFggaMBa7Dac0hJVWsiCBJn3qezHJHjErOFNU21S
         LMrg4vlRXJ/qphqkmC3bvLhLd8b+uPwAoEcNzcIOtgly7MipBuieDdHdEbjZ4tFvfJVE
         RegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682532896; x=1685124896;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ri0bBEjm5s+a/gKuB0L9oXqUjUppyosIHZpXMRBGxiA=;
        b=UEFT1xlNvBoAImVyhPTtC9nl1wrerpgme5mMQnbM3iA7eBYjrWU5j4RlLnHkNGUDj8
         N1ZEM9AVMdWnJrJbZjSXZkupzadIw52peJ7HxtPtuKb7N3M3CdfeXat20nnxMk0GyhnB
         8IKyYz43x3GnQ4cVkoUqa4+R++ocHQO+J+gTZ847Dxo+azxceer43dBL4HY0fy2MkHP/
         soVfIWNYYnvIn0XGEI9RWbMIn5fdslBzSQL3rxwhQIaak2fCRU3xZP03AyNpY1vxa4Wf
         rXu3c6nKNYJuksrXoD51AwZprFKyh7w3T9Q8+ofd/LfuPKhJpkEcumvXw2MaoPivod1i
         f0OQ==
X-Gm-Message-State: AAQBX9fDWYVavP4Y+yuu5M07QoU8sz2i3TwHbN9+nrweyPBgGu8dnoI2
        BQgQANndlYDSDbxfKadTiac=
X-Google-Smtp-Source: AKy350ZIBo0mdN1bhE+Jy9doRFD6ncnq4cG0Z5L82BGmrPg4tyY0Lyd7GNUaJzZ2t3NPqeSi9v1LzA==
X-Received: by 2002:a05:6a00:15c2:b0:63f:158a:6e7b with SMTP id o2-20020a056a0015c200b0063f158a6e7bmr28173380pfu.6.1682532895844;
        Wed, 26 Apr 2023 11:14:55 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id s9-20020a63e809000000b00476d1385265sm9964699pgh.25.2023.04.26.11.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 11:14:55 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 00/22] Header cleanups (more splitting of cache.h and
 simplifying a few other deps)
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
        <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
        <kl6lbkjao7fe.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Wed, 26 Apr 2023 11:14:55 -0700
In-Reply-To: <kl6lbkjao7fe.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Wed, 26 Apr 2023 10:54:45 -0700")
Message-ID: <xmqqsfcmse74.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> This series continues to focus on splitting declarations from cache.h to
>> separate headers. This series also untangles some dependencies between
>> hash.h and repository.h, and between read-cache.c and tree.[ch], and cleans
>> up a few other headers. At the end of this series the number of cache.h
>> includes drops from 189 down to 149.
>
> I looked over all of the patches briefly and didn't spot any issues,
> though not deeply enough for a Reviewed-by.
>
> FWIW I am quite happy with the direction of this series. I find the
> result much easier to understand compared to the cache.h status quo.

Anything that shrinks the kitchen-sinks would be good ;-)

Thanks.
