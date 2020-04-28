Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7524C83002
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 00:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81D01208FE
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 00:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HiV0wEN+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgD1ABT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 20:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726307AbgD1ABS (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 20:01:18 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A8BC03C1A8
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 17:01:17 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id q43so22453373qtj.11
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 17:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3u3DweNqVT51+76ePUwJFgPxr2rK4EQok0gtAqBJ13Y=;
        b=HiV0wEN+QVqwJO3/e24BSBSvIin4AsiUrn4fYkZAOyeSe7HD1Fzr14PpgukM67vraa
         jy78JWqNgXzTY3+B2Li8+nnBvTKQjaNTs3dAWANVYc5GkzDA614AmCx6sXgtp/qOfzT9
         ba1+JEuWYNKXbM1oijU/Km7Fvl6OhCqvPvq/iZkTvWg/qPZiPbnC1Tn1b/BiKwZTX089
         iTrt3UZvkeL44MrejAosw2kjxzqi/wsZ6H6EQuooVo3Vklf/55/U0AeiPgEaeY1IS13Z
         999vtqi1If6sJYC3XMhpsf8kGahuE3og5s6yP6yIKA4EnHLdO0kM3dOKQFBLvD+YIr15
         sB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3u3DweNqVT51+76ePUwJFgPxr2rK4EQok0gtAqBJ13Y=;
        b=W9mNG3cS7qOv/tq40vFRp0fXFFO805zvawUFqFLgjwSoTNcysXveLfBo+xWr3W7R9z
         aVaxr4ch7z0BlybM/a8S5jfyx+pQjVhaUrsKLRzYkopuUA+OD2yOxQ0W/CuXv3YUwlPY
         RZsdo3FUEJJ2cU4dOPjsAYacIE+hP2FkrtZBIa1JJKMNKybcLey1xmWQsBnZ7Jlwsst8
         TGFsAj2xM2k4AIQPtPYWooPU0DYnQ4nbb6wBqa1gr99kyzE8ZbHGuUvP41jHtYmYYaCi
         xY4QZTm3iixrwfFpj9pXkAR7lVXuLN4gPG2wOSa0Vva7m8bMMKRfHA7PoW/hVyuFOGP+
         //OA==
X-Gm-Message-State: AGi0PuZl7OmCO1a5SV3fq9NVXbJhfK4pDNcoOCdu9u4HtJwQuVLKzhrO
        lC3ozh4VcOnPV0HZmV6/x/Tvq6pfR9j0XuZonMdGIn+3LSGL4JKIr4piRL1TQbwVFe12AcMqbSd
        oQIKUUi6gDLhahWfnIUshL7kR+V3s0SBVH/eLiCc7K1MrlAGH8IjKVdSV/bXNZWNnDvfFQ3L56T
        vd
X-Google-Smtp-Source: APiQypL/ZsxAt90DYBUFoTSsu+Qf9lIq9KvyoTpbiVmOU2vqV2BExDEqEQqjWRDRejcR+0C4UAUTboLlB/L6Lh3MGSZi
X-Received: by 2002:a0c:b286:: with SMTP id r6mr5234992qve.244.1588032076923;
 Mon, 27 Apr 2020 17:01:16 -0700 (PDT)
Date:   Mon, 27 Apr 2020 17:01:09 -0700
In-Reply-To: <cover.1588031728.git.jonathantanmy@google.com>
Message-Id: <eb18faea2d00d9b09d3fcc79646cc7556023c258.1588031728.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1587775989.git.jonathantanmy@google.com> <cover.1588031728.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v2 2/3] fetch-pack: in protocol v2, in_vain only after ACK
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When fetching, Git stops negotiation when it has sent at least
MAX_IN_VAIN (which is 256) "have" lines without having any of them
ACK-ed. But this is supposed to trigger only after the first ACK, as
pack-protocol.txt says:

  However, the 256 limit *only* turns on in the canonical client
  implementation if we have received at least one "ACK %s continue"
  during a prior round.  This helps to ensure that at least one common
  ancestor is found before we give up entirely.

