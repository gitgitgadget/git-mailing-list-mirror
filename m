Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A35C433F5
	for <git@archiver.kernel.org>; Sat,  5 Mar 2022 04:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbiCEEZE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 23:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiCEEZD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 23:25:03 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10187532CF
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 20:24:14 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id gb39so21294644ejc.1
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 20:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AhF1S88GJuIYWbi0dHmjoiXLZcrBf0eJW/1w1EeFC+Y=;
        b=sxAgJtYzEEEoLtSPNBQvdd0H3qwGOtQ2MvlwVDUuMYuLSwbOsJ/BCrH9peZigWWR/2
         97/uPDFiGEf9PgXCsajKRXro8ZsglPjEEEhYYXczOLH1n1ovTtmfnJ9JaRzRE2OqbiTs
         TNs7bmx2sg8fl81zyzq9ofFSSWOCu93OCphKK5G/7QWPtAp6c/g7BcD5k4cLLXga4sbf
         6wQRdj+1YdT+/2YeBaUSkbI71UE0ffS1alGtx2tIf/UqPfcd/r6DBlRsK2muH2zUZ7me
         yq+p5SFkmZtKLJXGpbsUi1sRRiW6ois/eTwbekPAi6G7dJfs2+ufNpDjN1Mz7x6FBOs6
         MZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AhF1S88GJuIYWbi0dHmjoiXLZcrBf0eJW/1w1EeFC+Y=;
        b=MIW0wX8oHGmcDXP8hcTB33CVeTz8TEg7iiY44V/eq8sFNnmbGPicizFq37aRWvqVt5
         yTSIkb2UylRz38826XgWYlJg0UPETsx2+uOFn1ZZUKegivknf4qNU1L4j/XbFTXgmBbm
         rwbnOh+wSr2pidE+kDhTQKN45xST2OkSv5FgzMICOgmsp+aASiRYd51gkveTUojACaYh
         pVmj1LG8rSKo0gidf0+RRgRs3Gpu1DbtFNyACu/SjkcVdmgnvxUXUpAI29PH7WxCWLuM
         TiQgzcmtUy6hUMZ4oqAZWThSvZlvjQuF72P1DiGtt1R7yzKAFkrX8H60LybJQ0YwW2+s
         n5sA==
X-Gm-Message-State: AOAM53024E7evOjbQRFosFiSXe5kB4KWXexHI8jXSiAEz5z+HPwxLoAm
        f66QO83SjsEssjZZXH8vtdKZwPJ5KHZ2UW/NFa8nW5gn8BrK0dFg
X-Google-Smtp-Source: ABdhPJxnBkp7MKmnEvtv8oV+3KWWLGsVbUNm+G7MD7HQUqFpbQliniy0c5Ma8APbqYOhx5sHAc6sbGfympQVPiuGBKw=
X-Received: by 2002:a17:906:4ad9:b0:6cf:93f:f77e with SMTP id
 u25-20020a1709064ad900b006cf093ff77emr1527180ejt.558.1646454252507; Fri, 04
 Mar 2022 20:24:12 -0800 (PST)
MIME-Version: 1.0
References: <pull.1166.v2.git.1646127910.gitgitgadget@gmail.com> <pull.1166.v3.git.1646201124.gitgitgadget@gmail.com>
In-Reply-To: <pull.1166.v3.git.1646201124.gitgitgadget@gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Sat, 5 Mar 2022 05:24:01 +0100
Message-ID: <CAPMMpogoVzHBh8j4GZG-tRpAxap4wY+hAray5V_QUcaNpf7dEQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Reduce explicit sleep calls in t7063 untracked
 cache tests
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

I see that in the latest "what's coming" update, this patch series is
listed as expecting reroll, but as far as I can see there have been no
comments since I sent this V3 out.

What should be my next step, if I think this is "as ready as I know to
get it" without any comments on the latest submission?

Thanks,
Tao

(Apologies to recipients of duplicate email in cc, I accidentally sent
html email that the list rejected)

