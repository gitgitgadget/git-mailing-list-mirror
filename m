Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C25C433EF
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 20:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243912AbiAEUN1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 15:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243875AbiAEUN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 15:13:26 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A511CC061245
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 12:13:25 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id t8so402361ilf.12
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 12:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from
         :subject:to:cc:content-transfer-encoding;
        bh=p5+9vKSMUyyGCFlD7mMQPGHDGvvMSv05CHc+2Gdfuws=;
        b=n9Nb+fnnyTzp+MIwWL5y0u/N4OnuTxjiM9b72rqMfpc8ZlURPWR/M7hwjZwNNPW7a+
         fbeGUNA2m9IwSB8mBw4Qco2fYI4OFlGZXj02hl4JYfnLQ8KWNSFy1So5x+vJids45qMc
         TdzxfPLSGKlD2ptLIDq/vfwGmO1vvhaLiGl0qOs+gymLc44jNXFKDCiZOxCf5E1ZRyGe
         yAXf1iH44jubeaynTUYTD/WIUbR8UNjNQOuqTeCI6FtbHC/2GnTI9cquy8iFdZyrnLSw
         MObcFALAk1LUinb8GWlR9MowlRGwXfpIix+tY+HeaV98KR5/6qYyAm8CGnNHIwyREAgt
         5ZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:subject:to:cc:content-transfer-encoding;
        bh=p5+9vKSMUyyGCFlD7mMQPGHDGvvMSv05CHc+2Gdfuws=;
        b=ifUgV0w4N/5j3JpD6sPhIFghVJI2goiDQFYgVWeA8IYRe1IXWVAw0aeFtt2zwqjX7x
         e8B/cj2lv/vwD6FBBMLZ/BKPQpvL8OWQZ/4xrUtEwBg9aLuMkrzOnyyRhinuyvoJIRRt
         4LJljjWO8JFyXMA3kg5+Mqy3iLTBuODBGc7xLUZzvM11la9Jm2WgoLQT1s2M4ywhSoPk
         SZH8DhQfLlABdAabHzbe4SfO3p69Z6ufY2D8Z5xBkKW3L/83irfTVv/UYrAr820KH8J7
         jcHQX/gxPWH2fpTq0ti9JKnmN4vblUNzN1WEzwgWuOtujkpURdKGYcBdj0NfMsmcEFtl
         Dxlg==
X-Gm-Message-State: AOAM530YHS+zncg4Vj62rbHOCdISe3lNqYiujMqwpc8gZ84Ey1pOQ/3s
        seAnI3xdoZU8gmOaVBRdwndLHwXvgcr1GI2p
X-Google-Smtp-Source: ABdhPJzpdMMLRGMhkaDdg3tt5EP4lj3aVHAQcOta4K+LrDGfArN7EWh5ZGLB5wvlbEBPMvTMqDjxug==
X-Received: by 2002:a05:6e02:15c8:: with SMTP id q8mr28529683ilu.21.1641413604788;
        Wed, 05 Jan 2022 12:13:24 -0800 (PST)
Received: from [192.168.86.121] (097-087-102-211.res.spectrum.com. [97.87.102.211])
        by smtp.gmail.com with ESMTPSA id p14sm1367063ils.54.2022.01.05.12.13.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 12:13:24 -0800 (PST)
Message-ID: <29f0410e-6dfa-2e86-394d-b1fb735e7608@gmail.com>
Date:   Wed, 5 Jan 2022 14:13:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Content-Language: en-US
From:   Lessley Dennington <lessleydennington@gmail.com>
Subject: Bug report - sparse-checkout ignores prefix when run in
 subdirectories
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone! See the following bug report pertaining to sparse-checkout
when run outside top-level directories.

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

$ git init -b main tmp
$ cd tmp
$ mkdir -p a/b/c
$ touch a/b/c/d a/b/c/e
$ git add a/
$ git commit -m "initial"
$ cd a/  # Not at the top level anymore
$ git sparse-checkout set --cone b/c
$ git -C .. sparse-checkout list

What did you expect to happen? (Expected behavior)

We expected the output sparsity path to be a/b/c.

What happened instead? (Actual behavior)

The output was b/c. Running $ cat ../.git/info/sparse-checkout
showed that the paths in this file were incorrect:
/*
!/*/
/b/
!/b/*/
/b/c/

What's different between what you expected and what actually happened?

The output path and the paths in the sparse-checkout file are missing the
expected 'a' prefix. This means that the `set` and `add` subcommands of
`sparse-checkout` can only be safely run from a repo's top-level directory.

Anything else you want to add:

This was discovered by newren@gmail.com in my recent tab-completion
series. You can find additional context at [1].

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.

[System Info]
git version:
git version 2.34.1.88.gcecf501e07.dirty (local build, based off
en/sparse-checkout-set)
cpu: x86_64
shell-path: /bin/zsh
uname: Darwin
compiler info:
Configured with: --prefix=/Library/Developer/CommandLineTools/usr
--with-gxx-include-dir=/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk
/usr/include/c++/4.2.1
Apple clang version 13.0.0 (clang-1300.0.29.3)
Target: x86_64-apple-darwin20.6.0
Thread model: posix
InstalledDir: /Library/Developer/CommandLineTools/usr/bin
$SHELL (typically, interactive shell): /bin/zsh

-Lessley

[1]: 
https://lore.kernel.org/git/CABPp-BGdr54XgCXw8k1xRCgkwBtDonyODS3O+_nS_QY3SOEFGQ@mail.gmail.com/
