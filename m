Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 160A61F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 05:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbeGMGGB (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 02:06:01 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:44610 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbeGMGGB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 02:06:01 -0400
Received: by mail-io0-f194.google.com with SMTP id q19-v6so30331748ioh.11
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 22:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NVEXAzo0r28pb+7EQTynVL34F52ATT3sqlK6nCN0VlI=;
        b=asMLhlXdKy4tylj6QxHGr4Tx5HmNBadlZZmzpGvBE5C+DJkbk7qjIBn4P/tZys34yR
         DkVa5ieQgNKjOlwewG0uwg8i1lYzjopkTjs15yTY0UMcGrAQ/SfoACMZZjBmZyh62MEV
         5v3GkJjIBf/mq+dR06n1hmcZiVLfTxErTMOsz6ovqeGoBsYkJZMTj6QdcV0oV7IcdfmR
         MG1ak8ZEdP27MtsaSUkwh68YCrdiopViqudgEOKhg0HIPAlCVwfUf/cPqoK4rxNc8ZL0
         Eiw4Dp8rpE51SkXMp1lJn8BKyQSDAbIaOYTVTtEiP6qbjEjEvE3ATlAWt61cDG5amJ2d
         cbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=NVEXAzo0r28pb+7EQTynVL34F52ATT3sqlK6nCN0VlI=;
        b=BNfh6GzpRMZKNg4BG7NkRnlGAL1rULs6cERowTScflso9Ec5NPs8GFXjcUOc5/mJHS
         WmKD3QHo9c8kSKqrZcA5Yert63XeR9caf134yOFgDscTigtkrdxQ8BjkjcyODvsmiiH9
         ISWPH6vQg+JZcvhB+dFz0Bv/ajdwmbRDcr3PzL/8T93tFidDPt/2z2PdXLt5A897cKmc
         nwHPZavFc0uI8WgB082U8G2zwRmyu2bO6GFMh6BPbWDwn6KqyeRs5+7c6+QHSYT/UBU2
         MJO6V2vZPQ5SGbJQdmikwK/FasnJCstuahbZdaYMVhwOlmSRWKdSUldMVvhQPzljnlCr
         3CCA==
X-Gm-Message-State: APt69E3i8VEFWe/+ut8y73JjfxsMCkVUZLqEVpmzJ5kKtRP2ao3pJSFy
        RyZtVlCy9cJti1zHBfuo+VYk+g==
X-Google-Smtp-Source: AAOMgpe3QpKKc3Mn+jO3tEA0NEhHXjPznZYsvq4CbPszyn6Oqv9C0eVCr7EQgnE9R7Hlsvwq3l44ug==
X-Received: by 2002:a5e:9910:: with SMTP id t16-v6mr31090118ioj.113.1531461178824;
        Thu, 12 Jul 2018 22:52:58 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id m10-v6sm3138036ioj.22.2018.07.12.22.52.58
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 12 Jul 2018 22:52:58 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/4] t/check-non-portable-shell: stop being so polite
Date:   Fri, 13 Jul 2018 01:52:03 -0400
Message-Id: <20180713055205.32351-3-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e
In-Reply-To: <20180713055205.32351-1-sunshine@sunshineco.com>
References: <20180713055205.32351-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Error messages emitted by this linting script are long and noisy,
consisting of several sections:

    <test-script>:<line#>: error: <explanation>: <failed-shell-text>

Many problem explanations ask the reader to "please" use a suggested
alternative, however, such politeness is unnecessary and just adds to
the noise and length of the line, so drop "please" to make the message a
bit more concise.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/check-non-portable-shell.pl | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
index e07f028437..11028578ff 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -17,12 +17,12 @@ sub err {
 while (<>) {
 	chomp;
 	/\bsed\s+-i/ and err 'sed -i is not portable';
-	/\becho\s+-[neE]/ and err 'echo with option is not portable (please use printf)';
+	/\becho\s+-[neE]/ and err 'echo with option is not portable (use printf)';
 	/^\s*declare\s+/ and err 'arrays/declare not portable';
-	/^\s*[^#]\s*which\s/ and err 'which is not portable (please use type)';
-	/\btest\s+[^=]*==/ and err '"test a == b" is not portable (please use =)';
-	/\bwc -l.*"\s*=/ and err '`"$(wc -l)"` is not portable (please use test_line_count)';
-	/\bexport\s+[A-Za-z0-9_]*=/ and err '"export FOO=bar" is not portable (please use FOO=bar && export FOO)';
+	/^\s*[^#]\s*which\s/ and err 'which is not portable (use type)';
+	/\btest\s+[^=]*==/ and err '"test a == b" is not portable (use =)';
+	/\bwc -l.*"\s*=/ and err '`"$(wc -l)"` is not portable (use test_line_count)';
+	/\bexport\s+[A-Za-z0-9_]*=/ and err '"export FOO=bar" is not portable (use FOO=bar && export FOO)';
 	# this resets our $. for each file
 	close ARGV if eof;
 }
-- 
2.18.0.233.g985f88cf7e

