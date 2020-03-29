Return-Path: <SRS0=P8cE=5O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32275C2D0EE
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 14:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009652073B
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 14:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/uLQOOf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgC2Odl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 10:33:41 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:36794 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728275AbgC2Odk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 10:33:40 -0400
Received: by mail-pf1-f174.google.com with SMTP id i13so7279825pfe.3
        for <git@vger.kernel.org>; Sun, 29 Mar 2020 07:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g304PI77YifKtyVQiytTcPrtXT3GCYpUdexpxNvuPxM=;
        b=N/uLQOOfwsxHgPnFBjuACZ7zWI5MDrH+eU/2AkcV2o/aHU4o2KExJkwb70w3Y8BX9g
         BlRdT3TVoJK7P3zLLjAjmRYr0fuKiAaYziHhzeUpcy5wxAOHjULkV4OLDjZCje2XYfii
         MSEF7+5IvAJzrJ8Nl320TPOFlG8qVlXvZKiplFaV8PUelw4kpS7x4eJoK7LCAPj8VM8K
         iKEBzmk/zPE2rRxrnELElD/67eo6Pq+MfLgHAzGSFHCRda3jaHuyRqaJThEzWs1gVP89
         r5agme6op+Ei+kOwxPidsFUqL3c2OFRud8LPFYfmty5+Jan62BSeLAZiX7UmxPcnmdw8
         O3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g304PI77YifKtyVQiytTcPrtXT3GCYpUdexpxNvuPxM=;
        b=OILBWvdeNCLdU4jZ/0glG4zOW1ocEY/Q8meu/DfQvM20BWKlZ1NbCJ9j+JYDI7YBEg
         eaWglonRLARMzYXootq6RTBmFlMkiU5hrr65vOTtl0UL/6w5mf31IlVgQlLv4gs/k9EM
         XeNMdpDkI7/+233nbTNEWVVu75Bw6042vuGjPrgpPTGNLFWP89+792mM5d9hCCxR7rsi
         bRIlOcOKVvXJr/M8V+/VI5Y/X2xbJpeTDf54Jdb2ykV+a5X9NrRW0gk8WxqsIMbPqSwn
         0LXxU0G4p6xVq8MoFd5KOERwcDVH1b6lpGHyLU1vwSUz9VcxiUOQVIjODEnUl40WlbmE
         GMrA==
X-Gm-Message-State: ANhLgQ2P3haQYNyI5PtYkpigsABb7vactxlubujaGa5ynux/dP8ZjB6l
        DuMcOtpirzfUXsBFu5Doy9E=
X-Google-Smtp-Source: ADFU+vtGXeiHqNzjpXwQ/upu8wj9oKak6727aVKWknpcXSLgNst3CTGfkr+08HPKcxI1o2gJ2wZVPw==
X-Received: by 2002:aa7:9790:: with SMTP id o16mr8872133pfp.322.1585492418226;
        Sun, 29 Mar 2020 07:33:38 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id u13sm2947246pgp.49.2020.03.29.07.33.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Mar 2020 07:33:37 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v2 3/4] transport-helper: mark failure for atomic push
Date:   Sun, 29 Mar 2020 10:33:28 -0400
Message-Id: <20200329143329.13846-4-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200325143608.45141-1-zhiyou.jx@alibaba-inc.com>
References: <20200325143608.45141-1-zhiyou.jx@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

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
2.26.0.4.g39bcdcb101.dirty

