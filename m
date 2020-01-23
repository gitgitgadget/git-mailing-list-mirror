Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EF4C33CAF
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 12:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 570B124673
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 12:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWip/I2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgAWM2Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 07:28:24 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46043 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgAWM2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 07:28:24 -0500
Received: by mail-wr1-f67.google.com with SMTP id j42so2824245wrj.12
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 04:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Aa3LmM7G62Jt+wArrDG0N9AHHVYhry75OsxLe6GzWf0=;
        b=PWip/I2cOKMhCB5O0MKFrybxJjF83VN5cJ3sXIGmWZQmQx/S1mK8mCf7z1ZzCB+WZT
         lPAVl00PXqSnZK1Uez/oei+oJQ66dggkO+IdKoHvG8wAOKlVODaxPMseRvuuslaMTd5W
         IgQ419Qct5YdyaGPzdy4H6OrFL/0rQ8f3DtwE3DAoQKuQXf1K+DxzSMAKMCL8TfsZFkH
         l2QdJMAOiMgIMC/Vn3Y7hmxXhAkE8tLV/XoBPsmGgF6IIvvAGZUmL5sMADxcEMR19cKl
         GDkTGqLt2HIQyYhJ0kq9u7njEfRcpG5cWqUlC26NmWATrTfK+PHc4rtcKV7Qj3m3ymTF
         zZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Aa3LmM7G62Jt+wArrDG0N9AHHVYhry75OsxLe6GzWf0=;
        b=uRZ0l33sgL6v1EkM5gjivzRQu9heSUAi46ora+4Su5XGqb5vgcmWR/ssQb3kZ0CH+D
         zJoYBJ8RKdUx0oW/T6utSQ2oHLxBnGrjlZOu32/UBl57G9D21oSNILiB5fF/6FbuYz30
         WagIWLb9qqzeaO5AYUBw9GbhI7OhjZ4wy5Mbbcj0KT30uqb+qHs1UGvhfYRBF+RgcCPw
         yH9ac8/GSb9BputEtZax8ULHlLGFeO88H+iJmtixThmjNUGZ+5jxAQQmMJzcsYhxTKrh
         kU4JYligyB2OHuohtONE/kLRiOnBnOepmLGd+yZYIIOFeqKn4S7xW7+oBswIg+G9Ki0c
         TPZQ==
X-Gm-Message-State: APjAAAVGcftIStKdXhrxXajrrp6xAFIgKxWZIfvVJTcDx40199W8tr3O
        oKtjyVm2uewQzTOe6BnqFMbLtUTf
X-Google-Smtp-Source: APXvYqzZ2Xn120Xegmfi5HaFjLI67mYJnuKJNgufrkbjoVxtxfZ4EaOlBme14kdwTFylMkcWYFJkQA==
X-Received: by 2002:adf:ec0d:: with SMTP id x13mr17315003wrn.400.1579782501679;
        Thu, 23 Jan 2020 04:28:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p5sm2753297wrt.79.2020.01.23.04.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 04:28:21 -0800 (PST)
Message-Id: <6f5c7b032524ed2510286caa0623fdbfa2b02eb3.1579782500.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.529.v3.git.1579782499.gitgitgadget@gmail.com>
References: <pull.529.v2.git.1579304283.gitgitgadget@gmail.com>
        <pull.529.v3.git.1579782499.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Jan 2020 12:28:17 +0000
Subject: [PATCH v3 1/3] parse_insn_line(): improve error message when parsing
 failed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alban Gruin <alban.gruin@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In the case that a `get_oid()` call failed, we showed some rather bogus
part of the line instead of the precise string we sent to said function.
That makes it rather hard for users to understand what is going wrong,
so let's fix that.

While at it, return a negative value from `parse_insn_line()` in case of
an error, as per our convention. This function's only caller,
`todo_list_parse_insn_buffer()`, cares only whether that return value is
non-zero or not, i.e. does not need to be changed.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index b9dbf1adb0..7c30dad59c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2118,6 +2118,8 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 	saved = *end_of_object_name;
 	*end_of_object_name = '\0';
 	status = get_oid(bol, &commit_oid);
+	if (status < 0)
+		error(_("could not parse '%s'"), bol); /* return later */
 	*end_of_object_name = saved;
 
 	bol = end_of_object_name + strspn(end_of_object_name, " \t");
@@ -2125,11 +2127,10 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 	item->arg_len = (int)(eol - bol);
 
 	if (status < 0)
-		return error(_("could not parse '%.*s'"),
-			     (int)(end_of_object_name - bol), bol);
+		return status;
 
 	item->commit = lookup_commit_reference(r, &commit_oid);
-	return !item->commit;
+	return item->commit ? 0 : -1;
 }
 
 int sequencer_get_last_command(struct repository *r, enum replay_action *action)
-- 
gitgitgadget

