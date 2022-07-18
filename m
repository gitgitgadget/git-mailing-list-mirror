Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAD3C43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 08:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbiGRI6I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 04:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbiGRI6F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 04:58:05 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BCE11C34
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 01:58:02 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a5so16004988wrx.12
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 01:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HWLzvyOgWUrn9dDZAAPopG7irdNVa+1v2J03xxvlSOo=;
        b=MdhVLK5pSnnNe/oBWSMYqJ2qOoy9d+F5XY44utFoJOGKcXcbAIRgean78hVlxfmoud
         +QZB/+cHLCGJ8HiJgtQCAxi3e70Ei+fOjVQJe2q0t8aZl8sw3EIGeXSlmFAGFbkwriPW
         /cM3Vgc26DeuISbSYARGyuWzIxqTpeKO5Kp+prqPAaj5pSaVmtXQYU6Cw1jAe1uUmNBw
         bSCx/dTXBY0k/DCgwFrCMDXuiChPVgZbTKxUM70Z4jYxcE/nQDP2ATax+bvY1lylyICs
         zG4hziwHySABolzXMFlWi4z0V2AzDyp3zqsUMDgbvldYkfyWsm2060wm8b01zj5Paaio
         bihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HWLzvyOgWUrn9dDZAAPopG7irdNVa+1v2J03xxvlSOo=;
        b=yu2FnL1XEkFebupLLG2HHHrliOcmX+x84h42MBNoIYNzM2rx/ykGsETUL75ijo8KBj
         ZMAjCWUptxrkQ1Yj5mV8k1VipaCOhwY+M07gIkDaTH1eBta2Sndzn/AqDs0kRT8s0j6X
         Pd43wgBE+XjTF+4Q2Iia80eWtbOjEAu9Hv6itAI0hwesgmDtwP4RTx1XddSdHzYwya5Q
         vdhn4QrO+D8po52FvC1w+dapKr2nr00wAjwNzDIAV4YoUWezYMyZmxG80twwUQQKm6MR
         v60y+9lLrgE4KGwDipmrs5Mrw93pKX7viBaiR7W7Dwag63xKd3pAYnBRrorSUEGu8fPg
         ppYg==
X-Gm-Message-State: AJIora8CDVF2dcFuQyBGr8dboO1a1Ljl3X03z0lyukS01rQ1rDmP7Pu9
        mXmiD1hSDeYiynII9VDNzbl1U4nQQ6U=
X-Google-Smtp-Source: AGRyM1uZ2C2cpg1IsRhwa0UemMel7omJn2PmOTW7gcwNjGIoKimub/bN3x1DlFLIqttxI5NUCzEr0A==
X-Received: by 2002:a5d:588f:0:b0:21d:a516:f57b with SMTP id n15-20020a5d588f000000b0021da516f57bmr21760756wrf.685.1658134680911;
        Mon, 18 Jul 2022 01:58:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k6-20020adfd846000000b0021d8b1656dfsm10218107wrl.93.2022.07.18.01.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 01:58:00 -0700 (PDT)
Message-Id: <pull.1285.v2.git.git.1658134679233.gitgitgadget@gmail.com>
In-Reply-To: <pull.1285.git.git.1657267260405.gitgitgadget@gmail.com>
References: <pull.1285.git.git.1657267260405.gitgitgadget@gmail.com>
From:   "Kilian Kilger via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 18 Jul 2022 08:57:59 +0000
Subject: [PATCH v2] git-p4: fix bug with encoding of p4 client name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Kilian Kilger <kkilger@gmail.com>,
        Kilian Kilger <kkilger@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kilian Kilger <kkilger@gmail.com>

The Perforce client name can contain arbitrary characters
which do not decode to UTF-8. Use the fallback strategy
implemented in metadata_stream_to_writable_bytes() also
for the client name.

Signed-off-by: Kilian Kilger <kkilger@gmail.com>
---
    git-p4: Fix bug with encoding of P4 client name

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1285%2Fcohomology%2Fmaint-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1285/cohomology/maint-v2
Pull-Request: https://github.com/git/git/pull/1285

