Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A9911F597
	for <e@80x24.org>; Mon, 30 Jul 2018 09:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbeG3LEQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 07:04:16 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:54900 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbeG3LEP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 07:04:15 -0400
Received: by mail-it0-f68.google.com with SMTP id s7-v6so16304194itb.4
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 02:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tt5E6dwG/F7acsIkal0vP1S7VzERb1DRdqYzn1DWheE=;
        b=JW5zBbYdo4QolH0tHNtUGJXwHtHQjmZyR12TD9tKRpUaXOleDnziEdQlDVtL9Fl38h
         yK4zweoelRiBHqg9s+7fcmp+oFNIFopxp0hgUc33YwumsMhZPCETnEv5gcWcqstfX+6Z
         K3ylTGaDG3DDyQXLOUK4KBWPCTML7p+3TzFMDUqPsmeUXoWrXlUldJE+vRhDu3gUhoua
         x7exfAwjBVj4KBlDiIUPXY+aihXDjQdiETGvdmSuJ9A8OnzONFjhsh8BVv0y58WAQrw5
         nTdK2UYxLZmj6MWeEzfSjnqICsd0p14mxlVq54SBDlY6Dz9YjAi2UQn6aklbWmJkHsey
         ZsRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Tt5E6dwG/F7acsIkal0vP1S7VzERb1DRdqYzn1DWheE=;
        b=SOJtgkSWBn9QcxjhbRI/gbPqtrskG14yFyv2vNN0VONNRG6hghMVU6lOpw+P5OYP3f
         4T2zgV2rpf6/dLl/zmcGDooNzXNuj7iXteQ+MHsmFx6pwHzHQHjVZPk3DdtgjG09Pn3w
         tUjYHwfNJaW5a525emcUINUy0WaQ0kfr1s43qHvazf51HPhiB14xp4VZ9hWQHyFzeUYt
         g60xKRIVdfR7oTpZ1xCHz2dvWNZ/1itxnC6CE+U9hkJp6SxoTfgcCqDjFyeIW5sWyrb5
         FfWpTuE7GSNVWJNrtjY6DbCpRAxWGWkiRG9yppREzREZ82179hd220BEvFt9GZ8HSlPo
         BBxA==
X-Gm-Message-State: AOUpUlFUFcUwqY1BopItOoE7g8aN8Re5IaJPbDDWacHiJnxUzWp54uHc
        76I7DuoCHr9bl8GQKIJo+xfDCSlq
X-Google-Smtp-Source: AAOMgpc2w3bwIXpTq6yj5ekVsEW4z+kICORrFHcOV9IScPgTELhh3Hpdbv1xgXGxdrGEKEa3z6dMhw==
X-Received: by 2002:a24:ac1d:: with SMTP id s29-v6mr13511640ite.3.1532943008385;
        Mon, 30 Jul 2018 02:30:08 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id d10-v6sm3341105iob.4.2018.07.30.02.30.07
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 30 Jul 2018 02:30:07 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Akinori MUSHA <knu@iDaemons.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/2] sequencer: fix "rebase -i --root" corrupting author header timezone
Date:   Mon, 30 Jul 2018 05:29:29 -0400
Message-Id: <20180730092929.71114-3-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad
In-Reply-To: <20180730092929.71114-1-sunshine@sunshineco.com>
References: <20180730092929.71114-1-sunshine@sunshineco.com>
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
index 8509c89a26..37796bb4c1 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1420,7 +1420,7 @@ test_expect_success 'valid author header after --root swap' '
 	set_fake_editor &&
 	FAKE_LINES="2 1" git rebase -i --root &&
 	git cat-file commit HEAD^ >out &&
-	grep "^author ..* @[0-9][0-9]* [-+][0-9][0-9]*$" out
+	grep "^author ..* @[0-9][0-9]* [-+][0-9][0-9][0-9][0-9]$" out
 '
 
 test_done
-- 
2.18.0.597.ga71716f1ad

