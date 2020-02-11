Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A07FC3B189
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 18:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D69821D7D
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 18:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFxJbvIZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730837AbgBKS6N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 13:58:13 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36761 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730808AbgBKS6L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 13:58:11 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so13825080wru.3
        for <git@vger.kernel.org>; Tue, 11 Feb 2020 10:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/UIX+i4pqEtOl8elqbLxcbXJF0mnPDhMyhfoDVg7bus=;
        b=bFxJbvIZ1B6cJG37Ea4rgNq2sjFhvrOjzGYmp/9uk0QAhMum9LsvmGZj6uK2GTdWFI
         ab5JsCgWVoKF2Zng7OW8HGK/ZKCIl/3U8Oj52FqPnnivxyL4z3vN6FeeJx6SeilX05Mv
         kxhodCe4h3Z9T4eeSUkxbR989WW+c9VhmQHl9ilvwYFYaYQmMwKAmUDOK7J5fQs6XcCO
         aJRxl3D9vgfGoV6sBEDfq2DOxg5z+krWMrQ77yXbFfaHGsvQDQMl4M2Ny+Z3bAXWM7cy
         4oOP6sJxtnzFIhglQDzvBOQV9eZVwg5QmdWiZYXIVXIGPrk2fLi6Ok2wct5S8afRIacl
         4PsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/UIX+i4pqEtOl8elqbLxcbXJF0mnPDhMyhfoDVg7bus=;
        b=dVxK0+u9XiN4G/doAQSlaWy8zhqdAy+xfeNGArGXLvdlhNrTdXC/UL+L7cgEax8IPj
         HSi3Uu6HB75BwF5FNMv9NFlDdgORuTEWQedzIzkwYQZZnOFPlNXIKFyvKUF9f62iaVlM
         bYmoTMMmdrfekPGJSppYoBQ7RmxJwY2O/ug9r0/5qIfgSNyvbVfSJiteCzKrjp0qf2DL
         MXCPUGUMv0iY0QvkFrDG1y+sffNxI+YcOVu+JIvRLKnIHFc4ac2Y+gjoq8mTTsD9CUI9
         pS656I00HfI8D9QD/VGDjpzRoeevuPWpWNrxw8nhJrwg2fYjoCPoGvK8xEjHnkodMECw
         woBw==
X-Gm-Message-State: APjAAAW01KBq9GpSrKpymxALCHHc+ONOtwQiBI7D+XAZNnwLqCmiIBC9
        bsVahEGH/NeLyIeCYbJ/jEk++9Se
X-Google-Smtp-Source: APXvYqyeGKHBDCZQuwRGvBemheZeqMHMKNBE2ilZB/PDOgTAqAZhIx2uG7AOqBo0/oecAft0+N/ObA==
X-Received: by 2002:adf:e746:: with SMTP id c6mr9473056wrn.323.1581447488682;
        Tue, 11 Feb 2020 10:58:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k7sm4792909wmi.19.2020.02.11.10.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 10:58:08 -0800 (PST)
Message-Id: <5f2b47bf6aa2686d2c8d9a47f73daed59cd94af5.1581447485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.698.v5.git.git.1581447484.gitgitgadget@gmail.com>
References: <pull.698.v4.git.git.1581372376.gitgitgadget@gmail.com>
        <pull.698.v5.git.git.1581447484.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 11 Feb 2020 18:58:00 +0000
Subject: [PATCH v5 3/7] git-p4: add p4-pre-submit exit text
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>, Ben Keene <seraphire@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Keene <seraphire@gmail.com>

When the p4-pre-submit exits with a non-zero exit code, the application
will abort the process with no additional information presented to the
user. This can be confusing for new users as it may not be clear that
the p4-pre-submit action caused the error.

Add text to explain why the program aborted the submit action.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 4eccea3fa5..b1c86678fc 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2405,7 +2405,15 @@ def run(self, args):
             sys.exit("number of commits (%d) must match number of shelved changelist (%d)" %
                      (len(commits), num_shelves))
 
-        if not run_git_hook("p4-pre-submit"):
+        try:
+            if not run_git_hook("p4-pre-submit"):
+                print("\nThe p4-pre-submit hook failed, aborting the submit.\n\nYou can skip " \
+                    "this pre-submission check by adding\nthe command line option '--no-verify', " \
+                    "however,\nthis will also skip the p4-changelist hook as well.")
+                sys.exit(1)
+        except Exception as e:
+            print("\nThe p4-pre-submit hook failed, aborting the submit.\n\nThe hook failed "\
+                "with the error '{0}'".format(e.message) )
             sys.exit(1)
 
         #
-- 
gitgitgadget

