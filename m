Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8430AC7619A
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 21:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjDLVTu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 17:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjDLVTd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 17:19:33 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014758A4F
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 14:19:02 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id c10-20020a17090abf0a00b0023d1bbd9f9eso16047706pjs.0
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 14:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681334336; x=1683926336;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nN0FtnzQ74/DDIp4gSsinQpcrc39lwmnP8RuLdRVv+U=;
        b=m5O0IK/aSl66LipAchn3thwYBnJUrY4Z2TVSWQRQU6tAcLl1wVk1URufe6pd3Qi1T5
         mj9qsr7QtjCV5vOodpeyih3on1SldkQlvB/0VKhREUMMPE1D2tqOwWL3pJEhwNvE2HkV
         yYd11636Dau2nwaR174+guTVEoh1dKf3IrkiW0v0k7ZvYrWvfFRAWRp7CtvhHq+N/vr+
         rmEd/fcdLOvglt40lWMhbm1aKECqckDU3sbrzfvWMsSQRXKi20aGVScG4/P4Yoj0kQsu
         kXW512eSEGAhU9p0x8ZcOCp0cdcJyPDovszK8dWdEns/8KMe9EmAMOc666i1/TLgqE0O
         +8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681334336; x=1683926336;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nN0FtnzQ74/DDIp4gSsinQpcrc39lwmnP8RuLdRVv+U=;
        b=UgopvUVYFoQbudefz/toZ6wY8lEdHQAFUjh6M4tBt+4gq5iuZCW5dIZBn5nhOkreOI
         K5hwSgRcINHGIYgAnf79OH07tl4TPCvK+DTszVN63C97t5lPfZynxW1zmLHW6jbwV02l
         AOPDZEdTbVDKiQOy9tc0+6kEQ2PrRLAs96j6gMPPPm4vAI3qppCdYXR3t8+22A3xra/k
         94w3Pj0/mbs1wBx0rb4AmL5VYXBQBbzMdcKriF3dV+FdfVe6Cl+ekaZGENDHGrRAcmYO
         iRW8bx69ctxsCbnq+pk5GGdfvu2wY68wLplDdaXJcLtqm+HEQ8FhK+BeADNFAm86KMW/
         muIg==
X-Gm-Message-State: AAQBX9ek3vtTDtGb9h3WdX1ua3VDsPAaBsWh0uTAo9gtACtDyKRZL/Lf
        r67gOLKEb2bQHtt+4gagaOEUBqeemZ4=
X-Google-Smtp-Source: AKy350YCphfRBU91b5AIqqCYibytelQP75TPYab3zqUyIzhh/UK+6mNr9mUhGVX+lExoduvANyCsUQ==
X-Received: by 2002:a17:902:d40c:b0:1a2:17b1:71b with SMTP id b12-20020a170902d40c00b001a217b1071bmr147915ple.66.1681334336334;
        Wed, 12 Apr 2023 14:18:56 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id v23-20020a17090331d700b001a63deeb5d1sm51482ple.27.2023.04.12.14.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 14:18:56 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH 1/2] cocci: add headings to and reword README
References: <pull.1495.git.git.1681329955.gitgitgadget@gmail.com>
        <4a8b8a2a6745e791e35296e34f530b5f40f51c27.1681329955.git.gitgitgadget@gmail.com>
Date:   Wed, 12 Apr 2023 14:18:55 -0700
In-Reply-To: <4a8b8a2a6745e791e35296e34f530b5f40f51c27.1681329955.git.gitgitgadget@gmail.com>
        (Glen Choo via GitGitGadget's message of "Wed, 12 Apr 2023 20:05:54
        +0000")
Message-ID: <xmqq8rew7q9s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Glen Choo <chooglen@google.com>
>
> - Drop "examples" since we actually use the patches.
> - Drop sentences that could be headings instead
>
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>  contrib/coccinelle/README | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Makes sense.  Will queue.  Thanks.

