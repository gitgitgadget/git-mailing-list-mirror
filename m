Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4FBC28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 22:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238237AbiHVWPV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 18:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbiHVWPU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 18:15:20 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C06402ED
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 15:15:19 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id h21so9080753qta.3
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 15:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:to:from:to:cc;
        bh=5SGNiHlPtBp/x6TyA0gUIUbb7pxont4oSA+WfxrM6BM=;
        b=PxSmydsvM/wG+jRnR4PQROnooxKMQZoMTqBIKdbwkIFVMnB8qxjSDo6EeNcUAeTIdg
         C2tpAd3DdOl7ojgGh1a0ZQsHebEQKdnJVJCGpzKsXbcbHUH8/PN3EASdNOQjSPq43lGH
         WeYT+IAU6qfCy+zJtKSiD2ye3VtKVvZLINzaNJD5z2Dj55lUuflBETAvkBuejysgeIkN
         SFmtV7SEEi6sVyD70y5Qlugit3v9gAZKcy5O+hDxTnwEKnG8TpNHHaeLa+UYTHg7n+VV
         V42zpNTaWWfaUWLiJJ0yzfEh8qnLgBoU0Bz+M5mmz4nc8rFL2SEr4JGXKtvUmqGo6mBP
         zdvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:to:x-gm-message-state:from:to:cc;
        bh=5SGNiHlPtBp/x6TyA0gUIUbb7pxont4oSA+WfxrM6BM=;
        b=wlzZ6j3vJApg6tGoFX4IPDsKTQGeyAxyicCFtwwOCFAhg6Ic0Rka1UBIpTCrZrLpvB
         SBcrdAn9nOnSyKtQpfA/s4iElx6MvevkhO/B2BYytQZRaLNZEcgqacWwcNDggVN94eBy
         2jya80duXrgyjPBdBezH+NT721Yy3hEzryPF8y0S2n3qc4mDeQNqzEUXdLq8QuxRs4qU
         fxX5NXx3DquLkI1ZDQjpUstlNZqAJ7G8QLoifFRkHnh9sI7DYEb3ZPKDCB5TvRuEsPqQ
         UJSSU8GZHLEwc6Fg6HK4UNGdPfSHFfbzn4YhRa0DYaVNxleaMIxECdHmy8AsXDjt09ss
         3vkg==
X-Gm-Message-State: ACgBeo1C+/7f+czd+qCBFsRY+wBAys3yOmK8CZQXoDpJfpetVDLvqq7t
        vXcfYmuvAROCUGPtEwcvqwiNy9MUXkk=
X-Google-Smtp-Source: AA6agR5gPu/Ms23EjX40P0VsKRmCf+zxpP5KC6fik8AUSaxBZxkkiWw10FNoUYvAz1QWMIkjb5JwHg==
X-Received: by 2002:a05:622a:451:b0:344:ad2f:692c with SMTP id o17-20020a05622a045100b00344ad2f692cmr9842468qtx.604.1661206518468;
        Mon, 22 Aug 2022 15:15:18 -0700 (PDT)
Received: from [192.168.1.128] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id n1-20020ac86741000000b0031eebfcb369sm9370437qtp.97.2022.08.22.15.15.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 15:15:17 -0700 (PDT)
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git mailing list <git@vger.kernel.org>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Regression in 'git add -p' with 'interactive.diffFilter' since
 builtin version is default
Message-ID: <ecf6f5be-22ca-299f-a8f1-bda38e5ca246@gmail.com>
Date:   Mon, 22 Aug 2022 18:15:16 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

I found a regression in the builtin 'add -i'. I use diff-so-fancy [1]
as a pager and also use it via 'interactive.diffFilter'. With the 
builtin implementation, this errors with:

    error: could not parse colored hunk header '?[36m?[1m?[38;5;13m@ file:1 @?[1m?[0m'

With the Perl version, it works fine.

This has been reported in the 'diff-so-fancy' project here: [2].

Here is a reproducer:

~~~bash
#!/bin/bash

set -euEo pipefail

repo=repro
rm -rf $repo

TEST_AUTHOR_LOCALNAME=author
TEST_AUTHOR_DOMAIN=example.com
GIT_AUTHOR_EMAIL=${TEST_AUTHOR_LOCALNAME}@${TEST_AUTHOR_DOMAIN}
GIT_AUTHOR_NAME='A U Thor'
GIT_AUTHOR_DATE='1112354055 +0200'
TEST_COMMITTER_LOCALNAME=committer
TEST_COMMITTER_DOMAIN=example.com
GIT_COMMITTER_EMAIL=${TEST_COMMITTER_LOCALNAME}@${TEST_COMMITTER_DOMAIN}
GIT_COMMITTER_NAME='C O Mitter'
GIT_COMMITTER_DATE='1112354055 +0200'
export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
export HOME=

git -c init.defaultBranch=unimportant init $repo
cd $repo
date>file
git add file
git commit -m file
git clone https://github.com/so-fancy/diff-so-fancy.git
date>>file
export PATH="diff-so-fancy:$PATH"
git -c interactive.diffFilter="diff-so-fancy --patch" -c add.interactive.useBuiltin=false add -p < <(echo y)
date>>file
git -c interactive.diffFilter="diff-so-fancy --patch" add -p
~~~

Cheers,

Philippe.

[1] https://github.com/so-fancy/diff-so-fancy
[2] https://github.com/so-fancy/diff-so-fancy/issues/437
