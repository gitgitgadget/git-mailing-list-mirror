Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836072D792
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 22:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="eqMzNjJK"
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91EE1B2
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 15:46:42 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-5842a94feb2so924548eaf.0
        for <git@vger.kernel.org>; Thu, 26 Oct 2023 15:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1698360402; x=1698965202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FO8nzutUerGj+rNocMCvjOeeegjB0orbkFZh5eeWFo8=;
        b=eqMzNjJKHcvZk0it/R5nkLzyr7LhV3UMZOlmjewusWl4ScpGJlKv94yRr42AU1j7fi
         p6JnUbU4WxCxBUZQeeYWNLj3ppekgHb8monx+2x4cEDncnI8nwJoXzWsSQbrLrurw8Rz
         Ym8n9RaqscvC60uF//jMh9DPH4xHr7urQpvf+1ybz4QLatIwiH+uDK+NxzVaoXQQ7XtP
         xCPXQDunTlEIYz4WZynqkfPJbjAwHhk9SMn8iPe6WoVW3rzmiajLkIzEcSl3RtPn5ram
         xT6rVuhwybygohi/ad0gUdTEmpGVCKxgkeMY1ixrDs4JZv9WEvcKvIFD/BzgZa5nywWH
         6uNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698360402; x=1698965202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FO8nzutUerGj+rNocMCvjOeeegjB0orbkFZh5eeWFo8=;
        b=mUY5RuVTWA0QZeAeBg8/+r6/tk92IT6fyga86GcOiGy6FWQPt9eHaTMNdJWC3sg2id
         JW1x2IPXWbrk3xSgMdXI6OLbWmRqTlM7gQCxppDyRqs3c5SZ2CqsKE0VgpeqodJxD8eu
         NZMY6lpPGstfVLbPNvULsGy8OixSAVoT8R6S8QpAvCQF3fHToZznYp0PR34Vp4QKnLjw
         BfjRKfFcGqewZ1gZwo3ToA4dOsbVj48gdM1YuDvgcR0J4cfC4ljeWUZAGEiN1rUTJ1yq
         m/ZKtraUdddPvcSUBBEOTjRXVERGUDO8Ub+J96CZvWaaQL+rFKu/CSxKZnUmn4mNowsO
         3LgA==
X-Gm-Message-State: AOJu0YwHKaQ55U7yeF3Xra/DWgp081Ut0sOr4oh5fsqEm0/SL9yJgC6A
	aVa8Gb0HF2ymfUO7xvbKCNNO7bdA8orHW66cV+0=
X-Google-Smtp-Source: AGHT+IHCRgAtVQt4i4twQcwf4hgtTAna6uHJiOSX334sGis3Etz73mo308EYufMhU8xDj23OgHYiPQ==
X-Received: by 2002:a05:6358:2809:b0:168:dd31:73f6 with SMTP id k9-20020a056358280900b00168dd3173f6mr1448648rwb.2.1698360401982;
        Thu, 26 Oct 2023 15:46:41 -0700 (PDT)
Received: from localhost.localdomain (mobile-166-170-45-225.mycingular.net. [166.170.45.225])
        by smtp.gmail.com with ESMTPSA id s194-20020a6377cb000000b0058ac101ad83sm112318pgc.33.2023.10.26.15.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 15:46:41 -0700 (PDT)
From: Jacob Stopak <jacob@initialcommit.io>
To: git@vger.kernel.org
Cc: Jacob Stopak <jacob@initialcommit.io>
Subject: [RFC PATCH v2 2/6] status: handle long paths in noob format
Date: Thu, 26 Oct 2023 15:46:11 -0700
Message-ID: <20231026224615.675172-3-jacob@initialcommit.io>
X-Mailer: git-send-email 2.42.0.404.g2bcc23f3db
In-Reply-To: <20231026224615.675172-1-jacob@initialcommit.io>
References: <20231020183947.463882-1-jacob@initialcommit.io>
 <20231026224615.675172-1-jacob@initialcommit.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jacob Stopak <jacob@initialcommit.io>
---
 table.c     | 58 ++++++++++++++++++++++++++++++++++++++++++++++-------
 table.h     |  2 +-
 wt-status.c |  2 +-
 3 files changed, 53 insertions(+), 9 deletions(-)

