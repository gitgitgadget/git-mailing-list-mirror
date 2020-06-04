Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D193FC433E0
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 23:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99214206C3
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 23:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhOHMo4f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbgFDXd3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 19:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgFDXd3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 19:33:29 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A6AC08C5C0
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 16:33:29 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id v15so3831243ybk.2
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 16:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=InN3v82yNreGdGV6MSVKjmxgMLpl2kJG91DQ2djUf8M=;
        b=bhOHMo4fOOFsu2ezGmf7HTh5x/C9brtIZoACywplXNykaIxiiEiArRuKUipOr1T8b9
         umf4zpy7LZ1OpRPg7CyBH3TnVvg48/NVLO4L+uMpdFeErLViArxy9SgWCCCENxHWtvyj
         nqiZwaCYB2gOGKta8kswD/g8UMHfW1xioAtB6pQF6LFG0SuYUsn95LRaLKLOxb1e/MzP
         NXXtMicOMcNAbIR/qv99/p3TXN8zRUdszL6Xjb2e1xc/IYamxZz6jq3sbA4w4xPiA33O
         Gwo0Tl2cc3019DP5NO4pzlmgC/2uy222FFQSWvY37VEkmjP6Ln0fR1ptnyvAcizSHklg
         FphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=InN3v82yNreGdGV6MSVKjmxgMLpl2kJG91DQ2djUf8M=;
        b=lNsX3nMJfYIx1IsAEcV3ndWWKbqjXa0bVPe/1xRcNHQvpBvX0YAXpmm5YnjYVkxe3e
         qmlunDJkfMtRXsZTx5iaPMHLkEv2w9+BVmCPQsCU+AHY4fKrB61B7oGhb3DD8uSlfQ6N
         gWkOdoRFjNi+KV5GfOZaroeIx/Gt5inI/8sboqO8ATBPD1Hibbsb6mrWc7Hkk2zAHZXx
         i/KLBz9dpWJfPnDBCcUzuvG88l9Sg/lFoU/rk1m15g3WpZ2b8h32RTz7vQZueN7k8hJy
         P/MkOG1NHJd7TPoCZ2WBD+Ixcjt5fesfiZuztU6pbXt8JrvpdEToo5fOMfNIvCRzFg7W
         IBPg==
X-Gm-Message-State: AOAM531/1Y3QZi0ffhBS6cC/EIhm04S1sVzuuIB8E5OhfLPhnUGOQB4Q
        f/OQ7CkpJI1iM3witGaLoJjlQtwXUlXFfZvfcllYkbot04A=
X-Google-Smtp-Source: ABdhPJx4fqfsurIuxxgluH+UbEQoVSNAdkTTRHlEs7uKlSy5ePb3yYOKVJHoPXeb7ML9aEkZChFNEWoQZqLQz59AEpY=
X-Received: by 2002:a05:6902:1007:: with SMTP id w7mr6795854ybt.217.1591313606749;
 Thu, 04 Jun 2020 16:33:26 -0700 (PDT)
MIME-Version: 1.0
From:   Steven Penny <svnpenn@gmail.com>
Date:   Thu, 4 Jun 2020 18:33:16 -0500
Message-ID: <CAAXzdLXt4+-34+OhS=Jn=-VeORN3Y2jMzzg9+bhyn88aN4hm0A@mail.gmail.com>
Subject: Change Native Windows shell
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The Git pager is set up by the function `setup_pager` [1]. `setup_pager` calls
`prepare_pager_args` [2]. `prepare_pager_args` sets `use_shell` [3]. Then
`setup_pager` calls `start_command` [4]. Then, since `use_shell` has been
defined, `prepare_shell_cmd` is called [5]. Finally, regardless of operating
system, `sh` is called [6]:

    #ifndef GIT_WINDOWS_NATIVE
                    argv_array_push(out, SHELL_PATH);
    #else
                    argv_array_push(out, "sh");
    #endif
                    argv_array_push(out, "-c");

The issue is, that it is possible to build a fully static native Windows
Git [7]. A Git like this can run on a stock Windows system, with no requirement
on MSYS2 or Cygwin. So it doesnt make sense for Git to be calling `sh`, when a
user may not have or need `sh` on their system. I think that on Native Windows
builds, that the Pager should be called directly, or if a shell must be used,
then make it `cmd.exe` or `powershell.exe`.

1. https://github.com/git/git/blob/20514004/pager.c#L106
2. https://github.com/git/git/blob/20514004/pager.c#L127
3. https://github.com/git/git/blob/20514004/pager.c#L101
4. https://github.com/git/git/blob/20514004/pager.c#L130
5. https://github.com/git/git/blob/20514004/run-command.c#L928
6. https://github.com/git/git/blob/20514004/run-command.c#L272-L277
7. https://github.com/nu8/gulf/blob/e9ea5c0b/chapter-2/program.sh
