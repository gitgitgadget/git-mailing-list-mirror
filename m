Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 215461F403
	for <e@80x24.org>; Mon,  4 Jun 2018 17:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751341AbeFDR3w (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 13:29:52 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:40268 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbeFDR3u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 13:29:50 -0400
Received: by mail-pg0-f66.google.com with SMTP id l2-v6so14732823pgc.7
        for <git@vger.kernel.org>; Mon, 04 Jun 2018 10:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x6XevhiR4RTXFB8TI+3tCNe1MWPnI3BZtIHWyZRc1WU=;
        b=VlqEVA9mb29mFbDVSLCMY0KxDgKLMQHFg/vjelVo93IQ3rRvpFTwwMbmkizqQ9bgXj
         dREetCZ9tBDqWhUBTToWH3O0XaDW8aQkuD2WbctDrd04S+Ps6ycgS4/wNBUZX26qkDY6
         n11SguOVUI6rQanphveCXqBODH1sRWL0YoViTlE0Ic7SrTmSEu31HvaX2tl3zqH07Fbb
         glid6SEMhzLgLDFH7D9XG5RoVbivf4D8/AOxKDignm3EMkZPx5oTzg/AqQgT70eMgXcN
         zy/RixsebsoXE0s7J/qCliVdfi9Efw0wT31PjPPLcybLlsu6ig3Ey/pJMaCZAvhF9gpK
         xkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x6XevhiR4RTXFB8TI+3tCNe1MWPnI3BZtIHWyZRc1WU=;
        b=rar6+opKREYUqSAnQoiRRFXATX4woTClWDqj3YV6d7OCpzm2cLbs98IMOGj9AApacd
         kU6uoV/q3W3WfWtBSZO8mkwq7ApR9CSzWTHxFwmeXoJ0TKQ68UrVOzqWdj04t7vA989i
         nRXevBEJimsH+m1gaZW7IFn3O8BM7euGagM4R5RK8WJBb/n7bYEXT2MYjn4UB9MYa/Ti
         SildFYuBbmutQUuRQwkJQdC7t1gReb32LCXVe8MW2KyuMJTGZQcBqtYXAi+Fz+gkYGuI
         KiKppZ4mZsYF+6MlRdA3tYTag/rnZNmWENZHcoXX/2Uvm1Mk8OBd1Tc+hACuOgC1uGNz
         G0Rg==
X-Gm-Message-State: APt69E2a/4152kSwNQhRzE6oWE3jKkGjmnL2vtGrN2RSpyv3u0Em4iAX
        hpOUFnhbjMpt7inMcyMWaaxSRvT/Uec=
X-Google-Smtp-Source: ADUXVKJ+x8MPhNgsYZoUuN0x3DiXsLVIcqsZQAs40k7IA61LTThjdqNXMaHfWREgPLB/DXB0sfhJ/g==
X-Received: by 2002:a65:6290:: with SMTP id f16-v6mr9646829pgv.155.1528133388976;
        Mon, 04 Jun 2018 10:29:48 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id x2-v6sm4491994pfn.11.2018.06.04.10.29.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jun 2018 10:29:47 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        bmwill@google.com
Subject: [PATCH 3/6] fetch-pack: in protocol v2, enqueue commons first
Date:   Mon,  4 Jun 2018 10:29:33 -0700
Message-Id: <8265d9485a2bfe0e81d68495afd3733879add992.1527894919.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.768.g1526ddbba1.dirty
In-Reply-To: <cover.1527894919.git.jonathantanmy@google.com>
References: <cover.1527894919.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In do_fetch_pack_v2(), rev_list_insert_ref_oid() is invoked before
everything_local(). This means that if we have a commit that is both our
ref and their ref, it would be enqueued by rev_list_insert_ref_oid() as
SEEN, and since it is thus already SEEN, everything_local() would not
enqueue it.

If everything_local() were invoked first, as it is in do_fetch_pack()
for protocol v0, then everything_local() would enqueue it with
COMMON_REF | SEEN. The addition of COMMON_REF ensures that its parents
are not sent as "have" lines.

Change the order in do_fetch_pack_v2() to be consistent with
do_fetch_pack(), and to avoid sending unnecessary "have" lines.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c          |  6 +++---
 t/t5500-fetch-pack.sh | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 2d090f612..192771a8f 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1372,14 +1372,14 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 				for_each_ref(clear_marks, NULL);
 			marked = 1;
 
-			for_each_ref(rev_list_insert_ref_oid, NULL);
-			for_each_cached_alternate(insert_one_alternate_object);
-
 			/* Filter 'ref' by 'sought' and those that aren't local */
 			if (everything_local(args, &ref, sought, nr_sought))
 				state = FETCH_DONE;
 			else
 				state = FETCH_SEND_REQUEST;
+
+			for_each_ref(rev_list_insert_ref_oid, NULL);
+			for_each_cached_alternate(insert_one_alternate_object);
 			break;
 		case FETCH_SEND_REQUEST:
 			if (send_fetch_request(fd[1], args, ref, &common,
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 0680dec80..ad6a50ad6 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -808,6 +808,41 @@ test_expect_success 'fetch with --filter=blob:limit=0' '
 	fetch_filter_blob_limit_zero server server
 '
 
+test_expect_success 'use ref advertisement to prune "have" lines sent' '
+	rm -rf server client &&
+	git init server &&
+	test_commit -C server aref_both_1 &&
+	git -C server tag -d aref_both_1 &&
+	test_commit -C server aref_both_2 &&
+
+	# The ref name that only the server has must be a prefix of all the
+	# others, to ensure that the client has the same information regardless
+	# of whether protocol v0 (which does not have ref prefix filtering) or
+	# protocol v2 (which does) is used.
+	git clone server client &&
+	test_commit -C server aref &&
+	test_commit -C client aref_client &&
+
+	# In both protocol v0 and v2, ensure that the parent of aref_both_2 is
+	# not sent as a "have" line.
+
+	rm -f trace &&
+	cp -r client clientv0 &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C clientv0 \
+		fetch origin aref &&
+	grep "have $(git -C client rev-parse aref_client)" trace &&
+	grep "have $(git -C client rev-parse aref_both_2)" trace &&
+	! grep "have $(git -C client rev-parse aref_both_2^)" trace &&
+
+	rm -f trace &&
+	cp -r client clientv2 &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C clientv2 -c protocol.version=2 \
+		fetch origin aref &&
+	grep "have $(git -C client rev-parse aref_client)" trace &&
+	grep "have $(git -C client rev-parse aref_both_2)" trace &&
+	! grep "have $(git -C client rev-parse aref_both_2^)" trace
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
2.17.0.768.g1526ddbba1.dirty

