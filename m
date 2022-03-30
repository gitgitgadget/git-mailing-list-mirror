Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97007C433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 18:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348538AbiC3SQR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 14:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349882AbiC3SQM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 14:16:12 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4C41095
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 11:14:18 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id i132-20020a1c3b8a000000b0038ce25c870dso398593wma.1
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 11:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=Ay5rEPC2JrBf05NW5L33xfjMWD3qtLGeWlZC91mweqE=;
        b=GH7gPF/cvJQz1HxIx2jZ9Kqq5o/UOPQ7pEA9M2IJBIMK1OS4TnDU4FDWmr1+HEq/Rf
         shW/dsX9IWM6CWTLRACogA6erOPOSJOG5sk9gQEr6ig4jO9mk1FnC36mcEwH/3gITHOp
         EmE+oyOBXlXGb9RSPyysL48nnlA72M1/E2MNuUZEWo1L062WFBZF0R41E1+rLeX85/Pw
         u3zTNKOBsofQCRoofYQpdmOFpdgGdB4hXcR115lqTZ3R3hQv5E759kjBENda6yB2LzFZ
         WpYHQo2gPWIgFfAKgiMRZlOGJBQ3cuKauPxkWsQ4EE+yKohxkmubrhLd3nTVsCQwLYxe
         a0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Ay5rEPC2JrBf05NW5L33xfjMWD3qtLGeWlZC91mweqE=;
        b=rTLZ1lxpj7R3X33SujPniPkF20DRq+Jk8pjsRQKZlLGHeLST0ioimoAIM+GEp6Y7Vt
         M4oBZJrQ2Rs/xJ2MiNtomHWL53zNw/A0nZHB+MPXrCx1Zw4QJHO4bAuYECqtHPfbb2bK
         gFDoNeqWMM1bONc/MUnGygD85Knot9LRA7od/fO350VVImk38+xxNqVepmidQvJkvodk
         SIeDgAO7PmfbTVMVm/+58nO4hG6MCLd8+A1SwycVEcwMRXwcdBqY6/Aq/c2r705M7/f3
         NIznsoySmdRRtxjniR1+d7bsV2D980mQ1/JhOvD3+a5BwA+k/fikRTkeDMieOG+wax9h
         upGw==
X-Gm-Message-State: AOAM5328YVlEm5l7hMqmFRKvR9e5qzoB/iSmg2FXlTvkrsj59Idgi5I+
        ar1Si85eaMjTSpEI93oVRPze6zjl0bs=
X-Google-Smtp-Source: ABdhPJyMqoLgegD6ZN+QJAPfbl185SBpnjB3vW9ErsQsmoOJ3NDVT5wNYcEn5zw2xsQCjJHSCiFzvw==
X-Received: by 2002:a05:600c:1c20:b0:38c:ae37:c1ae with SMTP id j32-20020a05600c1c2000b0038cae37c1aemr660442wms.203.1648664057000;
        Wed, 30 Mar 2022 11:14:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i10-20020a0560001aca00b00203daf3759asm18853136wry.68.2022.03.30.11.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 11:14:16 -0700 (PDT)
Message-Id: <pull.1194.git.1648664055986.gitgitgadget@gmail.com>
From:   "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Mar 2022 18:14:15 +0000
Subject: [PATCH] object-file: pass filename to fsync_or_die
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

If we die while trying to fsync a loose object file, pass the actual
filename we're trying to sync. This is likely to be more helpful for a
user trying to diagnose the cause of the failure than the former
'loose object file' string. It also sidesteps any concerns about
translating the die message differently for loose objects versus
something else that has a real path.

Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
    object-file: pass filename to fsync_or_die
    
    If we die while trying to fsync a loose object file, pass the actual
    filename we're trying to sync. This is likely to be more helpful for a
    user trying to diagnose the cause of the failure than the former 'loose
    object file' string. It also sidesteps any concerns about translating
    the die message differently for loose objects versus something else that
    has a real path.
    
    Reported-by: Ævar Arnfjörð Bjarmason avarab@gmail.com Signed-off-by:
    Neeraj Singh neerajsi@microsoft.com
    
    ------------------------------------------------------------------------
    
    This is in response to:
    https://lore.kernel.org/git/220321.861qyv9rjr.gmgdl@evledraar.gmail.com/
    
    > Unrelated nit: this API is producing sentence lego unfriendly to
    > translators.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1194%2Fneerajsi-msft%2Fns%2Ffsync-die-filename-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1194/neerajsi-msft/ns/fsync-die-filename-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1194

 object-file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/object-file.c b/object-file.c
index b254bc50d70..5ffbf3d4fd4 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1888,16 +1888,16 @@ void hash_object_file(const struct git_hash_algo *algo, const void *buf,
 }
 
 /* Finalize a file on disk, and close it. */
-static void close_loose_object(int fd)
+static void close_loose_object(int fd, const char *filename)
 {
 	if (the_repository->objects->odb->will_destroy)
 		goto out;
 
 	if (fsync_object_files > 0)
-		fsync_or_die(fd, "loose object file");
+		fsync_or_die(fd, filename);
 	else
 		fsync_component_or_die(FSYNC_COMPONENT_LOOSE_OBJECT, fd,
-				       "loose object file");
+				       filename);
 
 out:
 	if (close(fd) != 0)
@@ -2011,7 +2011,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 		die(_("confused by unstable object source data for %s"),
 		    oid_to_hex(oid));
 
-	close_loose_object(fd);
+	close_loose_object(fd, tmp_file.buf);
 
 	if (mtime) {
 		struct utimbuf utb;

base-commit: 805e0a68082a217f0112db9ee86a022227a9c81b
-- 
gitgitgadget
