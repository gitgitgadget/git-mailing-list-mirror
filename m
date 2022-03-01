Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B958C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 09:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbiCAJuu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 04:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbiCAJus (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 04:50:48 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0268BF7A
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 01:50:08 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id gb39so30333980ejc.1
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 01:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6W/EiKYcO7oERqThiFnYPP1W54OIVWNYzy9M+MUf6C8=;
        b=Y2kpN7H9Gqut4GRUHj5ZOTFYMChijb0dqBa1tjGz8pwp/ZDEcXcdvVrsObC9qwE0Cl
         axoZZ2326xAkdK+2Pgg53+/tM9r9/1SLeBMmABb4WbewEMxAOp56AlD+MkBe+TGjRNIY
         fq0+RTGXxnPZG0eN12BnaYnTqgL/qBIL80yZfQApazIGW8Rqxx9b0rKOcdFJ2sabOIIm
         hD2MiFwvEGx7m1vIiRqqVUUe3lPdr436drzRwh7yNy00PGOSto2ZHCx1ZCkUIEmzsYIe
         LmdQhlatpSsrmzMI1Tdf7HIgVz5vaw5B3gjTt1UsFRZ18oWGqg+M3vT2qreSmJlkW2fR
         mBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6W/EiKYcO7oERqThiFnYPP1W54OIVWNYzy9M+MUf6C8=;
        b=TKHBXnpWBIf2trBKbqpX2Jwa+ALg5OSGd3hp5a+UeKNNODYbOGDbr/oOHSrXq1KloH
         HzbLm4zScRyRytpj/enhJCu2eWCMFYyq0Ab6i5OAF1tyBL9ayEfSxj43alENAQ3WZTlo
         fdtwkbbi55WJ74vIMWqiSpzxjZ2oNfob6QpBVJ5pfG+V8YaPah6bSjXxC0v3oE4rKBEn
         jpCEm8kGE7a8Ed9nVfTZtviIP8M2/C/yULZQGrmmsZXDFhIJMgOhgrdLQtslPZ2yyE0H
         B2P8W61LYNu2FiSqN4Tj1ApPxCS5Lv5X4zHADedwbfaQKzP3ItinRNX0uu4ORRZ7ugYH
         oNpw==
X-Gm-Message-State: AOAM5334g2UNYP8HmRX+RIdpp+2S+PHm7pGT02kAHzBfg53ZJF6JfR5c
        HD6MPDlyE0SpIqDiP6QvDJfeM91Njr36GEyoKupnTw==
X-Google-Smtp-Source: ABdhPJwqU36SzbErIlPWb9MZLVkPa0PEX0h4qafPmmWVphAuGHCwbU8v4XzqawU10AEqMPV4qJfwI71xfICEkV52bh0=
X-Received: by 2002:a17:906:4ad9:b0:6cf:93f:f77e with SMTP id
 u25-20020a1709064ad900b006cf093ff77emr18678971ejt.558.1646128206434; Tue, 01
 Mar 2022 01:50:06 -0800 (PST)
MIME-Version: 1.0
References: <pull.1166.git.1646041236.gitgitgadget@gmail.com> <pull.1166.v2.git.1646127910.gitgitgadget@gmail.com>
In-Reply-To: <pull.1166.v2.git.1646127910.gitgitgadget@gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 1 Mar 2022 10:49:54 +0100
Message-ID: <CAPMMpog2r6ydon0rCfGSGbiBFYrQNuCTS0u0HJ5yf2mGzhHxAg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Reduce explicit sleep calls in t7063 untracked
 cache tests
To:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I do have a question to the list here: Do mingw.c changes need to be
> upstreamed somewhere? I don't understand the exact relationship between this
> file and the MinGW project.

(sorry, failed to update the cover letter to remove the now-answered
question :( )

On Tue, Mar 1, 2022 at 10:45 AM Tao Klerks via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> As noted in a recent proposed patch to t/t7519-status-fsmonitor.sh, a number
> of test cases in t\t7063-status-untracked-cache.sh explicitly sleep a
> second, in order to avoid the untracked cache content being invalidated by
> an mtime race condition.
>
> Even though it's only 9 seconds of sleeping that can be straightforwardly
> replaced, it seems worth fixing if possible.
>
> Replace sleep calls with backdating of filesystem changes, but first fix the
> test-tool chmtime functionality to work for directories in Windows.
>
> I do have a question to the list here: Do mingw.c changes need to be
> upstreamed somewhere? I don't understand the exact relationship between this
> file and the MinGW project.
>
> Tao Klerks (2):
>   t/helper/test-chmtime: update mingw to support chmtime on directories
>   t7063: mtime-mangling instead of delays in untracked cache testing
>
>  compat/mingw.c                    | 21 +++++++++++++++++----
>  t/t7063-status-untracked-cache.sh | 27 +++++++++++++++------------
>  2 files changed, 32 insertions(+), 16 deletions(-)
>
>
> base-commit: 4c53a8c20f8984adb226293a3ffd7b88c3f4ac1a
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1166%2FTaoK%2Ftaok-untracked-cache-testing-remote-waits-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1166/TaoK/taok-untracked-cache-testing-remote-waits-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1166
>
> Range-diff vs v1:
>
>  1:  76b6216281e ! 1:  7cdef0ad5fb t/helper/test-chmtime: update mingw to support chmtime on directories
>      @@ Commit message
>           The mingw_utime implementation in mingw.c does not support
>           directories. This means that "test-tool chmtime" fails on Windows when
>           targeting directories. This has previously been noted and sidestepped
>      -    by Jeff Hostetler, in "t/helper/test-chmtime: skip directories
>      -    on Windows" in the "Builtin FSMonitor Part 2" work.
>      +    temporarily by Jeff Hostetler, in "t/helper/test-chmtime: skip
>      +    directories on Windows" in the "Builtin FSMonitor Part 2" work, but
>      +    not yet fixed.
>
>           It would make sense to backdate file and folder changes in untracked
>           cache tests, to avoid needing to insert explicit delays/pauses in the
>           tests.
>
>      -    Add support for directory date manipulation in mingw_utime by calling
>      -    CreateFileW() explicitly to create the directory handle, and
>      -    CloseHandle() to close it.
>      +    Add support for directory date manipulation in mingw_utime by
>      +    replacing the file-oriented _wopen() call with the
>      +    directory-supporting CreateFileW() windows API explicitly.
>
>           Signed-off-by: Tao Klerks <tao@klerks.biz>
>
>        ## compat/mingw.c ##
>      -@@ compat/mingw.c: int mingw_utime (const char *file_name, const struct utimbuf *times)
>      -  int fh, rc;
>      +@@ compat/mingw.c: static inline void time_t_to_filetime(time_t t, FILETIME *ft)
>      + int mingw_utime (const char *file_name, const struct utimbuf *times)
>      + {
>      +  FILETIME mft, aft;
>      +- int fh, rc;
>      ++ int rc;
>         DWORD attrs;
>         wchar_t wfilename[MAX_PATH];
>       + HANDLE osfilehandle;
>      @@ compat/mingw.c: int mingw_utime (const char *file_name, const struct utimbuf *ti
>         }
>
>       - if ((fh = _wopen(wfilename, O_RDWR | O_BINARY)) < 0) {
>      --         rc = -1;
>      --         goto revert_attrs;
>      -+ if (attrs & FILE_ATTRIBUTE_DIRECTORY) {
>      -+         fh = 0;
>      -+         osfilehandle = CreateFileW(wfilename,
>      -+                                    0x100 /*FILE_WRITE_ATTRIBUTES*/,
>      -+                                    0 /*FileShare.None*/,
>      -+                                    NULL,
>      -+                                    OPEN_EXISTING,
>      -+                                    FILE_FLAG_BACKUP_SEMANTICS,
>      -+                                    NULL);
>      -+         if (osfilehandle == INVALID_HANDLE_VALUE) {
>      -+                 errno = err_win_to_posix(GetLastError());
>      -+                 rc = -1;
>      -+                 goto revert_attrs;
>      -+         }
>      -+ } else {
>      -+         if ((fh = _wopen(wfilename, O_RDWR | O_BINARY)) < 0) {
>      -+                 rc = -1;
>      -+                 goto revert_attrs;
>      -+         }
>      -+         osfilehandle = (HANDLE)_get_osfhandle(fh);
>      ++ osfilehandle = CreateFileW(wfilename,
>      ++                            0x100 /*FILE_WRITE_ATTRIBUTES*/,
>      ++                            0 /*FileShare.None*/,
>      ++                            NULL,
>      ++                            OPEN_EXISTING,
>      ++                            attrs & FILE_ATTRIBUTE_DIRECTORY ?
>      ++                                 FILE_FLAG_BACKUP_SEMANTICS : 0,
>      ++                            NULL);
>      ++ if (osfilehandle == INVALID_HANDLE_VALUE) {
>      ++         errno = err_win_to_posix(GetLastError());
>      +          rc = -1;
>      +          goto revert_attrs;
>         }
>      -
>      -  if (times) {
>       @@ compat/mingw.c: int mingw_utime (const char *file_name, const struct utimbuf *times)
>                 GetSystemTimeAsFileTime(&mft);
>                 aft = mft;
>      @@ compat/mingw.c: int mingw_utime (const char *file_name, const struct utimbuf *ti
>                 rc = 0;
>       - close(fh);
>       +
>      -+ if (fh)
>      -+         close(fh);
>      -+ else if (osfilehandle)
>      ++ if (osfilehandle != INVALID_HANDLE_VALUE)
>       +         CloseHandle(osfilehandle);
>
>        revert_attrs:
>  2:  a1806c56333 ! 2:  3e3c9c7faac t7063: mtime-mangling instead of delays in untracked cache testing
>      @@ t/t7063-status-untracked-cache.sh: sync_mtime () {
>         find . -type d -exec ls -ld {} + >/dev/null
>        }
>
>      -+chmmtime_worktree_root () {
>      ++chmtime_worktree_root () {
>       + # chmtime doesnt handle relative paths on windows, so need
>       + # to "hardcode" a reference to the worktree folder name.
>      -+ cd .. &&
>      -+ test-tool chmtime $1 worktree &&
>      -+ cd worktree
>      ++ test-tool -C .. chmtime $1 worktree
>       +}
>       +
>        avoid_racy() {
>      @@ t/t7063-status-untracked-cache.sh: test_expect_success 'setup' '
>         touch one two three done/one dtwo/two dthree/three &&
>       + test-tool chmtime =-300 one two three done/one dtwo/two dthree/three &&
>       + test-tool chmtime =-300 done dtwo dthree &&
>      -+ chmmtime_worktree_root =-300 &&
>      ++ chmtime_worktree_root =-300 &&
>         git add one two done/one &&
>         : >.git/info/exclude &&
>         git update-index --untracked-cache &&
>      @@ t/t7063-status-untracked-cache.sh: test_expect_success 'create/modify files, som
>       - rm base &&
>       + test-tool chmtime =-180 done/two done/three done/four done/five done &&
>       + # we need to ensure that the root dir is touched (in the past);
>      -+ chmmtime_worktree_root =-180 &&
>      ++ chmtime_worktree_root =-180 &&
>         sync_mtime
>        '
>
>
> --
> gitgitgadget
