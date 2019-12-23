Return-Path: <SRS0=vT7Y=2N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89C5C2D0C0
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 13:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845962073A
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 13:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfLWNOu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Dec 2019 08:14:50 -0500
Received: from gateway36.websitewelcome.com ([192.185.196.23]:48308 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726676AbfLWNOu (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Dec 2019 08:14:50 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id C409140157EA2
        for <git@vger.kernel.org>; Mon, 23 Dec 2019 06:02:34 -0600 (CST)
Received: from gator4087.hostgator.com ([192.185.4.99])
        by cmsmtp with SMTP
        id jNBEiyxy94kpjjNBEiVkXd; Mon, 23 Dec 2019 06:51:24 -0600
X-Authority-Reason: nr=8
Received: from mail-qk1-f177.google.com ([209.85.222.177]:34941)
        by gator4087.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <xda@abalgo.com>)
        id 1ijNBE-001F6q-CE
        for git@vger.kernel.org; Mon, 23 Dec 2019 06:51:24 -0600
Received: by mail-qk1-f177.google.com with SMTP id z76so13781486qka.2
        for <git@vger.kernel.org>; Mon, 23 Dec 2019 04:51:24 -0800 (PST)
X-Gm-Message-State: APjAAAWOn2i7+s8Aj0+I5uP3pXmfcm/X1FKW+ynwBs1Oaeb/lTayC5OH
        25/7NjJ5yD97/TusrLPOux6RQAfm7MCAn7BxOEA=
X-Google-Smtp-Source: APXvYqx9Yxo0t6ZdV2pWDM+CQTme7p2XsqR4WoDz3DMHCW2lEznb1Q9YMb3IAiHYNNV2qiKezH2R62MxJnKa6guTBGw=
X-Received: by 2002:a05:620a:91c:: with SMTP id v28mr25338174qkv.248.1577105483868;
 Mon, 23 Dec 2019 04:51:23 -0800 (PST)
MIME-Version: 1.0
From:   Arnaud Bertrand <xda@abalgo.com>
Date:   Mon, 23 Dec 2019 13:51:12 +0100
X-Gmail-Original-Message-ID: <CAEW0o+gYqWT5u-Tf8aDoMgXaf36Mb-XOApLNs4D+GMVLvsOjxg@mail.gmail.com>
Message-ID: <CAEW0o+gYqWT5u-Tf8aDoMgXaf36Mb-XOApLNs4D+GMVLvsOjxg@mail.gmail.com>
Subject: Mismatch meaning between git-diff and git-log for the .. (double dot
 notation) and ... (triple dot notation)
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4087.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - abalgo.com
X-BWhitelist: no
X-Source-IP: 209.85.222.177
X-Source-L: No
X-Exim-ID: 1ijNBE-001F6q-CE
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: mail-qk1-f177.google.com [209.85.222.177]:34941
X-Source-Auth: abalgo
X-Email-Count: 3
X-Source-Cap: YWJhbGdvO2FiYWxnbztnYXRvcjQwODcuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Git Version 2.24.0.windows.2

Summary:
triple dots
git diff L...R -- foo    <=> diff between CommonAncestror(L,R) to R
git log L...R            <=> all commit from L to R

double dots
git diff L..R -- foo    <=> diff between L and R
git log L..R            <=> commit from CommonAncestror(L,R) to R

So, to make the command related to the common ancestor, git diff uses
the triple dots notation  by opposite to git log that uses the double
dots notation



In details
------------
#######################################################
The ... (triple dots notation)
In the diff context, the triple dots notation is related to the common
ancestror:

git diff L...R -- foo

means diff between (common ancestor of L and R) and R
is equivalent to:

git diff $(git merge-base L R) R -- foo

But now, if I use the same notation for git log, it means all the
commit that differ from L to R

Example, you can execute the following lines:

mkdir test
cd test
git init
echo common > foo
git add foo
git ci -m "add common part"
git switch -c L
echo LeftPart >> foo
git ci -am "add a left part"
git switch master
git switch -c R
echo "right part" >> foo
git ci -am "add a right part"
git switch master
git diff L...R -- foo


And verify:
$ git diff L...R -- foo
diff --git a/foo b/foo
index 30e1159..2570fa8 100644
--- a/foo
+++ b/foo
@@ -1 +1,2 @@
 common
+right part


As expected, only the right part appears.

 and now with the log:
$ git log --oneline --left-right L...R
> f2f11c4 (tag: R) R: add a right part
< 7f4f3d6 (tag: L)  L: add a left part

The log that concers the left part appears too!

##################################################################

If now we consider the .. (double dots notation), it is exactly the opposite!
$ git diff L..R -- foo
diff --git a/foo b/foo
index 6f2cf25..2570fa8 100644
--- a/foo
+++ b/foo
@@ -1,2 +1,2 @@
 common
-LeftPart
+right part


It is clear that both branches differences appear

and with git log:
$ git log --oneline --left-right L..R
> f2f11c4 (tag: R) R: add a right part

For the log, only the commit from the common ancestror to R appear !

So there is well an incoherence between diff and log using the
multi-dots notation


Best regards,

Arnaud Bertrand
