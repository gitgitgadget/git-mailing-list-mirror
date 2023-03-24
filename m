Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52611C6FD20
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 04:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjCXElY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 00:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCXElX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 00:41:23 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F0E12F03
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 21:41:22 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so516573pjb.0
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 21:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679632882;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jfGdNPjMrQOpQn4S00WsOxTn8p0bVeQDTQIpye/psH4=;
        b=PY/hgnAMgQfX4PUYx2pldrR3ZA4gPHmqjiQakKY666DjzO5bQFoY5Xuhfr4wp/becF
         ArTd/ra7NGPezRrgoXWcHhFQfW6A8CpJvjcho1NMXgjp2JqnDZPi+hlfMfoDQeQ7kI/D
         jvv+evR5+Oq3NmEfRIUSZodV0Pq3p6uXZ9qazlY3Th77hequYlWDbidB9y7cAhw533rj
         BBtFJyKepPCZtKLLbZXOZ+gtqFTdnu8R3wYmj6N8l0GPXosTp5yNvbFd6gLH5ejOBjxM
         6BdwV4rPewZ9vDCkh6lzt405evAQkCihkts4oVjdSd79703MZ7/0W+fcHqL7mcP6suJ8
         M41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679632882;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jfGdNPjMrQOpQn4S00WsOxTn8p0bVeQDTQIpye/psH4=;
        b=iy8YbmIwysLCO6LYDlAZc23e06PpXf1Ry8blDPZaSQXpfA0t6xKuXCspzmlEVH7+eH
         ebLxJMSDvBdic327HbnEG8ceRcNQElrfqnNKxStnFg5cAmYUv9QSOWdiqe3CV/VphrhY
         rbklTdN/e461gniKeV10EMtmEc6LuuTT1L1jwy6UtMiUuciXZi8FKaoUTu3UlCsrA+nq
         xpWk0zm7C4/HgtkVN4TAjNVDP0skgoJnNgz0km0Npj+suENVmSaLavZCtBMbpOO+diYs
         TXMGSmbyPhwSigmisOTJNoeHeLDzwySoo22KY2p8G/Kde22bGPMSfJYnquiFF/5LFLXe
         SsJQ==
X-Gm-Message-State: AO0yUKWhfLoa0wITU8UajOldsL6CDmjx5atLI7641nYyjC4gMym+o33A
        trOw+M+1fZwiwDkZfTb5it8=
X-Google-Smtp-Source: AK7set9q/XxI1fleJRX/9KCq/nATSnJn5WNV1RnRzpW0xcYvmxLw0yCd557GFfyTbJn/qW2OYbdCsQ==
X-Received: by 2002:a05:6a20:c10f:b0:d9:84d2:7a9f with SMTP id bh15-20020a056a20c10f00b000d984d27a9fmr1772202pzb.24.1679632881718;
        Thu, 23 Mar 2023 21:41:21 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id k23-20020aa790d7000000b006247123adf1sm13167566pfk.143.2023.03.23.21.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 21:41:21 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] blame: allow --contents to work with non-HEAD commit
References: <20230324010457.275902-1-jacob.e.keller@intel.com>
Date:   Thu, 23 Mar 2023 21:41:21 -0700
In-Reply-To: <20230324010457.275902-1-jacob.e.keller@intel.com> (Jacob
        Keller's message of "Thu, 23 Mar 2023 18:04:57 -0700")
Message-ID: <xmqqy1nm69se.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> The --contents option can be used with git blame to blame the file as if
> it had the contents from the specified file. This is akin to copying the
> contents into the working tree and then running git blame. This option
> has been supported since 1cfe77333f27 ("git-blame: no rev means start
> from the working tree file.")
>
> The --contents option always blames the file as if it was based on the
> current HEAD commit. If you try to pass a revision while using
> --contents, you get the following error:
>
>   fatal: cannot use --contents with final commit object name
>
> This is because the blame process generates a fake working tree commit
> which always uses the HEAD object.

"the HEAD object as its sole parent."

> Fix fake_working_tree_commit to take the object ID to use for the
> parent instead of always using HEAD. If both a revision and --contents
> is provided, look up the object ID from the provided revision instead of
> using HEAD.

An obvious enhancement.

As the original author of 1cfe7733 (git-blame: no rev means start
from the working tree file., 2007-01-30), I am not sure if the verb
"fix" is fair to describe this change, though.  If you update the
working tree file with contents that is vastly different and totally
unrelated to the version at HEAD, then with this new feature, your
"blame" can start at the working tree file, and then some commit
that is totally unrelated to HEAD, and down the history from it, and
everything should make sense, but if you smudge your working tree
files that way, it would be quite awkward to use the working tree to
advance the history that leads to HEAD.  That is the reason why I
designed the "fake commit based on off-history contents" features to
work only with HEAD.  But unlike actually messing with the contents
of the working tree files, feeding a temporary contents via the
"--contents" option has much less chance of breaking the next
commit, so I do not have any objection to this patch.

Thanks.
