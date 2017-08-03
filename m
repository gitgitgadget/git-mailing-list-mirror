Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1909D2047F
	for <e@80x24.org>; Thu,  3 Aug 2017 09:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbdHCJUS (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 05:20:18 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33377 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752059AbdHCJUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 05:20:16 -0400
Received: by mail-wm0-f67.google.com with SMTP id q189so1447506wmd.0
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 02:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DG5P210zGnn5VOdl4NQG9lBD0GZzPexcThtDY9xzzto=;
        b=rowCqolGYZ1MUEj6jTuhmGuFY4saG4v3eYWehH4mBgeA6/BGAis0+BZ2fwWiaaFzE8
         xLb5DQX2ydmlNGeZLYyOaWKBZpfcI234ntuoncusLprJr2kLY6LKIasnV5UNxdFiIuNF
         78giBl9KvmRZgPfXBOMc4mT6r5FoJ8mmor9gcnKJVmhKVU0Jsq+GgBbVo8oUuBoOjBGZ
         WHf+c0SjoP8hw4lwKt1Xk9+uzK4mOtpVpBcGc5d8rk6nKphiuIKP4kJ5PaLcWNTyO5tT
         xzMLy0DmZR1BsVH0Qk7+e/0uJwyYR3mavR9XfGn9VUiKFbBBXKj4IcjGxiR2Sndnwm0+
         YZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DG5P210zGnn5VOdl4NQG9lBD0GZzPexcThtDY9xzzto=;
        b=OKDeQkY7iCnD42Pm8nSu+nJWRAAShqo4m56vCl1LvfOdq28CndoNasdtLTYao4rlRh
         9wGb03LNuAF3AnzfdgkNJROLK1PBn8y5oal6HAgca2mrutxoo/awARRmA4TEA5E0WCwt
         MHit28U7SsL1cRqmSu949Qe7c6eKGu4vW6pefy/+jHnZHS9nNCJqfQTmxQECXVhAwL12
         W0LvJrRIbx6Tk15VuQCOdfbiIeqEpDhTeosmHY9OtofA8mmzeESU0bSZmWwp2karsLZu
         M+9tQ5ZNXJEppw9XQYMnW6ArVxT1cc5G5U2MqoDJq4xd+nFxdzafgdyUFAZHYXFxxnan
         NhCQ==
X-Gm-Message-State: AIVw110ZgAaQcsPnhAsC7IaCV8MfhiLcAMV8FqRNJi5S3U8AiTFQq1cQ
        hto0AAtX4Qt6Lv5Q
X-Received: by 10.28.103.69 with SMTP id b66mr731319wmc.142.1501752014473;
        Thu, 03 Aug 2017 02:20:14 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id n184sm1308051wme.33.2017.08.03.02.20.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 02:20:14 -0700 (PDT)
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
Subject: [PATCH v5 30/40] odb-helper: add put_object_process()
Date:   Thu,  3 Aug 2017 11:19:16 +0200
Message-Id: <20170803091926.1755-31-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.0.rc1.52.gf02fb0ddac.dirty
In-Reply-To: <20170803091926.1755-1-chriscool@tuxfamily.org>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds the infrastructure to send objects to a sub-process
handling the communication with an external odb.

For now we only handle sending raw blobs using the 'put_raw_obj'
instruction.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 odb-helper.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 72 insertions(+), 3 deletions(-)

diff --git a/odb-helper.c b/odb-helper.c
index fce1dff501..db90c0a004 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -445,6 +445,58 @@ static int get_object_process(struct odb_helper *o, const unsigned char *sha1, i
 					  o->cmd, cur_cap);
 }
 
+static int send_put_packets(struct object_process *entry,
+			    const unsigned char *sha1,
+			    const void *buf,
+			    size_t len,
+			    struct strbuf *status)
+{
+	struct child_process *process = &entry->subprocess.process;
+	int err = packet_write_fmt_gently(process->in, "command=put_raw_obj\n");
+	if (err)
+		return err;
+
+	err = packet_write_fmt_gently(process->in, "sha1=%s\n", sha1_to_hex(sha1));
+	if (err)
+		return err;
+
+	err = packet_write_fmt_gently(process->in, "size=%"PRIuMAX"\n", len);
+	if (err)
+		return err;
+
+	err = packet_write_fmt_gently(process->in, "kind=blob\n");
+	if (err)
+		return err;
+
+	err = packet_flush_gently(process->in);
+	if (err)
+		return err;
+
+	err = write_packetized_from_buf(buf, len, process->in);
+	if (err)
+		return err;
+
+	return check_object_process_status(process->out, status);
+}
+
+static int put_object_process(struct odb_helper *o,
+			      const void *buf, size_t len,
+			      const char *type, unsigned char *sha1)
+{
+	int err;
+	struct object_process *entry;
+	struct strbuf status = STRBUF_INIT;
+
+	entry = launch_object_process(o, ODB_HELPER_CAP_PUT_RAW_OBJ);
+	if (!entry)
+		return -1;
+
+	err = send_put_packets(entry, sha1, buf, len, &status);
+
+	return check_object_process_error(err, status.buf, entry, o->cmd,
+					  ODB_HELPER_CAP_PUT_RAW_OBJ);
+}
+
 struct odb_helper *odb_helper_new(const char *name, int namelen)
 {
 	struct odb_helper *o;
@@ -896,9 +948,9 @@ int odb_helper_get_object(struct odb_helper *o,
 	return res;
 }
 
-int odb_helper_put_object(struct odb_helper *o,
-			  const void *buf, size_t len,
-			  const char *type, unsigned char *sha1)
+static int put_raw_object_script(struct odb_helper *o,
+				 const void *buf, size_t len,
+				 const char *type, unsigned char *sha1)
 {
 	struct odb_helper_cmd cmd;
 
@@ -924,3 +976,20 @@ int odb_helper_put_object(struct odb_helper *o,
 	odb_helper_finish(o, &cmd);
 	return 0;
 }
+
+int odb_helper_put_object(struct odb_helper *o,
+			  const void *buf, size_t len,
+			  const char *type, unsigned char *sha1)
+{
+	int res;
+	uint64_t start = getnanotime();
+
+	if (o->script_mode)
+		res = put_raw_object_script(o, buf, len, type, sha1);
+	else
+		res = put_object_process(o, buf, len, type, sha1);
+
+	trace_performance_since(start, "odb_helper_put_object");
+
+	return res;
+}
-- 
2.14.0.rc1.52.gf02fb0ddac.dirty