On Wed, Mar 2, 2022, 07:05 Tao Klerks via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Replace sleep calls with backdating of filesystem changes, but first fix the
> test-tool chmtime functionality to work for directories in Windows.
>
> In this third version, a bug with inaccessible-path-handling that Jeff found
> is fixed, and a relative-path-avoiding strategy that had been added in t7073
> is simplified out after Junio's comments revealed it was misguided.
>
> Tao Klerks (2):
>   t/helper/test-chmtime: update mingw to support chmtime on directories
>   t7063: mtime-mangling instead of delays in untracked cache testing
>
>  compat/mingw.c                    | 23 +++++++++++++++++++----
>  t/t7063-status-untracked-cache.sh | 21 +++++++++------------
>  2 files changed, 28 insertions(+), 16 deletions(-)
>
>
> base-commit: 4c53a8c20f8984adb226293a3ffd7b88c3f4ac1a
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1166%2FTaoK%2Ftaok-untracked-cache-testing-remote-waits-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1166/TaoK/taok-untracked-cache-testing-remote-waits-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/1166
>
> Range-diff vs v2:
>
>  1:  7cdef0ad5fb ! 1:  052b3dd9bba t/helper/test-chmtime: update mingw to support chmtime on directories
>      @@ compat/mingw.c: int mingw_utime (const char *file_name, const struct utimbuf *ti
>
>       - if ((fh = _wopen(wfilename, O_RDWR | O_BINARY)) < 0) {
>       + osfilehandle = CreateFileW(wfilename,
>      -+                            0x100 /*FILE_WRITE_ATTRIBUTES*/,
>      ++                            FILE_WRITE_ATTRIBUTES,
>       +                            0 /*FileShare.None*/,
>       +                            NULL,
>       +                            OPEN_EXISTING,
>      -+                            attrs & FILE_ATTRIBUTE_DIRECTORY ?
>      ++                            (attrs != INVALID_FILE_ATTRIBUTES &&
>      ++                                 (attrs & FILE_ATTRIBUTE_DIRECTORY)) ?
>       +                                 FILE_FLAG_BACKUP_SEMANTICS : 0,
>       +                            NULL);
>       + if (osfilehandle == INVALID_HANDLE_VALUE) {
>      @@ compat/mingw.c: int mingw_utime (const char *file_name, const struct utimbuf *ti
>                 aft = mft;
>         }
>       - if (!SetFileTime((HANDLE)_get_osfhandle(fh), NULL, &aft, &mft)) {
>      ++
>       + if (!SetFileTime(osfilehandle, NULL, &aft, &mft)) {
>                 errno = EINVAL;
>                 rc = -1;
>  2:  3e3c9c7faac ! 2:  dceb2857609 t7063: mtime-mangling instead of delays in untracked cache testing
>      @@ Commit message
>           Signed-off-by: Tao Klerks <tao@klerks.biz>
>
>        ## t/t7063-status-untracked-cache.sh ##
>      -@@ t/t7063-status-untracked-cache.sh: sync_mtime () {
>      -  find . -type d -exec ls -ld {} + >/dev/null
>      - }
>      -
>      -+chmtime_worktree_root () {
>      -+ # chmtime doesnt handle relative paths on windows, so need
>      -+ # to "hardcode" a reference to the worktree folder name.
>      -+ test-tool -C .. chmtime $1 worktree
>      -+}
>      -+
>      - avoid_racy() {
>      -  sleep 1
>      - }
>       @@ t/t7063-status-untracked-cache.sh: test_expect_success 'setup' '
>         cd worktree &&
>         mkdir done dtwo dthree &&
>         touch one two three done/one dtwo/two dthree/three &&
>       + test-tool chmtime =-300 one two three done/one dtwo/two dthree/three &&
>       + test-tool chmtime =-300 done dtwo dthree &&
>      -+ chmtime_worktree_root =-300 &&
>      ++ test-tool chmtime =-300 . &&
>         git add one two done/one &&
>         : >.git/info/exclude &&
>         git update-index --untracked-cache &&
>      @@ t/t7063-status-untracked-cache.sh: test_expect_success 'create/modify files, som
>       - rm base &&
>       + test-tool chmtime =-180 done/two done/three done/four done/five done &&
>       + # we need to ensure that the root dir is touched (in the past);
>      -+ chmtime_worktree_root =-180 &&
>      ++ test-tool chmtime =-180 . &&
>         sync_mtime
>        '
>
>
> --
> gitgitgadget
