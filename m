Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402FCC43381
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 17:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DCB164E46
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 17:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbhBCRAo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 12:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbhBCQ6e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 11:58:34 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C90C06178A
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 08:57:54 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id i9so334291wmq.1
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 08:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=7xCNSB93YhvjUF+oh6fqnI8e7+tyj2rOrCUzwlPdTjU=;
        b=GPZEglEw5rPoorey0tgjqghuhCKxn6H0Codu/lhAIeW3p9lu7op0xaKCwZjCBA1IaI
         XdRNmvlCWHpfyk3HqKUx9FZdAzlS1Hj6clXkTCAOhsfFtN6H0U2FB1doLBkwoqSLft4y
         RQpHcR+IEKlnOVrkCz8/tVcxq6nGsLVR49Q2xTvfBRcjUaKPEB4PIVQciiBufkjI7y9Y
         owB393xQ3hoavOK5IoIeDtVMLxnXRgURvVg+Z4GJtHhOf5lFNbPqFjU1kfVW94MFh4OY
         M+NEAurCy5q1kqtsLfbV4zfuTA8xDTVfVuK5lpLhZ3tJMB3r5wWvkh8oMtgHecBPnFTD
         0O8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7xCNSB93YhvjUF+oh6fqnI8e7+tyj2rOrCUzwlPdTjU=;
        b=uCZZoC5+IKG/3MpFLHzRig83A5zVFP/gW10426oxzRZ/Er3li0Sffpji41LAzvIH7+
         Xtet+xPxly3SShlYZH5bUSEEfEgnalrTI9U+2TsKJazRvlbd29gBIb8gAOau3Cm3YtWw
         BmFE3NT91tomKdNN5ChtPgsRXk6UH0x+w/bYzsCCgHZvnJcc4W9H4M6T6BnYHXB6+giU
         +IdBBEsClM7cYeRkE7FPDtPp75kcjT1hInlqySIlC4MrEXidipkZqOPi0ZtSvZNUC4oF
         VYUu+XU/RdKCBuCnxZ4BQ/p775FhN+vnwnreO8khwYnWrWjmzKAAaiJVXVIzBtuIXTZK
         mVNg==
X-Gm-Message-State: AOAM532pLYh5Knj//bNGIzpdZT/EktvurCxmxlfW7VinVeBzSaF3ptO0
        vXdczwzvxw66YfQoYwDm2lI+3UAJ9BQ=
X-Google-Smtp-Source: ABdhPJyrq1LhWiO122UpARjvZQhrRyLYwNn3QF6DgJZ4Ov3PeMJhsVA3GTbSRnO61wtZ0ubccKl0rA==
X-Received: by 2002:a1c:a5d0:: with SMTP id o199mr3588598wme.81.1612371472745;
        Wed, 03 Feb 2021 08:57:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l1sm4503118wrp.40.2021.02.03.08.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 08:57:52 -0800 (PST)
Message-Id: <pull.862.git.1612371471347.gitgitgadget@gmail.com>
From:   "Feiyang via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 03 Feb 2021 16:57:50 +0000
Subject: [PATCH] git-p4: remove deprecated function "encodeWithUTF8()"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Feiyang <github@feiyangxue.com>, Feiynag Xue <fxue@roku.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Feiynag Xue <fxue@roku.com>

commit d38208a297e76bbfbfa8e485632c217aaafa9486 introduced function "decode_path()" to replace "encodeWithUTF8()". This old function "encodeWithUTF8()" no longer has reference by any code in this file.

Signed-off-by: Feiynag Xue <fxue@roku.com>
---
    Remove deprecated function "encodeWithUTF8()"
    
    The function encodeWithUTF8() no longer has reference after
    d38208a297e76bbfbfa8e485632c217aaafa9486, which introduced decode_path()
    to replace encodeWithUTF8() for path encoding handling. I cannot think
    of a reason to keep encodeWithUTF8() in the codebase.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-862%2Ffeiyeung%2Fremove-encodeWithUTF8-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-862/feiyeung/remove-encodeWithUTF8-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/862

 git-p4.py | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 09c9e93ac40..2c7e5498afa 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2939,18 +2939,6 @@ def writeToGitStream(self, gitMode, relPath, contents):
             self.gitStream.write(d)
         self.gitStream.write('\n')
 
-    def encodeWithUTF8(self, path):
-        try:
-            path.decode('ascii')
-        except:
-            encoding = 'utf8'
-            if gitConfig('git-p4.pathEncoding'):
-                encoding = gitConfig('git-p4.pathEncoding')
-            path = path.decode(encoding, 'replace').encode('utf8', 'replace')
-            if self.verbose:
-                print('Path with non-ASCII characters detected. Used %s to encode: %s ' % (encoding, path))
-        return path
-
     # output one file from the P4 stream
     # - helper for streamP4Files
 

base-commit: e6362826a0409539642a5738db61827e5978e2e4
-- 
gitgitgadget