Range-diff vs v1:

 1:  7393b59c642 ! 1:  3280a9579bc git-p4: fix bug with encoding of p4 client name
     @@
       ## Metadata ##
     -Author: Kilian Kilger <kilian.kilger@sap.com>
     +Author: Kilian Kilger <kkilger@gmail.com>
      
       ## Commit message ##
          git-p4: fix bug with encoding of p4 client name
     @@ Commit message
          Signed-off-by: Kilian Kilger <kkilger@gmail.com>
      
       ## git-p4.py ##
     +@@ git-p4.py: def isModeExecChanged(src_mode, dst_mode):
     +     return isModeExec(src_mode) != isModeExec(dst_mode)
     + 
     + 
     ++def p4KeysContainingNonUtf8Chars():
     ++    """Returns all keys which may contain non UTF-8 encoded strings
     ++       for which a fallback strategy has to be applied.
     ++       """
     ++    return ['desc', 'client', 'FullName']
     ++
     ++
     ++def p4KeysContainingBinaryData():
     ++    """Returns all keys which may contain arbitrary binary data
     ++       """
     ++    return ['data']
     ++
     ++
     ++def p4KeyContainsFilePaths(key):
     ++    """Returns True if the key contains file paths. These are handled by decode_path().
     ++       Otherwise False.
     ++       """
     ++    return key.startswith('depotFile') or key in ['path', 'clientFile']
     ++
     ++
     ++def p4KeyWhichCanBeDirectlyDecoded(key):
     ++    """Returns True if the key can be directly decoded as UTF-8 string
     ++       Otherwise False.
     ++
     ++       Keys which can not be encoded directly:
     ++         - `data` which may contain arbitrary binary data
     ++         - `desc` or `client` or `FullName` which may contain non-UTF8 encoded text
     ++         - `depotFile[0-9]*`, `path`, or `clientFile` which may contain non-UTF8 encoded text, handled by decode_path()
     ++       """
     ++    if key in p4KeysContainingNonUtf8Chars() or \
     ++       key in p4KeysContainingBinaryData() or  \
     ++       p4KeyContainsFilePaths(key):
     ++        return False
     ++    return True
     ++
     ++
     + def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
     +         errors_as_exceptions=False, *k, **kw):
     + 
      @@ git-p4.py: def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
     +     try:
     +         while True:
     +             entry = marshal.load(p4.stdout)
     ++
                   if bytes is not str:
     -                 # Decode unmarshalled dict to use str keys and values, except for:
     -                 #   - `data` which may contain arbitrary binary data
     +-                # Decode unmarshalled dict to use str keys and values, except for:
     +-                #   - `data` which may contain arbitrary binary data
      -                #   - `desc` or `FullName` which may contain non-UTF8 encoded text handled below, eagerly converted to bytes
     -+                #   - `desc` or `client` or `FullName` which may contain non-UTF8 encoded text handled below, eagerly converted to bytes
     -                 #   - `depotFile[0-9]*`, `path`, or `clientFile` which may contain non-UTF8 encoded text, handled by decode_path()
     +-                #   - `depotFile[0-9]*`, `path`, or `clientFile` which may contain non-UTF8 encoded text, handled by decode_path()
     ++                # Decode unmarshalled dict to use str keys and values. Special cases are handled below.
                       decoded_entry = {}
                       for key, value in entry.items():
                           key = key.decode()
      -                    if isinstance(value, bytes) and not (key in ('data', 'desc', 'FullName', 'path', 'clientFile') or key.startswith('depotFile')):
     -+                    if isinstance(value, bytes) and not (key in ('data', 'desc', 'FullName', 'path', 'clientFile', 'client') or key.startswith('depotFile')):
     ++                    if isinstance(value, bytes) and p4KeyWhichCanBeDirectlyDecoded(key):
                               value = value.decode()
                           decoded_entry[key] = value
                       # Parse out data if it's an error response
      @@ git-p4.py: def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
     +             if skip_info:
     +                 if 'code' in entry and entry['code'] == 'info':
                           continue
     -             if 'desc' in entry:
     -                 entry['desc'] = metadata_stream_to_writable_bytes(entry['desc'])
     -+            if 'client' in entry:
     -+                entry['client'] = metadata_stream_to_writable_bytes(entry['client'])
     -             if 'FullName' in entry:
     -                 entry['FullName'] = metadata_stream_to_writable_bytes(entry['FullName'])
     +-            if 'desc' in entry:
     +-                entry['desc'] = metadata_stream_to_writable_bytes(entry['desc'])
     +-            if 'FullName' in entry:
     +-                entry['FullName'] = metadata_stream_to_writable_bytes(entry['FullName'])
     ++            for key in p4KeysContainingNonUtf8Chars():
     ++                if key in entry:
     ++                    entry[key] = metadata_stream_to_writable_bytes(entry[key])
                   if cb is not None:
     +                 cb(entry)
     +             else:


 git-p4.py | 51 ++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 9 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 8fbf6eb1fe3..9323b943c68 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -822,6 +822,42 @@ def isModeExecChanged(src_mode, dst_mode):
     return isModeExec(src_mode) != isModeExec(dst_mode)
 
 
