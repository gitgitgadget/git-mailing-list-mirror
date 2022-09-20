Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE06CC6FA82
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 20:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiITU5k (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 16:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiITU5j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 16:57:39 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3D86C11C
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 13:57:38 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id i3so2644973qkl.3
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 13:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=rkps4Vf/2TILqaH01kTqjAPelTwORfac3BSe8Edb6fI=;
        b=axf98uiezb1QvRbLXzda8QzWqUDP5GL7pj4BM8d52vSRKCeHjGcj6dh2UnBYVeHfTz
         7QlbOg0Aa1qfN3A6WEApU11BYDnS6m7mQ6Tgpc/VNycCKdQG5pjxyygorYM+GYkTCu8n
         FxjJZ8tZqPqexBSvoGcwHIwZDDZRbX32plC2dP+nUt1/q3Ln+87htaq/eNGXtetmME4Z
         xX2Mo5DlldRXtC861QQYvChL6CLne9HMt/g7xoclPuPL0V2ceWyf4PwHHR0uTKkumpT3
         +sMqHZJrsXUutCWRzJL7GE/tlHlAkqatX3dssdkagg3qRM8nZjPts+w7/gMw7ihOlnWz
         qcsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=rkps4Vf/2TILqaH01kTqjAPelTwORfac3BSe8Edb6fI=;
        b=fczZRakuZX69r0EdJgZGX/pblniBMmK9I3D14Ee95AD8cr9xc9Pl2tADHdWWJkWOmS
         dFQY6NiFv6Polcf3+llQYtpB3gpb/45OMTAsP4H8tY98pZhqcERvPB6CAw8TfFPASScD
         GXic5ZTwENSs+Y1AO7Vu4cY2arTGQN1/ykCsTp9bG9vhl7xuDooUjoE4wx6IJWfmZP3O
         Le1iVfyrZABcxEdaD28uiTDqde3i6R9eVaXlGnlhpfpppbkNwSwqGQMmI8WyPJFIOKyJ
         mt7F3sOzux3nS3JSnYIc5VCekKB9HxL3Z9he4PrwVKoyZ1CdZBPdcIkt9QszWzoov7g4
         m4zQ==
X-Gm-Message-State: ACrzQf3JAB42niAIgWM9XHGQQ4fh9qmKFZM3Dw1te7jPW/+y+cGbBUft
        o5JVXhB2VxOA3qb9w3KTH8xUpYmU7yiW5Q==
X-Google-Smtp-Source: AMsMyM7qajJ3ih11l9o7m3xAsbHsbjzYFVZsOzMdCrFn6f+H7Kdbdsa0pUgB7guLYUXglOr483Krhg==
X-Received: by 2002:ae9:c102:0:b0:6ce:33ee:e222 with SMTP id z2-20020ae9c102000000b006ce33eee222mr17680080qki.571.1663707457240;
        Tue, 20 Sep 2022 13:57:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f39-20020a05622a1a2700b0035cf31005e2sm411712qtb.73.2022.09.20.13.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 13:57:36 -0700 (PDT)
Date:   Tue, 20 Sep 2022 16:57:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Subject: [BUG] seemingly-rare segfault in merge-tree
Message-ID: <YyopQD+LvPucnz3w@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was looking through alerts this morning and found this one that
happened in GitHub's infrastructure a few days ago. Usually these are
memory corruption issues (and get dealt with via a separate process),
but this was a legitimate SEGV in the merge-tree builtin.

The backtrace is as follows:

  (gdb) bt
  #0  oid_to_hex (oid=0x4) at hex.c:164
  #1  0x000056234188aba3 in real_merge (prefix=0x0, branch2=<optimized out>, branch1=<optimized out>, o=0x7ffd3fc4cd60) at builtin/merge-tree.c:528
  #2  cmd_merge_tree (argc=<optimized out>, argv=0x7ffd3fc4d7c0, prefix=0x0) at builtin/merge-tree.c:658
  #3  0x000056234181ffe9 in run_builtin (argv=0x7ffd3fc4d7c0, argc=8, p=0x562341d5c788 <commands+1896>) at git.c:465
  #4  handle_builtin (argc=8, argv=0x7ffd3fc4d7c0) at git.c:724
  #5  0x000056234182117f in run_argv (argv=0x7ffd3fc4d4f0, argcp=0x7ffd3fc4d4fc) at git.c:792
  #6  cmd_main (argc=<optimized out>, argv=<optimized out>) at git.c:923
  #7  0x000056234181fb80 in main (argc=11, argv=0x7ffd3fc4d7a8) at common-main.c:59

and it looks like the result's tree object is left NULL, which we then
produce a SEGV on when trying to pass `&NULL->object.oid` to
`oid_to_hex()`:

  (gdb) up
  #1  0x000056234188aba3 in real_merge (prefix=0x0, branch2=<optimized out>,
      branch1=<optimized out>, o=0x7ffd3fc4cd60) at builtin/merge-tree.c:528
  528	builtin/merge-tree.c: No such file or directory.
  (gdb) p result->tree
  $1 = (struct tree *) 0x0

I haven't looked too hard at these paths (nor do I have a useful
reproduction, since the top-level `argv` array is optimized out). But I
figured I'd share it here in case this was obvious to either one of you.

Thanks in advance for taking a look, and let me know if there's any
information you need from me in order to debug it further.

Thanks,
Taylor
