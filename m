Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEDEC07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 17:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41D4A60FED
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 17:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238035AbhGNRNY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 13:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237893AbhGNRNX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 13:13:23 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DB1C061760
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 10:10:30 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o30-20020a05600c511eb029022e0571d1a0so1896345wms.5
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 10:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:subject:mime-version
         :content-transfer-encoding:content-disposition;
        bh=qpCVq0mLvkH9OYc3Ms7+fnlLoMDTVxMft0m9fqzdsKQ=;
        b=lsc5u2V6slPJMFh+zn/osspBWZg+OD6ziicSVyfduHRm5hsfYi+ppx8xHSXQyvFn0y
         8N3wiMtca2XDyz/nRg+gUo++JkoFzsmIy3CivOWbzqJvOQtyH5ZN2Wz1CZD7qaqeWx/R
         NUEcWZ/lOynLP+Vtx43cnKL0kIMGreW6yf7ra9g03NFAU7QZ5CT9e06I0k2d3ZBB91Mr
         y/N6UlytE/vPv/rL1Ly6Bglm43lIKvogEX5OFhgzfp1ykJfVX+2AN3q/eyJJrhvIy3LX
         0NSwDksDxRwCREnVPPg21qMJ06XLZnkN2XnxhDM0xxidoxpV4UDpbXuzXcD7Ap+TMxGy
         LAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:subject:mime-version
         :content-transfer-encoding:content-disposition;
        bh=qpCVq0mLvkH9OYc3Ms7+fnlLoMDTVxMft0m9fqzdsKQ=;
        b=dZYz1oTfwqPpx6M/9lGLpdKK4qh2EUvgp+JV35NOpc8kKFQS9jPNhdCOYjflORlo7t
         QqcB90RbnGpBdcrlaP0ARDIQOfRmireivUuk3ScUFPdtKvRmcjyQ/AgernjYhYbjBS63
         o5zgT/9m/UZkI2SSdpCkALE59aQKpylRUfc8zcdf/YCsENmddpfbOvAxjf1D7FE7DTrH
         2nEDHI6DL/Zqm1XhwxkuoUAUYMarACIflwQpXaOqjw4B/SijiQoiEVpeObDwixCy9Jpm
         reUOhFGdB50kkDW61zwAA88zqnc2rYeXFEhrulEkOSxY9UvsERESSCF1WKvqqHPTru6h
         LjoA==
X-Gm-Message-State: AOAM5316xtN/y2409LsACCkAXK1iI6iDl8PtWpUvUMZcFgTnDj5Dl8ep
        dr4+4vLUAJDf/KDEIaz+BsY2wBSPgXnsDw==
X-Google-Smtp-Source: ABdhPJxLj0XLuXsnF/0BNnCRSLEK/pbwrtXJM9nuKVpYUQl1528T5FLbEKoZRAP5UYLbGvnNjMDomg==
X-Received: by 2002:a7b:cc8d:: with SMTP id p13mr5155841wma.145.1626282628989;
        Wed, 14 Jul 2021 10:10:28 -0700 (PDT)
Received: from gec-zebradil-lenovo ([2a02:908:1347:ac20:1a08:8f6a:8172:9625])
        by smtp.gmail.com with ESMTPSA id d18sm2543989wmp.46.2021.07.14.10.10.28
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Jul 2021 10:10:28 -0700 (PDT)
Date:   Wed, 14 Jul 2021 19:10:27 +0200
From:   German Lashevich <german.lashevich@gmail.com>
To:     "=?utf-8?Q?git=40vger.kernel.org?=" <git@vger.kernel.org>
Message-ID: <1C6C1E49-5EC1-420D-A72A-8C50BD1931A2@getmailspring.com>
Subject: Bug report: GIT_CONFIG and user.email/name
X-Mailer: Mailspring
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I've faced an issue while trying to use a non-default .gitconfig file
via specifying
GIT_CONFIG environment variable.


What did you do before the bug happened? (Steps to reproduce your issue)

```
# use custom .gitconfig via GIT_CONFIG envvar:
mkdir -p /tmp/git-test/repo
cat <<EOT > /tmp/git-test/.gitconfig
[user]
    name = John Doe
    email = john@doe.me
EOT
cd /tmp/git-test/repo
git init
export GIT_CONFIG=/tmp/git-test/.gitconfig
echo Hi > readme.txt
git add readme.txt
git commit -m 'Initial commit'
```


What did you expect to happen? (Expected behavior)
Git creates a new commit.


What happened instead? (Actual behavior)
Error occurred:

```
Author identity unknown

*** Please tell me who you are.

Run

  git config --global user.email "you@example.com"
  git config --global user.name "Your Name"

to set your account's default identity.
Omit --global to set the identity only in this repository.

fatal: unable to auto-detect email address (got 'john@computer.(none)')
```


What's different between what you expected and what actually happened?
For some reason `git commit` doesn't use configuration options specified
in the
custom `.gitconfig` file.


Anything else you want to add:
`git config` shows correct values:

```
sh-5.1$ pwd
/tmp/git-test/repo
sh-5.1$ echo $GIT_CONFIG
/tmp/git-test/.gitconfig
sh-5.1$ cat $GIT_CONFIG
[user]
    name = John Doe
    email = john@doe.me
sh-5.1$ git config user.name
John Doe
sh-5.1$ git config user.email
john@doe.me
```

The same happens with git version 2.32.0.432.gabb21c7263


[System Info]
git version:
git version 2.32.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.12.15-arch1-1 #1 SMP PREEMPT Wed, 07 Jul 2021 23:35:29
+0000 x86_64
compiler info: gnuc: 11.1
libc info: glibc: 2.33
$SHELL (typically, interactive shell): /bin/zsh
