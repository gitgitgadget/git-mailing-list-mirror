Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FAD8F74
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 18:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="R8AwjxCV"
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AE8D5F
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 11:39:55 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-27d104fa285so965507a91.2
        for <git@vger.kernel.org>; Fri, 20 Oct 2023 11:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1697827194; x=1698431994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6nNhvW8l9ieWflD01LAdyFAexuLSlkB+F28Sdzp57fA=;
        b=R8AwjxCVs1t8HCiTUAa5fxJkVHbnYbmyX+Ov6wh+JOFB0WyQwkRquEThwhPUGS9vqy
         +YUL9IrGrbIYmueLwWVr+FCCZxk3A+UURBvtPn29WQTCSjDdUoTS4w7wR1Nmi9f3o6HO
         HOcbgMYiZmUI9FrXsWQ0O29e9gM0ifOIjZa3fnodKFIeho6UU4yrcGIgJfG9HKfzFTGT
         wTR+DiJvRAkLJ+Pc+Kh2G7fP5KQbHQKXK3RrlZuBL6ISd5wEknMBlVcojzPyOoa0yeot
         FKYa+VCn86xA0ZnFtTsRBH6XfeGDO9S8a/X3JPpHQ3Y/Z/abAAquwE/Gvcgvn81o2tQF
         9w3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697827195; x=1698431995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6nNhvW8l9ieWflD01LAdyFAexuLSlkB+F28Sdzp57fA=;
        b=st8SSRlYzNZPqFAKflwfIRtHE2Vfu0UXeprekKGL/Cv+iHioXS0D08U8ow1/dymDva
         0oohxwcONaQMFlmkmOQMkLVXPV7DBx04f3RT0hEx+W7p2uS4bw8xyWHENNAS4c6XuHna
         09leIyjX8WsKfcuH0UIKyQYTVEfUi4DLyUdTxwQwStPkHH9kR/RGlwGTJl12fp/fUreg
         f4+MYRM495CERIE0TH18Tgvxy3pmLse6/ucy+VZg+35cxZ7+dutlQF9qZ7paELTbUxzt
         Kp4EvaSICOD8CT7Nv3zk9mybtTNhdCdjvkcjdM9XBJrSrwX2ubkIkvkxGtvl7AR1EQwf
         HTVQ==
X-Gm-Message-State: AOJu0YyqSjOrR4KPF9HKieKQtS8VjffLTxoUVN8xFQ6LvZM81PpMsx1z
	WLSLmwF8Im0ltVcEDa5OQWXrUliO41K6WP8oMsCJ939e5aM=
X-Google-Smtp-Source: AGHT+IGKNwjgJ7ZIG+2M+UquAYCv5ri3is4YGfYIWW26LWA+yYlEZRv5/KhOUARUm+LlF2oOvkOpnQ==
X-Received: by 2002:a17:90a:41:b0:27d:d9d:c54d with SMTP id 1-20020a17090a004100b0027d0d9dc54dmr2645530pjb.34.1697827194693;
        Fri, 20 Oct 2023 11:39:54 -0700 (PDT)
Received: from localhost.localdomain (mobile-166-170-46-176.mycingular.net. [166.170.46.176])
        by smtp.gmail.com with ESMTPSA id s15-20020a17090a5d0f00b0027e022bd62fsm2994353pji.5.2023.10.20.11.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 11:39:54 -0700 (PDT)
From: Jacob Stopak <jacob@initialcommit.io>
To: git@vger.kernel.org
Cc: Jacob Stopak <jacob@initialcommit.io>
Subject: [RFC PATCH 2/5] status: handle long paths with -t, --table flag
Date: Fri, 20 Oct 2023 11:39:44 -0700
Message-ID: <20231020183947.463882-3-jacob@initialcommit.io>
X-Mailer: git-send-email 2.42.0.402.gbe8243af7b.dirty
In-Reply-To: <20231020183947.463882-1-jacob@initialcommit.io>
References: <20231020183947.463882-1-jacob@initialcommit.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jacob Stopak <jacob@initialcommit.io>
---
 table.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/table.c b/table.c
index 54cf9e4d07..87b6df8c66 100644
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
-- 
2.42.0.402.gbe8243af7b.dirty

