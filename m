Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D05C433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 04:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239149AbiANEYa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 23:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbiANEYa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 23:24:30 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DEDC061574
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 20:24:29 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id f13so1979239plg.0
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 20:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7D0H/HoIWzdMlSJc/GnwRlne1OwwGfG3RCmqr2QzfvQ=;
        b=nDvL/4xi3tzii2EHZBq5aJIXm3w0iUYIoyMA7UU5h9fyH+MI3hHvRDYCFE0O83YyOw
         8qfm0XTm4uu8I/KktsBYAvyWNAY7SkI2Kce+sLyXUgWwH+eedjdzcn8ariaYT8Xx/X8G
         ttB65vlzqbSdobKIUj0GDkqRYq7MvYqHHEQyOh59rgipjErEy2vRiM+B0MaePeLZU+uD
         t7H492j5VwH/K5BCFrwkbZJe+7GzmNZMzG4m5zZL+DaKz+FErtWLeW7j9im2YQSh4bWV
         72dTfgKq0KZs4zg36CH2YdqM8CiBz4SApSD0VJQZXpcv0s8iinsZwr/EFHkGW/e5nvjT
         nHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7D0H/HoIWzdMlSJc/GnwRlne1OwwGfG3RCmqr2QzfvQ=;
        b=TZ0R3/kr9gxJd2fveaFIJq5I1TMuVchQI/gwljcmHfCqsSxcPVF8hXYhHFOQlQCy3Y
         CDhRMmWM2VRVjZcBMfNDXdBV5v9+9MkUWQwfViPAy7PY3JXicduoYfl14LCttTLwEdHR
         QW1dPkzjDCw1E5AhgU2pNx94EDcW+pi27vDupn5Ip4ARrPGxX0xkJYMdfDa1uVrc//zD
         L8qGxVKzLmQ+YnrJFbFscxqCr93nSRBX1lPWZuqDmen0DP8L1vObDwqsbaqmqLN7Q2dA
         ZOdDIJBP4LnLsudW4uIQpzIqETY8I6B9Z1PhHCXZcACrNoge8DE3/0xSFMuWvPgxtsoB
         yh2g==
X-Gm-Message-State: AOAM532v3FuqTkBNP8XNMmQ+9jbgLXsqiZiASHnLaKmNoV30ye/zHJV5
        fa33Nbh9uILtVPdI/OQnK9gbKDtIqIqoPTXr
X-Google-Smtp-Source: ABdhPJyf2SX/yLRavA1pO5r5jQim7qTuCt31cT3Hq3DNa4+hnqpd4/H3yqoEBZApVd+G7KXSE/4cag==
X-Received: by 2002:a17:90a:6843:: with SMTP id e3mr8759124pjm.55.1642134269183;
        Thu, 13 Jan 2022 20:24:29 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.59])
        by smtp.gmail.com with ESMTPSA id k20sm4084079pfk.111.2022.01.13.20.24.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jan 2022 20:24:28 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@vger.kernel.org
Cc:     tenglong.tl@alibaba-inc.com, Teng Long <dyroneteng@gmail.com>
Subject: [RFC PATCH v1 0/1] ls-remote: inconsistency from the order of args and opts
Date:   Fri, 14 Jan 2022 12:24:22 +0800
Message-Id: <cover.1642129840.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.391.g9ef3d6f133
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It has a different results by executing "git ls-remote -heads origin"
and "git ls-remote origin --heads". A test for reproduction is as
follows:

@@ -0,0 +1,17 @@
+#!/bin/sh
+                                                                                                           
+test_description='test ls-tree for reproduction'
+
+. ./test-lib.sh
+
+
+test_must_fail 'Exchange the order of "--heads" and <remote>' '
+    git --version &&
+    git init "test.git" &&
+    test_commit -C "test.git" one &&
+    git -C "test.git" ls-remote --heads ./. > result.1 &&
+    git -C "test.git" ls-remote ./. --heads > result.2 &&
+    test_cmp result.1 result.2
+'
+
+test_done
--
2.34.1.391.g9ef3d6f133

"git -C "test.git" ls-remote ./. --heads" returns nothing here because
"ls-remote" supports to treat args as patterns to filter the refs list
, and "--heads" here as the pattern does not match any.

If a repo exists a ref which is named as "refs/heads/--heads", execute
`mgit ls-remote origin --heads` will return ("mgit" is a alias means
the git binary that is built by "master" in my env):
                                                                                                            
       0319b78d7c31e5203d79157fe82960db88cc4a54        refs/heads/--heads

If we execute again in terms of this patch by `git ls-remote origin --heads`:

      0319b78d7c31e5203d79157fe82960db88cc4a54        refs/heads/--heads
      0319b78d7c31e5203d79157fe82960db88cc4a54        refs/heads/master

And if we hope to let "--heads" to be treated as a "pattern", we can execute
`git ls-remote origin --heads -- "--heads"`:

      0319b78d7c31e5203d79157fe82960db88cc4a54        refs/heads/--heads

Personally, I think the second option is probably a little better, but there
are also possible backward compatibility issues, such as users ending branch
names with "-heads" and so on.

So I sent this patch to try to figure out if this was a requirement of the
original design, or if it was something that could really be improved, or if
we can find a better way to deal this issue with compatibility.

Thanks.

Teng Long (1):
  ls-remote: Make the output independent of the order of opts and
    <remote>

 builtin/ls-remote.c  |  3 +--
 t/t5512-ls-remote.sh | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

Range-diff against v0:
-:  ---------- > 1:  9ef3d6f133 ls-remote: Make the output independent of the order of opts and <remote>
-- 
2.34.1.391.g9ef3d6f133

