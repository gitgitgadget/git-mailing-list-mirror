Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C44C120248
	for <e@80x24.org>; Mon,  1 Apr 2019 21:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfDAVxi (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 17:53:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34766 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfDAVxi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 17:53:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id p10so13990913wrq.1
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 14:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v8HsMoTpJ40120qWfjo2GURyQAfkWu9Tok//Qtr+H1g=;
        b=gYSho64ivRAVoahCrXFG5QH//8XGtNnpox2ilZ6vXe4viyUfTshaeebQIvYKHntyQp
         XXieI7F0uQ6q3/52P0gXeT7Pzdfk8ootR1PJjD6rI9j2BGiz7CDiVo6FLxiKEc7BntmN
         wWC9HkVc8Lc37pK9QJPU+aI/JqIERIZ2xukqLz/lanyeNW7AH9Y0RYF5A3FRJrmCwSJW
         2JTqywQJm4u/82NI5wr8bxW9Mvvjid1w5etR6bx5xYkWnv5DMvKy51D+nf9prxVNNiJA
         V/t/ILwHW1VLIWZP4A0qvwNOmg6LcVKEcxoceRT3GyrcROLPK7kPPJeSje3uyK81m5FM
         dw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v8HsMoTpJ40120qWfjo2GURyQAfkWu9Tok//Qtr+H1g=;
        b=E7CxY/OmK2/IU+wQWiPRttVydU23/v0uFR+143ixVHfQeJrUPSMz9r8ltz7Xn+LLnZ
         pDtAtRbQTEkH4bJy0PsWgYRSmJBCHTnxasw0t/oaER3YE05oYEzKLFBiRUHeMgU1A0vT
         nR2NCCCKWQ9JI3U5/ybxNJ1utYV9ROg0geOrByAJOfiwjH8S+1pqhqwRV1gLpbwJyGGW
         vxEs4at6eoVVW/9yqwPHXoidv+rwUzUlm09lAwA48BpDq18ERSH5tDtd/itLNsZSIv3t
         hCFjFMkHwD21EW+D6QCiiDE21DSNcV8P8Ml5vZxJqKh8WPVqW85Zv+N3KnbnN8j2PVfd
         nkSw==
X-Gm-Message-State: APjAAAWjP/S5HOWOHkJBycpgDkdRpe6on5TaP/qE207HVaKGIWUFCMYK
        CuRk/bB6OGoMoU+hhGcVW95jDO37vCg=
X-Google-Smtp-Source: APXvYqxtdHJnBfbJSufi1Mrb2hAkhIWtRZOrxcKb1mKkAb0/ZYMNrq1KQWbfkRy+rCO63plj9DLLYw==
X-Received: by 2002:adf:fd04:: with SMTP id e4mr44358570wrr.190.1554155616705;
        Mon, 01 Apr 2019 14:53:36 -0700 (PDT)
Received: from localhost.localdomain ([185.220.70.166])
        by smtp.gmail.com with ESMTPSA id v192sm17082227wme.24.2019.04.01.14.53.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 14:53:35 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v2 1/2] mailinfo: use starts_with() for clarity
Date:   Mon,  1 Apr 2019 23:53:33 +0200
Message-Id: <20190401215334.18678-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190331220104.31628-1-rybak.a.v@gmail.com>
References: <20190331220104.31628-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Existing checks using memcmp(3) never read past the end of the line,
because all substrings we are interested in are two characters long, and
the outer loop guarantees we have at least one character. So at most we
will look at the NUL.

However, this is too subtle and may lead to bugs in code which copies
this behavior without realizing substring length requirement.  So use
starts_with() instead, which will stop at NUL regardless of the length
of the prefix. Remove extra pair of parentheses while we are here.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---

On Mon, Apr 01, 2019 at 06:11:57 -0400, Jeff King wrote:
> I wonder if it's worth re-writing it like:

Turned Peff's suggestion into a patch.

 mailinfo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mailinfo.c b/mailinfo.c
index b395adbdf2..f4aaa89788 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -693,8 +693,8 @@ static int is_scissors_line(const char *line)
 			perforation++;
 			continue;
 		}
-		if ((!memcmp(c, ">8", 2) || !memcmp(c, "8<", 2) ||
-		     !memcmp(c, ">%", 2) || !memcmp(c, "%<", 2))) {
+		if (starts_with(c, ">8") || starts_with(c, "8<") ||
+		    starts_with(c, ">%") || starts_with(c, "%<")) {
 			in_perforation = 1;
 			perforation += 2;
 			scissors += 2;
-- 
2.21.0

