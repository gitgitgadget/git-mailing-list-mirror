Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBE4A2047F
	for <e@80x24.org>; Thu,  3 Aug 2017 09:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbdHCJVM (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 05:21:12 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37530 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752066AbdHCJUT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 05:20:19 -0400
Received: by mail-wm0-f67.google.com with SMTP id t138so1421522wmt.4
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 02:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JRpw1Tw4HeadGhNb2iXRg35D0ET1Aj/ptMB3332HmNo=;
        b=uj+Z60Cbrv/Esqa3/2eKq8ARIE8O1H4Ucaxa9COf3Y0CsFb6TmNqFXcjdhb57Bdvg5
         oYamL8aHFobqzMhpGvWu5mriijwG+2XJ4dTy0DtngTI5qymQLCqFy8M2GEwYFkedVBIR
         wqKLnguOtB8MmaveQfHhLP/RZM9SFq12FNluOfyn/O5pqBhzW6P0j1f1SACec5wO071J
         06F5VJ8TwcAuYJhonFpUF5IH1xBoh61PQH1AcXaCqe8Kc34vHP6loU/f5GoK6CDXgQ7C
         dI/7NAQ0Tf7vnoGU0EDQ+v85QDU/HeHpR3E1w/sIhkzrmSMp0HPsFP6/Zliu383mBEfH
         PbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JRpw1Tw4HeadGhNb2iXRg35D0ET1Aj/ptMB3332HmNo=;
        b=SAVKClIGGcDdwR8dVFyymyjE2M/Dyw+ci8ThK96aTY6vLRQ8hdBvTC6DMnO1y9B4Gl
         +Jz4ipbVv0RxTSqCqgu/Kt6kMGcIwR4JpPJRS37fih+5vSNuOtH/DpEhkaNgApkqZ++G
         SSiZAxaIJcyWHraBoRr0tPrsZbfHBvbwpiDmY+VZJ7U+RiBcBDyNfdq5PkhwlhsgQs3q
         6km+5dfPSR1mktTAIqHfM85wO6xaftgEfCY1qhee2ixiO9VqT5VnT6oPwtrZZwRLEhuQ
         3QemnWqg4XWH5HYq5BJKGJLdFz9xd+GgEmNT1WxJhQ7zEK7TPPu3E3ypqr+A2j2hAl/4
         5AKw==
X-Gm-Message-State: AHYfb5hyKT5bpPlGpZkYeWW1N//gIjP1kgfaj/H1YpR349FLB/LqVcWH
        L3iMiUwiCGyOSWWS
X-Received: by 10.28.28.206 with SMTP id c197mr785625wmc.93.1501752017996;
        Thu, 03 Aug 2017 02:20:17 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id n184sm1308051wme.33.2017.08.03.02.20.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 02:20:16 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 32/40] odb-helper: add have_object_process()
Date:   Thu,  3 Aug 2017 11:19:18 +0200
Message-Id: <20170803091926.1755-33-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.0.rc1.52.gf02fb0ddac.dirty
In-Reply-To: <20170803091926.1755-1-chriscool@tuxfamily.org>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds the infrastructure to handle 'have' instructions in
process mode.

The answer from the helper sub-process should be like the
output in script mode, that is lines like this:

sha1 SPACE size SPACE type NEWLINE

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 odb-helper.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/odb-helper.c b/odb-helper.c
index db90c0a004..31fb398469 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -646,6 +646,70 @@ static int odb_helper_object_cmp(const void *va, const void *vb)
 	return hashcmp(a->sha1, b->sha1);
 }
 
+static int send_have_packets(struct odb_helper *o,
+			     struct object_process *entry,
+			     struct strbuf *status)
+{
+	char *line;
+	int packet_len;
+	int total_got = 0;
+	struct child_process *process = &entry->subprocess.process;
+	int err = packet_write_fmt_gently(process->in, "command=have\n");
+
+	if (err)
+		return err;
+
+	err = packet_flush_gently(process->in);
+	if (err)
+		return err;
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
+	if (packet_len < 0)
+		return packet_len;
+
+	return check_object_process_status(process->out, status);
+}
+
+static int have_object_process(struct odb_helper *o)
+{
+	int err;
+	struct object_process *entry;
+	struct strbuf status = STRBUF_INIT;
+
+	entry = launch_object_process(o, ODB_HELPER_CAP_HAVE);
+	if (!entry)
+		return -1;
+
+	err = send_have_packets(o, entry, &status);
+
+	return check_object_process_error(err, status.buf, entry, o->cmd,
+					  ODB_HELPER_CAP_HAVE);
+}
+
 static void have_object_script(struct odb_helper *o)
 {
 	struct odb_helper_cmd cmd;
@@ -667,12 +731,20 @@ static void have_object_script(struct odb_helper *o)
 
 static void odb_helper_load_have(struct odb_helper *o)
 {
+	uint64_t start;
+
 	if (o->have_valid)
 		return;
 	o->have_valid = 1;
 
+	start = getnanotime();
+
 	if (o->script_mode)
 		have_object_script(o);
+	else
+		have_object_process(o);
+
+	trace_performance_since(start, "odb_helper_load_have");
 
 	qsort(o->have, o->have_nr, sizeof(*o->have), odb_helper_object_cmp);
 }
-- 
2.14.0.rc1.52.gf02fb0ddac.dirty

