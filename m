Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CCCC433DB
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 01:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF211208A9
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 01:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbhAGByz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 20:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbhAGByy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 20:54:54 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2B7C0612EF
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 17:54:14 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id lt17so7709288ejb.3
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 17:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4NwkXRYxeqZUyGrJzQdRwRJOSST9zdW8xl0IWLEzuOY=;
        b=Tz6cEENgWf+IGT5TA326oM9NTORYSdE8sBUqbfMLtNUVbMNhuUEiR4gUYb+G4jxFSO
         eahKQr4lUQm7ZIKsLF+Kh3c2fmSUd2CuTrJZ0uFteb+bQxDEkGta+V8ai19VmwGZ5DQv
         VcvCMNy1wkNs9aV8jThBuvxmHCZhvhlBfZ8FbpE2nTK3EmfN6+xS1T30jviU1s+k7pry
         bXhlY1R0Y/IBJNlNijQ0iA0hjFyx/CuiedRailsy6UBpnrEiUmXPZ0A8i5piRIQcaXHi
         ApoVPZ7Hm1nJR3fAtv76Qq0QIfr4IXXxCxMbNxzl5CxP3PlOdb7eR0IFcjGYoS19DbnO
         b/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4NwkXRYxeqZUyGrJzQdRwRJOSST9zdW8xl0IWLEzuOY=;
        b=krWUTP+Pn28lrQJUtmcr+W3mz0BSy7ILS2G9cI3h0bWu/3R4e8sQCIjCizOvK4AY/o
         V08vZeCfUho4dcDiTJD6D+AYRreukssebNMH3vNQSdf+yZmawpyNlcWVUkUz9uhPmeBj
         cx68cUHMm1RN5y2DpTwaaYX67T3adn3D73MFp/5W4h5ScNbar4EVb4rrfzBedbsFQ+E6
         P2Z/7GMwWBh3Wf5Z+BU2xDMnxeVgGLF8mpkjFEWMnAe61Q9zd24HD9WLxzOcirrcSZX9
         0KG/rpWjHsuHxxRPtcH2Eu0VWmyWQh/9e/t7KGXBwShoxH91mI9a1f+/iKhpfV5wsnLQ
         /l+g==
X-Gm-Message-State: AOAM531TxP2MROZohsTSTYotNw3PT8xLcExuasLU3C9vV12ONeeXdwVI
        6BHRL5XsmCsMfJsfiIrryxhdG2kXfhqEDg==
X-Google-Smtp-Source: ABdhPJxzxvneUBpGisxcINB+XZAle5jD36RidxSKAGyR3pyCUdfDP4Wz6yRKdhOFZZwJwSsjnlOFDg==
X-Received: by 2002:a17:907:a96:: with SMTP id by22mr4493463ejc.171.1609984452980;
        Wed, 06 Jan 2021 17:54:12 -0800 (PST)
Received: from localhost.localdomain ([2001:420:c0c0:1003::137])
        by smtp.gmail.com with ESMTPSA id x17sm2063358edq.77.2021.01.06.17.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 17:54:12 -0800 (PST)
From:   Johan Herland <jherland@gmail.com>
To:     git@vger.kernel.org
Cc:     Roger Strain <rstrain@swri.org>,
        Avery Pennarun <apenwarr@gmail.com>,
        Johan Herland <jherland@gmail.com>
Subject: [BUG?] 'git subtree split' replicates unrelated mainline merges into subtree?
Date:   Thu,  7 Jan 2021 02:54:04 +0100
Message-Id: <20210107015404.3433-1-jherland@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm observing an issue with 'git subtree split' after adding a subtree
(with 'git subtree add') in a topic branch, and then merging the topic
branch back into the main branch (where other/unrelated changes have
accrued in the meantime). The patch below adds a failing t7900-subtree
test case which reproduces the issue.

Here is the repo history just prior to running 'git subtree split'

    $ git log --oneline --graph --decorate
    *   1355f01 (HEAD -> master) merge should be skipped on subtree
    |\  
    | *   adc8ecf (otherbranch) Add 'sub dir/' from commit '5280958b2f997c3ce7bff7192cceb19f55b45cd9'
    | |\  
    | | * 5280958 sub1
    * | a966436 other_unrelated
    |/  
    * 9b6e8f6 main1

