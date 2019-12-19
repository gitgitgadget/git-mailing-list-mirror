Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4B9C43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 15:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A90206EC
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 15:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYzh4R1x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfLSPJk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 10:09:40 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45885 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfLSPJj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 10:09:39 -0500
Received: by mail-ed1-f67.google.com with SMTP id v28so5172599edw.12
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 07:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YHLrGWWVsIYzZ9gOiB4l/Hc43a9dJKvUWEfhR3t/WNg=;
        b=PYzh4R1xsvV6VstP1DpXAaLsQ+CC2vXbY0YM3MkhXY+ZYtBlC+BxaDMxsmpbKw4tuN
         GohI2WboN2iW5UIkWvt2SM0eHhTQRnRPfYFHAVR1Zk5vmDD+3qigNhqpOKiJFg2EkKt0
         zg/xHAZBShcbafR5v9/TA7eOHcK2zcNd1K2s37rgYN2ZHD5IjMe8e/KikP7EXinSZ4lk
         /xSD7a/d38jA/UE7ihWnEPclqyRepu2iDHbFwPZ/lXmIgqancfhndQgJbkDijCa+jy4o
         kWhkPosWEeI5XjzBlyZq+VwnJxWU2PYHDoe3/eg4Z7sDNm6MwRUCub3JOp4Qm81woJJu
         s9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YHLrGWWVsIYzZ9gOiB4l/Hc43a9dJKvUWEfhR3t/WNg=;
        b=gcSvFEds0htUtBfljG8YhbtOLuJqm+AeOaVGcfi/BtSrqyNDYa63vVah0NTgccWVql
         cgN3UkrjO5AIkqLS2l00FcBp0xEWq3jjYRT2S49krv0i7k4hGN8FuP9JlvhfPGXQXbuE
         4L31cowPwX8qLXDo1h1z/iogu2f2fRZ4cjsOh+bUunNOZqIS2YY2SzLhs02+Igrgzmc5
         iR8eQdt+FWC3kNtR9AR1tncv5jwjrSshxPhvaJ06JUve1pVHTap3zHFQJ2pa39BaJrL7
         06zhPaO0ezvRvlWCAqvQOCE8zPrsIxzbSoHsrMm2lDmJh7qje/+xeSTouyo7oFvNpLt3
         yP6w==
X-Gm-Message-State: APjAAAWU+pq+XgSz2vkUYt2SoHDK37BrSackU6IDdW6fg0LWsnGJH6YJ
        M9KfsFsxkUTgyEUYzgJgMN98MTgZ
X-Google-Smtp-Source: APXvYqzW7PGiQgVlEMq6vc2V3xKC1NHGzz0lSphUf2h+tfqmxQKHYkYUOjpzlOM4YWOA28mkDv1gpA==
X-Received: by 2002:a17:906:27d3:: with SMTP id k19mr9949153ejc.290.1576768178319;
        Thu, 19 Dec 2019 07:09:38 -0800 (PST)
Received: from localhost.localdomain (x4db583fb.dyn.telefonica.de. [77.181.131.251])
        by smtp.gmail.com with ESMTPSA id b27sm546584ejg.40.2019.12.19.07.09.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Dec 2019 07:09:37 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 2/6] completion: clean up the __git_find_on_cmdline() helper function
Date:   Thu, 19 Dec 2019 16:09:17 +0100
Message-Id: <20191219150921.5889-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.1.982.ga4d4aba446
In-Reply-To: <20191219150921.5889-1-szeder.dev@gmail.com>
References: <20191017173501.3198-1-szeder.dev@gmail.com>
 <20191219150921.5889-1-szeder.dev@gmail.com>
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
2.24.1.982.ga4d4aba446

