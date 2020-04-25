Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBCDC54FD0
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 00:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D5CB2076C
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 00:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PpV7OjcS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgDYA4L (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 20:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgDYA4K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 20:56:10 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F80C09B049
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 17:56:10 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d4so9329591plr.18
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 17:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QBnRaNU0jdnIMvDVgSUA3zvTnA+iAPga6ZIkZJgxM7I=;
        b=PpV7OjcSJ3MITfZwFvZUBamw++EMwORyMb1gv0DaxLF+sLWStJ7ch7hDXAGMxMJzbT
         0aDK0VfkgEIhcVfsoTCh+hY3sgaeXT+f2qXTvf1suBsO0PmNMKO6n4OU7YMaarBkv9ZL
         u2JfDfx8sG77fwv7ztK6u6MdbA/1QNq5qVvl1qwIjs+ghjC1KR/aDbu8ozTSB4wv/DOa
         Rr6iZU8rEdgrVdmonKAlyBrMhj9qrbs9DP+8WcjweAlRzw1Wh3qUFAl7D7x0M+SfGBTE
         75XROMN3/lYwPpLy+D2pI/psP1pnA0Dse6lq+5dgbsTEzkEwWPw5xnaTSITi5A05wFXY
         5s2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QBnRaNU0jdnIMvDVgSUA3zvTnA+iAPga6ZIkZJgxM7I=;
        b=JbD3YRTGdG9hF+GroXpr7/H+cGB7YxSD/SkP0Hwkinz+q/lnGdakNclVThMkXF7G8G
         mysBstUTjAM2SIxiTFtXdqt2raDdPvgAYziV8fjadCgxlFfI+HHI6BcApDg68McNT/DU
         WS7HPxSmZSvs6Ak9Q4ANZfhBYZaLayQ8Rjb8FE1t+qkyFXKFEZg+ZVx8BXw0dojwAyjz
         tNH0mTXA6O7ltgsbTMpSUoYj5JQKLRCJKFq4IBxt5in43Aq8uu7IdPk3K23vl0tqLeWZ
         X+9cDhMWz8fOOu9KQ8YVyBDPySw6Y2H71K1U9NF8l20LIvcRfcTUjgawCDXanor6mNrJ
         OkGA==
X-Gm-Message-State: AGi0PuZAN3JYGmYI0KVA23x/AEoYpkMALovMxEbQ2bDwYdtN8aeKFvK2
        FAXh87e7uzITPkhnDB9QYoa7ROlmjhrk1r8o4U2frtyfGmMgyAHQrnncHyReI0oN3IdeYYKHKq6
        kbtdlOtZYxuxyu1Z0NP6B1DVxmt4Jg0lnIrnhPPmTEkTZYge891LmRjn0Jpkm2b0KRvQ+Sczf4A
        Hd
X-Google-Smtp-Source: APiQypLgdlh3wUlXKNTMJIz+9cDpVudQ7pCRdIv6Tgx3J6uWbjWixJ/MKS5hGkipEnptBftiDTO9QZ2cNYu6+xrrriW6
X-Received: by 2002:a17:90a:718c:: with SMTP id i12mr9568214pjk.58.1587776169420;
 Fri, 24 Apr 2020 17:56:09 -0700 (PDT)
Date:   Fri, 24 Apr 2020 17:56:01 -0700
In-Reply-To: <cover.1587775989.git.jonathantanmy@google.com>
Message-Id: <51174e53527f9b29bb0a5ebb8726f07333113dfb.1587775989.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1587775989.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH 1/2] fetch-pack: in protocol v2, in_vain only after ACK
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        jrnieder@gmail.com, gitster@pobox.com
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
 t/t5500-fetch-pack.sh | 19 +++++++++++++++++++
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 0b07b3ee73..7d15c7af81 100644
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
@@ -1444,6 +1446,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	int haves_to_send = INITIAL_FLUSH;
 	struct fetch_negotiator negotiator_alloc;
 	struct fetch_negotiator *negotiator;
+	int seen_ack = 0;
 
 	if (args->no_dependents) {
 		negotiator = NULL;
@@ -1500,7 +1503,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			if (send_fetch_request(negotiator, fd[1], args, ref,
 					       &common,
 					       &haves_to_send, &in_vain,
-					       reader.use_sideband))
+					       reader.use_sideband,
+					       seen_ack))
 				state = FETCH_GET_PACK;
 			else
 				state = FETCH_PROCESS_ACKS;
@@ -1513,6 +1517,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 				break;
 			case 1:
 				in_vain = 0;
+				seen_ack = 1;
 				/* fallthrough */
 			default:
 				state = FETCH_SEND_REQUEST;
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index baa1a99f45..fcc5cc8ab0 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -385,6 +385,25 @@ test_expect_success 'clone shallow with packed refs' '
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
+	cp trace /tmp/x &&
+	test_i18ngrep "Total 3 " trace
+'
+
 test_expect_success 'fetch in shallow repo unreachable shallow objects' '
 	(
 		git clone --bare --branch B --single-branch "file://$(pwd)/." no-reflog &&
-- 
2.26.2.303.gf8c07b1a785-goog

