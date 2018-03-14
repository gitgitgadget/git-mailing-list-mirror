Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FD551F404
	for <e@80x24.org>; Wed, 14 Mar 2018 18:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751551AbeCNSm7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 14:42:59 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38941 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751470AbeCNSm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 14:42:56 -0400
Received: by mail-pg0-f65.google.com with SMTP id e3so1737136pga.6
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 11:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=2eLSbFh01q2qspRpnnZUO3uDLWPtWvEGkm3lO65ducM=;
        b=jHytvp0YPaQpHuBqN8TEUKo0RiidzV7hwqSBu3SzU/rlbjlCch7LyLEfzgfMa+DMJS
         rbhuGGu3LjYbMBpDIb9R1KTkVkD2tOBnt5BoE7hWCJ4yCw3IBMSLw2Nn9fPLvS8ZkrpE
         yQ6l7L5WmcEg5dk9TXbH/RPfH6aqhDbouiDkxd/+zvxt7pT85xq5B98386+WsFxUbOGy
         CvCiktyfBTdfAAcKa92Sjw4Iq1e9dZQNBX0ny2VqzLT8oIk5XTyPYT9tugc0ANpqAFs9
         aicJ9sWdHxBKCUvq2R5lHkj2Hz2Ep6kjkPw4BpWrosXz2kyDSAMJNob6NXoewDhcGDbl
         AkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=2eLSbFh01q2qspRpnnZUO3uDLWPtWvEGkm3lO65ducM=;
        b=Omsbgt7wCQTwsl7vIq+6tMlzBOIL4pmpIp9qXJ93kaXOwekXRm0Qm/ZKvrmFLlV2OQ
         GVCY9lbn5gtTBeByeitWpS4yR5aP/UukiOJ31gPOxsbdADqaq4/deEzs9hM+aX3JaZzE
         1cf146f40YShSYgCZZKI2QO931mWhFWxiRDqK1HlTjM7DeN0k7c0UoPerk+ejJmV7Cn6
         BLb7XJ6z0svfAB2Yt2yKVvo9EDA7h0I8Lnzsg7mdBdnXKru1FveLqV/A3gIDT+nZOEpw
         toyoClOHpr2jZ23+OUNbxUHpoK7A1GvZbfOoY2tO4AQRQciJyEq857Mj1moyHzDlx8yM
         WstA==
X-Gm-Message-State: AElRT7ECToitVX6etslAMWvWmiJYi3agy7y/Uxf1Pu5NrzgmuL65ACla
        cAycRrxwAveBnRI17JEC6/hbp8Te47U=
X-Google-Smtp-Source: AG47ELubAmpl0/KXQhXo3cNhwJoIGxyDfmu7xon1BvzIDDFQyTk22oTKer7K7h5TWzXrpSrmrOLvJg==
X-Received: by 10.99.126.24 with SMTP id z24mr4571156pgc.110.1521052975412;
        Wed, 14 Mar 2018 11:42:55 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id l22sm6255351pfj.98.2018.03.14.11.42.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Mar 2018 11:42:54 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 2/2] fetch-pack: do not check links for partial fetch
Date:   Wed, 14 Mar 2018 11:42:41 -0700
Message-Id: <c2f59866a1b1dc5f11713e1922eac2521ef98b07.1521052825.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.16.2.520.gd0db9edba.dirty
In-Reply-To: <cover.1521052825.git.jonathantanmy@google.com>
References: <cover.1521052825.git.jonathantanmy@google.com>
In-Reply-To: <cover.1521052825.git.jonathantanmy@google.com>
References: <cover.1521052825.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When doing a partial clone or fetch with transfer.fsckobjects=1, use the
--fsck-objects instead of the --strict flag when invoking index-pack so
that links are not checked, only objects. This is because incomplete
links are expected when doing a partial clone or fetch.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c             | 13 +++++++++++--
 t/t5616-partial-clone.sh | 11 +++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index d97461296..1d6117565 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -886,8 +886,17 @@ static int get_pack(struct fetch_pack_args *args,
 	    ? fetch_fsck_objects
 	    : transfer_fsck_objects >= 0
 	    ? transfer_fsck_objects
-	    : 0)
-		argv_array_push(&cmd.args, "--strict");
+	    : 0) {
+		if (args->from_promisor)
+			/*
+			 * We cannot use --strict in index-pack because it
+			 * checks both broken objects and links, but we only
+			 * want to check for broken objects.
+			 */
+			argv_array_push(&cmd.args, "--fsck-objects");
+		else
+			argv_array_push(&cmd.args, "--strict");
+	}
 
 	cmd.in = demux.out;
 	cmd.git_cmd = 1;
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 29d863118..cee556536 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -143,4 +143,15 @@ test_expect_success 'manual prefetch of missing objects' '
 	test_line_count = 0 observed.oids
 '
 
+test_expect_success 'partial clone with transfer.fsckobjects=1 uses index-pack --fsck-objects' '
+	git init src &&
+	test_commit -C src x &&
+	test_config -C src uploadpack.allowfilter 1 &&
+	test_config -C src uploadpack.allowanysha1inwant 1 &&
+
+	GIT_TRACE="$(pwd)/trace" git -c transfer.fsckobjects=1 \
+		clone --filter="blob:none" "file://$(pwd)/src" dst &&
+	grep "git index-pack.*--fsck-objects" trace
+'
+
 test_done
-- 
2.16.2.520.gd0db9edba.dirty

