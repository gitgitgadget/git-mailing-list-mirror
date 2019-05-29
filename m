Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77F291F462
	for <e@80x24.org>; Wed, 29 May 2019 21:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfE2VWg (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 17:22:36 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:46447 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfE2VWg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 17:22:36 -0400
Received: by mail-qk1-f201.google.com with SMTP id 18so3042019qkl.13
        for <git@vger.kernel.org>; Wed, 29 May 2019 14:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vJi0q6GxRQ7l+KxhqglCbmOrqB8/BF6S7u9oZop9i4M=;
        b=koc55Kj4LEmnww/IXxnMx4dAe4RGxMLOBgBRdfpMfjN3G03+aJldQWhGSufWyf6E4U
         BPnU3ec3iHzoQ/iteneKCzSyCNM+TdXRgCdREx6Otd+DGHhjmPrvxWDuYEfMHpnKkC3L
         1ou+BJTK3yeNVWqA0QyodHG7e51zIwuUQ+QfT+KtJ0/r5TZ3fTAQ6fCS3vNrENmxDaK5
         Qabo2paXtU4ayIAI2C3Y7fP9USqNZyS/UlGHKRwj3evvGlqgGXTKxb46jYGw2rmE3ynr
         AwdQum7gazApjGiSB5/re8CYN0satDPVFniEylNy42Qaj1/OG23o1umLi3l1V2UPD7WR
         DY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vJi0q6GxRQ7l+KxhqglCbmOrqB8/BF6S7u9oZop9i4M=;
        b=hdBH7/DGvd/tbPQ71hVjORjeb8nHviklufAAsKqzl490Q673tYOGUo7Ba4WD3LM7Op
         I9Sk9Rp2irH4zN6gh87d2rjyqdDR7t6PqvR0g8WH+yz1/h/zGGiVpFNhpRTP14rFthjG
         RxOhuEJZsloybbTV81g7lCoAUYBvSqdt6oCL/z1DkAFtMrzswuqcPPmTxTL0p5H/Gd4H
         zVi2jc1ezeAYBeCxSsOhm1dSYzYEA3ZEtWkedB5jyXp9Uhh4iCgeuplCdbv4xOYjIuqs
         HP0wc+6dPFzDsdG18eSxzZvOJvYryrByFEIeb2V/O95tj3BTjsI70gFr6DwjL0msAEmG
         GR0Q==
X-Gm-Message-State: APjAAAXGwdvfoTqowbbQxTfQQXOaymFdAIeR3R8i8upg6w6OwT3OxCxu
        KTyDMOkgGMENpdgObn7KMkby2tjdgtH2
X-Google-Smtp-Source: APXvYqzuqo502CxX7NVAYdv4bcccwAQIf4tQtXWRWjDGgrx0JatAh8ZcSzDHn/MesoFdFJ+UfunSyn1Wi374
X-Received: by 2002:a0c:b17c:: with SMTP id r57mr133063qvc.207.1559164955363;
 Wed, 29 May 2019 14:22:35 -0700 (PDT)
Date:   Wed, 29 May 2019 14:22:31 -0700
In-Reply-To: <20190529211610.190269-1-delphij@google.com>
Message-Id: <20190529212231.197417-1-delphij@google.com>
Mime-Version: 1.0
References: <20190529211610.190269-1-delphij@google.com>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH v4] clone: respect user supplied origin name when setting up
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
index d6948cbdab..22066bb88c 100755
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
+	partial_clone_server server "file://$(pwd)/server" &&
+	git clone -o blah --filter=blob:limit=0 "file://$(pwd)/server" client
+'
+
 test_expect_success 'partial clone: warn if server does not support object filtering' '
 	rm -rf server client &&
 	test_create_repo server &&
-- 
2.22.0.rc1.257.g3120a18244-goog

