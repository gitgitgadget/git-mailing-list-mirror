Return-Path: <SRS0=CKFy=AO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBD5C433E0
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 09:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47C49206A1
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 09:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkZpIKEL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgGCJa6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jul 2020 05:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgGCJa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jul 2020 05:30:58 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9A5C08C5C1
        for <git@vger.kernel.org>; Fri,  3 Jul 2020 02:30:57 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s10so31898824wrw.12
        for <git@vger.kernel.org>; Fri, 03 Jul 2020 02:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=A54hwH2URah7YCYurnXrb1iFD2YN7HHBzTYlRXqE7go=;
        b=DkZpIKELh2uKu6HZu3neyHmhVhkXgoI72l2XaB919Ics5BIK0eEFO6MuZYCeYrecG3
         yQz1MGBP7D/6Fk3/91egMAQa1y/x++Yhl0/NJlDoA6sChlO1FPFegaiWdE3gH8xS0hp4
         8Pg+IXyjW4wIVv73QlXhGzAckzSSHpfkedaTrxXziV65r0DcevJKX6+85FQfntZZx1fw
         xVRAcbWkSZL8anePXqNyHxVQHCHInZfqmmbVR4KLQQkIg1txxCPwRhAMorF/dFPCN9xb
         SMnw9P34BwqTTertTEi+b0cJL/nJOsJZo3bhAWzwUrObV6sbjo9gOPRhkgN+r1I5DDpW
         410w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=A54hwH2URah7YCYurnXrb1iFD2YN7HHBzTYlRXqE7go=;
        b=PdxH67PKAGZbOihJQYtW1u0FWDy3lV4TOoewvx1MXjPy9lSsx8QsVZT6awNg0TtgxK
         YHaVc1Z1ziLEHAdV06tAmOMo227bI2PLmL/fp7PwK7Vm2HGDHtVbz4ZkCE5xbE45llDh
         6CPUbpog07OQ1d1t1Uxlpeo1l6z9BX3WJk2oRrQ5pMRseBIOafJ94E7k9HUu0Gvm/vKV
         I92YiQP7LseXCiFogrKKFQ9PemcMFUzhOSw2xyxK4kpJaEfF5oU6eDSGj/TMTdEdX3ss
         oVdFATyFM3LlR+UZ4mw7HT07JgTEspJGCWXIh8daglHjHcdMWAqVFYicB5x94nYl7nhc
         b5Ig==
X-Gm-Message-State: AOAM530nqZeLo5UykwXXWvGi25sYeq3Yw9FTHLr2aRtZEkzyoIirXyuN
        rMpiorROf7bzu2k8IRiPITPwo6E7
X-Google-Smtp-Source: ABdhPJzGBIusGZ/+UpgVJ8I8ZhiRCY8TbD+2WoahRd+aiMDw7M5j7NwS4wZHGKgNnDXura2jjofWHg==
X-Received: by 2002:adf:f504:: with SMTP id q4mr35254870wro.163.1593768656355;
        Fri, 03 Jul 2020 02:30:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f12sm13908418wrj.48.2020.07.03.02.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 02:30:55 -0700 (PDT)
Message-Id: <pull.815.git.git.1593768655179.gitgitgadget@gmail.com>
From:   "Martin Bektchiev via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Jul 2020 09:30:55 +0000
Subject: [PATCH] commit: correctly escape @ of stashes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Martin Bektchiev <martinb@gmail.com>,
        Martin Bektchiev <martin.bektchiev@progress.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Martin Bektchiev <martin.bektchiev@progress.com>

Autocomplete suggestions for stashes are broken due to `stash@`
being suggested without escaping.

Reproducible on `GNU bash, version 3.2.57(1)-release` and
`macOS Catalina 10.15.5`.

Signed-off-by: Martin Bektchiev <martin.bektchiev@progress.com>
---
    Correctly escape @ of stashes
    
    Autocomplete suggestions for stashes are broken due to stash@being
    suggested without escaping.
    
    Reproducible on GNU bash, version 3.2.57(1)-release
    (x86_64-apple-darwin19)and macOS Catalina 10.15.5.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-815%2Fmbektchiev%2Fpatch-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-815/mbektchiev/patch-1-v1
Pull-Request: https://github.com/git/git/pull/815

 contrib/completion/git-completion.bash | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index de5d0fbbd1..986a7352ef 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2999,12 +2999,14 @@ _git_stash ()
 				__git_complete_refs
 			else
 				__gitcomp_nl "$(__git stash list \
-						| sed -n -e 's/:.*//p')"
+						| sed -n -e 's/:.*//p' \
+						| sed 's/@/\\@/')"
 			fi
 			;;
 		show,*|apply,*|drop,*|pop,*)
 			__gitcomp_nl "$(__git stash list \
-					| sed -n -e 's/:.*//p')"
+					| sed -n -e 's/:.*//p' \
+					| sed 's/@/\\@/')"
 			;;
 		*)
 			;;

base-commit: a08a83db2bf27f015bec9a435f6d73e223c21c5e
-- 
gitgitgadget
