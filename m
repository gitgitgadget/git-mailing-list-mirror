Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3048E1F405
	for <e@80x24.org>; Tue, 18 Dec 2018 21:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbeLRVYl (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 16:24:41 -0500
Received: from mail-vk1-f202.google.com ([209.85.221.202]:40519 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbeLRVYl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 16:24:41 -0500
Received: by mail-vk1-f202.google.com with SMTP id s196so4773497vke.7
        for <git@vger.kernel.org>; Tue, 18 Dec 2018 13:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=fCQlCoxevCVV+H2cCdkg+N2nv0MP6DpKgThIYAVKhFU=;
        b=ggiI8QS4lb17LDUdp/E6zUESDoi2kn+GJIrfUfNFshOzaxA2BjS9iSFfuNpSIcEeM+
         +Ziwx+GEcmFMETQBFn2ov+jxQIUxkKdXdFUVhkY4B4kAqAtAQQCTLZl+djjzEKumG8FB
         Q/iWcqyTtYuBJIVK6Vi+ih6azXH2o07YioDmjbJCX8iIeViebkccGqIFFwmyJRccuyB/
         rguseGd+gMtoEHKgTBkPARWjgEHQFiruYrosTF73YZFHMM/57bbNkYWUqvo8FVgpbeDd
         OwoAFa0H+uVpr/7rOraXawxHMyZ8V7htBpC59yWeQA06hGpKdeA9SJzc7KPX0tPCgVmR
         5wSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=fCQlCoxevCVV+H2cCdkg+N2nv0MP6DpKgThIYAVKhFU=;
        b=pymZBpNKldBMYda6WdcEPSF3kwqsymlFeKYrTTt+olNNqgWNUV4iDAHDbjUUTK34vH
         gymdNNUuyBQScJo/UaJlndgly1XJ2sLb3HdDa31aPibC+Qo4aKqPj7gkycoNSBqfATNA
         S+VMLx1/PLC+76uH3vjIiKRe1i/NqU9/zEhJ+8GJ2WSvzIuoiR/f3BAD9qHdTzaOBRU1
         BLh6GcCOjDSALH6iueTYSXszU+pdhfkFRu6W2iFSkD/vtHJAh2U1MEbMpJo+a16GsyIK
         mDwk7ooqPZbz50Bhmktd+OjwrtsGiabxt2xoJtKuzUfbiQhfwGClGExRtwaCn7xdOvfC
         W5NQ==
X-Gm-Message-State: AA+aEWY6AunIN22RANy7Nymvgb2rRCOR5os3ydv/06AaYIKDGCUf0vZl
        O5Ex2DMGMegaqTad0Fp3nMHnQsLId9PRFl1sQvEM+koQC+lc4Eu97unJdWxJDNYazBjT/TeHu47
        EAZyGLywyPYkhHRhousaUX3ANbU3v+9cJSsWDmn0cuJYdnCtvcOs5S/iOTrBQMkvXoMh62S6w5d
        G6
X-Google-Smtp-Source: AFSGD/U5hAlClTWe+2NgcUgMj83mYC5BTzJoMa+XZ3TrqgOKtdl2s7H7D1fLwhwEf7gjwJLtag5ammklFjwVZ3S20FXv
X-Received: by 2002:a1f:abcf:: with SMTP id u198mr18099270vke.21.1545168279588;
 Tue, 18 Dec 2018 13:24:39 -0800 (PST)
Date:   Tue, 18 Dec 2018 13:24:35 -0800
Message-Id: <20181218212435.201641-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH] upload-pack: teach deepen-relative in protocol v2
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 685fbd3291 ("fetch-pack: perform a fetch using v2", 2018-03-15)
attempted to teach Git deepen-relative in protocol v2 (among other
things), but it didn't work:

 (1) fetch-pack.c needs to emit "deepen-relative".
 (2) upload-pack.c needs to ensure that the correct deepen_relative
     variable is passed to deepen() (there are two - the static variable
     and the one in struct upload_pack_data).
 (3) Before deepen() computes the list of reachable shallows, it first
     needs to mark all "our" refs as OUR_REF. v2 currently does not do
     this, because unlike v0, it is not needed otherwise.

Fix all this and include a test demonstrating that it works now. For
(2), the static variable deepen_relative is also eliminated, removing a
source of confusion.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Similar to my first fix [1], another fix for an issue discovered by
Aevar's GIT_TEST_PROTOCOL_VERSION patches. This one is more
straightforward.

With this fix and my first fix [1], t5500 no longer reveals any more
bugs. (There might be more in other test files.)

[1] https://public-inbox.org/git/20181218010811.143608-1-jonathantanmy@google.com/
---
 fetch-pack.c           |  2 ++
 t/t5702-protocol-v2.sh | 29 +++++++++++++++++++++++++++++
 upload-pack.c          | 17 +++++++++++++++--
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 9691046e64..c383ea46b3 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1042,6 +1042,8 @@ static void add_shallow_requests(struct strbuf *req_buf,
 			packet_buf_write(req_buf, "deepen-not %s", s->string);
 		}
 	}
