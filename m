Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C44E51F597
	for <e@80x24.org>; Tue, 31 Jul 2018 07:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbeGaJNI (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 05:13:08 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:45459 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbeGaJNH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 05:13:07 -0400
Received: by mail-io0-f196.google.com with SMTP id k16-v6so12126343iom.12
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 00:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5lBr8rW09JXCSuTCWSIEfDnB5LEjBJkbU21dJYHFYzk=;
        b=QmV/waAsbxKW2GTMQMsovPQpALt3UndznwZRd2j6aLD2tBLlQ6/l4Hj4f1Rh9eK+ao
         zaw5al17aQy8pN4Q6kQr2+KRH9X1c7Z5vctkIgBeE+Fwi0RGcpXi3kH11gVl3U9cXIZk
         Suq4zaOP3umJkzAihfnuEV5e+yFVYqgBVpAwOlOy276xhiqvgNGbQm9Z2Y3RUl/rac57
         /62KpsOGvFWAPpfj8ahiylLASmfcYWy3nwrWJ2Bw3qbiPpL1QHee8k+t8p5Z6lwB7QcA
         xD56jdeythqt63wxHwvuH9i9LNWRR6hEmq9+1wLTHypuX1RtS3qUYHJbq6F+yNFnRwAZ
         Q+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=5lBr8rW09JXCSuTCWSIEfDnB5LEjBJkbU21dJYHFYzk=;
        b=SmAiUMJlOimllvT+O/UgQbFXV2eenSc31OAtKRVrQtoB5BPoc9QKU4MbdgkRzx8APW
         Uq3CPYatLYFyBatZI7Gp5lgJvdVRrCSlEUu71ppIKlVTwqbm3dcPgjfFMc8ov+LLN5U0
         +g7fnqUuwamjlnyetdVjTK5HKO+SkMK8ziE8eYtp8ohj4ASR0g97G4D0yjY4x5zd5hpF
         D2G6N50JlbrEPymFedt9KlmvSYsR+fWOdMSswYSg2s1IEN/Af1nkypKuXvzTPCHtRG5T
         7CC6JJjo+BBi6r38m1yOtr3PlI3jyz7OmdlHx9t0bhD+MeYVNatheVhoWIKnMa3I2FZb
         e3ew==
X-Gm-Message-State: AOUpUlE0QuzwGTe5WCEa++i30fDw13LTmXyvs+LIOwGB+rIeOyAGVwJp
        PYLkQ8zN+kBFidH58z9xy/LybKG/
X-Google-Smtp-Source: AAOMgpegQj8EY4pL706m/uvJR4xZ26X/+85ktfm6zhGwL0YSNUQXrS6gaN/ZzKwV7lznTZY7HglJNQ==
X-Received: by 2002:a6b:8851:: with SMTP id k78-v6mr17128258iod.290.1533022447648;
        Tue, 31 Jul 2018 00:34:07 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id m1-v6sm2371058iok.81.2018.07.31.00.34.06
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 31 Jul 2018 00:34:07 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Akinori MUSHA <knu@idaemons.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 3/4] sequencer: fix "rebase -i --root" corrupting author header timestamp
Date:   Tue, 31 Jul 2018 03:33:30 -0400
Message-Id: <20180731073331.40007-4-sunshine@sunshineco.com>
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
"author" header's timestamp by prepending a "@":

    author A U Thor <author@example.com> @1112912773 -0700

The commit parser is very strict about the format of the "author"
header, and does not allow a "@" in that position.

The "@" comes from GIT_AUTHOR_DATE in "rebase-merge/author-script",
signifying a Unix epoch-based timestamp, however, read_author_ident()
incorrectly allows it to slip into the commit's "author" header, thus
corrupting it.

One possible fix would be simply to filter out the "@" when constructing
the "author" header timestamp, however, a more correct fix is to parse
the GIT_AUTHOR_DATE date (via parse_date()) and format the parsed result
into the "author" header. Since "rebase-merge/author-script" may be
edited by the user, this approach has the extra benefit of catching
other potential timestamp corruption due to hand-editing.

We can do better than calling parse_date() ourselves and constructing
the "author" header manually, however, by instead taking advantage of
fmt_ident() which does this work for us.

The benefits of using fmt_ident() are twofold. First, it simplifies the
logic considerably by allowing us to avoid the complexity of building
the "author" header in parallel with and in the same buffer from which
"rebase-merge/author-script" is being parsed. Instead, fmt_ident() is
invoked to compose the header after parsing is complete.

Second, fmt_ident() is careful to prevent "crud" from polluting the
composed ident. As with validating GIT_AUTHOR_DATE, this "crud"
avoidance prevents other (possibly hand-edited) bogus author information
from "rebase-merge/author-script" from corrupting the commit object.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 sequencer.c                   | 23 +++++++++--------------
 t/t3404-rebase-interactive.sh |  2 +-
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 1008f6d71a..15a66a334c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -709,14 +709,16 @@ static const char *read_author_ident(struct strbuf *buf)
 	const char *keys[] = {
 		"GIT_AUTHOR_NAME=", "GIT_AUTHOR_EMAIL=", "GIT_AUTHOR_DATE="
 	};
-	char *in, *out, *eol;
-	int i = 0, len;
+	struct strbuf out = STRBUF_INIT;
+	char *in, *eol;
+	const char *val[3];
+	int i = 0;
 
 	if (strbuf_read_file(buf, rebase_path_author_script(), 256) <= 0)
 		return NULL;
 
 	/* dequote values and construct ident line in-place */
-	for (in = out = buf->buf; i < 3 && in - buf->buf < buf->len; i++) {
+	for (in = buf->buf; i < 3 && in - buf->buf < buf->len; i++) {
 		if (!skip_prefix(in, keys[i], (const char **)&in)) {
 			warning("could not parse '%s' (looking for '%s'",
 				rebase_path_author_script(), keys[i]);
@@ -730,16 +732,7 @@ static const char *read_author_ident(struct strbuf *buf)
 				keys[i], rebase_path_author_script());
 			return NULL;
 		}
-		len = strlen(in);
-
-		if (i > 0) /* separate values by spaces */
-			*(out++) = ' ';
-		if (i == 1) /* email needs to be surrounded by <...> */
-			*(out++) = '<';
-		memmove(out, in, len);
-		out += len;
-		if (i == 1) /* email needs to be surrounded by <...> */
-			*(out++) = '>';
+		val[i] = in;
 		in = eol + 1;
 	}
 
@@ -749,7 +742,9 @@ static const char *read_author_ident(struct strbuf *buf)
 		return NULL;
 	}
 
-	strbuf_setlen(buf, out - buf->buf);
+	strbuf_addstr(&out, fmt_ident(val[0], val[1], val[2], 0));
+	strbuf_swap(buf, &out);
+	strbuf_release(&out);
 	return buf->buf;
 }
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index fd3a18154e..d340018781 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1420,7 +1420,7 @@ test_expect_success 'valid author header after --root swap' '
 	set_fake_editor &&
 	FAKE_LINES="2 1" git rebase -i --root &&
 	git cat-file commit HEAD^ >out &&
-	grep "^author ..*> @[0-9][0-9]* [-+][0-9][0-9][0-9][0-9]$" out
+	grep "^author ..*> [0-9][0-9]* [-+][0-9][0-9][0-9][0-9]$" out
 '
 
 test_done
-- 
2.18.0.267.gbc8be36ecb

