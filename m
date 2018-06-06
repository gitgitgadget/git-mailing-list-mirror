Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4F291F403
	for <e@80x24.org>; Wed,  6 Jun 2018 20:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752541AbeFFUrb (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 16:47:31 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44091 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932080AbeFFUr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 16:47:29 -0400
Received: by mail-pf0-f193.google.com with SMTP id h12-v6so3707011pfk.11
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 13:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D48DHgFJJ+eYzMl51t7Yc8S/zV8EGb9UDUjZtNf4Mrg=;
        b=BQ59fAj5pmgBhvlRVIyG5T9Ey2wHpa1QHTJUiG38RuAAwOh1VKq4PKSLWs1p1a6IVI
         2vr1zRhbaPdFu/aq7iHKVb9TuRavd8gkcUmWEkoU0MowuTvDmxrSy8vyJSdSwhenO6Xv
         AKSqq9CChrLAU6LE/hL3GsHSALZLg/cPE34wK+g9glnzunpAd02t5xVFQEdZM/aEM2gP
         hO9TpWxtvLc2/8jKZjJfiaf2WHCYnWfMhak9zva5+ebcIBJ9cWJwGlI4S0q7/VULtGW3
         ssxy4+ZtHamRYMpVAf/w/1F7YYdSvn92DnJOKGjVJvsaK/cS9lA1wnrWS4uLU2orRFIr
         8tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D48DHgFJJ+eYzMl51t7Yc8S/zV8EGb9UDUjZtNf4Mrg=;
        b=EtuqjZ5/KpLA0Shik6O0++tku6LjCp76Ykj0haRnPp7290nViZyU8oH88pBkR5Dc6d
         3wKbF8RdUC8dQH+rFGsKAZzpDvNT3WdlukxmISah7gt3o5b4sxfCXpX+OvCwf3khPLEx
         Ls3xiMadw7JHkILh6nZLIrRFuzFP649XjnuhX4xtTyvF1nyvYuxakYk4WTJ0jcNBkM8d
         WxAZVOb6YpMbKWLHKw9i5XG8IhzmuJcsZmuvJaV3Nm7CIrivF8W51V06k/GOcdrRXLLH
         2TPTIHTIMdYYcyampRu4FqUB49Q7W/eJ0x1jEneg1V1/XxpbzHpB8OKzTEGnmI6OuM2B
         7qow==
X-Gm-Message-State: APt69E2lhp+UiksJ+9bdxcJZlm9MNRpd4Ii8AF3Kb5KetcicExhNHDe3
        jH+R1+DQiR2UpuzZSlgvhhE9k1OF8ZE=
X-Google-Smtp-Source: ADUXVKLY9JsY3qUT/uy6FAEmZ5MiqSBMBnjUxvgEp2JeZOoiZf/ZSc2V4Xqhwyqmo7jqBNr+HMrKyw==
X-Received: by 2002:a65:6250:: with SMTP id q16-v6mr3849986pgv.113.1528318048306;
        Wed, 06 Jun 2018 13:47:28 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id m1-v6sm20703323pfh.155.2018.06.06.13.47.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 13:47:27 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com
Subject: [PATCH v2 4/8] fetch-pack: use ref adv. to prune "have" sent
Date:   Wed,  6 Jun 2018 13:47:10 -0700
Message-Id: <f12342fb2760eb0449c86c66bf44d39f5871be57.1528317619.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.768.g1526ddbba1.dirty
In-Reply-To: <cover.1528317619.git.jonathantanmy@google.com>
References: <cover.1527894919.git.jonathantanmy@google.com> <cover.1528317619.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In negotiation using protocol v2, fetch-pack sometimes does not make
full use of the information obtained in the ref advertisement:
specifically, that if the server advertises a commit that the client
also has, the client never needs to inform the server that it has the
commit's parents, since it can just tell the server that it has the
advertised commit and it knows that the server can and will infer the
rest.

This is because, in do_fetch_pack_v2(), rev_list_insert_ref_oid() is
invoked before everything_local(). This means that if we have a commit
that is both our ref and their ref, it would be enqueued by
rev_list_insert_ref_oid() as SEEN, and since it is thus already SEEN,
everything_local() would not enqueue it.

If everything_local() were invoked first, as it is in do_fetch_pack()
for protocol v0, then everything_local() would enqueue it with
COMMON_REF | SEEN. The addition of COMMON_REF ensures that its parents
are not sent as "have" lines.

Change the order in do_fetch_pack_v2() to be consistent with
do_fetch_pack(), and to avoid sending unnecessary "have" lines.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c          |  6 +++---
 t/t5500-fetch-pack.sh | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 09f5c83c4..114207b8e 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1391,9 +1391,6 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 				for_each_ref(clear_marks, NULL);
 			marked = 1;
 
-			for_each_ref(rev_list_insert_ref_oid, NULL);
-			for_each_cached_alternate(insert_one_alternate_object);
-
 			/* Filter 'ref' by 'sought' and those that aren't local */
 			mark_complete_and_common_ref(args, &ref);
 			filter_refs(args, &ref, sought, nr_sought);
@@ -1401,6 +1398,9 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
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
index d4f435155..026ba9c9e 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -755,6 +755,45 @@ test_expect_success 'fetching deepen' '
 	)
 '
 
+test_expect_success 'use ref advertisement to prune "have" lines sent' '
+	rm -rf server client &&
+	git init server &&
+	test_commit -C server both_have_1 &&
+	git -C server tag -d both_have_1 &&
+	test_commit -C server both_have_2 &&
+
+	# In this test, the ref name that only the server has is a prefix of all
+	# other refs. This is because in protocol v2, the client sends
+	# "ref-prefix" to limit the ref advertisement. Naming the ref "bo" means
+	# that "ref-prefix refs/tags/bo*" is sent, resulting in the client also
+	# knowing about refs/tags/both_have_2, just as it would when it uses
+	# protocol v0.
+	git clone server client &&
+	test_commit -C server bo &&
+	test_commit -C client client_has &&
+
+	# In both protocol v0 and v2, ensure that the parent of both_have_2 is
+	# not sent as a "have" line. The client should know that the server has
+	# both_have_2, so it only needs to inform the server that it has
+	# both_have_2, and the server can infer the rest.
+
+	rm -f trace &&
+	cp -r client clientv0 &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C clientv0 \
+		fetch origin bo &&
+	grep "have $(git -C client rev-parse client_has)" trace &&
+	grep "have $(git -C client rev-parse both_have_2)" trace &&
+	! grep "have $(git -C client rev-parse both_have_2^)" trace &&
+
+	rm -f trace &&
+	cp -r client clientv2 &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C clientv2 -c protocol.version=2 \
+		fetch origin bo &&
+	grep "have $(git -C client rev-parse client_has)" trace &&
+	grep "have $(git -C client rev-parse both_have_2)" trace &&
+	! grep "have $(git -C client rev-parse both_have_2^)" trace
+'
+
 test_expect_success 'filtering by size' '
 	rm -rf server client &&
 	test_create_repo server &&
-- 
2.17.0.768.g1526ddbba1.dirty

