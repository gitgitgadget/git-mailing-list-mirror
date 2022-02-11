Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE03C4332F
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 16:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351603AbiBKQh3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 11:37:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351595AbiBKQh0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 11:37:26 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6174CD66
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 08:37:25 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id om7so8552285pjb.5
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 08:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/JGYhFn8Ke93ParmBIyzq8v6MMMmqm9taRndYwlXlQM=;
        b=czVCPTrTzp2/7G8Y0ywV+OWhjZRAZTGsfFp8r/SHv8sxA1TSOtwYxEDaYiCYtHIhVI
         1RZlDVKtKM9rD4sbcMEV3fPvXvTCv62s6RqoGVLZa2SirhMfo0OB4m0V1vVWKFj7PDlk
         t3FXbX3V/4jxuPIeZt4f/pE1d3XhJQAH1uM2Pm/kN1X7FAHo8+7KRwIm14rzJzH48a5x
         WH9f73mPL6ISKDtBOHzXq2WqsjGxPVomtSMj0+c2hF+9ybn5UvPItL5RfjQ24GDmG9sA
         MZ2te3qT9SM8lWSycbzCNmGEHr9pgr8KVDlv/GyAJjr1oauw0fIPhbz4zOmwjwGozhlu
         QKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/JGYhFn8Ke93ParmBIyzq8v6MMMmqm9taRndYwlXlQM=;
        b=VLFSysKj4qNYNVpwmiuiW3BFPMRL21HJn+E4yw0oYaKOd7PCiF2VBuD3087+CtVNqW
         KXhc/xKm7igWrCVOecaaAEtWlROk6103CLGWhtFgRzXPjlm0w+AKwQ/BPxa5hZbgCKto
         bWh0zXR9LcygkBPCoHYjTEi8iE/Yvo0x0rgBBoapb5odZVa1Ba2BNYhc59e/it27PpwX
         Kvqa4ZpCBf/vzPRziSULMtTGpovH0UcMOrRofKKL7GuwEqnWlMYjNt3ypeTuBKi3sfcN
         8TOYiC+VHlEBA3mj0GUahhaEeMxq/eIjuQCxciMPNXObRE3Ip46d/qDfcI9xnGlxbufH
         QvfQ==
X-Gm-Message-State: AOAM5334idyqDljVaNoMVMs+DFC5IvSECKA04zg6I+f11Oz7jlvlU56L
        HXqCaJh6f3HeFpYWxXm4yTFKkUhrlsk=
X-Google-Smtp-Source: ABdhPJzH2Z2ByqzOFn9wY2ckKT5tItI3O4ZtbKwwRL2qBZuQ1yvvttk27HFTGihJjZ7MR+RXJGbcwg==
X-Received: by 2002:a17:902:8c84:: with SMTP id t4mr2417076plo.78.1644597444554;
        Fri, 11 Feb 2022 08:37:24 -0800 (PST)
Received: from xavier.lan ([2001:470:b:114::cc1])
        by smtp.gmail.com with ESMTPSA id l17sm27450568pfu.61.2022.02.11.08.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 08:37:24 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, paulus@ozlabs.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v3 4/4] gitk: pass --no-graph to `git log`
Date:   Fri, 11 Feb 2022 09:36:27 -0700
Message-Id: <20220211163627.598166-4-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220211163627.598166-1-alexhenrie24@gmail.com>
References: <20220211163627.598166-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
v3: no changes
---
 gitk-git/gitk | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 23d9dd1fe0..24099ce0b8 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -411,8 +411,8 @@ proc start_rev_list {view} {
     }
 
     if {[catch {
-        set fd [open [concat | git log --no-color -z --pretty=raw $show_notes \
-                        --parents --boundary $args "--" $files] r]
+        set fd [open [concat | git log --no-color --no-graph -z --pretty=raw \
+                        $show_notes --parents --boundary $args "--" $files] r]
     } err]} {
         error_popup "[mc "Error executing git log:"] $err"
         return 0
@@ -559,8 +559,9 @@ proc updatecommits {} {
         set args $vorigargs($view)
     }
     if {[catch {
-        set fd [open [concat | git log --no-color -z --pretty=raw $show_notes \
-                        --parents --boundary $args "--" $vfilelimit($view)] r]
+        set fd [open [concat | git log --no-color --no-graph -z --pretty=raw
+                        $show_notes --parents --boundary $args "--"
+                        $vfilelimit($view)] r]
     } err]} {
         error_popup "[mc "Error executing git log:"] $err"
         return
-- 
2.35.1

