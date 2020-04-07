Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87056C2BB55
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5948F20801
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYa7hkXK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbgDGO22 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:28:28 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45081 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbgDGO2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 10:28:25 -0400
Received: by mail-qk1-f195.google.com with SMTP id m67so612685qke.12
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 07:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9RY3BND5SfeTlPhgSuFM1vnMiDc3w6JLlucpcDFJ81w=;
        b=FYa7hkXKc2ujY65SCC4jp7mFWfkAK9niWtc3oS0smP3tdAz7PnqRFRfYrEBMMHv2td
         fC596krHueGeLkaFnXx1rNM3vbPBA+K1bj1Zj/hD02a8On6HiPg0tN1u9JCeWV6hJmJ3
         gqE3uuhT1E64F6FVHp6EoO4gh5YzXGfjrxPIvPv4yOFWp9YKS8+5+1kRPvaW00R7K7+l
         HWBjqi+DwTUoFZgWIICiQduNPDpjHtEKcTBudMoSc+aXNJNWznO9rAWcKBcMMeJYdpQk
         FMAKYtAHNQsCHnz36BmDJM0wUbY/qYTkAOnTR+N2/fQxktaQPiTg8P3ycPeYdKBpbK6l
         uAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9RY3BND5SfeTlPhgSuFM1vnMiDc3w6JLlucpcDFJ81w=;
        b=boMl3UJoxE58XUw6NopTH8Wwfox2UqdtqKUc9BzF5IHXEPr0BQpeAyWM3HNQj+wD/B
         ANC2Tk0NyeCCMCq8O5BMiHLdfh8lw0dKxWZcIzWSZL3cLtC18xtSKEKSjMiXvXkKz3jB
         PBn+1Y3KDoe+mhihhQ/TKeNIOg0xf+P5o72bu3NNRHiFhFL0VE0FGsWNFz+lU+JAwxgB
         a6qH0yTquJLj2J4cCb+MQBIWO1WPP2otx6Aqsk5vHLi2mX47f4u/Qh1vVyYKE3g0Lbnx
         9NEsyPnizeX5frOZKRk4drOJGFsyzsLG46kTX35RTw/d0RQZTt6dMZX3KpwvYtCHFgpB
         8BfA==
X-Gm-Message-State: AGi0PuZNvJJAEsMUqxoz+F4s77nZ5K4TX1LWI2519CldeuUfQoUJePCa
        jJP/QOeRUdm3rAjeuwD/2mpBICLk
X-Google-Smtp-Source: APiQypIFvpkQJOMVJT4WxhlhFf79pg3v5F15sq5SvzXjQ2vmTg3yiBe/8iEnew7X1EY0cKZdrNfVoA==
X-Received: by 2002:a05:620a:22b1:: with SMTP id p17mr2594791qkh.396.1586269704415;
        Tue, 07 Apr 2020 07:28:24 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id j6sm17051736qti.25.2020.04.07.07.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:28:23 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v5 05/22] sequencer: make read_oneliner() accept flags
Date:   Tue,  7 Apr 2020 10:27:52 -0400
Message-Id: <f30ad07823c6e8f47c217ac24a06e02d3e0af554.1586269543.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1586269542.git.liu.denton@gmail.com>
References: <cover.1585962672.git.liu.denton@gmail.com> <cover.1586269542.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future commit, we will need read_oneliner() to accept flags other
than just `skip_if_empty`. Instead of having an argument for each flag,
teach read_oneliner() to accept the bitfield `flags` instead. For now,
only recognize the `READ_ONELINER_SKIP_IF_EMPTY` flag. More flags will
be added in a future commit.

The result of this is that parallel topics which introduce invocations
of read_oneliner() will still be compatible with this new function
signature since, instead of passing 1 or 0 for `skip_if_empty`, they'll
be passing 1 or 0 to `flags`, which gives equivalent behavior.

Mechanically fix up invocations of read_oneliner() with the following
spatch

	@@
	expression a, b;
	@@
	  read_oneliner(a, b,
	- 1
	+ READ_ONELINER_SKIP_IF_EMPTY
	  )

