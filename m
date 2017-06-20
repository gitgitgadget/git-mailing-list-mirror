Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D33020401
	for <e@80x24.org>; Tue, 20 Jun 2017 07:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752253AbdFTH4v (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:56:51 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34525 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752247AbdFTH4q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:56:46 -0400
Received: by mail-wr0-f196.google.com with SMTP id y25so14133829wrd.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CO2s7+7Tr/Bam+F+T9inyv1bbt/3K0r8kD/Xiy/uc5A=;
        b=eQ92Icj+KkxeBw7e4HFXR+dLbfQdsjBvtUySKDPb3ToDdm4sccy+GyPYQ1x5/FE8w+
         x34iqm1Ht+sZ/NZ9e8K+ebdBZw4rVc3pITmy45Po5qqqICbOF6F42a+PMoPgD6EPBkwR
         4USA3xAO6fKxbu9diu3d+N+3Dc13QyIHin7jNaWsOWDd9TWNLd5szwQcMeEsSTi8dMGd
         x060Fmx/FnDqoUR5Ab7UJPLgEhE7/ps75UHvgXLAggdud0BUiNPCrYoDZIUW8EerbAdr
         dkJJj/SVgW7QJYpvZ95/2F5NUyfn9B3I7lWvratnTUw9YttijqyUudCggf3zKnt/FCAY
         Xb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CO2s7+7Tr/Bam+F+T9inyv1bbt/3K0r8kD/Xiy/uc5A=;
        b=Rw1bd93+6IGZ0RS7c+tvjyE/ZiijMvidIPFYCANqUMs5Nz+om/juatKW7Y8OJjFitH
         48TpuSSTKChX5vVz/YUxYUyqmERO/HDDk9JR1LKoUqqJm0kyv69iGlFviiDP6VXVborq
         2VphWFFSN1hDArvoHbCunsDd2ghrSMHifZbKZRYFYwuMn/ZYhOowbV6fiDpUT3lvo+qv
         jK7bpfwO/X4NG6T24mW/LC3Kot8Yr0I38GQkCTFDDQGEo7sRpL1piLoMxb/F+cTN6Ob4
         uY9HWkEN8I0Th44x6ztc1WfabEzK16wq6XlfzlJ2GtqXe625Yt0Rtz8wlpfmZDAhVgw9
         ILtA==
X-Gm-Message-State: AKS2vOzhyHi8mhrJ7JYPPJ0AVBiPDLCqu8mxS1OMbfeKbqocmVxGWKrz
        zcR3/FhXnJ96gOoL
X-Received: by 10.223.133.4 with SMTP id 4mr22146918wrh.30.1497945399684;
        Tue, 20 Jun 2017 00:56:39 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.56.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:56:39 -0700 (PDT)
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
Subject: [RFC/PATCH v4 39/49] odb-helper: add write_object_process()
Date:   Tue, 20 Jun 2017 09:55:13 +0200
Message-Id: <20170620075523.26961-40-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 odb-helper.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 73 insertions(+), 3 deletions(-)

diff --git a/odb-helper.c b/odb-helper.c
index b2d86a7928..e21113c0b8 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -383,6 +383,65 @@ static int read_object_process(struct odb_helper *o, const unsigned char *sha1,
 	return err;
 }
 
+static int write_object_process(struct odb_helper *o,
+				const void *buf, size_t len,
+				const char *type, unsigned char *sha1)
+{
+	int err;
+	struct read_object_process *entry;
+	struct child_process *process;
+	struct strbuf status = STRBUF_INIT;
+	const char *cmd = o->cmd;
+	uint64_t start;
+
+	start = getnanotime();
+
+	entry = launch_read_object_process(cmd);
+	process = &entry->subprocess.process;
+	o->supported_capabilities = entry->supported_capabilities;
+
+	if (!(ODB_HELPER_CAP_PUT & entry->supported_capabilities))
+		return -1;
+
+	sigchain_push(SIGPIPE, SIG_IGN);
+
+	err = packet_write_fmt_gently(process->in, "command=put\n");
+	if (err)
+		goto done;
+
+	err = packet_write_fmt_gently(process->in, "sha1=%s\n", sha1_to_hex(sha1));
+	if (err)
+		goto done;
+
+	err = packet_write_fmt_gently(process->in, "size=%"PRIuMAX"\n", len);
+	if (err)
+		goto done;
+
+	err = packet_write_fmt_gently(process->in, "kind=blob\n");
+	if (err)
+		goto done;
+
+	err = packet_flush_gently(process->in);
+	if (err)
+		goto done;
+
+	err = write_packetized_from_buf(buf, len, process->in);
+	if (err)
+		goto done;
+
+	subprocess_read_status(process->out, &status);
+	err = strcmp(status.buf, "success");
+
+done:
+	sigchain_pop(SIGPIPE);
+
+	err = check_object_process_error(err, status.buf, entry, cmd, ODB_HELPER_CAP_PUT);
+
+	trace_performance_since(start, "write_object_process");
+
+	return err;
+}
+
 struct odb_helper *odb_helper_new(const char *name, int namelen)
 {
 	struct odb_helper *o;
@@ -804,9 +863,9 @@ int odb_helper_for_each_object(struct odb_helper *o,
 	return 0;
 }
 
-int odb_helper_write_object(struct odb_helper *o,
-			    const void *buf, size_t len,
-			    const char *type, unsigned char *sha1)
+int odb_helper_write_plain_object(struct odb_helper *o,
+				  const void *buf, size_t len,
+				  const char *type, unsigned char *sha1)
 {
 	struct odb_helper_cmd cmd;
 
@@ -832,3 +891,14 @@ int odb_helper_write_object(struct odb_helper *o,
 	odb_helper_finish(o, &cmd);
 	return 0;
 }
+
+int odb_helper_write_object(struct odb_helper *o,
+			    const void *buf, size_t len,
+			    const char *type, unsigned char *sha1)
+{
+	if (o->script_mode) {
+		return odb_helper_write_plain_object(o, buf, len, type, sha1);
+	} else {
+		return write_object_process(o, buf, len, type, sha1);
+	}
+}
-- 
2.13.1.565.gbfcd7a9048

