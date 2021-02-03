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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6746C43381
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 17:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90E0464F7E
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 17:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhBCRB2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 12:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbhBCRAT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 12:00:19 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBEAC0613D6
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 09:00:02 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id y187so327200wmd.3
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 09:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=icRbSSWZgqqKbESFt9Jm9J+SB+ASNYk2l7UuqGtXWj8=;
        b=I7Xhbuc8ZHJGca0IgC7fouoLBlcXdI1GOYEZkrNzokBgNoqP4NnI+AcMBNKnnX9emU
         HOwSLSgHq7cJ1RWltAFR0pjsXs/AoEhqB455nifgTnItuNryUukwwfu2czs09Mn7iopr
         NnFG7uDK0R1/GySYlH1aq7/kG0umM1VCI+82b9KPuv7nRd0pi7rbkTENyKyKmxB4ZZ8y
         P0mUsyJUa0w1KAPIGS1HYiPsSFkSih/EzRUGRTUu1bXEOKzZ6nDZ6W3Ym3g+I0kd/iVi
         7kEZ2UH7fnlVlGU7qAr/2bAwxc3dZkouL8yLgmyJRO7z8xsynnfIBqIHX554IuLWZsCp
         gaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=icRbSSWZgqqKbESFt9Jm9J+SB+ASNYk2l7UuqGtXWj8=;
        b=BCda/T1TclGB8B0Gcz7wDtHRG6/OV21At3GqD0uuFT+O2ZZt1ZMU70wG7D1con5oH+
         3F219+4AyApye0gIdeLHFQ3E+f87J54gZra/vMlLHKyjupi6RMpPsdtYFeM3BB87QcXC
         CVSmt2BB+sDjmFGOuhId/gA6dw0jNq7QFvh+Jk3eIHZ880hZYR45azkB2iNMkK5A9eTW
         K/jqpxFOjttfiT3s9idejHF2b5XM4dxw/uHPyP+rDGluUjrSlp7k4NYN9qIaKf+xNjVo
         u5vij7FkFDe0Oh+axOOqk0CoqQHW3cIGz4UOlDoPpvZjYBLlCnOR/+koH0aFLJWM+MjE
         RV3w==
X-Gm-Message-State: AOAM533IPjNdLUjXYu7n1CqD+5GKglLjehLy5rwEUw6pn5XsDrl8Zv1B
        gH4sBmg1i6cSwj2f74WYGvJwP+Hrp+U=
X-Google-Smtp-Source: ABdhPJyTCb7naJt3hQz9ZBtRe3O/jJb2LEvW2qGS/8NR04r1Ahw3ppM+ZJyGP43Woj3g2nZ3lb7ozw==
X-Received: by 2002:a1c:99d0:: with SMTP id b199mr2141366wme.147.1612371601352;
        Wed, 03 Feb 2021 09:00:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j185sm3564660wma.1.2021.02.03.09.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 09:00:00 -0800 (PST)
Message-Id: <pull.864.git.1612371600332.gitgitgadget@gmail.com>
From:   "Feiyang via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 03 Feb 2021 16:59:59 +0000
Subject: [PATCH] git-p4: handle non-unicode characters in p4 cl
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

P4 allows non-unicode characters in changelist description body,
so git-p4 needs to be character encoding aware when reading p4 cl

This change adds 2 config options, one specifies encoding,
the other specifies erro handling upon unrecognized character.
Those configs  apply when it reads p4 description text, mostly
from commands "p4 describe" and "p4 changes".

Signed-off-by: Feiynag Xue <fxue@roku.com>
---
    git-p4: handle non-unicode characters in p4 changelist description
    
    P4 allows non-unicode characters in changelist description body, so
    git-p4 needs to be character encoding aware when reading p4 cl.
    
    This change adds 2 config options: one specifies encoding, the other
    specifies erro handling upon unrecognized character. Those configs apply
    when it reads p4 description text, mostly from commands "p4 describe"
    and "p4 changes".
    
    ------------------------------------------------------------------------
    
    I have an open question in mind: what might be the best default config
    to use?
    
    Currently the python's bytes.decode() is called with default utf-8 and
    strict error handling, so git-p4 pukes on non-unicode characters. I
    encountered it when git p4 sync attempts to ingest a certain CL.
    
    It seems to make sense to default to replace so that it gets rid of
    non-unicode chars while trying to retain information. However, i am
    uncertain on if we have use cases where it relies on the
    stop-on-non-unicode behavior. (Hypothetically say an automation that's
    expected to return error on non-unicode char in order to stop them from
    propagating further?)
    
    ------------------------------------------------------------------------
    
    I tested it with git p4 sync to a P4 CL that somehow has non-unicode
    control character in description. With
    git-p4.cldescencodingerrhandling=ignore, it proceeded without error.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-864%2Ffeiyeung%2Fdescription-text-encoding-handling-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-864/feiyeung/description-text-encoding-handling-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/864

 Documentation/git-p4.txt | 13 +++++++++++++
 git-p4.py                | 12 +++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index f89e68b424c..01a0e0b1067 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -638,6 +638,19 @@ git-p4.pathEncoding::
 	to transcode the paths to UTF-8. As an example, Perforce on Windows
 	often uses "cp1252" to encode path names.
 
+git-p4.clDescEncoding::
+	Perforce allows non-unicode characters in changelist description. 
+	Use this config to tell git-p4 what encoding Perforce had used for 
+	description text. This encoding is used to transcode the text to
+	UTF-8. Defaults to "utf_8".
+
+git-p4.clDescNonUnicodeHandling::
+	Perforce allows non-unicode characters in changelist description. 
+	Use this config to tell git-p4 what to do when it does not recognize 
+	the character encoding in description body. Defaults to "strict" for 
+	stopping upon encounter. "ignore" for skipping unrecognized
+	characters; "replace" for attempting to convert into UTF-8. 
+
 git-p4.largeFileSystem::
 	Specify the system that is used for large (binary) files. Please note
 	that large file systems do not support the 'git p4 submit' command.
diff --git a/git-p4.py b/git-p4.py
index 09c9e93ac40..abbeb9156bd 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -206,6 +206,13 @@ def decode_path(path):
                 print('Path with non-ASCII characters detected. Used {} to decode: {}'.format(encoding, path))
         return path
 
+def decode_changlist_description(text):
+    """Decode bytes or bytearray using configured changelist description encoding options
+    """
+    encoding = gitConfig('git-p4.clDescEncoding') or 'utf_8'
+    err_handling = gitConfig('git-p4.clDescEncodingErrHandling') or 'strict'
+    return text.decode(encoding, err_handling)
+
 def run_git_hook(cmd, param=[]):
     """Execute a hook if the hook exists."""
     if verbose:
@@ -771,7 +778,10 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
                 for key, value in entry.items():
                     key = key.decode()
                     if isinstance(value, bytes) and not (key in ('data', 'path', 'clientFile') or key.startswith('depotFile')):
-                        value = value.decode()
+                        if key == 'desc':
+                            value = decode_changlist_description(value)
+                        else:
+                            value = value.decode()
                     decoded_entry[key] = value
                 # Parse out data if it's an error response
                 if decoded_entry.get('code') == 'error' and 'data' in decoded_entry:

base-commit: e6362826a0409539642a5738db61827e5978e2e4
-- 
gitgitgadget
