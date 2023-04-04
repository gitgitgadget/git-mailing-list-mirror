Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80D0C761A6
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 10:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbjDDKFD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 06:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234383AbjDDKE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 06:04:58 -0400
X-Greylist: delayed 361 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Apr 2023 03:04:52 PDT
Received: from server43.webgo24.de (server43.webgo24.de [185.30.32.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FB32D64
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 03:04:52 -0700 (PDT)
Received: from earendil.localnet (dynamic-089-013-004-129.89.13.pool.telefonica.de [89.13.4.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by server43.webgo24.de (Postfix) with ESMTPSA id A3D0141106D7
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 11:58:49 +0200 (CEST)
From:   Thorsten Otto <admin@tho-otto.de>
To:     git@vger.kernel.org
Subject: "git diff" does not show a diff for newly added, binary files
Date:   Tue, 04 Apr 2023 11:58:38 +0200
Message-ID: <3473764.PTxrJRyG3s@earendil>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git diff" does not show a diff for newly added, binary files

What did you do before the bug happened? (Steps to reproduce your issue)

$ git init .
$ touch a
$ git add a
$ git commit -m "first commit"
$ dd if=/dev/zero of=b count=1
$ git add b
$ echo hello > c
$ git add c
$ git diff --cached

What did you expect to happen? (Expected behavior)

I expected a binary diff for the new file, just like it is done
when comparing two different, already committed revisions.

What happened instead? (Actual behavior)

The "git diff" command only showed a diff for the text file c, 
but not for the binary file b:

diff --git a/b b/b
new file mode 100644
index 0000000..a64a5a9
Binary files /dev/null and b/b differ
diff --git a/c b/c
new file mode 100644
index 0000000..ce01362
--- /dev/null
+++ b/c
@@ -0,0 +1 @@
+hello

[System Info]
git version:
git version 2.39.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.1.3-1-default #1 SMP PREEMPT_DYNAMIC Wed Jan  4 11:03:53 UTC 
2023 (a5315fb) x86_64
compiler info: gnuc: 12.2
libc info: glibc: 2.36
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]



