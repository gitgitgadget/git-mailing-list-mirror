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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E7161F463
	for <e@80x24.org>; Mon, 30 Sep 2019 20:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbfI3Ugq (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 16:36:46 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:37924 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfI3Ug3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 16:36:29 -0400
Received: by mail-qt1-f202.google.com with SMTP id 59so15129474qtc.5
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 13:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=p3aqnzRA86+fYt+eoqqOVMq/3w1mVSrpyDNfeVG9mi0=;
        b=ObefrYFgRl6F/7uw7I+BwNvAF2egZq3UDoIt9mSC17OxAsh+OalYZv1MoRAPy8bIbG
         zkMgDhtSYyzntn7bPOtTjawb+zrcVHudcHoh9U9AsfND1ThTVk0VPVQPofKeGOmizsgx
         /CUjwRKYFEnoKI6aRHTc6N+wIYQXOdZdNYid5gD4PUOBEfvsE1tlX9WGDFQacEYH57Gj
         9+dZUkAgYCi4HpNXqZGy3VeH4MCLP840oWx5yqpguF5QhoR3TT8/HmJRYhJAGmrcL3W9
         Q6BDiE0f5wiSwVG9+HXmaPHYyi4a4jeqyAfkmanZJWV9Qax8cBf94vb4lKeKlTsBjsnb
         DZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=p3aqnzRA86+fYt+eoqqOVMq/3w1mVSrpyDNfeVG9mi0=;
        b=MuNCr1EseEyJidy+H2WO8KDdfBtZsGYbjmGQYZda6o14/bBzO+jdD6lG5HegRfdBFg
         034341lPwiLPKw73Gi2osAuR2gdpIAIOBamHfzCYJ2OeI4SaSKNLYjF8bwvMI8HRdJS0
         PSma9kFac/hlaVX8h+4g9hXBkhNF5woaVo6Mns7DzedixPfkrM8ixz9+FIvWpoH5hMwn
         ZM3pRwArnC8YwxgOj6WTpC3R+kzhO+n8sJX1FXeBU19fm4cYBmYNkc5BEEruQ58GqbgO
         ELf3gcvaGVf0Z5vFk+P47H19AFsrr46PIaijsV3bpwJ6Brxd8I0ISySp1HL5nRk5xMo9
         Gi5Q==
X-Gm-Message-State: APjAAAVLIQvNid64YbYudrbntq5UIJ7H+dS9JZ6TTiS5zdzYgdb074vU
        uKVHX9nO1IDPU+lRPXvxrEZ1CDZU7GMvf8/xwOH3EY6vwwYkgZqNhmKVgzpHARWSizHFhd7/f4d
        UN45xneNR0vYnrX38m4JnW2ga6OLjsQcXAOnJ58jaFHRc+FT98Q6VJ3qi+kDrZyayoMnMU1bEnw
        ==
X-Google-Smtp-Source: APXvYqygGxRzbdXSsANHmiBPkW9PmvLStXg8G9OqbUV3ZnJAZiL0jrD+E/kS7lQUzjepop1rURgSMHxVuizLOSHqC1U=
X-Received: by 2002:a37:4bd8:: with SMTP id y207mr2095980qka.271.1569875306455;
 Mon, 30 Sep 2019 13:28:26 -0700 (PDT)
Date:   Mon, 30 Sep 2019 13:28:18 -0700
In-Reply-To: <20190926213156.88185-1-emilyshaffer@google.com>
Message-Id: <20190930202818.2172-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
Subject: [PATCH v3] promisor-remote: skip move_to_tail when no-op
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
Fixed up some nits from Peff in v2. Thanks especially for the catch on
capturing the output of the fetch - I had been grepping it before I
realized that test_must_fail accounted for unexpected signal exits, and
forgot to remove the redirect.

 - Emily

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
index d4b7e535ea..12274705c2 100755
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
+	# reinitialize the promisors list; this must fail gracefully
+	git -C repo fetch --filter=blob:none foo
+'
+
 test_expect_success 'gc repacks promisor objects separately from non-promisor objects' '
 	rm -rf repo &&
 	test_create_repo repo &&
-- 
2.23.0.444.g18eeb5a265-goog

