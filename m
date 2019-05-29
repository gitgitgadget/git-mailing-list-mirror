Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A32A51F462
	for <e@80x24.org>; Wed, 29 May 2019 21:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfE2V0y (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 17:26:54 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:32896 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfE2V0y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 17:26:54 -0400
Received: by mail-yb1-f201.google.com with SMTP id e67so3031635ybc.0
        for <git@vger.kernel.org>; Wed, 29 May 2019 14:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=N9yK8kLWqZB9/W4pZFn8zxEGLvG7kjJquccLdS39t2M=;
        b=LC9Cd/EXwEVlrx6Og2LIx/i9H7Nq0tbQOqRg+326NjHi19RdH1p86/lc2xS7s9KBNM
         hf03vcnMOn4O7frSBddrH5jMJM2dDnJFYUFBBpEbshyO2Uhqn4GW070qwOHFEVJBdSdF
         7eX7rjSTS0lPDWrGS5h/dbv/pMnBXC7pj4FWpxgZS53ognWbGU69OFFnb5w28H5EyvMS
         fYTS8NidJPlae83twibqi3qqRz/cOflq0jN4sRgOthhgOmD6qNQ9t2V/yR2a6CPkIzZP
         dRjI6y8JyauySVcLAyOUuxAmAfwUPQc87eZCQFQPe3Poo37KSGNXOKffcY214fI4in7u
         5uUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=N9yK8kLWqZB9/W4pZFn8zxEGLvG7kjJquccLdS39t2M=;
        b=tL6HSWSBk0pQOAs22rzbTVXx1v3B4TuQXtJREHP4rsvB2GsMLDLskl5Gvp1/rkkw8P
         i4J2iWi70xvbkjwVc9HlPLnvv11CfYQJEBPFJQlqH7sDasV89de8ns0dXyOMH4HlXvWP
         gqI8rH2rSg3nW/rTE/XfF8SYStcgIOwadwg0h6clMpHt5N+x9owrIAJEmh/RkYNAIMqM
         RU6J+gFJ2moXKBTrQdUpYPH3OeZ1w+NqzOTLOTAll6dxU6DLFLkzyoJl+/Hmxk9t6+Er
         0EGemj1AtwEbRvOuUQ85iUeFk1Wq7zcl9XZ7lfO/7+2c0G1a/crLL7PDeQyyi7R7FzYn
         IpBQ==
X-Gm-Message-State: APjAAAV/McveBebeRxSL3AD6wwoq/EWQXgNTypHH84Ir+/x0jdpFPW5W
        rGqq5cvzfF+oPaeBBL5FGNw84GajEaYQ
X-Google-Smtp-Source: APXvYqwywwFnceLk+IKfp613o6Fa1GTBf/TjqqccTkypoG7uheUlRJ5/MEw218Hh1c5cFQdFWjTo20y5t3p0
X-Received: by 2002:a81:6957:: with SMTP id e84mr89773ywc.350.1559165213332;
 Wed, 29 May 2019 14:26:53 -0700 (PDT)
Date:   Wed, 29 May 2019 14:26:43 -0700
In-Reply-To: <20190529212231.197417-1-delphij@google.com>
Message-Id: <20190529212643.206908-1-delphij@google.com>
Mime-Version: 1.0
References: <20190529212231.197417-1-delphij@google.com>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH v5] clone: respect user supplied origin name when setting up
 partial clone
From:   Xin Li <delphij@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com, git@vger.kernel.org
Cc:     Xin Li <delphij@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Xin Li <delphij@google.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/clone.c  |  2 +-
 t/t5601-clone.sh | 16 +++++++++++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 50bde99618..822208a346 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1215,7 +1215,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			remote_head_points_at, &branch_top);
 
 	if (filter_options.choice)
-		partial_clone_register("origin", &filter_options);
+		partial_clone_register(option_origin, &filter_options);
 
 	if (is_local)
 		clone_local(path, git_dir);
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index d6948cbdab..1fae8ae223 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -634,9 +634,8 @@ test_expect_success CASE_INSENSITIVE_FS 'colliding file detection' '
 	test_i18ngrep "the following paths have collided" icasefs/warning
 '
 
-partial_clone () {
+partial_clone_server () {
 	       SERVER="$1" &&
-	       URL="$2" &&
 
 	rm -rf "$SERVER" client &&
 	test_create_repo "$SERVER" &&
@@ -646,8 +645,14 @@ partial_clone () {
 	test_commit -C "$SERVER" two &&
 	HASH2=$(git hash-object "$SERVER/two.t") &&
 	test_config -C "$SERVER" uploadpack.allowfilter 1 &&
-	test_config -C "$SERVER" uploadpack.allowanysha1inwant 1 &&
+	test_config -C "$SERVER" uploadpack.allowanysha1inwant 1
+}
 
+partial_clone () {
+	       SERVER="$1" &&
+	       URL="$2" &&
+
+	partial_clone_server "${SERVER}" &&
 	git clone --filter=blob:limit=0 "$URL" client &&
 
 	git -C client fsck &&
@@ -664,6 +669,11 @@ test_expect_success 'partial clone' '
 	partial_clone server "file://$(pwd)/server"
 '
 
+test_expect_success 'partial clone with -o' '
+	partial_clone_server server &&
+	git clone -o blah --filter=blob:limit=0 "file://$(pwd)/server" client
+'
+
 test_expect_success 'partial clone: warn if server does not support object filtering' '
 	rm -rf server client &&
 	test_create_repo server &&
-- 
2.22.0.rc1.257.g3120a18244-goog

