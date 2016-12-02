Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D10E81FC96
	for <e@80x24.org>; Fri,  2 Dec 2016 22:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755356AbcLBWnb (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 17:43:31 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36396 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753953AbcLBWn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 17:43:29 -0500
Received: by mail-pf0-f196.google.com with SMTP id c4so14151568pfb.3
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 14:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=opvYi1AjasG6GwMONMhAZAxAKLA6aL/eF31+UMLlDgI=;
        b=W+tDMmTZTZHhZt8HrKI6hckl5UCbN9MCd8PZtodnxRdqr8QXMD/DIUvUljHuGBRdtr
         pk357jKBc4N1y2MQP6ZGo58qDlM8hwgmKE6/FrzEiBI721Ad+AspOkjJzXDAyZ6bZEKN
         Dwfdw2YWRHVqZfd1WEVA9RNTsg8pROOeyM+ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=opvYi1AjasG6GwMONMhAZAxAKLA6aL/eF31+UMLlDgI=;
        b=Vg25zr7NnN76HFFppOb9VNkZCpOdRVPUmLBIfTB1NRKvSDsIin3sCbcfZikMiwVfZB
         uIiFJGwZJ+M00xe4tesVnSroAMBrJRYoqVxR/xdOXN3lGt43H1rhU8OW1BAYhUG0RjVl
         LFBLxSJ9EoBpXwhH9DfqUXi56QkKmPumzPmnRuSSrO+5J+Le7QzeDG7VdMJOn/3QaJmR
         UabiyD552OAD2BVfQk4HW9KpgpCvOByugT0Ol/855M+2EvOCfhY6xPVH8h4iWoCCC0Wk
         FsXnQleysI7dK4MNpAD2c+dWf5A7INUxB5lOauI4/63mnHYTWE8E4+lNBtZ9WAgj8ZvJ
         +IRw==
X-Gm-Message-State: AKaTC0048hzyz4IkrpgVBpaPqS/UkveF/AKEHwYqgaQ0xy6ymV3vf7+aTq5P3kHpKeFMkA==
X-Received: by 10.84.136.164 with SMTP id 33mr100866406pll.148.1480718608963;
        Fri, 02 Dec 2016 14:43:28 -0800 (PST)
Received: from lgd-kipper.corp.roku ([50.224.7.248])
        by smtp.gmail.com with ESMTPSA id 16sm9992784pfk.54.2016.12.02.14.43.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Dec 2016 14:43:28 -0800 (PST)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     Vinicius Kursancew <viniciusalexandre@gmail.com>,
        larsxschneider@gmail.com, Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 1/2] git-p4: support git-workspaces
Date:   Fri,  2 Dec 2016 22:43:18 +0000
Message-Id: <20161202224319.5385-2-luke@diamand.org>
X-Mailer: git-send-email 2.11.0.274.g0ea315c
In-Reply-To: <20161202224319.5385-1-luke@diamand.org>
References: <20161202224319.5385-1-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach git-p4 about git-workspaces.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index 0c4f2afd2..5e2db1919 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -566,6 +566,12 @@ def isValidGitDir(path):
     if (os.path.exists(path + "/HEAD")
         and os.path.exists(path + "/refs") and os.path.exists(path + "/objects")):
         return True;
+
+    # git workspace directory?
+    if (os.path.exists(path + "/HEAD")
+        and os.path.exists(path + "/gitdir")):
+        return True
+
     return False
 
 def parseRevision(ref):
-- 
2.11.0.274.g0ea315c

