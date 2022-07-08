Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3173C43334
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 08:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237455AbiGHIBI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 04:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237238AbiGHIBH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 04:01:07 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4917D7E01F
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 01:01:03 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v14so29439467wra.5
        for <git@vger.kernel.org>; Fri, 08 Jul 2022 01:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=1QrfVq6fY04AgDI9QKTHEEU3XUcQCaXCUU1O6tX1+EQ=;
        b=W/M7vy63iUYQBnwrlVWv/Ohmeu4XwXyojKU3QK4834ik7hvUowLPSwOmcPSWzCWQvy
         iPEJHepibR2VNT8BIqnv7xEfKmuwUXzDWSg13m97goitX9up2uZ7faR/bQEpXyDFYkRv
         ZIrjYKdQ7pZbJV1wEdNmEhyjX103CMgnzc0PBcfCK9V3lLytrlDbZeAO157JXsopUTIc
         ev24Z7BDtSUJ72cUTbJgAMj84YXWpERGay+E5Nmg2mrFbM2t2Yp8Bmq/4Q9RSVNPckCZ
         bZLM05lgRWHy+bvVT3OOW+ydXrz9bgJrzwQmElhE6wSIAE1+SRDYauUcDxxQLSdyB3+w
         vpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1QrfVq6fY04AgDI9QKTHEEU3XUcQCaXCUU1O6tX1+EQ=;
        b=c7On0ocFLlGJ+yHVq8mYCWadDbrZoHMCTI0q6UYyxuA6zJ0KAkYtyrZ/H1SIp6Ndkn
         BiBR8PshmhlfrHjHAJEVGnpRYEj8xh8e0n7xNi40ty4BFFwWntjprxfSVokEhIjPmq16
         avlT8KiPAynbnJ72W9x2qFL7/6t/I6gLQalkYsoTdVATrUycCumHHJfj0kC+zfV5YHB0
         Ba1OhFRot6puUR/Qkem4wpi5uyHs9Vo9Q5LKQXv3kBNv+2qjgJoZpYiPN45iF2hq72m0
         VFG2GJ3/iyFEmd5UeyMjf5xKwUsMZSzwGRvKZ7ym+99rROI4HjNz2i8eu1iWaIsUe6Uz
         TVuQ==
X-Gm-Message-State: AJIora92LOXCFXU9oedhEMq0EsuOws2ckJbiloP0trS+4x5rNanX9Qoh
        tNuPGVyePm+vGQ1mfm/fSIo3spRHla0=
X-Google-Smtp-Source: AGRyM1sY+5krk7XGqAr7K/bS3cRv91taPyyQqIOJgvjmpn++jLXjBjgVG3K73XcFpHQxP7xMKIG60g==
X-Received: by 2002:a5d:5c08:0:b0:21d:854a:7009 with SMTP id cc8-20020a5d5c08000000b0021d854a7009mr1949728wrb.263.1657267261607;
        Fri, 08 Jul 2022 01:01:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bn14-20020a056000060e00b0021d20a43523sm29710954wrb.42.2022.07.08.01.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 01:01:00 -0700 (PDT)
Message-Id: <pull.1285.git.git.1657267260405.gitgitgadget@gmail.com>
From:   "Kilian Kilger via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 08 Jul 2022 08:01:00 +0000
Subject: [PATCH] git-p4: fix bug with encoding of p4 client name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Kilian Kilger <kkilger@gmail.com>,
        Kilian Kilger <kilian.kilger@sap.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kilian Kilger <kilian.kilger@sap.com>

The Perforce client name can contain arbitrary characters
which do not decode to UTF-8. Use the fallback strategy
implemented in metadata_stream_to_writable_bytes() also
for the client name.

Signed-off-by: Kilian Kilger <kkilger@gmail.com>
---
    git-p4: Fix bug with encoding of P4 client name

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1285%2Fcohomology%2Fmaint-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1285/cohomology/maint-v1
Pull-Request: https://github.com/git/git/pull/1285

 git-p4.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 8fbf6eb1fe3..e65d6a2b0e1 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -854,12 +854,12 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
             if bytes is not str:
                 # Decode unmarshalled dict to use str keys and values, except for:
                 #   - `data` which may contain arbitrary binary data
-                #   - `desc` or `FullName` which may contain non-UTF8 encoded text handled below, eagerly converted to bytes
+                #   - `desc` or `client` or `FullName` which may contain non-UTF8 encoded text handled below, eagerly converted to bytes
                 #   - `depotFile[0-9]*`, `path`, or `clientFile` which may contain non-UTF8 encoded text, handled by decode_path()
                 decoded_entry = {}
                 for key, value in entry.items():
                     key = key.decode()
-                    if isinstance(value, bytes) and not (key in ('data', 'desc', 'FullName', 'path', 'clientFile') or key.startswith('depotFile')):
+                    if isinstance(value, bytes) and not (key in ('data', 'desc', 'FullName', 'path', 'clientFile', 'client') or key.startswith('depotFile')):
                         value = value.decode()
                     decoded_entry[key] = value
                 # Parse out data if it's an error response
@@ -871,6 +871,8 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
                     continue
             if 'desc' in entry:
                 entry['desc'] = metadata_stream_to_writable_bytes(entry['desc'])
+            if 'client' in entry:
+                entry['client'] = metadata_stream_to_writable_bytes(entry['client'])
             if 'FullName' in entry:
                 entry['FullName'] = metadata_stream_to_writable_bytes(entry['FullName'])
             if cb is not None:

base-commit: e4a4b31577c7419497ac30cebe30d755b97752c5
-- 
gitgitgadget
