Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385B8C77B7F
	for <git@archiver.kernel.org>; Wed,  3 May 2023 20:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjECUtA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 16:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjECUs7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 16:48:59 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F71D7AB2
        for <git@vger.kernel.org>; Wed,  3 May 2023 13:48:58 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50bc4bc2880so6842524a12.2
        for <git@vger.kernel.org>; Wed, 03 May 2023 13:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683146936; x=1685738936;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6J13ENc6JPFEp8c/w6/QF1v1q0LXLLC2y30hdtgtKds=;
        b=eRdXTxLmCysma8Qs1BRNCow+A5QmOaQPDOzmpBMxohQsjgdPZTe+C6EYVfOU0U3/Rj
         SnbyNUVQvajEBJMKqQTpH5+Axq6jg/czyR5zJVikLOnjtY9dNDlvzG6EXMZk4ANySVeP
         ZfLTKxqRYJpI3LoT9ksT68ZP360LFKvWEdJhDMzA5JOptPRplJqmqO8+2tJjgObUvwLM
         xSYHfgEVakiSDMH1uqzCZ+ArwfgYlxZo7L/60KWNgcoHa5NtmbhTrp+gGgAqfy3tbBqr
         ImhRMT2WN55A79OwHeAZIva4MmLGqjtfC8rUtkkeLt/Dy2Cky/47WX2DGmvHsOR6LW/S
         isew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683146936; x=1685738936;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6J13ENc6JPFEp8c/w6/QF1v1q0LXLLC2y30hdtgtKds=;
        b=h6htDr9m3FT8QSs6Vb2jnsJyp+WS66b03WdkRb0OkNvbabByPANPQNJUW3gl8HOEWa
         j21ic3l6URGX01b9cj5FKux6s+9w5vY0Q/MnzXcLnfE66+sPTXqvbtb80jrgYibfzN3y
         fihUZHpbCxuVskcIhiT15GXIkk9AB55NiJjIbUFHCq0oh0da3EJQv+FXHLiV7RYc3CC+
         GMHbTUUAtrb6pCWr9I0ewvlfBniC5ERNgbxbQl7K6fb6R+nZy2FAjkK67lDMvW+f9pIc
         1eZM3J/H2GIDu0tcVUJqzpZI9Z5YBnmonQXBx7Z4+JfvZlqs3JAslQqBys4m4WMwbRBG
         MnAw==
X-Gm-Message-State: AC+VfDynxc62l/Av+k0ZbwdSnFpgTlwtOaE4gECL5sdoCQFd2HXWdW9C
        Rbiwxt7y0Jr2OGHXDyOsiRsvmh56Y68=
X-Google-Smtp-Source: ACHHUZ6S0ltfmFPMe39c9Th3XHcTbyduvTBlu04fvpKoQtgOqzkmq+gz8x3Z6zR/p1Q5ySNXQGplsQ==
X-Received: by 2002:a05:6402:b04:b0:50b:cae1:d4b2 with SMTP id bm4-20020a0564020b0400b0050bcae1d4b2mr6473933edb.38.1683146936084;
        Wed, 03 May 2023 13:48:56 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:515:f01:c45c:4d31:96d3:b3ce])
        by smtp.gmail.com with ESMTPSA id f22-20020a056402069600b0050bd4b8ca8fsm1084315edy.14.2023.05.03.13.48.55
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 May 2023 13:48:55 -0700 (PDT)
From:   Lukas Tenbrink <lukastenbrink@gmail.com>
X-Google-Original-From: Lukas Tenbrink <lukas.tenbrink@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: git diff -U0 header off-by-one error when deleting no lines
Message-Id: <B097ECB7-1976-40FC-B91D-A60D648F973B@gmail.com>
Date:   Wed, 3 May 2023 22:48:44 +0200
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3731.500.231)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

Full reproduction:

echo "A\nB\nC" > test1
echo "A\nB\nC\nD\nE\nF" > test2
git diff -U0 test1 test2


What did you expect to happen? (Expected behavior)

I expected the header of the change to show the correct "from line =
index".
For reference, a plain git diff:

> git diff test1 test2
diff --git a/test1 b/test2
index b1e6722..cead32e 100644
--- a/test1
+++ b/test2
@@ -1,3 +1,6 @@
 A
 B
 C
+D
+E
+F

When passing -U0, I would expect the from line index to be 3 larger, =
because the 3 lines of context are omitted:

diff --git a/test1 b/test2
index b1e6722..cead32e 100644
--- a/test1
+++ b/test2
@@ -4,0 +4,3 @@ C
+D
+E
+F


What happened instead? (Actual behavior)

The actual output places the new text at line 3:

> git diff -U0 test1 test2
diff --git a/test1 b/test2
index b1e6722..cead32e 100644
--- a/test1
+++ b/test2
@@ -3,0 +4,3 @@ C
+D
+E
+F


What's different between what you expected and what actually happened?

The header information "-3" is incorrect, because if a script wishes to =
insert the added code using the line indicator, it will place the newly =
added code at line 3 (before the C).
Instead, I would expect "-4", because we wish to insert the DEF starting =
at line 4.


Anything else you want to add:

Notably, the bug does not occur when also deleting lines.
Now, we are correctly placed at the beginning of line 3:

echo "A\nB\nD\nE\nF" > test3

> git diff -U0 test1 test3
diff --git a/test1 b/test3
index b1e6722..98422e9 100644
--- a/test1
+++ b/test3
@@ -3 +3,3 @@ B
-C
+D
+E
+F


[System Info]
git version:
git version 2.39.2 (Apple Git-143)
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 22.4.0 Darwin Kernel Version 22.4.0: Mon Mar  6 21:00:17 =
PST 2023; root:xnu-8796.101.5~3/RELEASE_X86_64 x86_64
compiler info: clang: 14.0.3 (clang-1403.0.22.14.1)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]

