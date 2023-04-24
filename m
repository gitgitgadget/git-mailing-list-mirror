Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1400C7618E
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 16:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjDXQAz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 12:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjDXQAx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 12:00:53 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9D96A59
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:00:52 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-63d2ba63dddso3788486b3a.2
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682352052; x=1684944052;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gmuEQ7D44iPWSphfcVTFd7ucdQ65w7h1IstcJ1YYQvQ=;
        b=P6xwt08M8VCilZO6bLpQe3IhXHgAjvY3W4Q86FiJjrJJIBXxgdqL8G8rx+lKa/OGlc
         lAZjecA3h20rNirOhjcdUyh3GVIXxT/CzPJ2s+Ti2M6EPu3MZcbvteLuMWGuJ7Vw/BQV
         Tct6wDsySVbm/KZlu0OymvqR1/jtXvwGnjGvKEdnTmmUA4TFurUkOy9FXPT/sb7zFa8b
         O/77pTX9VIJEIVjWmgpwauIRqtptqrMzBHUQaJiT9/D8eHfCwadIaRJbXyAzlMG5CrvH
         /CRqYAFvessOKBXs0exCi6qHv92Ka+SZ0TjgS43QUjx+z8nrUrRcHQNszEI+J4T1Un83
         o0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682352052; x=1684944052;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gmuEQ7D44iPWSphfcVTFd7ucdQ65w7h1IstcJ1YYQvQ=;
        b=mGhxe1b5+5SgNCvhlzCXFbtqgp7MaW2dNkJFSqs6PflIsF57SWUvE/c0ku2Ub5NIiI
         G1QBmqWUScOLwSSSBzsI9TyFiItgk8cRE0Ein98PkRjgBtX5CTJMp0CF1YJeJIPKR9y1
         VCskMGpSuyUKmaevm9/+zrLnu1Jl7rS4ZbP1et+INaAqO6YraTrjUY1w+YGDypuSwx/U
         dzjZ14kK6q2B2UWfuwW2TMHj7+mx7VKVw41Xn6ZMIvZPs1zef+EO8nbn0Tw+v3gR1w+6
         eLxf3vOScbU4AiafAXtj5aVlvSdziBheN9x6AxEWHwoDNPYf4hION3GxkWDGzvRBCdda
         CqqA==
X-Gm-Message-State: AAQBX9ewMj1dopLoMOMXzqLCc95Xp66G8Ok86GoBgixgoCTfYHwuzIwO
        7QsMbeCaM/k1tbqFN+ZSYIU=
X-Google-Smtp-Source: AKy350Z3+zw/a+j7e+E2uDKSf6N92gbRi+SEIDrhWlry6ze/GWUfVCXdSFQiaacTYyIEyg1s2i/58g==
X-Received: by 2002:a05:6a20:8424:b0:ef:6c30:5798 with SMTP id c36-20020a056a20842400b000ef6c305798mr18408358pzd.27.1682352052071;
        Mon, 24 Apr 2023 09:00:52 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id t10-20020a63460a000000b004fab4455748sm6694702pga.75.2023.04.24.09.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 09:00:51 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Shuqi Liang <cheskaqiqi@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, derrickstolee@github.com
Subject: Re: [PATCH v5] write-tree: optimize sparse integration
References: <20230421004108.32554-1-cheskaqiqi@gmail.com>
        <20230423071243.1863977-1-cheskaqiqi@gmail.com>
Date:   Mon, 24 Apr 2023 09:00:51 -0700
In-Reply-To: <20230423071243.1863977-1-cheskaqiqi@gmail.com> (Shuqi Liang's
        message of "Sun, 23 Apr 2023 03:12:43 -0400")
Message-ID: <xmqqleihgtho.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang <cheskaqiqi@gmail.com> writes:

> 'prepare_repo_settings()' needs to be run inside a repository. Ensure
> that the code checks for the presence of a repository before calling
> this function.

Can you explain why this change is needed?

That is, if the caller made sure if this codepath is entered only
when inside a repository, such a "we need to refrain from doing
this" becomes unnecessary.  Describe under what condition the
control passes this section with !the_repository->gitdir, e.g. "When
the command is run in such and such way outside a repository, the
control reaches this position but prepare_repo_settings() cannot be
blindly called".

I suspect that it is a bug if the control reaches this point without
having a repository, as the call to write_index_as_tree() would be
already failing if we were not in a repository, but there is no such
a bug, and you did not introduce one with your previous changes to
this codepath that you need to fix here.  You can observe a few
things:

 - "write-tree" in the git.c::commands[] table has RUN_SETUP.

 - git.c::run_builtin() is repsonsible for calling cmd_write_tree();
   what happens before it calls the function?  For a command with
   RUN_SETUP set, unless the command line argument is "-h" (that is,
   "git write-tree -h" is run), setup_git_directory() is called.

 - setup_git_directory() dies unless run in a repository.

 - git.c::run_builtin() calls setup_git_directory_gently() when the
   command line argument is "-h" and it does not die even run
   outside a repository.  However, before the code you touched,
   there is a call to parse_options().

 - parse_options() called for the command line argument "-h" shows a
   short help and then exits.

So...?

Also when starting to talk about totally different things (like, you
were discussing the change to write_tree.c to avoid segfaulting when
run outside a repository, but now you are going to talk about the
title of one test piece), please make sure it is clear for readers.
A blank line here may be appropriate.

> 'write-tree on all' had an unclear meaning of 'on all'.
> Change the test name to simply 'write-tree'. Add a baseline
> 'test_all_match git write-tree' before making any changes to the index,
> providing a reference point for the 'write-tree' prior to any
> modifications. Add a comparison of the output of
> 'git status --porcelain=v2' to test the working tree after 'write-tree'
> exits. Ensure SKIP_WORKTREE files weren't materialized on disk by using
> "test_path_is_missing".

All of the above may be easier to read in a bulletted list form,
e.g.

 * 'on all' in the title of the test 'write-tree on all' was
   unclear; remove it.

 * test the baseline test_all_match git write-tree" before doing
   anything else.

 ...



> Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
> ---
>
> * Update commit message.

OK.

> * 'command_requires_full_index' to be set after 'parse_options'.

This does not match what we see in this patch.

> * Remove trailing whitespace.

OK.  But there is a new line with a trailing whitespace before the
line that says # check that SKIP_WORKTREE files are not materialized"
in the test.

Thanks.
