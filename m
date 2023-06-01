Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A87C7EE23
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 05:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjFAFJ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 01:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjFAFJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 01:09:58 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718BC129
        for <git@vger.kernel.org>; Wed, 31 May 2023 22:09:57 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5289cf35eeaso1291437a12.1
        for <git@vger.kernel.org>; Wed, 31 May 2023 22:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685596197; x=1688188197;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ldw+V0/ZqUAGaykBeG/TGQSw05Gi9jXJcuMnL5OAOkM=;
        b=Ife9h+rzfpRJii304Lf/iWYlWwRlvURx50gcBSSxj2HE4m3kvNplaFgVUkQXTYnrhB
         ynLcwCzXfBIO7ywSTXZVZ5SdYb5BKiWsI1ezx9f/R4JQ9gBLJL99b4xxYt9PuE+qslWv
         y/0Sqp+7efh4olyD0PA+t6nmIMEurX9U0mgi5NhZOAFC0RnXMr6ChV81Q6ahQ7/JFUSc
         xWwyN1/sQnw5qofT/IDDx7Uata7gGmKYCXynCAD+/Zro46UBALKblEZRZorq1KEmm4Y5
         F53R8CXRNMrUJWRpikLUhdK1d/UqZarnTqt3VUqv5rUdeMfhKA30KY22Brrf/xr7+G8q
         WcXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685596197; x=1688188197;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ldw+V0/ZqUAGaykBeG/TGQSw05Gi9jXJcuMnL5OAOkM=;
        b=PWHoHm1JHbruq+PmD3qyPcPLItod69guPQkT4xSsX+hcj5Yt2hiBxhEd6c3vQIqveN
         BCCINhJDuoC4wOyLQ3l65j0i6Fp606z6MooEzL60/vdmB7mRB7DjVp2beMFSdAqmMAN7
         Fr+YYKvn6xlvz2SC2nWucLWrUGjmIbU81h9vg9zuY7uDfTXug3xwXDsbfXhY6luDJG+A
         N4nu5Dzs5TjDew4bPWC3Apzfbu4S66T927DtnZo6/4cA13vv334nFDvDFgLUrBYQcpg5
         mLtPFGv0g1RLE7hYPwZ6lzeYFUl/A62Tec9OwdwHsS5ZwYj6XPaoVT6CmDvPQTp2NOVe
         /rQA==
X-Gm-Message-State: AC+VfDzCZdLp71Il/o/qYPVpTHoc+NtOdj+RyTieOFqBj7sYs0UREsDT
        Pn3OLMWsFdjYtqfzRUYXq00=
X-Google-Smtp-Source: ACHHUZ7gtlyBKDxXOATJQuUwaPBWb19OkPgaMcSancWi022D14lT/BGKJkg1acy5O2HotlHU+vYY/Q==
X-Received: by 2002:a17:902:e809:b0:1aa:d235:6dd4 with SMTP id u9-20020a170902e80900b001aad2356dd4mr838034plg.19.1685596196550;
        Wed, 31 May 2023 22:09:56 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id y20-20020a170902ed5400b001993a1fce7bsm2320738plb.196.2023.05.31.22.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 22:09:55 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Johnson <me@adamj.eu>
Cc:     Adam Johnson via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] doc: restore: remove note on --patch w/ pathspecs
References: <pull.1504.git.git.1683282753768.gitgitgadget@gmail.com>
        <CAMyDDM2iwpXkZOBB+9wLDwbcu-_KzEmDvXhSwnXXaHN+KNOieQ@mail.gmail.com>
Date:   Thu, 01 Jun 2023 14:09:55 +0900
In-Reply-To: <CAMyDDM2iwpXkZOBB+9wLDwbcu-_KzEmDvXhSwnXXaHN+KNOieQ@mail.gmail.com>
        (Adam Johnson's message of "Thu, 25 May 2023 08:25:42 +0100")
Message-ID: <xmqq5y87epjw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Johnson <me@adamj.eu> writes:

> Hi, is there anything I can do to help with review?

One good thing you can do is to ping like you did ;-)

I have been down/sick and will be a bit busy with release work but
after that I may find time to review it myself, as it sounds like an
easy change.  But I'll comment on something I immediately spotted.

>
> On Fri, May 5, 2023 at 11:32 AM Adam Johnson via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Adam Johnson <me@adamj.eu>
>>
>> This note was added with the command in 46e91b663b (checkout: split part of

"command" -> "commit", I think.
