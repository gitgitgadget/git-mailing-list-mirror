Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A1151F597
	for <e@80x24.org>; Tue, 31 Jul 2018 07:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbeGaJNF (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 05:13:05 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:35675 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbeGaJNF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 05:13:05 -0400
Received: by mail-io0-f195.google.com with SMTP id w11-v6so12145144iob.2
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 00:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KAcO91JGGjOBJOFpOrrkBH8QrSZfo04irO6/sEcyrSQ=;
        b=BAdGKgh/8oMHKi8MHAlFZf1T95R3hIFxe9WmElBwrDPU29g2kBAWeGuw+DGS0fagM5
         1YmC6TQKFV8ZAHCE+SXznXNV/6MWJqQLKbro28lvFfqIJZfSA0hkhviaaxAYQl8r9VO+
         dEgtCxUXXpSjRcEB6jxsjIrqgjoF7Is2KBmUkWD7ODp7wTkIV4DfPq/ExVHCNrf9hrUF
         6M6iAEX2y1n4qFpLGRhNGuMk9L2PxjofY746aEw7aCZ/15HXcQUm8ub91KKggyjz28VN
         vKGhX+92Sdd9ETKF/DGGOb7yjwkapQbsSJB3bRSF26lfKtX3V4f8BUjadlZEvDxYJGj6
         TkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=KAcO91JGGjOBJOFpOrrkBH8QrSZfo04irO6/sEcyrSQ=;
        b=n8l2A6ScmlgqqUR60TP7ef+6LzDL1gIUCuC1/lFrbfdeLcKzoSlVWuQg6tZDecrf7g
         XPVrWi8XE9t8imYwHimP6CZHIac0Y4Iv0viIZb/I4KlkaJzR/U42Nuf1Xj2+3A8evqSW
         tOQuJHeVgeVwVpiwCdLkM/zcMQ60srZQWlta9QdRLJ8dLZXoX0pZCzZAF74XJ4QqaDRq
         A+U+yAwXzkh4Nrxd+AsMnbCXR2YeMY+tAGYH+fgVQIcKHPg0NV8uqFF7WleoXthqf31Z
         laVnYyQ733QsiwvxzEgtghVzpzTCiHCjyahRkHLPTArk9FsQtJR9Oo+q/VC8krS1oNGp
         s2Yw==
X-Gm-Message-State: AOUpUlG31spH6KnDoxPRlVKlh6PpKMKhRjIDrRT1LQL7TPhvFG9/vBon
        o2zgoxinPwRxkWS8tGWs1if3u8UC
X-Google-Smtp-Source: AAOMgpfifnuNMAuNmK5lUgqO98H8JENsFaWe1JK6Dl1bJjxO9NvBCcOw0dXcT6UHkDcqSidcMJeZXQ==
X-Received: by 2002:a6b:9c09:: with SMTP id f9-v6mr16311070ioe.179.1533022445721;
        Tue, 31 Jul 2018 00:34:05 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id m1-v6sm2371058iok.81.2018.07.31.00.34.04
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 31 Jul 2018 00:34:05 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Akinori MUSHA <knu@idaemons.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/4] sequencer: fix "rebase -i --root" corrupting author header
Date:   Tue, 31 Jul 2018 03:33:28 -0400
Message-Id: <20180731073331.40007-2-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad
In-Reply-To: <20180731073331.40007-1-sunshine@sunshineco.com>
References: <20180731073331.40007-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When "git rebase -i --root" creates a new root commit (say, by swapping
in a different commit for the root), it corrupts the commit's "author"
header with trailing garbage:

    author A U Thor <author@example.com> @1112912773 -07000or@example.com

This is a result of read_author_ident() neglecting to NUL-terminate the
buffer into which it composes the "author" header.

(Note that the "@" preceding the timestamp and the extra "0" in the
timezone are separate bugs which will be fixed subsequently.)

Security considerations: Construction of the "author" header by
read_author_ident() happens in-place and in parallel with parsing the
content of "rebase-merge/author-script" which occupies the same buffer.
This is possible because the constructed "author" header is always
smaller than the content of "rebase-merge/author-script". Despite
neglecting to NUL-terminate the constructed "author" header, memory is
never accessed (either by read_author_ident() or its caller) beyond the
allocated buffer since a NUL-terminator is present at the end of the
loaded "rebase-merge/author-script" content, and additional NUL's are
inserted as part of the parsing process.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c                   |  2 +-
 t/t3404-rebase-interactive.sh | 10 +++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 16c1411054..78864d9072 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -744,7 +744,7 @@ static const char *read_author_ident(struct strbuf *buf)
 		return NULL;
 	}
 
-	buf->len = out - buf->buf;
+	strbuf_setlen(buf, out - buf->buf);
 	return buf->buf;
 }
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 01616901bd..d6e9b52740 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1238,7 +1238,7 @@ rebase_setup_and_clean () {
 		test_might_fail git branch -D $1 &&
 		test_might_fail git rebase --abort
 	" &&
-	git checkout -b $1 master
+	git checkout -b $1 ${2:-master}
 }
 
 test_expect_success 'drop' '
@@ -1415,4 +1415,12 @@ test_expect_success 'rebase -i --gpg-sign=<key-id> overrides commit.gpgSign' '
 	test_i18ngrep "$SQ-S\"S I Gner\"$SQ" err
 '
 
+test_expect_success 'valid author header after --root swap' '
+	rebase_setup_and_clean author-header no-conflict-branch &&
+	set_fake_editor &&
+	FAKE_LINES="2 1" git rebase -i --root &&
+	git cat-file commit HEAD^ >out &&
+	grep "^author ..*> @[0-9][0-9]* [-+][0-9][0-9]*$" out
+'
+
 test_done
-- 
2.18.0.267.gbc8be36ecb

