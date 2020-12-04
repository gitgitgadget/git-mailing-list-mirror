Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18F8C4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 23:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64B6E22519
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 23:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgLDXUL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 18:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLDXUL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 18:20:11 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BBFC061A4F
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 15:19:25 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id l1so6830815wrb.9
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 15:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=8p2tRFdHEQcEStNLv/f4qpLBgq1swbhYWm8TEUkVJ4U=;
        b=sL7KlG55tEpcLFFPKLdrJkQZXxLwV8GHtUSLQw9zzq5/2Wz8bQyUq4nEWtU83LX4Xj
         ZVbKPQ8IUS0px7gBGowVIX7iK3SSJKdNvK3PQYRcF/YzucztBffdzGGL71nQre/nx2tj
         qwFsfJCA+xC7/OVtZB0nkUNGKJK2LlWG75zDdPFUbxHfV3msscGTcRk3acCVQEd4lMx3
         8fe9KiUriJTB8uBsFHdlPT9a7cSgt3FNgt/7pApqTHgR+P2iiEHvQq3zqbN2Gq2Qw2QG
         N8DyQhh8LBfRev4hb7omg1hDueb0lf2sDu639fOVPn778G7ezrIavlCnmYlPKT4ebmu/
         aiyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=8p2tRFdHEQcEStNLv/f4qpLBgq1swbhYWm8TEUkVJ4U=;
        b=OLw4yR5JQq54UiyvXRqiSkK5XHDD+1I4yZx73OcaijaYb8qWovWMvs/ikTIjiIaFbx
         o/v71FErs/gTBqd1tlqHpEBrNUYGKNEFa7wDKv57jvyM5FIaDVe3fNm5timDfDG7yxkq
         1JUxp6sdMJjqxEOPZR4HxqKg/0XcnXgl1NyxYrhOEV7cCRCdA/pC5yHnyhlGwNSvkJTK
         sD7qnHPY9sYQ9GoS72FNRlE27qxYg4ios7eCcfjvMigg3yNiDy8vvA/Tz0g42OQXt527
         nPFmK2pfOLQS7OpNMOy5qkV7kHZmckTiYfxL5YTN47W3qlw2sE1e3neJMEFVIkvuSnCU
         M5Lw==
X-Gm-Message-State: AOAM532/57jiqogGoS8w+NlEZUMub4uabAZgtuXgK/7kgzCzOaYc/x//
        ZQb1vBJ3Tk8reDr1OhZC8iclsQmKk2o=
X-Google-Smtp-Source: ABdhPJw0cGf/enCT5i2MGFRolBuLUfo2u6ocfs/YTPahbGOo7hlrMEsdrlPgz1ZbvuZmPgfIIgO6mQ==
X-Received: by 2002:adf:df8e:: with SMTP id z14mr7532889wrl.406.1607123963675;
        Fri, 04 Dec 2020 15:19:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d187sm2039658wmd.8.2020.12.04.15.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 15:19:23 -0800 (PST)
Message-Id: <pull.928.git.git.1607123962304.gitgitgadget@gmail.com>
From:   "David Racine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Dec 2020 23:19:21 +0000
Subject: [PATCH] Support having non-utf-8 characters returned by p4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Luke Diamand <luke@diamand.org>,
        David Racine <bass_dr@hotmail.com>,
        David Racine <bass_dr@hotmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: David Racine <bass_dr@hotmail.com>

When perforce server is not configured for Unicode, and commands like
`p4 users` returns a string with non-ascii characters (eg. one of the
user's FullName has a french `é` in it), git-p4 was giving
`Exception: failure accessing depot: could not connect`.
With this patch, if such character is encountered, it will honor the new
`git-p4.textEncoding` config option, or silently replace the erronous
character and continue.

Signed-off-by: David Racine <bass_dr@hotmail.com>
---
    git-p4: Support having non-utf-8 characters returned by p4
    
    When perforce server is not configured for Unicode, and commands like p4
    users returns a string with non-ascii characters (eg. one of the user's
    FullName has a french é in it), git-p4 was giving Exception: failure
    accessing depot: could not connect. With this patch, if such character
    is encountered, it will honor the new git-p4.textEncoding config option,
    or silently replace the erronous character and continue.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-928%2Fbassdr%2Fpatch-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-928/bassdr/patch-1-v1
Pull-Request: https://github.com/git/git/pull/928

 git-p4.py | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 6ae5bbfe99..6cbd153419 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -195,16 +195,27 @@ def decode_path(path):
     """Decode a given string (bytes or otherwise) using configured path encoding options
     """
     encoding = gitConfig('git-p4.pathEncoding') or 'utf_8'
+    return p4_decode_stream(path, encoding)
+
+def p4_decode_text(user):
+    """Decode a given string (bytes or otherwise) using configured text encoding options
+    """
+    encoding = gitConfig('git-p4.textEncoding') or 'utf-8'
+    return p4_decode_stream(s, encoding)
+    
+def p4_decode_stream(s, encoding):
+    """Decode a given string (bytes or otherwise) using encoding argument
+    """
     if bytes is not str:
-        return path.decode(encoding, errors='replace') if isinstance(path, bytes) else path
+        return s.decode(encoding, errors='replace') if isinstance(s, bytes) else s
     else:
         try:
-            path.decode('ascii')
+            s.decode('ascii')
         except:
-            path = path.decode(encoding, errors='replace')
+            s = s.decode(encoding, errors='replace')
             if verbose:
-                print('Path with non-ASCII characters detected. Used {} to decode: {}'.format(encoding, path))
-        return path
+                print('Text with non-ASCII characters detected. Used {} to decode: {}'.format(encoding, s))
+        return s
 
 def run_git_hook(cmd, param=[]):
     """Execute a hook if the hook exists."""
@@ -771,7 +782,7 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
                 for key, value in entry.items():
                     key = key.decode()
                     if isinstance(value, bytes) and not (key in ('data', 'path', 'clientFile') or key.startswith('depotFile')):
-                        value = value.decode()
+                        value = p4_decode_text(value)
                     decoded_entry[key] = value
                 # Parse out data if it's an error response
                 if decoded_entry.get('code') == 'error' and 'data' in decoded_entry:

base-commit: 3a0b884caba2752da0af626fb2de7d597c844e8b
-- 
gitgitgadget
