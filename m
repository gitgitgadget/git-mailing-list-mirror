Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A1DC43331
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 14:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193AA20777
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 14:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hr68l2oV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgCYOga (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:36:30 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:46036 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbgCYOg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 10:36:27 -0400
Received: by mail-pl1-f182.google.com with SMTP id b9so854799pls.12
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 07:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YldpHljorqSItlmtAJicqf9shB217Y3+gvmG7lnmgik=;
        b=hr68l2oVxFk0G0P0L/CX8UteLGw4J8JOVU/Bqhr/jdcVhGtTg8XTrr523CNrIWQl+3
         UKHUqT+h++ilWqZf2GGFEtOTMa6MAtQIwoMLVIWcF4Ioakpxd9lUhooc2JxWkfeerq5V
         ckD1pTHot7asAxzx8OLsJGSaI0k37Xum1hu9nBgm2qIvrsGnklWZ6yTLOHfWsjp46FGF
         gZw/S8fQO8Z9YR5gwCgSnED16U0/MElbQjtZu3YX34u+dTw1od2jqIxu2s4T4i+I6VdL
         G6BIBzlvdYk5d3JdV5a613+rxyF4m/xrp21HbO01B60an/rE3xWZZ/JqZ1Otpw3ObY3q
         KCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YldpHljorqSItlmtAJicqf9shB217Y3+gvmG7lnmgik=;
        b=eXf+7ay3JNkfpCAMs6/sQBbHSbvcGAOB8lhIgFWL4LJ0Kmck1p7PQrg9jho2sPARPd
         QiuAksNphqGmR45JeiMVlZ9s+S5b9Y5qHMJXarIVGQtBcsq2vOxaIsAn79vPDkqHDx9e
         zv102apTjBQtz/8yjoHnwYcMFU9ZPFTwULkkrQwHT/RIblgPMvLCFZWZd5xCcJ7wmvyY
         63x7+PkNk9vuKPhLeglQOJQlka97nMMKAW1MJQEI8eZ0tLvedNKHCEhjcWqCAEhF/+tZ
         nnxK6Rv5rMsrwVRpz0R+BvVUcYkHcmjjG6MGQGsOmDa/xkwoDDOEWOefQTSBPIHorpZk
         cNBA==
X-Gm-Message-State: ANhLgQ0KIODYPRfFiVIFn/IODXYuJ5lDdfNFvkaS/3eSyEht+FoivBiV
        ULwLXJFD+c5QMHOsnxzO9Fw=
X-Google-Smtp-Source: ADFU+vtVlf63xqaJbqXOU/XYZ4SF2CtDqdgwsurKX14m/RRgXi7WjIJdpTdbbQ43djCV9evBIHGm0A==
X-Received: by 2002:a17:90a:198e:: with SMTP id 14mr3990069pji.164.1585146985449;
        Wed, 25 Mar 2020 07:36:25 -0700 (PDT)
Received: from localhost.localdomain ([47.89.83.3])
        by smtp.gmail.com with ESMTPSA id f127sm18180423pfa.112.2020.03.25.07.36.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 07:36:24 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH 3/3] transport-helper: enforce atomic in push_refs_with_push
Date:   Wed, 25 Mar 2020 22:36:08 +0800
Message-Id: <20200325143608.45141-4-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.26.0.3.ga7a9d752d4
In-Reply-To: <20200322131815.11872-3-worldhello.net@gmail.com>
References: <20200322131815.11872-3-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit v2.22.0-1-g3bca1e7f9f (transport-helper: enforce atomic in
push_refs_with_push, 2019-07-11) noticed the incomplete report of
failure of an atomic push for HTTP protocol.  But the implementation
has a flaw that mark all remote references as failure.

Only mark necessary references as failure in `push_refs_with_push()` of
transport-helper.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t5541-http-push-smart.sh | 14 +++++++++++---
 transport-helper.c         | 15 +++++++++++++++
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 2c2c3fb0f5..afc680d5e3 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -177,7 +177,10 @@ test_expect_success 'push (chunked)' '
 	 test $HEAD = $(git rev-parse --verify HEAD))
 '
 
-test_expect_failure 'push --atomic also prevents branch creation, reports collateral' '
+## References of remote: atomic1(1)            master(2) collateral(2) other(2)
+## References of local :            atomic2(2) master(1) collateral(3) other(2) collateral1(3) atomic(1)
+## Atomic push         :                       master(1) collateral(3)                         atomic(1)
+test_expect_success 'push --atomic also prevents branch creation, reports collateral' '
 	# Setup upstream repo - empty for now
 	d=$HTTPD_DOCUMENT_ROOT_PATH/atomic-branches.git &&
 	git init --bare "$d" &&
@@ -189,7 +192,8 @@ test_expect_failure 'push --atomic also prevents branch creation, reports collat
 	test_commit atomic2 &&
 	git branch collateral &&
 	git branch other &&
-	git push "$up" master collateral other &&
+	git push "$up" atomic1 master collateral other &&
+	git tag -d atomic1 &&
 
 	# collateral is a valid push, but should be failed by atomic push
 	git checkout collateral &&
@@ -224,7 +228,11 @@ test_expect_failure 'push --atomic also prevents branch creation, reports collat
 
 	# the collateral failure refs should be indicated to the user
 	grep "^ ! .*rejected.* atomic -> atomic .*atomic push failed" output &&
-	grep "^ ! .*rejected.* collateral -> collateral .*atomic push failed" output
+	grep "^ ! .*rejected.* collateral -> collateral .*atomic push failed" output &&
+
+	# never report what we do not push
+	! grep "^ ! .*rejected.* atomic1 " output &&
+	! grep "^ ! .*rejected.* other " output
 '
 
 test_expect_success 'push --atomic fails on server-side errors' '
diff --git a/transport-helper.c b/transport-helper.c
index 20a7185ec4..ab3b52eb14 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -894,6 +894,21 @@ static int push_refs_with_push(struct transport *transport,
 		case REF_STATUS_REJECT_STALE:
 		case REF_STATUS_REJECT_ALREADY_EXISTS:
 			if (atomic) {
+				/* Mark other refs as failed */
+				for (ref = remote_refs; ref; ref = ref->next) {
+					if (!ref->peer_ref && !mirror)
+						continue;
+
+					switch (ref->status) {
+					case REF_STATUS_NONE:
+					case REF_STATUS_OK:
+					case REF_STATUS_EXPECTING_REPORT:
+						ref->status = REF_STATUS_ATOMIC_PUSH_FAILED;
+						continue;
+					default:
+						break; /* do nothing */
+					}
+				}
 				string_list_clear(&cas_options, 0);
 				return 0;
 			} else
-- 
2.26.0.3.ga7a9d752d4

