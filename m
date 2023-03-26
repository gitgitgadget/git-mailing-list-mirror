Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AD5C6FD1C
	for <git@archiver.kernel.org>; Sun, 26 Mar 2023 14:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbjCZOzm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Mar 2023 10:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjCZOzl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2023 10:55:41 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D6849D2
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 07:55:40 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id e21so6361107ljn.7
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 07:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679842537;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RaQedORWihYUWO6YAmHOMiPyhS5SQwjrPZ4Jnypqb0Y=;
        b=YPYdcxir5QGGX0CRvBnJ0UkyXWcULZ6K2E8jUlRxEnGqMVTl4vgqmFdvOcmAlbBcWv
         xIJvGtBLLZ1eXTQcW1UJnoodNSPqUnTUlydgXOUIAXHcrzVrlGztgOV6btMdRMjwC0I/
         zQkkvLcII3P12g+JhNykkX6Lw4yQ1GqXu1xq+Le9XuWnx+7XGF8l6BCRNxSeXhqUlyjb
         BKQK1787YCp3U4E363nYIExLYCWQcyVFylIIngLpBJ2J48VtrjrJBOoNhNUK9f8vSXS5
         hxVDlU1zUeMNQZKqSZ77Xy0EELDeffDB2lqtoh6BGXXVlDob/rtRbPYS2vlQWFsq5/9J
         gdqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679842537;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RaQedORWihYUWO6YAmHOMiPyhS5SQwjrPZ4Jnypqb0Y=;
        b=lwkOVC+eqY9qZ6BRExffoPcMEOQHJoPCy+j5tSYDIDbqyw0sgT0bMdRMBm1hU3H1c+
         +mi54xUCMSGqfKr+8rLqAIUPCiFjR3BaRlQEMLk19FiJIab4VWISYdvwPr+YQNzOO3be
         N17sLiANolHnZBODdR39TwpxxAwzWFYZ75SI6jwgvXW9e36vhcbxXSZ9744zRZci+Itc
         WN8QBzuzdZc9Z5Yc1msgc1EktHVFmSbYEgONyHRwTrmLy8vlSGeuty3+5bQjm777w5pH
         3ffB1T+Qbvz2VvzlEwDiYPrPUzsVXGkPBi6YP9HYXW19roNcXqiWvfo/pVZXMtdt/2Ue
         Eyxg==
X-Gm-Message-State: AAQBX9c0RZhPycxFE9D2eRutP11fSoaL6klrzgMQLaIhyjAbMB5uWqIB
        SI5Ob4OZYl5G8JWt9LnyjBz4aVx0DIi+8xpNRfLNadLHe6PQLA==
X-Google-Smtp-Source: AKy350buYsOSsTsVvfZZwEnEVZi9tWmL+U/WiTgFMBxB1z2e7EoRg/vzJlmK7Lf2bfS7a6wikQSLAwYjcCek9N/+T1g=
X-Received: by 2002:a2e:86da:0:b0:2a5:f152:bd with SMTP id n26-20020a2e86da000000b002a5f15200bdmr537732ljj.6.1679842537639;
 Sun, 26 Mar 2023 07:55:37 -0700 (PDT)
MIME-Version: 1.0
From:   Maifee Ul Asad <maifeeulasad@gmail.com>
Date:   Sun, 26 Mar 2023 20:55:25 +0600
Message-ID: <CANb2QxDUp_Lm+eYQM9x2OPzu10LCB2MBZamy2ehC6F03GdsDKw@mail.gmail.com>
Subject: A new approach to Git's clone process for improved functionality |
 Maifee Ul Asad
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear,

I am Maifee Ul Asad. I have been studying Git's codebase for a while
now. And there is something I noticed about clone functionality.
Whenever I run a clone operation it creates five independent
processes. Now the only way to cancel this cloning operation is
through CLI, press CTRL+C or a relevant command based on different OS.
I have only checked in Windows.

But, when I am creating a wrapper, or I have some existing wrapper for
Git, and I want to add functionality to cancel the cloning process, it
can not be done so easily. Then I have to create a process and pass a
signal interrupt via stdin of that process and cancel it.

I think it would be way cool and lot cleaner if we could create a
parent process and add these processes as children to that parent
process. In this case, we can simply use kill to terminate that parent
process.

Till now I was only able to identify these operations, and I am pretty
helpful they I have identified the correct functions:
 - perform the fetch operation
 - perform the receive-pack operation
 - perform the indexing operation
 - perform the pack-objects operation
 - perform the update-ref operation


Now we can simply wrap these with a fork (yes, we have to think about
NT not having a fork; and cygwin and other libraries may add tons of
load here) call. But here is my proposed pseudo code:
```
fork a new process
if (fork failed):
    log and exit
else if (fork is successful):
    perform the fetch operation
    perform the receive-pack operation
    perform the indexing operation
    perform the pack-objects operation
    perform the update-ref operation
else:
    wait for the child processes to finish
```

I think it would be a great improvement. And, I am really excited
about the discussion we are going to have on this.

Regards
Maifee Ul Asad