+def p4KeysContainingNonUtf8Chars():
+    """Returns all keys which may contain non UTF-8 encoded strings
+       for which a fallback strategy has to be applied.
+       """
+    return ['desc', 'client', 'FullName']
+
+
+def p4KeysContainingBinaryData():
+    """Returns all keys which may contain arbitrary binary data
+       """
+    return ['data']
+
+
+def p4KeyContainsFilePaths(key):
+    """Returns True if the key contains file paths. These are handled by decode_path().
+       Otherwise False.
+       """
+    return key.startswith('depotFile') or key in ['path', 'clientFile']
+
+
+def p4KeyWhichCanBeDirectlyDecoded(key):
+    """Returns True if the key can be directly decoded as UTF-8 string
+       Otherwise False.
+
+       Keys which can not be encoded directly:
+         - `data` which may contain arbitrary binary data
+         - `desc` or `client` or `FullName` which may contain non-UTF8 encoded text
+         - `depotFile[0-9]*`, `path`, or `clientFile` which may contain non-UTF8 encoded text, handled by decode_path()
+       """
+    if key in p4KeysContainingNonUtf8Chars() or \
+       key in p4KeysContainingBinaryData() or  \
+       p4KeyContainsFilePaths(key):
+        return False
+    return True
+
+
 def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
         errors_as_exceptions=False, *k, **kw):
 
@@ -851,15 +887,13 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
     try:
         while True:
             entry = marshal.load(p4.stdout)
+
             if bytes is not str:
-                # Decode unmarshalled dict to use str keys and values, except for:
-                #   - `data` which may contain arbitrary binary data
-                #   - `desc` or `FullName` which may contain non-UTF8 encoded text handled below, eagerly converted to bytes
-                #   - `depotFile[0-9]*`, `path`, or `clientFile` which may contain non-UTF8 encoded text, handled by decode_path()
+                # Decode unmarshalled dict to use str keys and values. Special cases are handled below.
                 decoded_entry = {}
                 for key, value in entry.items():
                     key = key.decode()
-                    if isinstance(value, bytes) and not (key in ('data', 'desc', 'FullName', 'path', 'clientFile') or key.startswith('depotFile')):
+                    if isinstance(value, bytes) and p4KeyWhichCanBeDirectlyDecoded(key):
                         value = value.decode()
                     decoded_entry[key] = value
                 # Parse out data if it's an error response
@@ -869,10 +903,9 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
             if skip_info:
                 if 'code' in entry and entry['code'] == 'info':
                     continue
-            if 'desc' in entry:
-                entry['desc'] = metadata_stream_to_writable_bytes(entry['desc'])
-            if 'FullName' in entry:
-                entry['FullName'] = metadata_stream_to_writable_bytes(entry['FullName'])
+            for key in p4KeysContainingNonUtf8Chars():
+                if key in entry:
+                    entry[key] = metadata_stream_to_writable_bytes(entry[key])
             if cb is not None:
                 cb(entry)
             else:

base-commit: e4a4b31577c7419497ac30cebe30d755b97752c5
-- 
gitgitgadget
