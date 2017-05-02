Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6C26207D6
	for <e@80x24.org>; Tue,  2 May 2017 04:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750979AbdEBEBY (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 00:01:24 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:33626 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750781AbdEBEBV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 00:01:21 -0400
Received: by mail-io0-f194.google.com with SMTP id o22so1895129iod.0
        for <git@vger.kernel.org>; Mon, 01 May 2017 21:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5jh8muBcbZbMDvZUXpn4kx1vLbR713r5Qr3nTm335wU=;
        b=Xm5EM8pHRGMuOfqP1/bHCGLVfbCP7kgUTWX+vqZfa4eMLGU7X7xlkcVglLLMWc6tx2
         BIgzeEbiE5v/jr9mzDBn8KwRV+chVsfeNd1TI4YXcoF4AknqiSnzhaD7DERwNHJAK/g+
         16y3BFOKRodXSw6MLxYzih6ZsVzKXOoUQ3COJRVLkv3ySwaQUtvd0+zWVgv1JgqBhyyR
         pb8sgEjTAA5EIe41Bqs9gkCZn/MN1Nt+TRPQ1kW0C82/mqVJf45Gxu6sldrq3jw7iv/+
         oaiv7C6uuG5a64BQMcd19LUDILqOWVP84AbiXOPjviB/XSxuScQmxQWnYOeN8FxzlZOr
         3iaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5jh8muBcbZbMDvZUXpn4kx1vLbR713r5Qr3nTm335wU=;
        b=nxF0wqCrB2kprYcCbMnQx0RUWDsMKwje0cqS/HC5bQ/hb3RmfQ2uX0b4gscb+e1EiU
         tSIBrEoK6jnwVeSS0T0YOGbyAL1/Tmpvk03ag7SvEJOSOxkNAfrJolPPMvE6IS+iGGc8
         RAsIUDmE+bw86hz6R3HKRiCVp1Jf+0TwyR3o9uVk81gS2KHfsG/v8aKfz1Cu9x+6W0h6
         BA/flLmBhDPvlHiFgSint3oh0N8xQSb3/w2nuoUJWiZU871D6i6d7rXT51wsxih1qulv
         hNn0L4EY4KidbKTbpjCgfm5/bP4ZVCya8AlNYa7eY5iIMoAHSK5vXJQYn0s1SJAYbdzb
         LWKg==
X-Gm-Message-State: AN3rC/6KBN3EDQMcIBV6j0iimM10qzYKHdtg0ucLfVypneJJJuX9NQee
        2UI80aOAzjPsHVJr
X-Received: by 10.107.46.215 with SMTP id u84mr27530940iou.147.1493697680562;
        Mon, 01 May 2017 21:01:20 -0700 (PDT)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id p65sm7211762ioe.3.2017.05.01.21.01.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 May 2017 21:01:20 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, peff@peff.net,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v3 2/6] rebase -i: add abbreviate_commands function
Date:   Tue,  2 May 2017 00:00:44 -0400
Message-Id: <20170502040048.9065-3-liambeguin@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170502040048.9065-1-liambeguin@gmail.com>
References: <20170502040048.9065-1-liambeguin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Once the rest of the processing is done, the `abbreviate_commands`
function is called. If the 'rebase.abbreviateCommands' option is set to
true, the function will replace each command-name by its abbreviated
form.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 git-rebase--interactive.sh | 16 ++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 9b8a030ff045..4fa621062cdf 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -884,6 +884,20 @@ add_exec_commands () {
 	mv "$1.new" "$1"
 }
 
+abbreviate_commands () {
+	test "$(git config --bool rebase.abbreviateCommands)" = true || return
+
+	while read -r command rest
+	do
+		case $command in
+		x|exec) command=x ;;
+		*)      command=${command%${command#?}} ;;
+		esac
+		printf "%s\n" "$command $rest"
+	done <"$1" >"$1.new" &&
+	mv -f "$1.new" "$1"
+}
+
 # Check if the SHA-1 passed as an argument is a
 # correct one, if not then print $2 in "$todo".badsha
 # $1: the SHA-1 to test
@@ -1143,6 +1158,7 @@ edit-todo)
 	git stripspace --strip-comments <"$todo" >"$todo".new
 	mv -f "$todo".new "$todo"
 	collapse_todo_ids
+	abbreviate_commands "$todo"
 	append_todo_help
 	gettext "
 You are editing the todo file of an ongoing interactive rebase.
@@ -1281,6 +1297,7 @@ fi
 test -s "$todo" || echo noop >> "$todo"
 test -n "$autosquash" && rearrange_squash "$todo"
 test -n "$cmd" && add_exec_commands "$todo"
+abbreviate_commands "$todo"
 
 todocount=$(git stripspace --strip-comments <"$todo" | wc -l)
 todocount=${todocount##* }
-- 
2.9.3

