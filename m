Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D40C433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 13:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbiCINSw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 08:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbiCINSr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 08:18:47 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36FD14FFE8
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 05:17:47 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id p9so2956043wra.12
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 05:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AGRtydwUAAL/pJbRKXwRWN+K2yyQYXB33ugVthGbh40=;
        b=j94HtLZwBIepM41NIqMg1NVEShoxySOt7r68ukpsnidqlswaC0QcILWsQa6fRnveLp
         18PadqmRRI+0pt1igImiCNK3pARJq2boPbVh8m6ltX0/Y++tVn/BPpvWhekcyD6KSO76
         Ub3RFOpc5jj5QMQ8sV0gqaZOEhzlqDJuKqKBaSy7P7qr7BiC/V2C05Mb80u6adoOwnWQ
         /28d12lD8oD2kJ+yQ++bWO4aGy8vdi7zLvYVIwBsgNkJCuuPyp8KRYIVQJl92NrfotJ5
         ynJcCWmpFFDJtzIexbJdTLsKwFZFF++ZcRpiHGFpadVT5aQKrylY2YuALRWdnmVhdPlF
         vIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AGRtydwUAAL/pJbRKXwRWN+K2yyQYXB33ugVthGbh40=;
        b=F9cnjpo9g9tEltWEPn5WODi19ZqzX54YyUoh+reo9WwL3kpI7wnmgTIe6thRGp84pN
         dwbNyuLVmInrB0yzXv7SNDifSRXEmuGaNI6xymtCzmOl6T0BZlRjLyiE39kW3BYzroq2
         aAPIMJq04D7UEP82hVjRIjx2rgnqvEdYpfmqltg9lQ/cC490E/G0cNc0R4THG1HUK1zr
         U6DHJCdxJJDTcl5VS6ZYV0BaQKzDb+1oJJBBYa0u5s9zUJhg0UetpLa8msu4xV7nZoUY
         lNLio2qUmtyCXW+SB5+q39B9dQ1Xe/CytPRzTU6r1EUXz6kEUuiQuH770i8h8g5rKUfa
         d2Uw==
X-Gm-Message-State: AOAM530Qm4bVR1sZa9O9ara/lnt7M2xoMwElhY5kdx2DYHm41j2YdS4d
        TF5h6nruDcrswKJGSaCYOpw8pcRvxPk=
X-Google-Smtp-Source: ABdhPJxOlibpScZkDtkrHrLgGGeJICOj3K+x+SukwTaQvEzIs+WJMqmYp9RDfaxl15FacJrM/iDu/g==
X-Received: by 2002:a05:6000:1549:b0:1f1:e564:874c with SMTP id 9-20020a056000154900b001f1e564874cmr14920256wry.668.1646831866136;
        Wed, 09 Mar 2022 05:17:46 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i74-20020adf90d0000000b0020373ba7beesm2599988wri.0.2022.03.09.05.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 05:17:45 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/24] format-patch: don't leak "extra_headers" or "ref_message_ids"
Date:   Wed,  9 Mar 2022 14:16:33 +0100
Message-Id: <patch-03.24-ab1afe6c0c8-20220309T123321Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1295.g6b025d3e231
In-Reply-To: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix two memory leaks in "struct rev_info" by freeing that memory in
cmd_format_patch(). These two are unusual special-cases in being in
the "struct rev_info", but not being "owned" by the code in
revision.c. I.e. they're members of the struct so that this code in
"builtin/log.c" can pass information code in log-tree.c.

See 20ff06805c6 (format-patch: resurrect extra headers from config,
2006-06-02) and d1566f7883f (git-format-patch: Make the second and
subsequent mails replies to the first, 2006-07-14) for the initial
introduction of "extra_headers" and "ref_message_ids".

We can count on repo_init_revisions() memset()-ing this data to 0
however, so we can count on it being either NULL or something we
allocated. In the case of "extra_headers" let's add a local "char *"
variable to hold it, to avoid the eventual cast from "const char *"
when we free() it.

While we're at it let's also move to using string_list_init_nodup()
instead of relying on calloc() implicitly coming up with the same
result. See 770fedaf9fb (string-list.[ch]: add a
string_list_init_{nodup,dup}(), 2021-07-01) for the introduction of
the string_list_init_nodup() helper. The string_list_clear() here is
redundant due to the *_nodup() initialization, but let's add it anyway
for consistency with other API use.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/log.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index c211d66d1d0..00846c2c8ac 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1746,6 +1746,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	struct commit *commit;
 	struct commit **list = NULL;
 	struct rev_info rev;
+	char *extra_headers = NULL;
 	struct setup_revision_opt s_r_opt;
 	int nr = 0, total, i;
 	int use_stdout = 0;
@@ -1946,7 +1947,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		strbuf_addch(&buf, '\n');
 	}
 
-	rev.extra_headers = strbuf_detach(&buf, NULL);
+	extra_headers = strbuf_detach(&buf, NULL);
+	rev.extra_headers = extra_headers;
 
 	if (from) {
 		if (split_ident_line(&rev.from_ident, from, strlen(from)))
@@ -2173,8 +2175,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		prepare_bases(&bases, base, list, nr);
 	}
 
-	if (in_reply_to || thread || cover_letter)
-		rev.ref_message_ids = xcalloc(1, sizeof(struct string_list));
+	if (in_reply_to || thread || cover_letter) {
+		rev.ref_message_ids = xmalloc(sizeof(*rev.ref_message_ids));
+		string_list_init_nodup(rev.ref_message_ids);
+	}
 	if (in_reply_to) {
 		const char *msgid = clean_message_id(in_reply_to);
 		string_list_append(rev.ref_message_ids, msgid);
@@ -2281,6 +2285,11 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	strbuf_release(&rdiff1);
 	strbuf_release(&rdiff2);
 	strbuf_release(&rdiff_title);
+	free(extra_headers);
+	if (rev.ref_message_ids) {
+		string_list_clear(rev.ref_message_ids, 0);
+		free(rev.ref_message_ids);
+	}
 	UNLEAK(rev);
 	return 0;
 }
-- 
2.35.1.1295.g6b025d3e231

