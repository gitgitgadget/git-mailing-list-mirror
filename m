Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B54CF1F463
	for <e@80x24.org>; Mon, 30 Sep 2019 22:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfI3WEB (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 18:04:01 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:41839 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfI3WEB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 18:04:01 -0400
Received: by mail-pf1-f202.google.com with SMTP id c24so8789628pfi.8
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 15:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=gfhxEE+U47Gq8ZW2ybM7qkxPGAEWCFBOdxWXS8IMUEY=;
        b=jbrX5UuyPq2MdQxt6Rs7A0otjcpWIIEV/UDb6EiplKfqEq78KLPMwBAngfK/vGxwhf
         nS+Q7N2Zc6vJZ3ld/uxov77xekA9vcEefO/nXxZCbCZalOhzhi2n5fven+xru4sekjc1
         P/RXT0jJvLDSF2LMwxzLIvSoVGZO6x03ScdIEgf07rn4l6z0PtdJDfKKlwIifiT3Al0E
         jJgPCryPWP4nxYIEjOwslIFQb9ZZSjuU4K2xapSXH2tqcpSq7DgvoUGYTStatJ7o7+DL
         E66adhvRBNpTKmSS76wCQb8rlVeCJQ9CKe59oaxZ91AujcMHFvqH8gvv8r0ofr3aFB63
         xaqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=gfhxEE+U47Gq8ZW2ybM7qkxPGAEWCFBOdxWXS8IMUEY=;
        b=W6ETmPyu7wZIdsTnhtgkZc19lr42qiWZ5kpOjen5XbrJi69a8S1q44ki60NpVUZGcF
         s3iG3MhxMnuI3XrilDSjuFtmH5nnJjTcfCGuPQAiYfsIQh6lteVDYxXjq12+BYBNAzk6
         //9ZspP0nv1xp7ksDVWL/U75/KVHwXlTfmguGZeW7SeDBtyLF+HK7+KANBpUxZ0vCa4F
         43T8JK4V3jdx29gu33M0tr2awhIX56mXo97i7wYwAMXSU7UclMYSsAwFkJ4Kla0lVfEt
         8jnR/uVVE1km3oW05UIvkjzxf+KZe3rvcJRS82ZqhcfNeZULt+6vWGAUYdZFahfKsw7K
         6K6w==
X-Gm-Message-State: APjAAAVl69UQAs4L8VFon7FaK/1G7ucc42Jg+WFUjELvR5ftLRtih73x
        a2pgKzLyfxB2FYpRW/Ys6QJVyaix6pziiTOBESVeZqn2BHFuR1iRcoYFMM+o47FDN0ajUD41fWk
        Z8GacRN0QpAMR+REOIbJpcJVwjuoqUI/6pqMPohE9Emyxwlgl+b65JUHXz6zS29qqKu8D4jrREA
        ==
X-Google-Smtp-Source: APXvYqxx/4Mb6lFqgPHfWEjEvJIXrGmRb+1/q4iackKLUDcmF2cJ+Mgbiaju694QuLILv4sruOEAsN7uaXbgTbxTPcM=
X-Received: by 2002:a63:a35b:: with SMTP id v27mr27365849pgn.64.1569881039099;
 Mon, 30 Sep 2019 15:03:59 -0700 (PDT)
Date:   Mon, 30 Sep 2019 15:03:55 -0700
In-Reply-To: <20190930202818.2172-1-emilyshaffer@google.com>
Message-Id: <20190930220355.108394-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
Subject: [PATCH v4] promisor-remote: skip move_to_tail when no-op
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, when promisor_remote_move_to_tail() is called for a
promisor_remote which is currently the final element in promisors, a
cycle is created in the promisors linked list. This cycle leads to a
double free later on in promisor_remote_clear() when the final element
of the promisors list is removed: promisors is set to promisors->next (a
no-op, as promisors->next == promisors); the previous value of promisors
is free()'d; then the new value of promisors (which is equal to the
previous value of promisors) is also free()'d. This double-free error
was unrecoverable for the user without removing the filter or re-cloning
the repo and hoping to miss this edge case.

Now, when promisor_remote_move_to_tail() would be a no-op, just do a
no-op. In cases of promisor_remote_move_to_tail() where r is not already
at the tail of the list, it works as before.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
Since v3 missed a small comment change.
 promisor-remote.c        |  3 +++
 t/t0410-partial-clone.sh | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/promisor-remote.c b/promisor-remote.c
index 9bc296cdde..9bd5b79d59 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -89,6 +89,9 @@ static struct promisor_remote *promisor_remote_lookup(const char *remote_name,
 static void promisor_remote_move_to_tail(struct promisor_remote *r,
 					 struct promisor_remote *previous)
 {
+	if (r->next == NULL)
+		return;
+
 	if (previous)
 		previous->next = r->next;
 	else
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index d4b7e535ea..5c676c71a5 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -429,6 +429,19 @@ test_expect_success 'rev-list dies for missing objects on cmd line' '
 	done
 '
 
+test_expect_success 'single promisor remote can be re-initialized gracefully' '
+	# ensure one promisor is in the promisors list
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_create_repo other &&
+	git -C repo remote add foo "file://$(pwd)/other" &&
+	git -C repo config remote.foo.promisor true &&
+	git -C repo config extensions.partialclone foo &&
+
+	# reinitialize the promisors list
+	git -C repo fetch --filter=blob:none foo
+'
+
 test_expect_success 'gc repacks promisor objects separately from non-promisor objects' '
 	rm -rf repo &&
 	test_create_repo repo &&
-- 
2.23.0.444.g18eeb5a265-goog

