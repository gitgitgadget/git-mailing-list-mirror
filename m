Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A69C2D0C9
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740AE22527
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O176a/gm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfLMII0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 03:08:26 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54397 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfLMIIV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 03:08:21 -0500
Received: by mail-wm1-f67.google.com with SMTP id b19so1071039wmj.4
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 00:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Z1rw34g52yejBNfZuXNfegd9xSsPbQsKJODHVlJOziY=;
        b=O176a/gmjDkDk6WVhji16PTHT2X2brURcMbQL1rfJTMlz7AM/9KsvEbricrOt6WUGV
         NmURnxCjZQJO4VnMaQtOeo4W0dxT4sKZ6GmDbPqoCgDszJgnjOxADgMZksyxGDYD/xt/
         AXiSMAcpo9rU+7FyGgwPPbYM6/pE9QJVII2snNs423q3RrkuGgUrHFT015oAr5y2JDSt
         xNNYNCwFTbRJle4HnlfLhjuUdcXebZ2pTVVWHkxOUnqLG7mnbwcIexN9fU8JS6w88p+a
         FzeKOK3nDShjzyNNHX68/Nj8XP39axVXLHbZVgkeFZq3nsM06kHJt07E4I4W+kQyrm2H
         FtyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Z1rw34g52yejBNfZuXNfegd9xSsPbQsKJODHVlJOziY=;
        b=nH1UBAiKKpyEXvVQRj1o5NENTAmBJiq30pap2wz281PlvUdrveZa5w8zwdyymTw1Fa
         jYaMrbKl+LKM6cHYtMLubDOGqVrY5MhHWU1IC+quGzl0/AA36zvXaDqfDa/ULTW/eGA0
         blEuZiJETOhmey9+sUs/XXKzAxQ/pDDSIKrQAW/eTGEkLIk5WF6OK2U+I/vKEGYDAsX9
         KjDBtuawD0cBO/rvF5iD3yh+xkG/ebmsD0HETjEa0IOGCIf0d9wkKB0VOatkEJpRK2fa
         5aWK/QdTc0w77TfP83DhSleDU3apIi5yT/q1oQ4fH4H2S8v5HZ10LJueRCLQDDlYh0gB
         znsw==
X-Gm-Message-State: APjAAAVMEupMxQQAsKJvZx7zzQUwFXWnEfn8w1xmJqNmZycs8cg87v1j
        buSKDWtVCuXpnJrsEfxz+UTxKQrl
X-Google-Smtp-Source: APXvYqxmoY+kR7Bs4FLGMYriDwFm7zJb2RLN2bT1sSFWiHneyb8UH9QQDrQTz7t63I+el3NpKFzUow==
X-Received: by 2002:a05:600c:2c13:: with SMTP id q19mr11300457wmg.144.1576224499877;
        Fri, 13 Dec 2019 00:08:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f16sm9253527wrm.65.2019.12.13.00.08.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 00:08:19 -0800 (PST)
Message-Id: <9a2cf7ed71fe012de93a5d23b72c9c3aa0bdcdf9.1576224486.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.173.git.1576224486.gitgitgadget@gmail.com>
References: <pull.173.git.1576224486.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Dec 2019 08:08:02 +0000
Subject: [PATCH 15/19] built-in add -p: implement the 'g' ("goto") command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

With this patch, it is now possible to see a summary of the available
hunks and to navigate between them (by number).

A test is added to verify that this behavior matches the one of the Perl
version of `git add -p`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-patch.c                | 88 ++++++++++++++++++++++++++++++++++++++
 t/t3701-add-interactive.sh | 16 +++++++
 2 files changed, 104 insertions(+)

diff --git a/add-patch.c b/add-patch.c
index ea863ca09d..fdbb1e3e22 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -955,6 +955,54 @@ static int edit_hunk_loop(struct add_p_state *s,
 	}
 }
 
