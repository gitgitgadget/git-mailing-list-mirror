Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26F222047F
	for <e@80x24.org>; Wed, 26 Jul 2017 23:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751568AbdGZXaL (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 19:30:11 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36049 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751502AbdGZXaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 19:30:09 -0400
Received: by mail-pf0-f180.google.com with SMTP id z129so36897394pfb.3
        for <git@vger.kernel.org>; Wed, 26 Jul 2017 16:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=WHgKGzgzigUhz60OKkWhvrNNrOfrT4ams0/l3ae7SuA=;
        b=XQUS0VepeVCaJ1levVGwzCRX+emoXf5kPXM4LiXH+oWifmtdEDlZgg6bxJEJ22L4gu
         w6p4OPuGAqf3kgDbFdesSPvlmL9Iln9raBxj8Cn0roR16gonZAWtym8RmcUfCvaAGddt
         3ZgoKgy3Q1D/AQLRy/I2bzth2erEgN3zRmMMUUvF2M9oTS+RT5rxlKjJ2Ydt8UoPGfKO
         KXsr90ph2zN/LEN2iF1vBZ9wEo/crIg4LJJ2bZDW8BOGx+xSj4EqqHHmLfS4az1xdz/W
         xEcLTXGygrZ94hFVuVS+vqTdD7TMjSPeWs1MTA5ZZkfdxKnguA4CCUL/6wek2aTDwSSC
         xhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=WHgKGzgzigUhz60OKkWhvrNNrOfrT4ams0/l3ae7SuA=;
        b=EYZDYZlJQXjWjBKfG2T9TbebKYEMcQcZ+ajNwK87q8ASNOBzm+0YReuJ+VKvCWcA3X
         1g6z2sbmury5zYMcARDUpeoyKQcmSptSS13JSCirV7Gi0pr+1IFFHiuDPENStVtJjJ2n
         jDH7unZOVvQbFkZGSyjujtE/E9BzyZl1Dv/s4/b5r0Cix3Z7ziMwZ3TlnXkFTWsEykYc
         ACc7AXU+NB1/81ROatYESb5FWmJY9wqMOisY4ZUa1pH4Rn0SFZY3YYpKD/2Dh3F13c6p
         +30EfuyAJ1Yr7WcDE1FUB5Z2k71egmwRoLu+oXdmGaOVgknK2VUMy0vnb+fJYkYdCCeK
         sbgw==
X-Gm-Message-State: AIVw112cFWkPgkCMkdr7MDL/idiBYdnlIRbkiQtbdQcMDOX2FICUWBY5
        g1FeSOLBaKyj3Gn+k7kEZQ==
X-Received: by 10.99.114.1 with SMTP id n1mr2240275pgc.63.1501111808685;
        Wed, 26 Jul 2017 16:30:08 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id e131sm299668pfc.93.2017.07.26.16.30.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Jul 2017 16:30:07 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peartben@gmail.com,
        christian.couder@gmail.com
Subject: [RFC PATCH 2/4] fsck: support refs pointing to lazy objects
Date:   Wed, 26 Jul 2017 16:30:00 -0700
Message-Id: <4c8bc7ab543d8d0d60719f65bd8a150c66123056.1501111615.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.rc0.400.g1c36432dff-goog
In-Reply-To: <cover.1501111615.git.jonathantanmy@google.com>
References: <cover.1501111615.git.jonathantanmy@google.com>
In-Reply-To: <cover.1501111615.git.jonathantanmy@google.com>
References: <cover.1501111615.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach fsck to not treat refs with missing targets as an error when
extensions.lazyobject is set.

For the purposes of warning about no default refs, such refs are still
treated as legitimate refs.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fsck.c         |  8 ++++++++
 t/t0410-lazy-object.sh | 20 ++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 1cfb8d98c..e29ff760b 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -438,6 +438,14 @@ static int fsck_handle_ref(const char *refname, const struct object_id *oid,
 
 	obj = parse_object(oid);
 	if (!obj) {
+		if (repository_format_lazy_object) {
+			/*
+			 * Increment default_refs anyway, because this is a
+			 * valid ref.
+			 */
+			default_refs++;
+			return 0;
+		}
 		error("%s: invalid sha1 pointer %s", refname, oid_to_hex(oid));
 		errors_found |= ERROR_REACHABLE;
 		/* We'll continue with the rest despite the error.. */
diff --git a/t/t0410-lazy-object.sh b/t/t0410-lazy-object.sh
index 36442531f..00e1b4a88 100755
--- a/t/t0410-lazy-object.sh
+++ b/t/t0410-lazy-object.sh
@@ -29,4 +29,24 @@ test_expect_success '...but succeeds if lazyobject is set' '
 	git -C repo fsck
 '
 
+test_expect_success 'fsck fails on lazy object pointed to by ref' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo 1 &&
+
+	A=$(git -C repo commit-tree -m a HEAD^{tree}) &&
+
+	# Reference $A only from ref, and delete it
+	git -C repo branch mybranch "$A" &&
+	delete_object repo "$A" &&
+
+	test_must_fail git -C repo fsck
+'
+
+test_expect_success '...but succeeds if lazyobject is set' '
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.lazyobject "arbitrary string" &&
+	git -C repo fsck
+'
+
 test_done
-- 
2.14.0.rc0.400.g1c36432dff-goog

