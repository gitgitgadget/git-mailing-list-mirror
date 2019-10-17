Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD3171F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 17:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436799AbfJQRfP (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 13:35:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38656 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbfJQRfO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 13:35:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id o15so2881344wru.5
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 10:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PD8Yp0H1cNQecXGlh2bWlADzZm0AD4xK+EpyxV/pLRU=;
        b=M15YGFj4DSRFYqKaBj1EE3AiKjQkP8bTwj+8VjNIuvQaz4y4dEMZ5///pldNm50f7F
         3fNaOh4eLlgTzhXfhd9p6BRRgfkW1dryvd0f0rMDgkspgrcjFs6WKnlKuH+w88O6SkXv
         5Qpakk5TuO7so0aYJ8oqmiSMZDITn6FoznCD5l0STJM80bQDnfQwLD9nrIwQQlLmSqLq
         H6HkZkIoWct2lXXtdL49JGafKCiLajEaw68P7jD+rAmrqCixZx3jd0/Cb8lqj0b0NHVK
         1b4XBzeGw82kpjgHHiAXCyIC/xwxDgivOI2a+woSsZl8Bt7dmNkSwJT6yNzk6z0M4/A3
         Cyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PD8Yp0H1cNQecXGlh2bWlADzZm0AD4xK+EpyxV/pLRU=;
        b=TF/I+UFontD8sMtBNaINyPQgWGQNI3qez9NZy1Pv+AqIdTv31Bl/fvujd1y2hlz7ay
         KHHBMzQ/jX8iU4O7b6la9snxZgOfEBtLFfSjGl3snR9E3v9oM/vvYYqMC7oXxyMxDJ+8
         E7gErKk2StFCJL0cqL8ziOgvtmL4vIxK8rxgICdB7MRoRMxJiayzExIE827L54Kd+DXt
         8dgDyw1+G8fmyahKZymoT3UIS85GdpJ+iWvTfEE/DeGuKt2nk5CXW947HGhH1PC4d87v
         GELpRnU6h23fz2L5XKfi2Hl81X8RZclyvfoUV/pr2hj85x2RidijyW/EEaqJCZhgXq6k
         BQZw==
X-Gm-Message-State: APjAAAUE1vhYETs0Z+nEHDuguUacd5iSK2RCW9Mf4pk/gtbIxTClOrkf
        MGAvXIVsspRTsL9gVddL6J3it6Iv
X-Google-Smtp-Source: APXvYqzArdXVAXzih8VJ+xbP0fKM5xDrTgPumsu3ii1GM4O9qPWeeDP9FkWntMpCUgwKu8KGFgZvIw==
X-Received: by 2002:adf:9dca:: with SMTP id q10mr4094290wre.183.1571333712320;
        Thu, 17 Oct 2019 10:35:12 -0700 (PDT)
Received: from localhost.localdomain (x4db41bda.dyn.telefonica.de. [77.180.27.218])
        by smtp.gmail.com with ESMTPSA id f20sm2599876wmb.6.2019.10.17.10.35.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Oct 2019 10:35:11 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/6] completion: clean up the __git_find_on_cmdline() helper function
Date:   Thu, 17 Oct 2019 19:34:57 +0200
Message-Id: <20191017173501.3198-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.1084.gae250eaa40
In-Reply-To: <20191017173501.3198-1-szeder.dev@gmail.com>
References: <20191017173501.3198-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The __git_find_on_cmdline() helper function started its life as
__git_find_subcommand() [1], but it served a more general purpose than
looking for subcommands, so later it was renamed accordingly [2].
However, that rename didn't touch the body of the function, and left
the $subcommand local variable behind, still reminiscent of the
function's original purpose.

Let's clean up the names of __git_find_on_cmdline()'s local variables
and get rid of that $subcommand variable name.

While at it, add a short comment describing the function's purpose.

[1] 3ff1320d4b (bash: refactor searching for subcommands on the
    command line, 2008-03-10),
[2] 918c03c2a7 (bash: rename __git_find_subcommand() to
    __git_find_on_cmdline(), 2009-09-15)

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 00fbe6c03d..2384f91e78 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1070,14 +1070,17 @@ __git_aliased_command ()
 }
 
 # __git_find_on_cmdline requires 1 argument
+# Check whether one of the given words is present on the command line,
+# and print the first word found.
 __git_find_on_cmdline ()
 {
-	local word subcommand c=1
+	local word c=1
+	local wordlist="$1"
+
 	while [ $c -lt $cword ]; do
-		word="${words[c]}"
-		for subcommand in $1; do
-			if [ "$subcommand" = "$word" ]; then
-				echo "$subcommand"
+		for word in $wordlist; do
+			if [ "$word" = "${words[c]}" ]; then
+				echo "$word"
 				return
 			fi
 		done
-- 
2.23.0.1084.gae250eaa40

