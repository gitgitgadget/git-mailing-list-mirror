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
	by dcvr.yhbt.net (Postfix) with ESMTP id B6EFE1F461
	for <e@80x24.org>; Tue,  9 Jul 2019 21:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfGIVLA (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jul 2019 17:11:00 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:35082 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfGIVLA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jul 2019 17:11:00 -0400
Received: by mail-pf1-f201.google.com with SMTP id r142so769pfc.2
        for <git@vger.kernel.org>; Tue, 09 Jul 2019 14:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=TkRLPMQQCXSt8s6G+Erz+7/5Xzn4oDwiUBcQwC+P1mA=;
        b=RWFRtH/p2HfhylDXFrsu4WIjBcWcMUOQpSL0Y5wHPFfiWUi2ZffC9VvBqvqvmaATll
         gcDHMc8c+siPGEzdwQ31Tu49WhErfhxjEljRoTD3oHxTKo2InPIZMqvQwWuWXyU6UEfE
         clIgFUqnIh1bTwpL778ibZoPfSbmaZkw5dIMkbDYrcyDaEbDL130DOBJcIKsmQDScWYn
         XtCXQ+ehyPMaiL5h1rfmpIwKj6olFHBiYu3mXFpM3pGXsY9QWsvsl6HaiHDgrVdZlSFI
         VWwQjE1cgjDMp3kXMbKzKkFjPe0500ygy9b//H2q9/F1cCq17db6UEmuFXGoALPIStDf
         qgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=TkRLPMQQCXSt8s6G+Erz+7/5Xzn4oDwiUBcQwC+P1mA=;
        b=psJY3ndrhyynWz85wETNkZd2npurnfSdZGQU0izBdu7sjAeSX7q0pPsOkVV/AbppA/
         AamLiAAQkj36G3AE7Kzl2rSGqtXuEWd+Firv98cbvy9r/o3kF2fqgf5jALCyfBTpG/nL
         zv/4QfgjQCMILK1JSOZQQif21+vUG5vX3uyV5bYsJ3T6ZRu21gB6sJykUcv5rSUDSYKN
         tvul8K62WB74MXRehKcYant+IMAf32S5iQnWLVkaIlvdZ8wgIa6H+tLVks7Wm65TMwq0
         FwqJ01RBZVQTKHS86spPCqkiaIPbbblAQkTfp9smFvveYdCrn4leWPYgDKG3u2svYUW1
         +BjQ==
X-Gm-Message-State: APjAAAWKMKiJsQgELbRLfdZxE/ZRvog5S4f2LXtEL+KusYw3+s64bpI9
        ooS66uD2XowAqc88WXJuJ1IVJmAgg1C2OvHIdFJ09ibMM56zOHiNs7Oy5zthsHQkKHduurjFMer
        mH9QTpRnqcB0u8xaqehahwRVVI/2V6DNCV5ooLXZ4PUgUxS+af6eZcnl7jBx0CeoqvE64byLtWA
        ==
X-Google-Smtp-Source: APXvYqyXBPx0ptNlTmRX4wHeIrYGhVnlN+mBuUVSN4xDQWJb8hFC26nCMIxdXEg9Ymn18iIbKvC9+KrwfSHGTHOEJOg=
X-Received: by 2002:a63:2bd2:: with SMTP id r201mr32289263pgr.193.1562706658777;
 Tue, 09 Jul 2019 14:10:58 -0700 (PDT)
Date:   Tue,  9 Jul 2019 14:10:43 -0700
In-Reply-To: <20190702005340.66615-1-emilyshaffer@google.com>
Message-Id: <20190709211043.48597-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v2] transport-helper: enforce atomic in push_refs_with_push
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
Since v2, I combined the test cases into one. Unfortunately the new test
case is checking a few things at once, but I hope the comments make it
clear enough. Johannes, I still left the setup at the top; for me in the
tradeoff between "one less line" and "setup happens first", the latter
wins.

I also removed the "try pushing two bad branches at the same time" case;
I don't think it's really covered by atomicity. So now we check that if
we push one bad ref, collateral damage in the form of 1) a new branch
and 2) a perfectly good push of another branch are both rejected and
reported correctly.

Also, got rid of the accidental new curly braces around unrelated part
of the code.

Thanks all.

 - Emily

 t/t5541-http-push-smart.sh | 39 ++++++++++++++++++++++++++++++++++++++
 transport-helper.c         |  6 ++++++
 transport.c                | 13 +++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 8ef8763e06..7f9ae1ef3f 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -177,6 +177,45 @@ test_expect_success 'push (chunked)' '
 	 test $HEAD = $(git rev-parse --verify HEAD))
 '
 
+test_expect_success 'push --atomic also prevents branch creation, reports collateral' '
+	# Setup upstream repo - empty for now
+	d=$HTTPD_DOCUMENT_ROOT_PATH/atomic-branches.git &&
+	git init --bare "$d" &&
+	test_config -C "$d" http.receivepack true &&
+	up="$HTTPD_URL"/smart/atomic-branches.git &&
+
+	# Tell up about two branches for now
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
+	test_must_fail git -C "$d" rev-parse refs/heads/atomic &&
+
+	# the failed refs should be indicated
+	grep "master -> master" output | grep rejected &&
+
+	# the collateral failure refs should be indicated
+	grep "atomic -> atomic" output | grep "atomic push failed" &&
+	grep "collateral -> collateral" output | grep "atomic push failed"
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

