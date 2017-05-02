Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98800207D6
	for <e@80x24.org>; Tue,  2 May 2017 04:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750784AbdEBEBW (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 00:01:22 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34287 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750747AbdEBEBU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 00:01:20 -0400
Received: by mail-io0-f194.google.com with SMTP id h41so26375999ioi.1
        for <git@vger.kernel.org>; Mon, 01 May 2017 21:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JIftGYxRcC0xyxTP6ggaDoPSYwL4dVwMrgZsDpG0KS8=;
        b=NMjJz9ylPlyWqcnyArhp9xB8URnMtvqc9CUz8lFXwH9KA1ZOlaeIan3/obXvvvXZVx
         SB/imsYtRPmAxEOYHaeHpTPe0TuAp/9JJ9hJKTsmz5emvo9OL62RnI0k/2DSK6iWQnxw
         KzwAWt0OzSwcv8Z/iZbJBn0tTAlLyIqe4F0k+GFMuBd3MfCG5hynINouLTmL+4TMzHil
         c57ctgPAOWLs0kR04jCCw1dtJvU5yHLoXQt0MZxNy4X69d4zMtQivyDgca3fR7a3mSJ4
         PsQ3SwlkovCV07xs/TI1O2+Qypc4oTpamlUutfPJLQbh9u9Fh4ylv7uv7SDE3OWUK2ce
         YopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JIftGYxRcC0xyxTP6ggaDoPSYwL4dVwMrgZsDpG0KS8=;
        b=oHRAtBROLoOHhkYqmFm74XU01XT+dTmE+q4kNMvEzeQrO2aXcjHSngFiO0o+wOzeuv
         PYPjC1mMXyMOacH5F7Aac5397wtjMTb9AiXLpapgjQjK4Z27ZkC6CxR3Jk+OSVCW59zI
         j9vEOqTBDl8brnQ27QMAU+ogYwLNpHHm7kYFO54F3MeTnnQxDZudDwTINwziSZ74Lu3d
         oapWbgq5akp+dWGj4HAPuALfqNffwtaQZHry+j04WzOqNfjJ/P5DBxS2PplUyBVFK7Ep
         L5bN6FMNQkCaGGAEeSYNU8br8GZslA1fvW+e41roF/tdUvEwnbuVOuBbxtgFyvyHEyga
         19BQ==
X-Gm-Message-State: AN3rC/4QCI2wE8r2Ow4TplPw+EnKNBobpeKYqwFAo+WhZdWhgFoJD75I
        lmRNVUizZ1RSUmjJ
X-Received: by 10.107.148.3 with SMTP id w3mr6375863iod.60.1493697678997;
        Mon, 01 May 2017 21:01:18 -0700 (PDT)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id p65sm7211762ioe.3.2017.05.01.21.01.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 May 2017 21:01:18 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, peff@peff.net,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v3 1/6] rebase -i: add abbreviated command-names handling
Date:   Tue,  2 May 2017 00:00:43 -0400
Message-Id: <20170502040048.9065-2-liambeguin@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170502040048.9065-1-liambeguin@gmail.com>
References: <20170502040048.9065-1-liambeguin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

make sure 'add_exec_commands' and 'transform_todo_ids' also understand
the abbreviated versions of the command-names.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 git-rebase--interactive.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 2c9c0165b5ab..9b8a030ff045 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -754,7 +754,7 @@ transform_todo_ids () {
 	while read -r command rest
 	do
 		case "$command" in
-		"$comment_char"* | exec)
+		"$comment_char"* |x|exec)
 			# Be careful for oddball commands like 'exec'
 			# that do not have a SHA-1 at the beginning of $rest.
 			;;
@@ -871,7 +871,7 @@ add_exec_commands () {
 		while read -r insn rest
 		do
 			case $insn in
-			pick)
+			p|pick)
 				test -n "$first" ||
 				printf "%s" "$cmd"
 				;;
-- 
2.9.3