+	if (args->deepen_relative)
+		packet_buf_write(req_buf, "deepen-relative\n");
 }
 
 static void add_wants(int no_dependents, const struct ref *wants, struct strbuf *req_buf)
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 0f2b09ebb8..340953f01c 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -471,6 +471,35 @@ test_expect_success 'upload-pack respects client shallows' '
 	grep "fetch< version 2" trace
 '
 
+test_expect_success 'deepen-relative' '
+	rm -rf server client trace &&
+
+	test_create_repo server &&
+	test_commit -C server one &&
+	test_commit -C server two &&
+	test_commit -C server three &&
+	git clone --depth 1 "file://$(pwd)/server" client &&
+	test_commit -C server four &&
+
+	# Sanity check that only "three" is downloaded
+	git -C client log --pretty=tformat:%s master >actual &&
+	echo three >expected &&
+	test_cmp expected actual &&
+
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client -c protocol.version=2 \
+		fetch --deepen=1 origin &&
+	# Ensure that protocol v2 is used
+	grep "fetch< version 2" trace &&
+
+	git -C client log --pretty=tformat:%s origin/master >actual &&
+	cat >expected <<-\EOF &&
+	four
+	three
+	two
+	EOF
+	test_cmp expected actual
+'
+
 # Test protocol v2 with 'http://' transport
 #
 . "$TEST_DIRECTORY"/lib-httpd.sh
diff --git a/upload-pack.c b/upload-pack.c
index 5e81f1ff24..9df27b55a0 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -43,7 +43,6 @@
 
 static timestamp_t oldest_have;
 
-static int deepen_relative;
 static int multi_ack;
 static int no_done;
 static int use_thin_pack, use_ofs_delta, use_include_tag;
@@ -662,6 +661,9 @@ static void send_unshallow(const struct object_array *shallows,
 	}
 }
 
+static int check_ref(const char *refname_full, const struct object_id *oid,
+		     int flag, void *cb_data);
+
 static void deepen(int depth, int deepen_relative,
 		   struct object_array *shallows, struct object_array *want_obj)
 {
@@ -676,6 +678,13 @@ static void deepen(int depth, int deepen_relative,
 		struct object_array reachable_shallows = OBJECT_ARRAY_INIT;
 		struct commit_list *result;
 
+		/*
+		 * Checking for reachable shallows requires that our refs be
+		 * marked with OUR_REF.
+		 */
+		head_ref_namespaced(check_ref, NULL);
+		for_each_namespaced_ref(check_ref, NULL);
+
 		get_reachable_list(shallows, &reachable_shallows);
 		result = get_shallow_commits(&reachable_shallows,
 					     depth + 1,
@@ -712,6 +721,7 @@ static void deepen_by_rev_list(int ac, const char **av,
 static int send_shallow_list(int depth, int deepen_rev_list,
 			     timestamp_t deepen_since,
 			     struct string_list *deepen_not,
+			     int deepen_relative,
 			     struct object_array *shallows,
 			     struct object_array *want_obj)
 {
@@ -834,6 +844,7 @@ static void receive_needs(struct object_array *want_obj)
 	int has_non_tip = 0;
 	timestamp_t deepen_since = 0;
 	int deepen_rev_list = 0;
+	int deepen_relative = 0;
 
 	shallow_nr = 0;
 	for (;;) {
@@ -925,7 +936,8 @@ static void receive_needs(struct object_array *want_obj)
 		return;
 
 	if (send_shallow_list(depth, deepen_rev_list, deepen_since,
-			      &deepen_not, &shallows, want_obj))
+			      &deepen_not, deepen_relative, &shallows,
+			      want_obj))
 		packet_flush(1);
 	object_array_clear(&shallows);
 }
@@ -1398,6 +1410,7 @@ static void send_shallow_info(struct upload_pack_data *data,
 
 	if (!send_shallow_list(data->depth, data->deepen_rev_list,
 			       data->deepen_since, &data->deepen_not,
+			       data->deepen_relative,
 			       &data->shallows, want_obj) &&
 	    is_repository_shallow(the_repository))
 		deepen(INFINITE_DEPTH, data->deepen_relative, &data->shallows,
-- 
2.19.0.271.gfe8321ec05.dirty

