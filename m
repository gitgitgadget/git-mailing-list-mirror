Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCE681F597
	for <e@80x24.org>; Tue, 31 Jul 2018 07:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbeGaJNH (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 05:13:07 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34151 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbeGaJNG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 05:13:06 -0400
Received: by mail-io0-f195.google.com with SMTP id l7-v6so12146715ioj.1
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 00:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gsILwSqnaEdo9strncFAMsYuYsNMekq9gltDEPjmBIQ=;
        b=JBEM6S/Arv6Af5ec3khfuTv91WG6v3zXcEmnAQiLldLDp3ZRePV0YkyBeLKY+ENDUg
         P4asdT1IWN3TojyhPcnI9fg2topfpbnKS7YuOKPZZpH4PsmBUgwBkob1003An1WnsGez
         M8Urzec225T/7S90ChTIjImidhQBtOyYLISr8j5T8VleW/nXlOLC020A5IyIfMV1ACGJ
         5BFSJlz5tgGkkvs/Su/0kedqjzoIg32sf1wGMeyBp1ZKnqvSWhcOvL16bzZIZHlE1VJx
         BFFU/UwS30Jm9ed9XeERqhrqftIe/b729la/fwp0LrhoHUzrFv2NifrAxTl3/Sb+DY7s
         Ox+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=gsILwSqnaEdo9strncFAMsYuYsNMekq9gltDEPjmBIQ=;
        b=egVTW677rW3t7VmRvi1bSncRZeWZaQ83kczbKxRhBh3NcI45exvZJUMh2t32ct109M
         AnIXeOdSczxt94hmVmmD1LZwfwvwzYYz0eSphiBJxkVfT0fiz3MZzP0yhaSPEJVnfqU7
         iLOW/zcwhRM1/Uf1WnY8s1ulXqwc+6BLBLX+AILzZSorQo81Ue9LtrVcUyoWi4Erlwds
         icx9e/i6ia3XiJ1oeO3+e99C9n9wEwV4lF2Horjesgt0bGrTFLE5yUBESl/8a8OveW63
         FO0VtEX1LoA2eiYv63cAWWVYc1lUJ9/cvc/15xyFe+OlTy6t2I7N/2bxMzuzykh2fE0W
         6x7w==
X-Gm-Message-State: AOUpUlGHRqaXgdSWc2Rrp0oFc19taI5DqwYk8cj1bJ2q67hrDXeEN5Wy
        THjtaPtl+jF83VQqFZw1M869rHan
X-Google-Smtp-Source: AAOMgpcG3pGm2YrqZ7L28bvM2f2NJJ69cyieAB8hmedwb8nkK5miJwVk6ejE7ja6z8P/y9BVAap6MQ==
X-Received: by 2002:a6b:fc14:: with SMTP id r20-v6mr8033053ioh.270.1533022446773;
        Tue, 31 Jul 2018 00:34:06 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id m1-v6sm2371058iok.81.2018.07.31.00.34.05
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 31 Jul 2018 00:34:06 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Akinori MUSHA <knu@idaemons.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/4] sequencer: fix "rebase -i --root" corrupting author header timezone
Date:   Tue, 31 Jul 2018 03:33:29 -0400
Message-Id: <20180731073331.40007-3-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad
In-Reply-To: <20180731073331.40007-1-sunshine@sunshineco.com>
References: <20180731073331.40007-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When "git rebase -i --root" creates a new root commit, it corrupts the
"author" header's timezone by repeating the last digit:

    author A U Thor <author@example.com> @1112912773 -07000

This is due to two bugs.

First, write_author_script() neglects to add the closing quote to the
value of GIT_AUTHOR_DATE when generating "rebase-merge/author-script".

Second, although sq_dequote() correctly diagnoses the missing closing
quote, read_author_ident() ignores sq_dequote()'s return value and
blindly uses the result of the aborted dequote.

sq_dequote() performs dequoting in-place by removing quoting and
shifting content downward. When it detects misquoting (lack of closing
quote, in this case), it gives up and returns an error without inserting
a NUL-terminator at the end of the shifted content, which explains the
duplicated last digit in the timezone.

(Note that the "@" preceding the timestamp is a separate bug which
will be fixed subsequently.)

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 sequencer.c                   | 7 ++++++-
 t/t3404-rebase-interactive.sh | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 78864d9072..1008f6d71a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -654,6 +654,7 @@ static int write_author_script(const char *message)
 			strbuf_addch(&buf, *(message++));
 		else
 			strbuf_addf(&buf, "'\\\\%c'", *(message++));
+	strbuf_addch(&buf, '\'');
 	res = write_message(buf.buf, buf.len, rebase_path_author_script(), 1);
 	strbuf_release(&buf);
 	return res;
@@ -724,7 +725,11 @@ static const char *read_author_ident(struct strbuf *buf)
 
 		eol = strchrnul(in, '\n');
 		*eol = '\0';
-		sq_dequote(in);
+		if (!sq_dequote(in)) {
+			warning(_("bad quoting on %s value in '%s'"),
+				keys[i], rebase_path_author_script());
+			return NULL;
+		}
 		len = strlen(in);
 
 		if (i > 0) /* separate values by spaces */
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index d6e9b52740..fd3a18154e 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1420,7 +1420,7 @@ test_expect_success 'valid author header after --root swap' '
 	set_fake_editor &&
 	FAKE_LINES="2 1" git rebase -i --root &&
 	git cat-file commit HEAD^ >out &&
-	grep "^author ..*> @[0-9][0-9]* [-+][0-9][0-9]*$" out
+	grep "^author ..*> @[0-9][0-9]* [-+][0-9][0-9][0-9][0-9]$" out
 '
 
 test_done
-- 
2.18.0.267.gbc8be36ecb

