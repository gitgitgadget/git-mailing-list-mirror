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
	by dcvr.yhbt.net (Postfix) with ESMTP id C23231F463
	for <e@80x24.org>; Thu, 26 Sep 2019 21:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbfIZVcQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 17:32:16 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:53995 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfIZVcP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 17:32:15 -0400
Received: by mail-pl1-f201.google.com with SMTP id g13so312640plq.20
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 14:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=t6q/TaY7L8nuu5ZQi269W1ucWnItwuo51e9F2NAfwqU=;
        b=nDdBgfqEhANolhOek32WoyrPl7MRVNOKrErl2JVupFqICcZQlVsLNFjRsK7StDIIYY
         6TVY4Ea57K2tsao4XwNvO/tGxyfI6pmF0/EJ6T2JDonByfJDOMGYRjQ9gQ+ahCeLM8mF
         c8+SQ6IcgUpJiY6pcDJe6UJSxMVdNPG5H+yqGDUerNvxVosiDxItPvhdQRvFmECRLCzF
         YzEhAXSt8laf0nXkCRDr9sZHf0+y8fh3d2glpx6xcMmZJ4vMe3iAHiv1NwYBVzD6MSF5
         bqgzoy8LwtWzq5uM2ZTqOU8THc9vsLtnjfKSl11vKo4QKett4iiU4eY+FrXLYGdMeeQ8
         DYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=t6q/TaY7L8nuu5ZQi269W1ucWnItwuo51e9F2NAfwqU=;
        b=pqLE0PhPoTcBDa3lCdcER/kthmGcaMoIQyYYlYw/4gj3O7y8hTMhrF05ilxod1FfQa
         u593pKLPP9bOJ4jdQX31EXVwwA1s68Lww9WB2oWNzt3NFlO+uRs1WdtfReWjs7r5/Ufy
         o3yf8NP6X7zdUOO0Tr/mlia/zcbxTONUc8pCbNjfdbSEVff064WAWZ3oFW02xe1AqG3/
         tADDeQciDoDrQVcr2VxI002zGLpVK9lvJQciFAMg2j8oeOxcvKC6v0okTxkxqlgpLqOn
         zZxuIp87r72rfTfgSM4o+w1ssodkwd6HKE91XDf0EFiZSWkOFCSAvVL2nEXXhce1nzwP
         bhcA==
X-Gm-Message-State: APjAAAXt+oWDVPkjtccV1xqvnHfiZtVjpyuwogwuKE+Ap5yfbyWJiR5c
        lmxWckABsIOpDKNugbZeHDLL65xEe+eFDZuU057y3rFhyzN5N4AXjCCtH6CgFYoPWltJKxXZ4p/
        4IQeW71RJL6x37H3mCYOQaEjWwbGEo+0VpQf1gxVt0yEafnvHx4FK8CkIwfr1cSG785Chx4arvw
        ==
X-Google-Smtp-Source: APXvYqzgQj2T1A+E59TZOfW4rmjCO6Ag9MFbNIVM/u+J+LuuDW5qaFO4g/AplVuerW3sRny+JnHogTep+HpvUZh3JAU=
X-Received: by 2002:a63:1d0e:: with SMTP id d14mr5590161pgd.324.1569533534328;
 Thu, 26 Sep 2019 14:32:14 -0700 (PDT)
Date:   Thu, 26 Sep 2019 14:31:56 -0700
In-Reply-To: <20190925213718.231231-1-emilyshaffer@google.com>
Message-Id: <20190926213156.88185-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
Subject: [PATCH v2] promisor-remote: skip move_to_tail when no-op
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

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Helped-by: Jeff King <peff@peff.net>
---
Thanks Peff for pointing out this bug occurs any time the tail is being
moved to tail in the promisors list. Modified patch to check just for
"already at tail" condition.

Added a test case based on Peff's reproduction steps (thanks!) and
confirmed it failed before the patch, exiting gracelessly with a
SIGABRT, and now fails gracefully (and passes test_must_fail condition).

 - Emily


 promisor-remote.c        |  3 +++
 t/t0410-partial-clone.sh | 12 ++++++++++++
 2 files changed, 15 insertions(+)

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
index d4b7e535ea..4db4d488c8 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -429,6 +429,18 @@ test_expect_success 'rev-list dies for missing objects on cmd line' '
 	done
 '
 
+test_expect_success 'single promisor remote can be re-initialized gracefully' '
+	# ensure one promisor is in the promisors list
+	rm -rf repo &&
+	test_create_repo repo &&
+	git -C repo remote add foo /wherever &&
+	git -C repo config remote.foo.promisor true &&
+	git -C repo config extensions.partialclone foo &&
+
+	# reinitialize the promisors list; this must fail gracefully
+	test_must_fail git -C repo fetch --filter=blob:none foo 2>fetch_err
+'
+
 test_expect_success 'gc repacks promisor objects separately from non-promisor objects' '
 	rm -rf repo &&
 	test_create_repo repo &&
-- 
2.23.0.444.g18eeb5a265-goog

