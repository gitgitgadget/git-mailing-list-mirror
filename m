Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AED201F597
	for <e@80x24.org>; Mon, 30 Jul 2018 09:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbeG3LEP (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 07:04:15 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54896 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbeG3LEO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 07:04:14 -0400
Received: by mail-it0-f65.google.com with SMTP id s7-v6so16304131itb.4
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 02:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yHqjAy7dpffX/lVlQbU+2WTBSqF0mUUtCDXzVyIYKdM=;
        b=rWJew5BrMlg8QskzRJAa+0f8qu9ZP5NlaRpVVHC6jKmSR3L8IENG7BsdxIcEbjG/Jg
         Ek4QrhhJqCeTfctNLZjkQoFSKR866Egv6l6w4Mgo1ddqVZGrjTAqFhLIqxWjoors6FxI
         yZZ1yFuWmbL/9CGMjqxRtP3czSODum9AkGSgimVyN/ICu1jYTpJzBG16IVJM84UEfB20
         ZYdyU9ecSt/bwfK2sVCEQwXPO2vo9h7OXSfA4Qtb2NyhOvFn06ABPGUIcM9Zitxxl0EC
         w2ygna/4qGpz/S7KY1Tm0w/zfimF6SLZQezuQ5bzPh4OQ+TrZeOgTz+2MkYsVpRNpq1K
         cMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=yHqjAy7dpffX/lVlQbU+2WTBSqF0mUUtCDXzVyIYKdM=;
        b=qBENFoy66U8PdIQHBwi8m/B/t73NGHzJW6n9727cJYt5c5yizR6xy9aDm526Vo5HAM
         Upr7dGzASwsXGUXyXn2QqeYxJSCAmex9WdxdLLutyDvT19BKdQpO+so1gN/McJLgKthd
         Cf+xVEJampl94D3aAXeF5SDl1eGTxK5SiyKk0s5Txv5QZ7YJuO8X560rypu3cihk5wVI
         dnk0tU3bJVmjg1ACtDssOwjKU4OczTL0hHkYJeasAadi46bZloJinnYsnjUpnQ476i8R
         vZty6ki8XX9B2XuMT5EjUjf9jF8vMIpBnoUULMDGfIPEr/8NBn9n6vmBhCpX11vRwP1h
         TwRQ==
X-Gm-Message-State: AOUpUlHQqiE+zzGgdcnV7twcfbMpTgSoKso6cW8GZIHTlQlflJ2UFXEv
        Ar2gRs0WtxzW3CkJSAKu1sqz7pr+
X-Google-Smtp-Source: AAOMgpedhEHejrI74o23k54JgVCj+gcN8vOsmEOc0GlEOG6EwCciZxI0tiKZ+IzOae84asNwvZ4YEQ==
X-Received: by 2002:a24:6c04:: with SMTP id w4-v6mr13372321itb.4.1532943007401;
        Mon, 30 Jul 2018 02:30:07 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id d10-v6sm3341105iob.4.2018.07.30.02.30.06
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 30 Jul 2018 02:30:06 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Akinori MUSHA <knu@iDaemons.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/2] sequencer: fix "rebase -i --root" corrupting author header
Date:   Mon, 30 Jul 2018 05:29:28 -0400
Message-Id: <20180730092929.71114-2-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad
In-Reply-To: <20180730092929.71114-1-sunshine@sunshineco.com>
References: <20180730092929.71114-1-sunshine@sunshineco.com>
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

(Note that the extra "0" in the timezone is a separate bug which will be
fixed subsequently.)

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
index 01616901bd..8509c89a26 100755
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
+	grep "^author ..* @[0-9][0-9]* [-+][0-9][0-9]*$" out
+'
+
 test_done
-- 
2.18.0.597.ga71716f1ad

