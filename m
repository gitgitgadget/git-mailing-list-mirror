Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 945341FEB3
	for <e@80x24.org>; Wed, 11 Jan 2017 07:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762125AbdAKHKj (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 02:10:39 -0500
Received: from mail-wj0-f193.google.com ([209.85.210.193]:34350 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762087AbdAKHKh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 02:10:37 -0500
Received: by mail-wj0-f193.google.com with SMTP id qs7so52065845wjc.1
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 23:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uu3xBNREC4TpjnmzBWj2h55CHrazOljac4o0cpDTqsA=;
        b=fBdVosc6YOfY2VT3DP2KvCtp9Xkuy5/BhxFDQRgEt/HrYg3EHwHVqGivMowEHfbza7
         9zQjKgOjtKGXOsuqCijo9/fYJZC0s1ka6S/MKAjYh9qVXnYUKGd+c9OvsmQORRjesW86
         NCI8LAE0lpwrEOzmti+lXmQyqoaEHVRUeeWdrVmzVMF/vkXymq1T960/4xyxMgH/XL0s
         q8TdyYIvbgQaQdAXBOxXCYLZx06dJyW2wMYdkW7aIEvDoe4JwEw149YKZAXEbUQRKTtG
         DzuqVG9kK1qb4VLu19yxtx3qh/e/yF6X/CE8MIDijzI+MD8Ue3FwpM8F3u8CwzmbDR4f
         3Cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uu3xBNREC4TpjnmzBWj2h55CHrazOljac4o0cpDTqsA=;
        b=n7c2oGlr16OIwH4ckrOLu6xfGSzfP7kPtkaRwdoZ/mV2PqqSK+8kOtfp36aEP1HTqk
         AgGDL1D51hIqKIr31NwVE3QlLjqoqgn+rbmzH3uzuGjrW9kVG8fABupciZSb1J80fauH
         sEM2JgtY3hzdBD76RCji93/HxtYvJuqST0d/2ipxDtmqYNKTj3fPOodexRIMVkXuBVt/
         S3HmX7pQlhswnn//D0mgIXbn6Fn2aSqQEPJMoTlAVksMdrp+rv+lYFMxryGP58++MUSa
         5XeBCia5FSQnj/pZ4G19Z7R1RmPg4PMvbqL/26OAypWhYfW8WSAVgcGnQvcAZ1Sc+v6K
         xvtQ==
X-Gm-Message-State: AIkVDXJEMNvVG8yrWNH/X4zQI+um9yyXX9HYTVxKIlQGgLvks3+rhBOnu+mC399bLSnTmA==
X-Received: by 10.194.172.42 with SMTP id az10mr4005585wjc.145.1484118636228;
        Tue, 10 Jan 2017 23:10:36 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([13.94.233.52])
        by smtp.gmail.com with ESMTPSA id d64sm28163333wmh.3.2017.01.10.23.10.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jan 2017 23:10:35 -0800 (PST)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCHv2 2/2] builtin/commit.c: drop use snprintf via dynamic allocation
Date:   Wed, 11 Jan 2017 07:10:32 +0000
Message-Id: <20170111071032.27797-2-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.11.0.154.g5f5f154
In-Reply-To: <20170111071032.27797-1-gitter.spiros@gmail.com>
References: <20170111071032.27797-1-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In general snprintf is bad because it may silently truncate results
if we're wrong. In this patch, instead of using xnprintf, which asserts
that we don't truncate, we are switching to dynamic allocation, so we can
avoid dealing with magic numbers in the code.

Helped-by: Jeff King <peff@peff.net> 
Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
This is the second version of the patch.

I have split the original commit in two, as discussed here
http://public-inbox.org/git/20161213132717.42965-1-gitter.spiros@gmail.com/.

 builtin/commit.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 09bcc0f13..37228330c 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1526,12 +1526,10 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 static int run_rewrite_hook(const unsigned char *oldsha1,
 			    const unsigned char *newsha1)
 {
-	/* oldsha1 SP newsha1 LF NUL */
-	static char buf[2*40 + 3];
+	char *buf;
 	struct child_process proc = CHILD_PROCESS_INIT;
 	const char *argv[3];
 	int code;
-	size_t n;
 
 	argv[0] = find_hook("post-rewrite");
 	if (!argv[0])
@@ -1547,11 +1545,11 @@ static int run_rewrite_hook(const unsigned char *oldsha1,
 	code = start_command(&proc);
 	if (code)
 		return code;
-	n = snprintf(buf, sizeof(buf), "%s %s\n",
-		     sha1_to_hex(oldsha1), sha1_to_hex(newsha1));
+	buf = xstrfmt("%s %s\n", sha1_to_hex(oldsha1), sha1_to_hex(newsha1));
 	sigchain_push(SIGPIPE, SIG_IGN);
-	write_in_full(proc.in, buf, n);
+	write_in_full(proc.in, buf, strlen(buf));
 	close(proc.in);
+	free(buf);
 	sigchain_pop(SIGPIPE);
 	return finish_command(&proc);
 }
-- 
2.11.0.154.g5f5f154

