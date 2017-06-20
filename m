Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2BED20401
	for <e@80x24.org>; Tue, 20 Jun 2017 07:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752444AbdFTH5X (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:57:23 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34587 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752198AbdFTH4v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:56:51 -0400
Received: by mail-wr0-f196.google.com with SMTP id y25so14134230wrd.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FfDNfdcRgEl4nW+WuFSqtrnHuvNRBBG0CppxHIif2Sg=;
        b=ZM++biI7gXMCfIkdvnKfe6b2sdMDf8mf00U4GHJc1nEmM83Rw1x7Qc+5YHN6bPtfTi
         AjqqqKirYPLc+kLXooMpIXXtfX41LQYHdRxVRLK58gl1SjWzlI061QGMpwxvnvqe+9Wi
         3t3ZAPFelQ4j59+YQa+vn0n3KjMxp9rKp6vdDYaAnG3wPX16DoHtgtcJzzyqaHJsFfTF
         UUjrYZjQUK3Mn0JnPc4vwqdq993hlT1jJHPzo/zS0sjv6oKa6hcxpZW/J2HcrsLbIeZE
         e5oe71Hj6HZ4hBLC8mxPs/4KvvASWSYi78FZDlmFW53RZ11AuhU7Jq+73qfJSPsiFmv0
         4eVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FfDNfdcRgEl4nW+WuFSqtrnHuvNRBBG0CppxHIif2Sg=;
        b=jwajHVe9MWxNFSGjjL0MCFwuEbyxc4BNu12AgsqTumWypCh3U3qxP3vFuTg5mgLXKh
         +uI1xt4DChwUzdheLnTXpkR7N7d7JZSN6C3C5LaLoPDy3gh1yd6vrsXun5M0pQkjkSWn
         Gfvalt6oeCRT6tqpHw6Xsxbzk0+JuLk++QnM8firVVU2Gn+irTvlNAPfx744E+ZOHbGc
         pC5feJkPRwwXIsE4TcHFH7EQ8htYWaC0W7Bm3XbrAs+2Up9YKDPaOi/EVf3g8xfUCEjq
         dDkj4wBCiSKG8lXdzS5RLrmgQG22qmiWNqgwtrlxhj1LxAZgDWmmXxutC6ndJhpKm6lD
         Hwhw==
X-Gm-Message-State: AKS2vOwaEuoaO8m7e9VEo4guELKUlXrKYLPxIKtGkmpOkyvp6u+FJa+0
        84lt0/nHaSxm2H1J
X-Received: by 10.223.178.143 with SMTP id g15mr17558160wrd.144.1497945409712;
        Tue, 20 Jun 2017 00:56:49 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.56.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:56:49 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v4 44/49] odb-helper: add have_object_process()
Date:   Tue, 20 Jun 2017 09:55:18 +0200
Message-Id: <20170620075523.26961-45-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 odb-helper.c | 103 ++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 91 insertions(+), 12 deletions(-)

diff --git a/odb-helper.c b/odb-helper.c
index 2e5d8af526..01cd6a713c 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -579,27 +579,106 @@ static int odb_helper_object_cmp(const void *va, const void *vb)
 	return hashcmp(a->sha1, b->sha1);
 }
 
+static int have_object_process(struct odb_helper *o)
+{
+	int err;
+	struct read_object_process *entry;
+	struct child_process *process;
+	struct strbuf status = STRBUF_INIT;
+	const char *cmd = o->cmd;
+	uint64_t start;
+	char *line;
+	int packet_len;
+	int total_got = 0;
+
+	start = getnanotime();
+
+	entry = launch_read_object_process(cmd);
+	process = &entry->subprocess.process;
+	o->supported_capabilities = entry->supported_capabilities;
+
+	if (!(ODB_HELPER_CAP_HAVE & entry->supported_capabilities))
+		return -1;
+
+	sigchain_push(SIGPIPE, SIG_IGN);
+
+	err = packet_write_fmt_gently(process->in, "command=have\n");
+	if (err)
+		goto done;
+
+	err = packet_flush_gently(process->in);
+	if (err)
+		goto done;
+
+	for (;;) {
+		/* packet_read() writes a '\0' extra byte at the end */
+		char buf[LARGE_PACKET_DATA_MAX + 1];
+		char *p = buf;
+		int more;
+
+		packet_len = packet_read(process->out, NULL, NULL,
+			buf, LARGE_PACKET_DATA_MAX + 1,
+			PACKET_READ_GENTLE_ON_EOF);
+
+		if (packet_len <= 0)
+			break;
+
+		total_got += packet_len;
+
+		do {
+			char *eol = strchrnul(p, '\n');
+			more = (*eol == '\n');
+			*eol = '\0';
+			if (add_have_entry(o, p))
+				break;
+			p = eol + 1;
+		} while (more);
+	}
+
+	if (packet_len < 0) {
+		err = packet_len;
+		goto done;
+	}
+
+	subprocess_read_status(process->out, &status);
+	err = strcmp(status.buf, "success");
+
+done:
+	sigchain_pop(SIGPIPE);
+
+	err = check_object_process_error(err, status.buf, entry, cmd, ODB_HELPER_CAP_HAVE);
+
+	trace_performance_since(start, "have_object_process");
+
+	return err;
+}
+
 static void odb_helper_load_have(struct odb_helper *o)
 {
-	struct odb_helper_cmd cmd;
-	FILE *fh;
-	struct strbuf line = STRBUF_INIT;
 
 	if (o->have_valid)
 		return;
 	o->have_valid = 1;
 
-	if (odb_helper_start(o, &cmd, 0, "have") < 0)
-		return;
+	if (o->script_mode) {
+		struct odb_helper_cmd cmd;
+		FILE *fh;
+		struct strbuf line = STRBUF_INIT;
 
-	fh = xfdopen(cmd.child.out, "r");
-	while (strbuf_getline(&line, fh) != EOF)
-		if (add_have_entry(o, line.buf))
-			break;
+		if (odb_helper_start(o, &cmd, 0, "have") < 0)
+			return;
 
-	strbuf_release(&line);
-	fclose(fh);
-	odb_helper_finish(o, &cmd);
+		fh = xfdopen(cmd.child.out, "r");
+		while (strbuf_getline(&line, fh) != EOF)
+			if (add_have_entry(o, line.buf))
+				break;
+
+		strbuf_release(&line);
+		fclose(fh);
+		odb_helper_finish(o, &cmd);
+	} else {
+		have_object_process(o);
+	}
 
 	qsort(o->have, o->have_nr, sizeof(*o->have), odb_helper_object_cmp);
 }
-- 
2.13.1.565.gbfcd7a9048

