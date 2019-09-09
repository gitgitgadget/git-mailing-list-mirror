Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B246A1F463
	for <e@80x24.org>; Mon,  9 Sep 2019 19:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbfIITBe (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 15:01:34 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:47677 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbfIITBe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 15:01:34 -0400
Received: by mail-qt1-f201.google.com with SMTP id v16so16911383qtp.14
        for <git@vger.kernel.org>; Mon, 09 Sep 2019 12:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gf9Y+WeFYcIkcM0S55HwSzsj6Ssoc7wTt8BSi3qAUs4=;
        b=uF4YZjrHC+1QXoAQ5/QsK6VoYKps8RbsaCIP9QlsY0UDPtUvkvNxqBfmbd2RcCBCnS
         EfAYXsmWhi3tjwp9GvDGZ5yfpLtjqnC4TMl3oPYVA/jiHd7VczshhwPOJcd6G/p9A/l4
         KyfFsk+X9XM3YLlYOQmV5auoUo5xE4Qhin//ZcHs7Cl7eKiu+MupoFxezjfa4L6c7h3E
         /kjdCV2Z8qmUGFN44URgoyOOwVxg5tVKf+BC+bkm/1YU+Ba71ADAvSUBmjFcJF5oPxa3
         M3G4ii+5o7l7tOGAFNdP7ZIFPLGp4Pr9vGHDMsye8KGPPhfLFoXOCj/z9OrU0yla/fNw
         Ejpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gf9Y+WeFYcIkcM0S55HwSzsj6Ssoc7wTt8BSi3qAUs4=;
        b=FJF0iNiNlSw582LCpwxXVl/RwI0m8/GDlCE6+YZxWWi2K2yOE6AgC3XdHqoWpymQ0V
         fkjUkRMNibYL/4MVM8JKetwUnEFDcw0SC8p0jzDGXABqz8B4pnPPbnIx4QkF0o/9SMtq
         Kc9Mey1Rd0PUiQFcZpEivTgsJNEghJhYd2BV8S9uJGVe+m2aDH+7Q7TqArkufbHGjw43
         pgtHeRp+rOXKXNOFXbh7F2YXFBw5YA/b80dXslm0ZcNSXDLnW/o5CDIP5OUUCa4sjl//
         z8hdVJjKCDnXuyH71w0UGVgMY8qV2T7XAiNCYxQ6POUFjip0NHyrn0hBU63czysRfpXE
         ZVrg==
X-Gm-Message-State: APjAAAUZ985YBbTmBrSg5tmGkooscvzMyhjn300VQypbrgfk8NHLPusj
        AJjeYPzVt17ClcEIcjT7sy9rM26yGPUFmcUpPQfmt5IBtXuOu1m/RkDa+Inl1Kmvf3g8dYWDdeg
        hT5ThlMT7Pq1pYe9nDjzWw0YSkTtY3qSJHOFiT0k9shphrJXUPHdRT6DhMgsrVoo/TMuSpdFVlE
        Oq
X-Google-Smtp-Source: APXvYqx7+D8G9oPc9Lrfg2X0upa0sPbgtdP07DAPEOj3ybZeGDksO+M/pNBZxa5HHnwCUMy7V5DIIb7I/x/pphYRBiJq
X-Received: by 2002:ac8:490e:: with SMTP id e14mr25339728qtq.375.1568055693495;
 Mon, 09 Sep 2019 12:01:33 -0700 (PDT)
Date:   Mon,  9 Sep 2019 12:01:30 -0700
In-Reply-To: <20190903194247.217964-1-jonathantanmy@google.com>
Message-Id: <20190909190130.146613-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190903194247.217964-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
Subject: [PATCH v2] cache-tree: do not lazy-fetch merge tree
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, stolee@gmail.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When cherry-picking (for example), new trees may be constructed. During
this process, Git constructs the new tree in a struct strbuf, computes
the OID of the new tree, and checks if the new OID already exists on
disk. However, in a partial clone, the disk check causes a lazy fetch to
occur, which is both unnecessary (because we have the tree in the struct
strbuf) and likely to fail (because the remote probably doesn't have
this tree).

Do not lazy fetch in this situation.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
As requested in What's Cooking [1], here's a patch with an updated
commit message. Otherwise, the patch is exactly the same.

[1] https://public-inbox.org/git/xmqqd0gcm2zm.fsf@gitster-ct.c.googlers.com/
---
 cache-tree.c             |  2 +-
 t/t0410-partial-clone.sh | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/cache-tree.c b/cache-tree.c
index c22161f987..9e596893bc 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -407,7 +407,7 @@ static int update_one(struct cache_tree *it,
 	if (repair) {
 		struct object_id oid;
 		hash_object_file(buffer.buf, buffer.len, tree_type, &oid);
-		if (has_object_file(&oid))
+		if (has_object_file_with_flags(&oid, OBJECT_INFO_SKIP_FETCH_OBJECT))
 			oidcpy(&it->oid, &oid);
 		else
 			to_invalidate = 1;
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 6415063980..3e434b6a81 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -492,6 +492,20 @@ test_expect_success 'gc stops traversal when a missing but promised object is re
 	! grep "$TREE_HASH" out
 '
 
+test_expect_success 'do not fetch when checking existence of tree we construct ourselves' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo base &&
+	test_commit -C repo side1 &&
+	git -C repo checkout base &&
+	test_commit -C repo side2 &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialclone "arbitrary string" &&
+
+	git -C repo cherry-pick side1
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
2.23.0.162.g0b9fbb3734-goog

