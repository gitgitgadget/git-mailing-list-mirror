Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 705521F403
	for <e@80x24.org>; Mon, 11 Jun 2018 21:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934656AbeFKVvd (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 17:51:33 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39932 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934508AbeFKVvb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 17:51:31 -0400
Received: by mail-pl0-f65.google.com with SMTP id f1-v6so13097530plt.6
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 14:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=y4EHbgVkTXppEqdIspou+2YMD3p8Nee0IZFAsQo8R+c=;
        b=cubKDz9BT3ETJI16BYC76hKmphjs2mxJgdr4q3cAq+CgJAlRbTjmPfPLYcxOJr91Dz
         wP2WlVfAgu47HJvyP9AOL8f14Uthk/1xcFoOF3DYAZymeFad12Ayg231pNbz0pzMoCCo
         XfOqIEYpb8b/d4vql9CzRpIRaw2xZZGJqbyROED/Gz+aZaD/RzCan9hZ1ySH5kzeWAvO
         iV0/Mn4q+R8FnErmcv05EE22p3hRAk8Got2iVP2W+C9zQmdVYXpO+JaO3hyec7sk0hev
         B+E1jEOAGPQs1b2CcdbHpGjhMK8nljo0Hgr6zPoJ46ZVVOeHnlyfI61Ns2nNGpXFnfnC
         FbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y4EHbgVkTXppEqdIspou+2YMD3p8Nee0IZFAsQo8R+c=;
        b=D48ajgRZ+bqDCzYTZUIujBxJcrK0Hhjkenv3p5pRVbrU9ncNHzqLAuQLj+2YNnY77b
         WbQ7KmIlUm1ptDu/3SirAd08dDLOBJ2nFJ1vdUhOVTsGiypIyzytf2TJbxLK9cmf5H0T
         JGeP9NDJP2gs9Pkcn6rzi/FOWuP2WLw5qNiIXD9XomCwLBjUpCx0N3CT2RNHb23S6Sbi
         Yf4TUIMEWcHE56ZiZMyH4nUlwC4y+KkwTdOLo4gT3znTcZOsno8YlpShyyfRMPv0/Mfn
         AFixE1P8r8FqaV37TIL2cKwnmlptBeNOF1sxNv+vbMDXK8ssD7Twy1EFI65b2jKdiMKf
         NbJg==
X-Gm-Message-State: APt69E0AmpERb2d9UuTP60UL6bZjRNnDMkOxF/yqQL56X01yjKWbYPJU
        8guF2LHCLqQ1B1Wmb/F+NKs6TBMZwTo=
X-Google-Smtp-Source: ADUXVKLmY8Nr0Ok7jnmRfORJrZ8WkExMI7IMbHqYhRzJ9IaQR60N4kOCMBVfPejYMVHIEgVgZi/8FA==
X-Received: by 2002:a17:902:ac1:: with SMTP id 59-v6mr941383plp.36.1528753890380;
        Mon, 11 Jun 2018 14:51:30 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id x72-v6sm69616785pff.176.2018.06.11.14.51.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 14:51:29 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH] list-objects: check if filter is NULL before using
Date:   Mon, 11 Jun 2018 14:51:26 -0700
Message-Id: <20180611215126.205944-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In partial_clone_get_default_filter_spec(), the
core_partial_clone_filter_default variable may be NULL; ensure that it
is not NULL before using it.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
This was noticed by someone else at $DAY_JOB when trying to use a
partial clone with no core.partialclonefilter set.
---
 list-objects-filter-options.c | 2 ++
 t/t0410-partial-clone.sh      | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 6a3cc985c4..c0e2bd6a06 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -146,6 +146,8 @@ void partial_clone_get_default_filter_spec(
 	/*
 	 * Parse default value, but silently ignore it if it is invalid.
 	 */
+	if (!core_partial_clone_filter_default)
+		return;
 	gently_parse_list_objects_filter(filter_options,
 					 core_partial_clone_filter_default,
 					 NULL);
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index cc18b75c03..4984ca583d 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -23,7 +23,15 @@ promise_and_delete () {
 	delete_object repo "$HASH"
 }
 
+test_expect_success 'extensions.partialclone without filter' '
+	test_create_repo server &&
+	git clone --filter="blob:none" "file://$(pwd)/server" client &&
+	git -C client config --unset core.partialclonefilter &&
+	git -C client fetch origin
+'
+
 test_expect_success 'missing reflog object, but promised by a commit, passes fsck' '
+	rm -rf repo &&
 	test_create_repo repo &&
 	test_commit -C repo my_commit &&
 
-- 
2.17.0.582.gccdcbd54c4

