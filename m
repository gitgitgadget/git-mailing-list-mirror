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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D68C1F461
	for <e@80x24.org>; Thu, 11 Jul 2019 21:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfGKVT1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 17:19:27 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:40518 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfGKVT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 17:19:27 -0400
Received: by mail-pl1-f202.google.com with SMTP id 91so3921041pla.7
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 14:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=kP2G61QY2jTk0MC7HWB1/dQ56dd8/4Hv9QQGk6fTGK8=;
        b=MPn6nvA33H5uu7+0k7mfbDUrMAzWFWBn3OdRye71FCYYlrBKl3WBXImFQQKH0ArZG8
         y2VJaJYQFCq74hgXluDrz8uPT16ryO9xMBJM9uIJJxIOj+qHyoC/gDfA6XtN1QXX7k5K
         73mfjCCteSbigqbwmzAna/m90iDCvdYYAyQlDVGWMrMBqOlDB+7j0twIIXU6tXdVvKYv
         kESvTXXSjzqiMNZkPlpOONSNRs+EvsxAREZ2KfwBl5xsTOXKQ1kJiG/6YXD3WMjRvlWm
         c+J/ZglyQI7nAXed8xpwo4tsmBD0W9LkwjwMWeXUhnguPHnkodCWxnSfeZKbBNYbWIej
         oC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=kP2G61QY2jTk0MC7HWB1/dQ56dd8/4Hv9QQGk6fTGK8=;
        b=rMdUO0cnS+y5BWH6Tx27h/X90aaCiYpeYsJIS8pktUAQrNkdq8/OVycjeQsKlKWqd7
         yhnsWgBSKn2pUnYFir1iwGOM5pXmVvAAlz4auKemH9w4e+K+vwkHCOb1kMdJlKyWZQG6
         rFO6t52L6OtVk/4twQmVTk2jPLVvPbhq3YxJKXKp2acFhq6YLbsJM6U9y8dKwzQaGLyC
         QiW7AHG2sYg70NYheyIgXQ+o6qwIkWNXrOF166JrCDYOPtTLfqx68f8l1lvhnSg6AhoS
         5hHgTHAs54bru4zJEBSgyXIY6enVz0yX+w/Caj7TzvGpok5ogsjqGbXOezv4kEz6M8m3
         5stQ==
X-Gm-Message-State: APjAAAVbipkzjCp0APrF9bxUzIl6POGXxEe0RV8lODAxx5dFK8zdWztn
        FqoV0oTpZY/HHlfxhItxNp93dC/14fQVTZcv2Of3d0lN0VgdOtIZc/dkF15r2KVFXxZtwB/SldG
        1EUL5RC3atu5QNs3OEJo0Thr1GP9s2RIjK6CXZpYNm1syk5xvSSU4FkZSDuv8HZ3jy1VTfTLDHA
        ==
X-Google-Smtp-Source: APXvYqzjhIi8MkuB0cUzvtM/hlG6uCWaZHcfzT6HkWwPaqag2HYEaYYFpvzwg/OO/h9hnMfGlD7xh31aBF7UqigwfMk=
X-Received: by 2002:a63:f941:: with SMTP id q1mr6648938pgk.350.1562879965728;
 Thu, 11 Jul 2019 14:19:25 -0700 (PDT)
Date:   Thu, 11 Jul 2019 14:19:19 -0700
In-Reply-To: <20190709211043.48597-1-emilyshaffer@google.com>
Message-Id: <20190711211919.32734-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v3] transport-helper: enforce atomic in push_refs_with_push
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach transport-helper how to notice if skipping a ref during push would
violate atomicity on the client side. We notice that a ref would be
rejected, and choose not to send it, but don't notice that if the client
has asked for --atomic we are violating atomicity if all the other
pushes we are sending would succeed. Asking the server end to uphold
atomicity wouldn't work here as the server doesn't have any idea that we
tried to update a ref that's broken.

The added test-case is a succinct way to reproduce this issue that fails
today. The same steps work fine when we aren't using a transport-helper
to get to the upstream, i.e. when we've added a local repository as a
remote:

  git remote add ~/upstream upstream

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
Since the previous version, made a couple changes based on Junio's
comments on the testcase.

- Use show-ref instead of rev-parse to avoid a corner case where a tag
  is named the same thing as the branch we hope not to create
- Reduce number of grep processes by using a longer regex instead
- Check the real contents of the upstream repo instead of just relying
  on the client side's reporting
  - The check on the client side remains, however, to ensure the user is
    made aware of why their perfectly good ref failed to push.