The only commit that touches the subtree is the one created by
'git subtree add' (adc8ecf), hence I would expect 'git subtree split'
to NOT synthesize any new history, but simply return the last commit
in the subtree history (5280958)

However, 'git subtree split' ends up synthesizing a history that
replicates the master history since the start of the topic branch
(which consists of entirely unrelated commits) from the superproject
(aka. mainline) into the synthesized subtree history (57cbde8 and its
left-hand parent in this graph):

    $ git log --oneline --graph --all
    *   1355f01 (HEAD -> master) merge should be skipped on subtree
    |\  
    | *   adc8ecf (otherbranch) Add 'sub dir/' from commit '5280958b2f997c3ce7bff7192cceb19f55b45cd9'
    | |\  
    | | | * 57cbde8 (subproj-br) merge should be skipped on subtree
    | |_|/| 
    |/| |/  
    | | * 5280958 sub1
    * | a966436 other_unrelated
    |/  
    * 9b6e8f6 main1

I've been trying to understand how the subtree cache (mis)behaves in
this case. The cache is initially seeded from find_existing_splits(),
which finds these lines the adc8ecf commit message:

    git-subtree-mainline: 9b6e8f677b700a00e9f1715e2624bf5ed756dc85
    git-subtree-split: 5280958b2f997c3ce7bff7192cceb19f55b45cd9

and adds these corresponding entries to the cache:

    9b6e8f6 -> 5280958
    5280958 -> 5280958

In other words, the cache starts out claiming that 5280958 is the
equivalent subtree commit for the 9b6e8f6 mainline commit.
However, in my naive understanding this does not make sense, as
9b6e8f6 _precedes_ the subtree addition, and has no content in
the relevant subdir.

When process_split_commit() proceeds to tackle each subsequent commit
in order, it adds the following cache entries:

    a966436 -> a966436 (notree flag set)
    adc8ecf -> 5280958 (correct, AFAICS)
    1355f01 -> 57cbde8 (synthesizing a merge of a966436 and 5280958)

AFAICS, the problem originates from the combination of:
 - the first mainline commit 9b6e8f6 mapping to subtree commit 5280958
 - the subsequent mainline commit a966436 mapping to _itself_

I suspect that if both had pointed to the same cache state (either
both pointing to 5280958, or both having set the notree flag, the
latter makes more sense, IMHO), then we would skip synthesizing the
incorrect history. However I suspect I've overlooked something as I
have yet to find a simple tweak that does not break other test cases.


Stay safe,
...Johan


---
 contrib/subtree/t/t7900-subtree.sh | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 57ff4b25c1..ef1fcaa3c0 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -971,6 +971,34 @@ test_expect_success 'push split to subproj' '
 	)
 '
 
+# If a subtree is added to a topic branch, which is then merged back to master
+# (where other, unrelated commits have been committed in meantime, a later
+# subtree split should not generate any new history (as nothing has touched
+# the sub dir since it was added)
+
+next_test
+test_expect_success 'split a subtree across mainline history with merge' '
+	subtree_test_create_repo "$subtree_test_count" &&
+	subtree_test_create_repo "$subtree_test_count/sub proj" &&
+	test_create_commit "$subtree_test_count" main1 &&
+	test_create_commit "$subtree_test_count/sub proj" sub1 &&
+	sub_head=$(cd "$subtree_test_count/sub proj"; git rev-parse HEAD) &&
+	(
+		cd "$subtree_test_count" &&
+		git checkout -b otherbranch &&
+		git fetch ./"sub proj" master &&
+		git subtree add --prefix="sub dir" FETCH_HEAD &&
+		git checkout master
+	) &&
+	test_create_commit "$subtree_test_count" other_unrelated &&
+	(
+		cd "$subtree_test_count" &&
+		git merge -m "merge should be skipped on subtree" otherbranch &&
+		git subtree split --prefix="sub dir" --branch subproj-br -d &&
+		check_equal "$(git rev-parse subproj-br)" "$sub_head"
+	)
+'
+
 #
 # This test covers 2 cases in subtree split copy_or_skip code
 # 1) Merges where one parent is a superset of the changes of the other
-- 
2.25.4

