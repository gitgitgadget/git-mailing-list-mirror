Return-Path: <SRS0=d2Ax=EG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFC8C00A89
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 02:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2812221EB
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 02:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mutual.io header.i=@mutual.io header.b="pcUYBmZz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgJaCjf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 22:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgJaCje (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 22:39:34 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FDAC0613D5
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 19:39:34 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id w11so3905207pll.8
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 19:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mutual.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LClCZt8fgdj48X052aLkEwsSguU1CUtChDjH0toGm1I=;
        b=pcUYBmZzh2cn3Pmbi5SuSkVyZvbT/T4ilmqOZokrO5s5GyOMUPnIRGJUc9/nWyZ6j2
         dTvAaUmG/Uhn8HQHDLrH9tZj1AXcPn+d1+2uHjdvNoR2GQDKNeQq0DyUYxeC9YntrIAK
         JUr8EbN3eBFSsIUYToq7PDZ6B0cTmvL0VXxDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LClCZt8fgdj48X052aLkEwsSguU1CUtChDjH0toGm1I=;
        b=hyfvEz4dNzOvKQWKCyYS6pzik2HKAbmwKXYtcD+OprnclqMQ1KR2CkESkWIxFJhO36
         u2kfEZGveMdTK0wV0zJUqVxXKX1bNhGlRT0lzNy89nCfJiVNuW/44BQQkB22ilzU0l88
         5eTQj4c1rbzCm8Cgkpniyu6pWShK99Tekr3LIKwTx85rZ7tDROyJochiGnpknWxP5FZf
         Dzz+JSa41v47zc6N+hF83ldSNnc0kJvW3qB46E4lbDLaQ0A1stYrY/q5uFWro0xRuQUP
         ASIhwRVEc3awr5ZV5REwNpUCgzQdoFDFTB7GBJZjvPp6ldd2aEhx2mcUFNTrq1JjVbfV
         Bn3g==
X-Gm-Message-State: AOAM533+a49Tdb7HHqoiudATb6wFmCVoXw5jib5fNlVaDWk9miBpnS3K
        qoRdNmhQpgqrr/tyPa62eIvZ7tlgM6/IovIl
X-Google-Smtp-Source: ABdhPJw5mrU3+qF+dsiTDTjIqDQJrP6hEUX4CwOfyeUtHgfjyg4DxqwClPp96Tt84MJEyl7zOyzsig==
X-Received: by 2002:a17:90b:1186:: with SMTP id gk6mr6317058pjb.109.1604111974365;
        Fri, 30 Oct 2020 19:39:34 -0700 (PDT)
Received: from shawarma.mutual.io (23-115-137-209.lightspeed.sntcca.sbcglobal.net. [23.115.137.209])
        by smtp.gmail.com with ESMTPSA id bx24sm4744259pjb.20.2020.10.30.19.39.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2020 19:39:33 -0700 (PDT)
Received: by shawarma.mutual.io (Postfix, from userid 502)
        id 3A65C2173357; Fri, 30 Oct 2020 19:39:32 -0700 (PDT)
From:   Daniel Duvall <dan@mutual.io>
To:     git@vger.kernel.org
Cc:     Daniel Duvall <dan@mutual.io>
Subject: [PATCH v3] upload-pack: allow stateless client EOF just prior to haves
Date:   Fri, 30 Oct 2020 19:39:02 -0700
Message-Id: <20201031023901.48193-1-dan@mutual.io>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <1604022059-18527-1-git-send-email-dan@mutual.io>
References: <1604022059-18527-1-git-send-email-dan@mutual.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During stateless packfile negotiation where a depth is given, stateless
RPC clients (e.g. git-remote-curl) will send multiple upload-pack
requests with the first containing only the
wants/shallows/deepens/filters and the subsequent containing haves/done.

When upload-pack handles such requests, entering get_common_commits
without checking whether the client has hung up can result in unexpected
EOF during the negotiation loop and a die() with message "fatal: the
remote end hung up unexpectedly".

Real world effects include:

 - A client speaking to git-http-backend via a server that doesn't check
   the exit codes of CGIs (e.g. mod_cgi) doesn't know and doesn't care
   about the fatal. It continues to process the response body as normal.

 - A client speaking to a server that does check the exit code and
   returns an errant HTTP status as a result will fail with the message
   "error: RPC failed; HTTP 500 curl 22 The requested URL returned error:
   500."

 - Admins running servers that surface the failure must workaround it by
   patching code that handles execution of git-http-backend to ignore exit
   codes or take other heuristic approaches.

 - Admins may have to deal with "hung up unexpectedly" log spam related
   to the failures even in cases where the exit code isn't surfaced as an
   HTTP server-side error status.

To avoid these EOF related fatals, have upload-pack gently peek for an
EOF between the sending of shallow/unshallow lines (followed by flush)
and the reading of client haves. If the client has hung up at this
point, exit normally.

Signed-off-by: Daniel Duvall <dan@mutual.io>
---

Changes in v2:
 - Replaced unconditional flipping (XOR) of PACKET_READ_GENTLE_ON_EOF bit w/
   `&= ~` to flip it back off (as it was when reader was initialized in
   previous clause)
 - Renamed test filename to group with other upload-pack related tests
 - Refactored test using packetize helper
 - Clarified in commit message that file descriptor is still valid but client
   hangup/EOF is the core issue
 - Added possible real-world effects of bug to commit message as suggested

Changes in v3:
 - Moved test into existing t/t5530-upload-pack-error.sh

---
 t/t5530-upload-pack-error.sh | 17 +++++++++++++++++
 upload-pack.c                | 13 ++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/t/t5530-upload-pack-error.sh b/t/t5530-upload-pack-error.sh
index 205a2631e7..9dd2d2457a 100755
--- a/t/t5530-upload-pack-error.sh
+++ b/t/t5530-upload-pack-error.sh
@@ -88,6 +88,23 @@ test_expect_success 'upload-pack fails due to error in pack-objects enumeration'
 	grep "pack-objects died" output.err
 '
 
+test_expect_success 'upload-pack tolerates EOF just after stateless client wants' '
+	test_commit initial &&
+	head=$(git rev-parse HEAD) &&
+
+	{
+		packetize "want $head" &&
+		packetize "shallow $head" &&
+		packetize "deepen 1" &&
+		printf "0000"
+	} >request &&
+
+	printf "0000" >expect &&
+
+	git upload-pack --stateless-rpc . <request >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'create empty repository' '
 
 	mkdir foo &&
diff --git a/upload-pack.c b/upload-pack.c
index 3b858eb457..5dc8e1f844 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1344,7 +1344,18 @@ void upload_pack(struct upload_pack_options *options)
 				   PACKET_READ_DIE_ON_ERR_PACKET);
 
 		receive_needs(&data, &reader);
-		if (data.want_obj.nr) {
+
+		/*
+		 * An EOF at this exact point in negotiation should be
+		 * acceptable from stateless clients as they will consume the
+		 * shallow list before doing subsequent rpc with haves/etc.
+		 */
+		if (data.stateless_rpc)
+			reader.options |= PACKET_READ_GENTLE_ON_EOF;
+
+		if (data.want_obj.nr &&
+		    packet_reader_peek(&reader) != PACKET_READ_EOF) {
+			reader.options &= ~PACKET_READ_GENTLE_ON_EOF;
 			get_common_commits(&data, &reader);
 			create_pack_file(&data, NULL);
 		}
-- 
2.29.2

