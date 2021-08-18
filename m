Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58B3C432BE
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 18:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8A2C610FD
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 18:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbhHRSZM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 14:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbhHRSZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 14:25:09 -0400
X-Greylist: delayed 299 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 Aug 2021 11:24:31 PDT
Received: from host1.jankratochvil.net (host1.jankratochvil.net [IPv6:2a02:2b88:6:3b57::1f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E7DC061764
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 11:24:31 -0700 (PDT)
Received: from host1.jankratochvil.net (localhost [127.0.0.1])
        by host1.jankratochvil.net (8.16.1/8.16.1) with ESMTPS id 17IIJT5R3138475
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 20:19:29 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 host1.jankratochvil.net 17IIJT5R3138475
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jankratochvil.net;
        s=default; t=1629310769;
        bh=71QgITUIhZCorLwdQtkiL/LCCh38GPK6bqfVePQ0HT8=;
        h=Date:From:To:Subject:From;
        b=LT1XRVL+riQlajedshHIf2Yd4eWlpWFiDGlGG9KfbpYoiOVcDeCRWY2Spr2BGP3c0
         MjRUn5kWMNCxbSq2MC3dTurrX+OKJSay3lqcCLdsTDnXYlc4bDVuCqX/WnjoH6OBsn
         gFqOqky9CX2pCNKPO5OIlR7DlJQMoH4B2ljDpWOg=
Received: (from lace@localhost)
        by host1.jankratochvil.net (8.16.1/8.16.1/Submit) id 17IIHNTh3136115
        for git@vger.kernel.org; Wed, 18 Aug 2021 20:17:23 +0200
Date:   Wed, 18 Aug 2021 20:17:23 +0200
From:   Jan Kratochvil <jan@jankratochvil.net>
To:     git@vger.kernel.org
Subject: bugreport: git apply -3 confusing "lacks the necessary blob"
Message-ID: <YR1OszUm08BMAE1N@host1.jankratochvil.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
git apply -3 b.diff

What did you expect to happen? (Expected behavior)
<<<<<<< ours
c
||||||| base
a
=======
b
>>>>>>> theirs

What happened instead? (Actual behavior)
error: patch failed: x:1
error: repository lacks the necessary blob to fall back on 3-way merge.
error: x: patch does not apply

What's different between what you expected and what actually happened?
The conflicting patch has not been applied to resolve it manually.

Anything else you want to add:
The problem is 'git apply -3' will print confusing "lacks the necessary blob"
message despite the real error message should be:
"b.diff is missing line starting with 'index', cannot apply by -3/--3way"

reproducer:
(set -ex;: rm -rf gitgit;mkdir gitgit;cd gitgit;git init;echo a >x;git add x;git commit -am.;git checkout -b b;echo b >x;git commit -am.;git checkout master;echo c >x;git commit -am.;git diff master^..b|grep -v ^index >b.diff;git apply -3 b.diff || cat b.diff)

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.31.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.12.11-300.fc34.x86_64 #1 SMP Wed Jun 16 15:47:58 UTC 2021 x86_64
compiler info: gnuc: 11.0
libc info: glibc: 2.33
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
not run from a git repository - no hooks to show