diff --git a/table.c b/table.c
index 15600e117f..d085f2a098 100644
--- a/table.c
+++ b/table.c
@@ -25,15 +25,44 @@ static void build_table_border(struct strbuf *buf, int cols)
 
 static void build_table_entry(struct strbuf *buf, char *entry, int cols)
 {
+	int len = strlen(entry);
+	size_t col_width = (cols / 3) - 5; /* subtract for padding */
+
 	strbuf_reset(buf);
-	strbuf_addchars(buf, ' ', (cols / 3 - 1 - strlen(entry)) / 2);
+
+	/* Trim equally from both sides if it doesn't fit in column */
+	if (len > col_width) {
+		struct strbuf start_buf = STRBUF_INIT;
+		struct strbuf end_buf = STRBUF_INIT;
+		struct strbuf entry_buf = STRBUF_INIT;
+
+		strbuf_addstr(&start_buf, entry);
+		strbuf_addstr(&end_buf, entry);
+
+		strbuf_remove(&start_buf, col_width / 2, len - col_width / 2);
+		strbuf_remove(&end_buf, 0, len - col_width / 2);
+
+		strbuf_addstr(&entry_buf, start_buf.buf);
+		strbuf_addstr(&entry_buf, "...");
+		strbuf_addstr(&entry_buf, end_buf.buf);
+
+		entry = strbuf_detach(&entry_buf, &col_width);
+		len = strlen(entry);
+
+		strbuf_release(&start_buf);
+		strbuf_release(&end_buf);
+		strbuf_release(&entry_buf);
+	}
+
+	strbuf_addchars(buf, ' ', (cols / 3 - len - 1) / 2); /* left padding */
 	strbuf_addstr(buf, entry);
 
-	/* Bump right padding if entry length is odd */
-	if (!(strlen(entry) % 2))
-		strbuf_addchars(buf, ' ', (cols / 3 - 1 - strlen(entry)) / 2 + 1);
+	/* right padding */
+	if (!(len % 2))
+		/* Bump right padding if entry length is odd */
+		strbuf_addchars(buf, ' ', (cols / 3 - len - 1) / 2 + 1);
 	else
-		strbuf_addchars(buf, ' ', (cols / 3 - 1 - strlen(entry)) / 2);
+		strbuf_addchars(buf, ' ', (cols / 3 - len - 1) / 2);
 }
 
 static void print_table_body_line(struct strbuf *buf1, struct strbuf *buf2, struct strbuf *buf3, struct wt_status *s)
@@ -47,7 +76,7 @@ static void print_table_body_line(struct strbuf *buf1, struct strbuf *buf2, stru
 	printf(_("|\n"));
 }
 
-void print_noob_status(struct wt_status *s)
+void print_noob_status(struct wt_status *s, int add_advice)
 {
 	struct winsize w;
 	int cols;
@@ -66,14 +95,29 @@ void print_noob_status(struct wt_status *s)
 		cols -= 1;
 	}
 
+	/* Draw table header */
 	build_table_border(&table_border, cols);
 	build_table_entry(&table_col_entry_1, "Untracked files", cols);
 	build_table_entry(&table_col_entry_2, "Unstaged changes", cols);
 	build_table_entry(&table_col_entry_3, "Staging area", cols);
 
-	/* Draw table header */
 	printf(_("%s\n"), table_border.buf);
 	printf(_("|%s|%s|%s|\n"), table_col_entry_1.buf, table_col_entry_2.buf, table_col_entry_3.buf);
+
+	if (add_advice) {
+		build_table_entry(&table_col_entry_1, "(stage: git add <file>)", cols);
+		build_table_entry(&table_col_entry_2, "(stage: git add <file>)", cols);
+		build_table_entry(&table_col_entry_3, "(unstage: git restore --staged <file>)", cols);
+
+		printf(_("|%s|%s|%s|\n"), table_col_entry_1.buf, table_col_entry_2.buf, table_col_entry_3.buf);
+
+		build_table_entry(&table_col_entry_1, "", cols);
+		build_table_entry(&table_col_entry_2, "(discard: git restore --staged <file>)", cols);
+		build_table_entry(&table_col_entry_3, "", cols);
+
+		printf(_("|%s|%s|%s|\n"), table_col_entry_1.buf, table_col_entry_2.buf, table_col_entry_3.buf);
+	}
+
 	printf(_("%s\n"), table_border.buf);
 
 	/* Draw table body */
diff --git a/table.h b/table.h
index c9e8c386de..5dff7162a4 100644
--- a/table.h
+++ b/table.h
@@ -1,6 +1,6 @@
 #ifndef TABLE_H
 #define TABLE_H
 
-void print_noob_status(struct wt_status *s);
+void print_noob_status(struct wt_status *s, int i);
 
 #endif /* TABLE_H */
diff --git a/wt-status.c b/wt-status.c
index 712807aa8f..b5899dcc98 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -2149,7 +2149,7 @@ static void wt_noobstatus_print(struct wt_status *s)
 		wt_longstatus_print_tracking(s);
 	}
 
-	print_noob_status(s);
+	print_noob_status(s, 0);
 }
 
 static void wt_porcelain_print(struct wt_status *s)
-- 
2.42.0.404.g2bcc23f3db