and manually break up long lines in the result.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 sequencer.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index a961cf5a9b..6c4e8743ef 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -419,6 +419,8 @@ static int write_message(const void *buf, size_t len, const char *filename,
 	return 0;
 }
 
+#define READ_ONELINER_SKIP_IF_EMPTY (1 << 0)
+
 /*
  * Reads a file that was presumably written by a shell script, i.e. with an
  * end-of-line marker that needs to be stripped.
@@ -429,7 +431,7 @@ static int write_message(const void *buf, size_t len, const char *filename,
  * Returns 1 if the file was read, 0 if it could not be read or does not exist.
  */
 static int read_oneliner(struct strbuf *buf,
-	const char *path, int skip_if_empty)
+	const char *path, unsigned flags)
 {
 	int orig_len = buf->len;
 
@@ -445,7 +447,7 @@ static int read_oneliner(struct strbuf *buf,
 		buf->buf[buf->len] = '\0';
 	}
 
-	if (skip_if_empty && buf->len == orig_len)
+	if ((flags & READ_ONELINER_SKIP_IF_EMPTY) && buf->len == orig_len)
 		return 0;
 
 	return 1;
@@ -2485,7 +2487,8 @@ static int read_populate_opts(struct replay_opts *opts)
 		struct strbuf buf = STRBUF_INIT;
 		int ret = 0;
 
-		if (read_oneliner(&buf, rebase_path_gpg_sign_opt(), 1)) {
+		if (read_oneliner(&buf, rebase_path_gpg_sign_opt(),
+				  READ_ONELINER_SKIP_IF_EMPTY)) {
 			if (!starts_with(buf.buf, "-S"))
 				strbuf_reset(&buf);
 			else {
@@ -2495,7 +2498,8 @@ static int read_populate_opts(struct replay_opts *opts)
 			strbuf_reset(&buf);
 		}
 
-		if (read_oneliner(&buf, rebase_path_allow_rerere_autoupdate(), 1)) {
+		if (read_oneliner(&buf, rebase_path_allow_rerere_autoupdate(),
+				  READ_ONELINER_SKIP_IF_EMPTY)) {
 			if (!strcmp(buf.buf, "--rerere-autoupdate"))
 				opts->allow_rerere_auto = RERERE_AUTOUPDATE;
 			else if (!strcmp(buf.buf, "--no-rerere-autoupdate"))
@@ -2527,7 +2531,8 @@ static int read_populate_opts(struct replay_opts *opts)
 		strbuf_reset(&buf);
 
 		if (read_oneliner(&opts->current_fixups,
-				  rebase_path_current_fixups(), 1)) {
+				  rebase_path_current_fixups(),
+				  READ_ONELINER_SKIP_IF_EMPTY)) {
 			const char *p = opts->current_fixups.buf;
 			opts->current_fixup_count = 1;
 			while ((p = strchr(p, '\n'))) {
@@ -3668,7 +3673,8 @@ static int apply_autostash(struct replay_opts *opts)
 	struct child_process child = CHILD_PROCESS_INIT;
 	int ret = 0;
 
-	if (!read_oneliner(&stash_sha1, rebase_path_autostash(), 1)) {
+	if (!read_oneliner(&stash_sha1, rebase_path_autostash(),
+			   READ_ONELINER_SKIP_IF_EMPTY)) {
 		strbuf_release(&stash_sha1);
 		return 0;
 	}
@@ -4292,7 +4298,8 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 		struct strbuf buf = STRBUF_INIT;
 		struct object_id oid;
 
-		if (read_oneliner(&buf, rebase_path_stopped_sha(), 1) &&
+		if (read_oneliner(&buf, rebase_path_stopped_sha(),
+				  READ_ONELINER_SKIP_IF_EMPTY) &&
 		    !get_oid_committish(buf.buf, &oid))
 			record_in_rewritten(&oid, peek_command(&todo_list, 0));
 		strbuf_release(&buf);
-- 
2.26.0.159.g23e2136ad0