Thanks, all.

 t/t5541-http-push-smart.sh | 49 ++++++++++++++++++++++++++++++++++++++
 transport-helper.c         |  6 +++++
 transport.c                | 13 ++++++++++
 3 files changed, 68 insertions(+)

diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 8ef8763e06..92bac43257 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -177,6 +177,55 @@ test_expect_success 'push (chunked)' '
 	 test $HEAD = $(git rev-parse --verify HEAD))
 '
 
+test_expect_success 'push --atomic also prevents branch creation, reports collateral' '
+	# Setup upstream repo - empty for now
+	d=$HTTPD_DOCUMENT_ROOT_PATH/atomic-branches.git &&
+	git init --bare "$d" &&
+	test_config -C "$d" http.receivepack true &&
+	up="$HTTPD_URL"/smart/atomic-branches.git &&
+
+	# Tell "$up" about two branches for now
+	test_commit atomic1 &&
+	test_commit atomic2 &&
+	git branch collateral &&
+	git push "$up" master collateral &&
+
+	# collateral is a valid push, but should be failed by atomic push
+	git checkout collateral &&
+	test_commit collateral1 &&
+
+	# Make master incompatible with upstream to provoke atomic
+	git checkout master &&
+	git reset --hard HEAD^ &&
+
+	# Add a new branch which should be failed by atomic push. This is a
+	# regression case.
+	git branch atomic &&
+
+	# --atomic should cause entire push to be rejected
+	test_must_fail git push --atomic "$up" master atomic collateral 2>output &&
+
+	# the new branch should not have been created upstream
+	test_must_fail git -C "$d" show-ref --verify refs/heads/atomic &&
+
+	# upstream should still reflect atomic2, the last thing we pushed
+	# successfully
+	git rev-parse atomic2 >expected &&
+	# on master...
+	git -C "$d" rev-parse refs/heads/master >actual &&
+	test_cmp expected actual &&
+	# ...and collateral.
+	git -C "$d" rev-parse refs/heads/collateral >actual &&
+	test_cmp expected actual &&
+
+	# the failed refs should be indicated to the user
+	grep "^ ! .*rejected.* master -> master" output &&
+
+	# the collateral failure refs should be indicated to the user
+	grep "^ ! .*rejected.* atomic -> atomic .*atomic push failed" output &&
+	grep "^ ! .*rejected.* collateral -> collateral .*atomic push failed" output
+'
+
 test_expect_success 'push --all can push to empty repo' '
 	d=$HTTPD_DOCUMENT_ROOT_PATH/empty-all.git &&
 	git init --bare "$d" &&
diff --git a/transport-helper.c b/transport-helper.c
index c7e17ec9cb..6b05a88faf 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -853,6 +853,7 @@ static int push_refs_with_push(struct transport *transport,
 {
 	int force_all = flags & TRANSPORT_PUSH_FORCE;
 	int mirror = flags & TRANSPORT_PUSH_MIRROR;
+	int atomic = flags & TRANSPORT_PUSH_ATOMIC;
 	struct helper_data *data = transport->data;
 	struct strbuf buf = STRBUF_INIT;
 	struct ref *ref;
@@ -872,6 +873,11 @@ static int push_refs_with_push(struct transport *transport,
 		case REF_STATUS_REJECT_NONFASTFORWARD:
 		case REF_STATUS_REJECT_STALE:
 		case REF_STATUS_REJECT_ALREADY_EXISTS:
+			if (atomic) {
+				string_list_clear(&cas_options, 0);
+				return 0;
+			} else
+				continue;
 		case REF_STATUS_UPTODATE:
 			continue;
 		default:
diff --git a/transport.c b/transport.c
index f1fcd2c4b0..d768bc275e 100644
--- a/transport.c
+++ b/transport.c
@@ -1226,6 +1226,19 @@ int transport_push(struct repository *r,
 		err = push_had_errors(remote_refs);
 		ret = push_ret | err;
 
+		if ((flags & TRANSPORT_PUSH_ATOMIC) && err) {
+			for (struct ref *it = remote_refs; it; it = it->next)
+				switch (it->status) {
+				case REF_STATUS_NONE:
+				case REF_STATUS_UPTODATE:
+				case REF_STATUS_OK:
+					it->status = REF_STATUS_ATOMIC_PUSH_FAILED;
+					break;
+				default:
+					break;
+				}
+		}
+
 		if (!quiet || err)
 			transport_print_push_status(transport->url, remote_refs,
 					verbose | porcelain, porcelain,
-- 
2.22.0.410.gd8fdbe21b5-goog

