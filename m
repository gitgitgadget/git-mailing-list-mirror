Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F9471F404
	for <e@80x24.org>; Mon,  5 Feb 2018 23:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752370AbeBEX7k (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 18:59:40 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46095 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752356AbeBEX7g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 18:59:36 -0500
Received: by mail-pl0-f67.google.com with SMTP id 36so78435ple.13
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 15:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YlBo8O6gGYk0fpTQUf+R+If4f8v7ZHCOfoM9Xz0zxCo=;
        b=M94wj/vkJIKjHyccmrDX+RaJLXQRO8QbDTfGSiRYG2xe1d7BVP54nkFToIejETPWjT
         UhgbNoFxJIM/1GdU0LRtN+x1RHEibCMjn6FNLRqfuXU/Bv0plq6er0yiuzcpvdH2VRht
         R2nsHWzjaLmDWawyqpUDQKm4Q246ivegSsC40tzHi6uVMYBWM1VdVl1yHHu/uycxck2J
         2MHfZsgGT503sWz/8jk4GSYZGZZrPAFrFPW1xu9EWT6ql5U1wSGs4LBAjpG2FwtxVUgi
         hQHMU4ghh/LCqIk0KWoyJCtLXPpx5fvSTfzbmbtgH3UQrKUEIcZFip6ckCTmblyruNQ5
         CR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YlBo8O6gGYk0fpTQUf+R+If4f8v7ZHCOfoM9Xz0zxCo=;
        b=o3sNHRJ6RtKo8cHJj6hAtKC0/1hKiU28CVbvt8DIR7IEg+1pBZsECt2gH40DYqf0ua
         yhoFbNMXGsYffmrJ38S1WGDPYPDm6ME0vAhVwtKsUsWP9Z85+fB2K0ffn278nlcTWdO0
         4l1KhVYv5SR3koXplGoyMADNiwOAWvahm3GE4s6uwDdpwK/6W9fDj6K5AX/hBNrAmJi9
         4yGXGvaP+ny0Gx6r0g7YeLiohJlcnLEQw4gw0pfgyR+Ofv3/TDwm0mli+BJXobsCKwWw
         wXX1QV7RbsWA34CjpnDulC1/PFDlQ0zLffc8NCIFMH8l1lbWcqIKVn3ANwuvGbhX/MJp
         b0Jg==
X-Gm-Message-State: APf1xPBezAvHrU7vx7oxi4FRv922XrZoB/iYz39DEm/wJnip5eSkyS5m
        Brj56DPWE1/1DzxXEm9Ozb1LvKQwDiA=
X-Google-Smtp-Source: AH8x226Jg2PBlbeQM8vSz9Ksc2wINA993uCCATosI9E+up7e5XsREa6Uz4yITq/Z6sgGCebxbzPp5A==
X-Received: by 2002:a17:902:8585:: with SMTP id e5-v6mr480771plo.165.1517875175310;
        Mon, 05 Feb 2018 15:59:35 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id s5sm19812638pfg.29.2018.02.05.15.59.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 15:59:34 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 030/194] pack: allow prepare_packed_git_one to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 15:54:51 -0800
Message-Id: <20180205235735.216710-10-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 packfile.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/packfile.c b/packfile.c
index fd7dfc816e..2b73e62a44 100644
--- a/packfile.c
+++ b/packfile.c
@@ -726,8 +726,8 @@ static void report_pack_garbage(struct string_list *list)
 	report_helper(list, seen_bits, first, list->nr);
 }
 
-#define prepare_packed_git_one(r, o, l) prepare_packed_git_one_##r(o, l)
-static void prepare_packed_git_one_the_repository(char *objdir, int local)
+static void prepare_packed_git_one(struct repository *r,
+				   char *objdir, int local)
 {
 	struct strbuf path = STRBUF_INIT;
 	size_t dirnamelen;
@@ -760,8 +760,7 @@ static void prepare_packed_git_one_the_repository(char *objdir, int local)
 		base_len = path.len;
 		if (strip_suffix_mem(path.buf, &base_len, ".idx")) {
 			/* Don't reopen a pack we already have. */
-			for (p = the_repository->objects.packed_git; p;
-			     p = p->next) {
+			for (p = r->objects.packed_git; p; p = p->next) {
 				size_t len;
 				if (strip_suffix(p->pack_name, ".pack", &len) &&
 				    len == base_len &&
@@ -774,7 +773,7 @@ static void prepare_packed_git_one_the_repository(char *objdir, int local)
 			     * corresponding .pack file that we can map.
 			     */
 			    (p = add_packed_git(path.buf, path.len, local)) != NULL)
-				install_packed_git(the_repository, p);
+				install_packed_git(r, p);
 		}
 
 		if (!report_garbage)
-- 
2.15.1.433.g936d1b9894.dirty

