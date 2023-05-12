Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED418C77B7F
	for <git@archiver.kernel.org>; Fri, 12 May 2023 17:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237795AbjELRXU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 13:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237248AbjELRXS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 13:23:18 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB978DDBD
        for <git@vger.kernel.org>; Fri, 12 May 2023 10:23:07 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6434e65d808so10847820b3a.3
        for <git@vger.kernel.org>; Fri, 12 May 2023 10:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683912187; x=1686504187;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AEAyg3Xtsw2yN671HEJRFjDAtpEJnft8kYVEz9NCXck=;
        b=cYhSLILMLlWJ+jmLAa8Px87WoG3JEB0g0GQLk1buu1LZ/mDtZgPh8BnXWNiWOPqc1n
         QSwXTDgwwMTDoXdiuvNoYIgPJM2yhlT9b8m1tK49bjYxXtSqY76wmg7+7gn85UA4QyaK
         fCNCvpenGBM3I6/2XJh+6X7a3c9oEVBsWacLEib7W5PkGSIZwOi+3EJRlqfua1F4yYFg
         uoZiJAidhQlhtmzm47Ct6499F2IhA4y1VDbBCqDBcxPN5fcmWotDWswxOkjsKjLzkmzp
         b/dOJgESefkmBG367vtLkD/vpu/JeM1H+O8Imu5TSs/aF2thTeE6uIMJSvJ7UZC8Byec
         AXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683912187; x=1686504187;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AEAyg3Xtsw2yN671HEJRFjDAtpEJnft8kYVEz9NCXck=;
        b=D4+zDb0JaGNw1bnkmL6tMkmpRJ+rfmZ9qvRioQO0gJrgU2SXThJHLFfOq9GjDhIASZ
         2n6XgZG0uR5Mh+79up7SQMpR5BZMPD63hLhTlCqH1jFkCniLIWBJvJRl6cOyI70B/2Kx
         XLZ0EvDuLNI/KKiQ4rX89lhuwGmSA7nPyH3hLSWgYNFNqt8GMg1GY2mprbeu2WuQI7d7
         r72R+t3VTOHIPwji4gCjSb7aaXrO8/0zt6OkXFoZlMGmyEy1eTI52Sjl+7+U6CwWAeqv
         zo6Gdk7yN4pixBQfU/NRuHK4XBQ0NWE73ktwm9DNWND9hx4iYz41mkww1ICqvAHCZLn3
         w8+w==
X-Gm-Message-State: AC+VfDxebW2mziMWMJS+Kb0s+lEQVZqAmn0M9ttAVV7IM0KmNyQ0Cl5Z
        bbT51MirQ0gKL56SqdjGI1M=
X-Google-Smtp-Source: ACHHUZ5KYvOQquYPUOg26U8JaFn7zW0jeQTGwLYe+eSQSv2BLLvXFPzznbFEJ0g8nPPeR3rN0VLehw==
X-Received: by 2002:a05:6a20:7d84:b0:100:d88c:4a23 with SMTP id v4-20020a056a207d8400b00100d88c4a23mr22023803pzj.52.1683912187173;
        Fri, 12 May 2023 10:23:07 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id v6-20020a63d546000000b004fbd91d9716sm6951427pgi.15.2023.05.12.10.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 10:23:06 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: tl/push-branches-is-an-alias-for-all
References: <xmqqo7mqs7rp.fsf@gitster.g>
        <CABPp-BFLOpsm6wg+CidEHaQhJ4FTnszfj8SUeBWxkFZgSeJ8Nw@mail.gmail.com>
Date:   Fri, 12 May 2023 10:23:06 -0700
In-Reply-To: <CABPp-BFLOpsm6wg+CidEHaQhJ4FTnszfj8SUeBWxkFZgSeJ8Nw@mail.gmail.com>
        (Elijah Newren's message of "Fri, 12 May 2023 08:26:09 -0700")
Message-ID: <xmqq3541qxad.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Thu, May 11, 2023 at 6:22 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> * tl/push-branches-is-an-alias-for-all (2023-05-06) 1 commit
>>   (merged to 'next' on 2023-05-09 at 1d8c3e5dcf)
>>  + push: introduce '--branches' option
>>
>>  "git push --all" gained an alias "git push --branches".
>>
>>  Will merge to 'master'.
>>  source: <20230506113408.61529-2-tenglong.tl@alibaba-inc.com>
>
> This topic breaks the tests for me; it needs a trivial one-character
> fix: https://lore.kernel.org/git/pull.1532.git.1683904156670.gitgitgadget@gmail.com/

I wonder what made this breakage hidden.  I usually run the tests
after accepting a series standalone, and I run the full test suite
(excluding the ones that depend on things I do not have, like p4)
with bash and dash before pushing anything out, and I haven't seen
GitHub Actions break due to this.

Ah, it is because t/Makefile essentially uses $(TEST_SHELL_PATH_SQ)
to run $@, instead of directly doing "./$@", in both cases with and
without probe.  This is very much deliberate in that we do not want
to rely on and get affected by whichever shell choice the system
administrator made when installing "/bin/sh".

I'll apply your patch primarily for consistency (a shell script file
that begins with "#!bin/sh" never is a good thing, and everybody
else begins with "#!/bin/sh") for now, but I think the justification
of your patch is questionable in that we do not want our developers
to rely on "./t5583-push-branches.sh" to work [*], as these scripts
are designed to run under $(TEST_SHELL_PATH).

Thanks.


[Footnote]

 * We could, for example, make t/t[0-9][0-9][0-9]-*.sh scripts
   consistently use bogus shebang line to catch possible breakage to
   t/Makefile that bypasses $(TEST_SHELL_PATH) in the future.  If
   that happens, developers who expect ./t5583-push-branches.sh to
   work will be broken.
