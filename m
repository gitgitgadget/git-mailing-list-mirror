Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB80EE020C
	for <git@archiver.kernel.org>; Tue, 26 Sep 2023 06:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbjIZGXG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Sep 2023 02:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbjIZGXE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2023 02:23:04 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E49E9
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 23:22:57 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-503065c4b25so12789668e87.1
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 23:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695709376; x=1696314176; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWIlzatUj0yB3Mm8UszHb+wk6g8QnOKK3XsDQqGKZnc=;
        b=keYXD4HjUMg0DhAi+ab3z8te/r4yS7+BlYIYOhf168uVwG0FOXpNTzZL3HwMKuAyYS
         jQ6qJ00W5DiB3/2vQdj/SNTeKukTjdwt1jq2KVGov1mfIFl/nS0V36fXz5hKfLicXhNM
         QlDDhTULJ65qQrHYsxMpoBOBniXTxZ2ayh2nBQ86J7/YE+Ds0/WN90VyejfP2/ep10Qe
         7vrV+dyd+lKV1b8KxSq/PIFn3WnVj148KiYpoQg8qlWu9GrwMNvXd9t18eK22sfJ3ODX
         q+guGEgsDsfoHkN0L3sIkN8zorkCc0J4DnbTnAnSfuvqxcAGY3M1hIEgdCoWbSJIu1QE
         Z6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695709376; x=1696314176;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zWIlzatUj0yB3Mm8UszHb+wk6g8QnOKK3XsDQqGKZnc=;
        b=F2yBSbQbhBhvip0s6zUoXGI6YlyolhgeGlYRp/HzvQSEtEwACyHYER1qwa363okCrd
         WJrh/lGhdw2uZS/8gm9pwRo+vzBAhsNn1Uj3a7sN/pBrqTcRfenT0kchsokKy+D/NsjQ
         Ia2nMe2rNSZ/qEJGKZqVDJkVgPKE9+nNfFSuGIvJZP3KR7zgBRZX82VD7K7gZpzPmaw2
         5hlIpL5hPi0VazX/3nRcz3mwUOxZBp9NqwNUQUruqmVL8ATHp3/zRvrvCr1s2Aw1IaAO
         qCS28DIyMlxuwRSCF6+OHrSaATQ1B4kAUx5y5nLGoOEfRXRMtn5NB1YaksMeEQd9+dq2
         Ggyw==
X-Gm-Message-State: AOJu0YztndZj7eDJB1VTa+JsO3HaqhkV2TfNUxhkpwY/owY2J9H7R/lz
        7SFChlMXw7d8MZ4Axs7NvY5uaQqERqQ=
X-Google-Smtp-Source: AGHT+IH/Fjxbljh1pcIDIEj8mGlTLNvY7L2hQPwTh7pyaNFktzThzC5VadqqAfqhfwBe2CTm+h+thA==
X-Received: by 2002:a05:6512:33cd:b0:4ff:a8c6:d1aa with SMTP id d13-20020a05651233cd00b004ffa8c6d1aamr8606588lfg.48.1695709375724;
        Mon, 25 Sep 2023 23:22:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f11-20020ac2532b000000b005007fc9ccd0sm2075655lfh.113.2023.09.25.23.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 23:22:55 -0700 (PDT)
Message-ID: <4ce5cf77005eb8c6da243777b3c29103add7ddbd.1695709372.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1563.v4.git.1695709372.gitgitgadget@gmail.com>
References: <pull.1563.v3.git.1695412245.gitgitgadget@gmail.com>
        <pull.1563.v4.git.1695709372.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Sep 2023 06:22:49 +0000
Subject: [PATCH v4 1/4] commit: ignore_non_trailer computes number of bytes to
 ignore
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Glen Choo <glencbz@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Linus Arver <linusa@google.com>,
        Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

ignore_non_trailer() returns the _number of bytes_ that should be
ignored from the end of the log message. It does not by itself "ignore"
anything.

Rename this function to remove the leading "ignore" verb, to sound more
like a quantity than an action.

Signed-off-by: Linus Arver <linusa@google.com>
---
 builtin/commit.c | 2 +-
 builtin/merge.c  | 2 +-
 commit.c         | 2 +-
 commit.h         | 4 ++--
 trailer.c        | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 7da5f924484..d1785d32db1 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -900,7 +900,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		strbuf_stripspace(&sb, '\0');
 
 	if (signoff)
-		append_signoff(&sb, ignore_non_trailer(sb.buf, sb.len), 0);
+		append_signoff(&sb, ignored_log_message_bytes(sb.buf, sb.len), 0);
 
 	if (fwrite(sb.buf, 1, sb.len, s->fp) < sb.len)
 		die_errno(_("could not write commit template"));
diff --git a/builtin/merge.c b/builtin/merge.c
index 545da0c8a11..c654a29fe85 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -870,7 +870,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 				_(no_scissors_editor_comment), comment_line_char);
 	}
 	if (signoff)
-		append_signoff(&msg, ignore_non_trailer(msg.buf, msg.len), 0);
+		append_signoff(&msg, ignored_log_message_bytes(msg.buf, msg.len), 0);
 	write_merge_heads(remoteheads);
 	write_file_buf(git_path_merge_msg(the_repository), msg.buf, msg.len);
 	if (run_commit_hook(0 < option_edit, get_index_file(), NULL,
diff --git a/commit.c b/commit.c
index b3223478bc2..4440fbabb83 100644
--- a/commit.c
+++ b/commit.c
@@ -1769,7 +1769,7 @@ const char *find_commit_header(const char *msg, const char *key, size_t *out_len
  * Returns the number of bytes from the tail to ignore, to be fed as
  * the second parameter to append_signoff().
  */
-size_t ignore_non_trailer(const char *buf, size_t len)
+size_t ignored_log_message_bytes(const char *buf, size_t len)
 {
 	size_t boc = 0;
 	size_t bol = 0;
diff --git a/commit.h b/commit.h
index 28928833c54..1cc872f225f 100644
--- a/commit.h
+++ b/commit.h
@@ -294,8 +294,8 @@ const char *find_header_mem(const char *msg, size_t len,
 const char *find_commit_header(const char *msg, const char *key,
 			       size_t *out_len);
 
-/* Find the end of the log message, the right place for a new trailer. */
-size_t ignore_non_trailer(const char *buf, size_t len);
+/* Find the number of bytes to ignore from the end of a log message. */
+size_t ignored_log_message_bytes(const char *buf, size_t len);
 
 typedef int (*each_mergetag_fn)(struct commit *commit, struct commit_extra_header *extra,
 				void *cb_data);
diff --git a/trailer.c b/trailer.c
index b6de5d9cb2d..3c54b38a85a 100644
--- a/trailer.c
+++ b/trailer.c
@@ -928,7 +928,7 @@ continue_outer_loop:
 /* Return the position of the end of the trailers. */
 static size_t find_trailer_end(const char *buf, size_t len)
 {
-	return len - ignore_non_trailer(buf, len);
+	return len - ignored_log_message_bytes(buf, len);
 }
 
 static int ends_with_blank_line(const char *buf, size_t len)
-- 
gitgitgadget

