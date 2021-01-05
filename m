Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230F1C433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 18:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDBFC22D57
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 18:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbhAESQX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 13:16:23 -0500
Received: from thunix.net ([188.40.73.235]:41712 "EHLO thunix.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbhAESQX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 13:16:23 -0500
X-Greylist: delayed 491 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Jan 2021 13:16:22 EST
Received: by thunix.net (Postfix, from userid 1080)
        id EAAA6334005B; Tue,  5 Jan 2021 13:07:27 -0500 (EST)
Date:   Tue, 5 Jan 2021 13:07:27 -0500
From:   southerntofu@thunix.net
To:     git@vger.kernel.org
Subject: Bug: permissions problem when recursively cloning from a suid program
Message-ID: <X/Sq38YKmLjY4KmD@thunix.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)

Hi, i tried to clone a repository with submodules from a program running with the suid/guid bit set.

What did you expect to happen? (Expected behavior)

It should clone the repository, with the submodules, with permissions from the owner of the suid program.

What happened instead? (Actual behavior)

git fails with a permissions error:

```
error: could not lock config file /path/to/.git/config: Permission denied
fatal: Failed to register url for submodule path
```

What's different between what you expected and what actually happened?

Cloning failed when fetching submodules (--recursive). However, it only works without submodules.

Anything else you want to add:

I could reproduce the bug on the next branch. I have a small reproduction case. It's a rust program, but the code is a bit more convoluted so it works without any dependency (just the standard library). Reproduction instructions in the repository:

https://tildegit.org/southerntofu/testsuid

[System Info]
git version:
git version 2.30.0.284.gd98b1dd5ea
cpu: x86_64
built from commit: d98b1dd5eaa7327399716162c746c9bd3cac3866
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
[REDACTED]
$SHELL (typically, interactive shell): /bin/bash