The code path for protocol v0 observes this, but not protocol v2,
resulting in shorter negotiation rounds but significantly larger
packfiles. Teach the code path for protocol v2 to check this criterion
only after at least one ACK was received.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c          | 13 +++++++++----
 t/t5500-fetch-pack.sh | 18 ++++++++++++++++++
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 45547a621e..76691dc6c0 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1143,6 +1143,7 @@ static void add_common(struct strbuf *req_buf, struct oidset *common)
 }
 
 static int add_haves(struct fetch_negotiator *negotiator,
+		     int seen_ack,
 		     struct strbuf *req_buf,
 		     int *haves_to_send, int *in_vain)
 {
@@ -1157,7 +1158,7 @@ static int add_haves(struct fetch_negotiator *negotiator,
 	}
 
 	*in_vain += haves_added;
-	if (!haves_added || *in_vain >= MAX_IN_VAIN) {
+	if (!haves_added || (seen_ack && *in_vain >= MAX_IN_VAIN)) {
 		/* Send Done */
 		packet_buf_write(req_buf, "done\n");
 		ret = 1;
@@ -1173,7 +1174,7 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 			      struct fetch_pack_args *args,
 			      const struct ref *wants, struct oidset *common,
 			      int *haves_to_send, int *in_vain,
-			      int sideband_all)
+			      int sideband_all, int seen_ack)
 {
 	int ret = 0;
 	struct strbuf req_buf = STRBUF_INIT;
@@ -1230,7 +1231,8 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 		add_common(&req_buf, common);
 
 		/* Add initial haves */
-		ret = add_haves(negotiator, &req_buf, haves_to_send, in_vain);
+		ret = add_haves(negotiator, seen_ack, &req_buf,
+				haves_to_send, in_vain);
 	}
 
 	/* Send request */
@@ -1465,6 +1467,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	int haves_to_send = INITIAL_FLUSH;
 	struct fetch_negotiator negotiator_alloc;
 	struct fetch_negotiator *negotiator;
+	int seen_ack = 0;
 
 	if (args->no_dependents) {
 		negotiator = NULL;
@@ -1521,7 +1524,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			if (send_fetch_request(negotiator, fd[1], args, ref,
 					       &common,
 					       &haves_to_send, &in_vain,
-					       reader.use_sideband))
+					       reader.use_sideband,
+					       seen_ack))
 				state = FETCH_GET_PACK;
 			else
 				state = FETCH_PROCESS_ACKS;
@@ -1534,6 +1538,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 				break;
 			case COMMON_FOUND:
 				in_vain = 0;
+				seen_ack = 1;
 				/* fallthrough */
 			case NO_COMMON_FOUND:
 				state = FETCH_SEND_REQUEST;
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index baa1a99f45..961cd6beec 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -385,6 +385,24 @@ test_expect_success 'clone shallow with packed refs' '
 	test_cmp count8.expected count8.actual
 '
 
+test_expect_success 'in_vain not triggered before first ACK' '
+	rm -rf myserver myclient trace &&
+	git init myserver &&
+	test_commit -C myserver foo &&
+	git clone "file://$(pwd)/myserver" myclient &&
+
+	# MAX_IN_VAIN is 256. Because of batching, the client will send 496
+	# (16+32+64+128+256) commits, not 256, before giving up. So create 496
+	# irrelevant commits.
+	test_commit_bulk -C myclient 496 &&
+
+	# The new commit that the client wants to fetch.
+	test_commit -C myserver bar &&
+
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C myclient fetch --progress origin &&
+	test_i18ngrep "Total 3 " trace
+'
+
 test_expect_success 'fetch in shallow repo unreachable shallow objects' '
 	(
 		git clone --bare --branch B --single-branch "file://$(pwd)/." no-reflog &&
-- 
2.26.2.303.gf8c07b1a785-goog

