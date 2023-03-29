Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448C3C6FD18
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 18:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjC2S2d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 14:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjC2S2b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 14:28:31 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FFB6A41
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 11:27:50 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so17079902pjz.1
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 11:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680114462;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=KvtdX/m9HqsqI4lm02Z07fuRsXg5+T/iWCDUXrlDjHc=;
        b=G8iK/0L6oZFQqwTiNxjdbkKgA9c9v4c4B2czlWQ84yFzEffq0fUh3TKBZyEvf3JkNh
         7fMSZ1CPi3jiO8W9BJLJ/idaG9kdQKVQoRhplPgHVbFK57tmWZvHo3oqL/yf3oIGf1OZ
         ptWI7iLD7dJqEsINmr2HnJVYofCjoJWU1qc+mYhQGeguUmNKUw4FOV6iZbs9vRI2oNqJ
         TmrRlR9bOSVjOQFwf5F8Iyl7SU5Gk2Gkmr7gpvfd44zdzSIC5MUZKnI5jcUx8PESH9RK
         6XCPCREyKBMlzb7Lfo/Mby9TCac006rpgb4JvR2U7VhU18Zrm3wkVTj0baI5UjS4G3o6
         Vn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680114462;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KvtdX/m9HqsqI4lm02Z07fuRsXg5+T/iWCDUXrlDjHc=;
        b=8Nmbemzi5d2+tXn0YjU38fmNuyr9N/E1tvk/QPnfoS2rH604U/kfKz0lKFyZKM6Lby
         VTixDrmoguL8tYirr1GID2WVIac0VkzX2gx0Lz3Nob7oMyhE+3fcfdSm15YJZWH1wDSN
         ylZSH1xMPUeuxxfQCX1bJeLIlHUT0OOOookD7wrXyqz2aKiOJmyByy6PSD3jMy3dTFfH
         bQ0K9g4zhFfxzNZQjrh4r6XOsiMw16ClU5/pf8ikP3L9qxtZHeDsAE5QAlPFtzaektSU
         HcmUfOutHhr3qR80YEdOG/kAPyC+JJFNBGPlxWoNhePe6DbccwhuDjRfVXQfczhamGfd
         mJ9A==
X-Gm-Message-State: AO0yUKVp63jN+q6lCKGH5ves7Snj74ZN0p5tr0paOetjXDJOj6J/n4zH
        7igJeVc1seY/vBWhVq9zLyQ=
X-Google-Smtp-Source: AK7set8sEue25fgqwrHTIm5zXFlnX1ju5DHu4neZ7ykK4qmQeyaWKu22NeSMpneIFHhQKBqSl/6f0g==
X-Received: by 2002:a05:6a20:3509:b0:cc:606a:4330 with SMTP id d9-20020a056a20350900b000cc606a4330mr14471284pze.55.1680114462114;
        Wed, 29 Mar 2023 11:27:42 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id g3-20020aa78743000000b0062c4eb40a3esm9090138pfo.30.2023.03.29.11.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 11:27:41 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Raghul Nanth A via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Raghul Nanth A <nanth.raghul@gmail.com>
Subject: Re: [PATCH v2] describe: enable sparse index for describe
References: <pull.1480.git.git.1679926829475.gitgitgadget@gmail.com>
        <pull.1480.v2.git.git.1680107154078.gitgitgadget@gmail.com>
        <8cb2b7a2-78f2-9221-1234-62814557d2d3@github.com>
Date:   Wed, 29 Mar 2023 11:27:41 -0700
Message-ID: <xmqqr0t79zvm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

>> diff --git a/t/t6121-describe-sparse.sh b/t/t6121-describe-sparse.sh
>> new file mode 100755
>> index 00000000000..ce53603c387
>> --- /dev/null
>> +++ b/t/t6121-describe-sparse.sh
>
> Is there a specific reason you've created a new test file instead of adding
> the tests to 't1092-sparse-checkout-compatibility.sh'? Historically, ...
> ... 't1092' also uses a more "interesting" test repo &
> includes comparison functions for full checkout/sparse-checkout/sparse
> index, so the tests added for 'git describe' can be more thorough.

Ahh...  I mentioned t6120 in my response, but t1092 does sound like
a lot more appropriate place for adding tests for these.

Thanks for pointing it out.
