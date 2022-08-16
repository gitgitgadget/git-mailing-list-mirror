Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A20C25B0E
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 16:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235815AbiHPQRE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 12:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbiHPQRD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 12:17:03 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20FB76772
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 09:17:02 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id f22so14123533edc.7
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 09:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=MabdYlHpYpmmjFNrLNV9eA3PdBQNfz26EMt6P+kGakg=;
        b=okspnQfp+c1OIifylWMVC/+T3fFoSW+SSaDHiLFoh8tT6JrSgQa7/Trkd9XFJcKEhC
         g+a2WL4r68qU+zxP2TSYZ6YvBJ+7IJ5cuJv8DjhmN5NZ0FTLd0+v1/mnarLAC3gnp7J6
         e9NJWs6FACO7BMnNyh1j//IaFfp9uTvtEgJJtuvej8OYdwSqrJOA8pTslL0LOctlBBhV
         4riLHty7VmPyKoSm+NGN7k0EDlu1q50CrhRCNDSZDbWywOo1oexXlMCYMVsXNjD4U108
         fSSJUZ6I6pmURwnmkY9yhFKTS5hgjzKy09SoVdfOf8URnr+RdTlGdvgSKzhf7wfTTqzo
         86qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=MabdYlHpYpmmjFNrLNV9eA3PdBQNfz26EMt6P+kGakg=;
        b=Sc2uzXlO7hJP1pGoHBruB4B/qzJQWZhDi06Rdzg9v8mxSJ2TdsjWXCLvR6WTn+UgnA
         SRsxrxwEChjCEuQRz7CQr1qkVpTtROee3we7dWrStXXJ+cHtlyadYYjSsBtm8xiLRQM+
         Ud7EjCQNv7CFAdehOS45JQCyJRB6TZIQzl0SH7XTrglkvkgzV6oNEfadNheIXkHWDvri
         ivr1lz3ObeXwrZI6xoVX7nYR6WdX+ppcfcF2XIUxrgC9xDhiBlIAs6EyUGU4WlEyVbCy
         e0JVVTGopTN8kKpnOvnvFhw6q9qAvKv3Wj1mCW7MaK1enhNeWYJa7lTFUbi6NAobcz1z
         HeUQ==
X-Gm-Message-State: ACgBeo3l0D89jtz4G9EqmEY+vyrT1fp3tWyqJFqtIhUe5gW/zTioUVpv
        KfH/qdAYCNW/xNo1Gs10URsUAD8tinQ2+BNw1hKRNWuMCP8=
X-Google-Smtp-Source: AA6agR7APR9KbyorPG9gFMuhsHUmog5pTm4wC+LIZYUI9gWldU1PS28ACK9aoHW429dmuwVj9YRcTEivx1Z4paQUGCs=
X-Received: by 2002:a05:6402:4247:b0:43d:f253:6577 with SMTP id
 g7-20020a056402424700b0043df2536577mr19821104edb.222.1660666620471; Tue, 16
 Aug 2022 09:17:00 -0700 (PDT)
MIME-Version: 1.0
From:   Jinwook Jeong <vustthat@gmail.com>
Date:   Wed, 17 Aug 2022 01:16:44 +0900
Message-ID: <CAA3Q-aYfn0om2tXjwH-9ayaX57Yj6xkKw1hpi2asthgHvWovsw@mail.gmail.com>
Subject: bugreport: "git config --global" fails if an invalid .git file present
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)

Executing `git config --global ...` and $PWD/.git exists as a file and
is invalid.

What did you expect to happen? (Expected behavior)

Git reads from or writes to the global config store.

What happened instead? (Actual behavior)

It prints:
  fatal: invalid gitfile format: $PWD/.git

What's different between what you expected and what actually happened?

Git fails to access the global config even if the current directory's
`.git` file has nothing to do with the global config.

[System Info]
git version:
git version 2.37.2
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 21.6.0 Darwin Kernel Version 21.6.0: Sat Jun 18 17:07:22
PDT 2022; root:xnu-8020.140.41~1/RELEASE_ARM64_T6000 arm64
compiler info: clang: 13.1.6 (clang-1316.0.21.2.5)
libc info: no libc information available
$SHELL (typically, interactive shell): /opt/homebrew/bin/bash


[Enabled Hooks]
not run from a git repository - no hooks to show