+#define SUMMARY_HEADER_WIDTH 20
+#define SUMMARY_LINE_WIDTH 80
+static void summarize_hunk(struct add_p_state *s, struct hunk *hunk,
+			   struct strbuf *out)
+{
+	struct hunk_header *header = &hunk->header;
+	struct strbuf *plain = &s->plain;
+	size_t len = out->len, i;
+
+	strbuf_addf(out, " -%lu,%lu +%lu,%lu ",
+		    header->old_offset, header->old_count,
+		    header->new_offset, header->new_count);
+	if (out->len - len < SUMMARY_HEADER_WIDTH)
+		strbuf_addchars(out, ' ',
+				SUMMARY_HEADER_WIDTH + len - out->len);
+	for (i = hunk->start; i < hunk->end; i = find_next_line(plain, i))
+		if (plain->buf[i] != ' ')
+			break;
+	if (i < hunk->end)
+		strbuf_add(out, plain->buf + i, find_next_line(plain, i) - i);
+	if (out->len - len > SUMMARY_LINE_WIDTH)
+		strbuf_setlen(out, len + SUMMARY_LINE_WIDTH);
+	strbuf_complete_line(out);
+}
+
+#define DISPLAY_HUNKS_LINES 20
+static size_t display_hunks(struct add_p_state *s,
+			    struct file_diff *file_diff, size_t start_index)
+{
+	size_t end_index = start_index + DISPLAY_HUNKS_LINES;
+
+	if (end_index > file_diff->hunk_nr)
+		end_index = file_diff->hunk_nr;
+
+	while (start_index < end_index) {
+		struct hunk *hunk = file_diff->hunk + start_index++;
+
+		strbuf_reset(&s->buf);
+		strbuf_addf(&s->buf, "%c%2d: ", hunk->use == USE_HUNK ? '+'
+			    : hunk->use == SKIP_HUNK ? '-' : ' ',
+			    (int)start_index);
+		summarize_hunk(s, hunk, &s->buf);
+		fputs(s->buf.buf, stdout);
+	}
+
+	return end_index;
+}
+
 static const char help_patch_text[] =
 N_("y - stage this hunk\n"
    "n - do not stage this hunk\n"
@@ -964,6 +1012,7 @@ N_("y - stage this hunk\n"
    "J - leave this hunk undecided, see next hunk\n"
    "k - leave this hunk undecided, see previous undecided hunk\n"
    "K - leave this hunk undecided, see previous hunk\n"
+   "g - select a hunk to go to\n"
    "s - split the current hunk into smaller hunks\n"
    "e - manually edit the current hunk\n"
    "? - print help\n");
@@ -1022,6 +1071,8 @@ static int patch_update_file(struct add_p_state *s,
 			strbuf_addstr(&s->buf, ",j");
 		if (hunk_index + 1 < file_diff->hunk_nr)
 			strbuf_addstr(&s->buf, ",J");
+		if (file_diff->hunk_nr > 1)
+			strbuf_addstr(&s->buf, ",g");
 		if (hunk->splittable_into > 1)
 			strbuf_addstr(&s->buf, ",s");
 		if (hunk_index + 1 > file_diff->mode_change &&
@@ -1089,6 +1140,43 @@ static int patch_update_file(struct add_p_state *s,
 				hunk_index = undecided_next;
 			else
 				err(s, _("No next hunk"));
+		} else if (s->answer.buf[0] == 'g') {
+			char *pend;
+			unsigned long response;
+
+			if (file_diff->hunk_nr < 2) {
+				err(s, _("No other hunks to goto"));
+				continue;
+			}
+			strbuf_remove(&s->answer, 0, 1);
+			strbuf_trim(&s->answer);
+			i = hunk_index - DISPLAY_HUNKS_LINES / 2;
+			if (i < file_diff->mode_change)
+				i = file_diff->mode_change;
+			while (s->answer.len == 0) {
+				i = display_hunks(s, file_diff, i);
+				printf("%s", i < file_diff->hunk_nr ?
+				       _("go to which hunk (<ret> to see "
+					 "more)? ") : _("go to which hunk? "));
+				fflush(stdout);
+				if (strbuf_getline(&s->answer,
+						   stdin) == EOF)
+					break;
+				strbuf_trim_trailing_newline(&s->answer);
+			}
+
+			strbuf_trim(&s->answer);
+			response = strtoul(s->answer.buf, &pend, 10);
+			if (*pend || pend == s->answer.buf)
+				err(s, _("Invalid number: '%s'"),
+				    s->answer.buf);
+			else if (0 < response && response <= file_diff->hunk_nr)
+				hunk_index = response - 1;
+			else
+				err(s, Q_("Sorry, only %d hunk available.",
+					  "Sorry, only %d hunks available.",
+					  file_diff->hunk_nr),
+				    (int)file_diff->hunk_nr);
 		} else if (s->answer.buf[0] == 's') {
 			size_t splittable_into = hunk->splittable_into;
 			if (splittable_into < 2)
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index fe383be50e..57c656a20c 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -413,6 +413,22 @@ test_expect_success 'split hunk setup' '
 	test_write_lines 10 15 20 21 22 23 24 30 40 50 60 >test
 '
 
+test_expect_success 'goto hunk' '
+	test_when_finished "git reset" &&
+	tr _ " " >expect <<-EOF &&
+	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,?]? + 1:  -1,2 +1,3          +15
+	_ 2:  -2,4 +3,8          +21
+	go to which hunk? @@ -1,2 +1,3 @@
+	_10
+	+15
+	_20
+	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,?]?_
+	EOF
+	test_write_lines s y g 1 | git add -p >actual &&
+	tail -n 7 <actual >actual.trimmed &&
+	test_cmp expect actual.trimmed
+'
+
 test_expect_success 'split hunk "add -p (edit)"' '
 	# Split, say Edit and do nothing.  Then:
 	#
-- 
gitgitgadget

