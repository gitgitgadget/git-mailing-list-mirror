Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 427A120193
	for <e@80x24.org>; Thu,  4 Aug 2016 19:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965157AbcHDTwN (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 15:52:13 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35609 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758997AbcHDTwK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 15:52:10 -0400
Received: by mail-pa0-f49.google.com with SMTP id iw10so85426031pac.2
        for <git@vger.kernel.org>; Thu, 04 Aug 2016 12:52:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1xqrgMtCnvNee+Wg8tGXaBb5QHsT1Svy9dmSSr8msn4=;
        b=Gt7fTXG3Csj2zUivJ8SCL4t72VZI5x9+eTpiSAjfRUEvpsXVj+cnGyMUW6J00i8HNi
         IHIojlIJ7ZJryD5psYbQxrnO8kw4wLAmajn7/9LasPY0tmlCw2RzInUP9mVH46szFs9I
         KnFHvaYV0bdvOdTNZaDfIV4oyshHBGQb7FBtknWnWEj6LqlqkHagr8fel27eei2pwNMk
         aX/rGHF/bpyi3E+LwRDDojiULkqJjby9zV48+vd+MIZoMKgNP+HQVC2KkiaXgk+pz+rB
         0knp+jr5IqtvMmvuCCAxQPMdIW8pGUG4z4ITjfAETK3L7X+z/o7qxjQ7T211tzIuMGD7
         myJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1xqrgMtCnvNee+Wg8tGXaBb5QHsT1Svy9dmSSr8msn4=;
        b=eXP+rcBycgDt46H31B1gJPJwLUJRbcV7XrmNphJQM++sLBD4s4EpVlPehm9MgtFyWI
         EhQRpKrB+VyDd8ek+iNQ4VmMGlPxlifHekUsZlg7zHAp4lLOWbKBhCbDWy7F+OvjlM8k
         Ax7SBAlYyTDfNRQtUO6fElLV4Mj8OeZBFYe5BkwxcLUQH42drdfbKg2jKZyFBByF7ylA
         paKCNhb6m3LHgwUs4aFTMgsIaa+9jQJUVsVc59TA6C0lEJC8OWV18gJTiMbIwP1y6AWp
         5VCuuwWi0+Tv3gJAzpnmf5a65pElDEKLWzx+8N7Ms7I6ZA3dzzQhIXHXAfw7BaWwRDCS
         5sqQ==
X-Gm-Message-State: AEkoouuW4bqBlQLqCrDCWODTim4dwFk8kYJNzncs+0YhG30go+X6IJ2tY+Tu1hlEP9LkGJv8
X-Received: by 10.66.242.201 with SMTP id ws9mr128400247pac.7.1470340329505;
        Thu, 04 Aug 2016 12:52:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b86b:a022:8342:c00c])
        by smtp.gmail.com with ESMTPSA id m128sm22282437pfm.42.2016.08.04.12.52.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 04 Aug 2016 12:52:08 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, mst@redhat.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/6] t7408: merge short tests, factor out testing method
Date:	Thu,  4 Aug 2016 12:51:55 -0700
Message-Id: <20160804195159.7788-3-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.572.g9d9644e.dirty
In-Reply-To: <20160804195159.7788-1-sbeller@google.com>
References: <20160804195159.7788-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Tests consisting of one line each can be consolidated to have fewer tests
to run as well as fewer lines of code.

When having just a few git commands, do not create a new shell but
use the -C flag in Git to execute in the correct directory.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t7408-submodule-reference.sh | 50 +++++++++++++++---------------------------
 1 file changed, 18 insertions(+), 32 deletions(-)

diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
index afcc629..1416cbd 100755
--- a/t/t7408-submodule-reference.sh
+++ b/t/t7408-submodule-reference.sh
@@ -10,6 +10,16 @@ base_dir=$(pwd)
 
 U=$base_dir/UPLOAD_LOG
 
+test_alternate_usage()
+{
+	alternates_file=$1
+	working_dir=$2
+	test_line_count = 1 $alternates_file &&
+	echo "0 objects, 0 kilobytes" >expect &&
+	git -C $working_dir count-objects >current &&
+	diff expect current
+}
+
 test_expect_success 'preparing first repository' '
 	test_create_repo A &&
 	(
@@ -42,44 +52,20 @@ test_expect_success 'preparing superproject' '
 	)
 '
 
-test_expect_success 'submodule add --reference' '
+test_expect_success 'submodule add --reference uses alternates' '
 	(
 		cd super &&
 		git submodule add --reference ../B "file://$base_dir/A" sub &&
 		git commit -m B-super-added
-	)
-'
-
-test_expect_success 'after add: existence of info/alternates' '
-	test_line_count = 1 super/.git/modules/sub/objects/info/alternates
-'
-
-test_expect_success 'that reference gets used with add' '
-	(
-		cd super/sub &&
-		echo "0 objects, 0 kilobytes" > expected &&
-		git count-objects > current &&
-		diff expected current
-	)
-'
-
-test_expect_success 'cloning superproject' '
-	git clone super super-clone
-'
-
-test_expect_success 'update with reference' '
-	cd super-clone && git submodule update --init --reference ../B
-'
-
-test_expect_success 'after update: existence of info/alternates' '
-	test_line_count = 1 super-clone/.git/modules/sub/objects/info/alternates
+	) &&
+	test_alternate_usage super/.git/modules/sub/objects/info/alternates super/sub
 '
 
-test_expect_success 'that reference gets used with update' '
-	cd super-clone/sub &&
-	echo "0 objects, 0 kilobytes" > expected &&
-	git count-objects > current &&
-	diff expected current
+test_expect_success 'updating superproject keeps alternates' '
+	test_when_finished "rm -rf super-clone" &&
+	git clone super super-clone &&
+	git -C super-clone submodule update --init --reference ../B &&
+	test_alternate_usage super-clone/.git/modules/sub/objects/info/alternates super-clone/sub
 '
 
 test_done
-- 
2.9.2.572.g9d9644e.dirty

