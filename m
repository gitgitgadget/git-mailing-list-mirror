Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72939C35240
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 03:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324FF22522
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 03:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GLL5khmF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbgAXDfm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 22:35:42 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:48328 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730002AbgAXDfl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 22:35:41 -0500
Received: by mail-pg1-f202.google.com with SMTP id c8so570168pgl.15
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 19:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WvPVNv9YPSMDwsZTnnax5OM3yhXCWMqhegtg+6rIqyk=;
        b=GLL5khmFkHOPmi8XMuUXvxjIrVk+OXNLZm1bGZy1ET8XAScgkvlsP+IGB1p31nRyS6
         qJHxpMsKJoHIuqD/BPwlwuxYae7Y34FttthLssSljyxFzclCfCy50U/q+9LxgvQxaBet
         zBpJgbrylbbShAmhqUT1mFzooQJQcNPxVSXUKTWY2KED7/4lvC1Z4jbZfW93RORpDpBl
         /2lYqt7timKa+ApTM9ImKdUgqItCT+mm4PzRCo4LBFko/18IvWuOaB4dofQ1PqRW0yS5
         8riJcBS4O2BVxlE5pWnsdycZFJcYrBQisUdUWtsGhZwEB2eElC4dR6yjmk7mcgDqiXaL
         GhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WvPVNv9YPSMDwsZTnnax5OM3yhXCWMqhegtg+6rIqyk=;
        b=pJubx2KrqEw9iWEdpH0Mo2X4BkW3cpG7FnFNQstcxFYQ7xsmWeP95ch1cmTKBYkBhK
         N5NUA2e5yQZqjUazr38QMq1Aup1OJWQYpi2yWaJW1aH7YMwXgeHSvwK42Pf4YOUyJ/eI
         VTuTT4ePmE7kAkevlfm3JttbfCBfyu3BiKKM/4XFrXLFvYgBGHvsmhwBOkBD5YsSWaoV
         9rTlCATy38H7ry9OqeoQClZXaAf9qupJUIV1uCs0dpeb1XFi2FG2tjRW14o9O6sxJY6q
         mJOjxISZJKvj6hqsmojeHNZIz37BYm3+z/BscdjeY1VYbObNDXJLxFQRE7In2yKK6UMF
         IoCw==
X-Gm-Message-State: APjAAAV3o3rDg4/bPvVW0IpQ1/Y2blHMHSEag1xLguaUZJtDKI3fQGaT
        7uqlKLAPSpXr/qpIRAbw3fO91Hwzlr5rQjUCrWRoh4Dyu8f2/F+aKJvbB19ej2bS4KfrRZDBzzj
        Xd1DVAFUdEJ39pL8UmbUQR4McXjQx7yBKbdfU0fJz2d61eKfS2RJhuMsyeZRU71DL4ajqfcqiDQ
        ==
X-Google-Smtp-Source: APXvYqwsNUgc24Fl3LiOnezxMeoosIzmKCYYduEsohimAL/+ie4cEljT3J6zksTOfecIPSt6pCEZc019ZHZ2BWG5ztk=
X-Received: by 2002:a65:4d0b:: with SMTP id i11mr1876227pgt.340.1579836941150;
 Thu, 23 Jan 2020 19:35:41 -0800 (PST)
Date:   Thu, 23 Jan 2020 19:34:34 -0800
In-Reply-To: <20200124033436.81097-1-emilyshaffer@google.com>
Message-Id: <20200124033436.81097-14-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200124033436.81097-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v5 13/15] bugreport: add packed object summary
From:   emilyshaffer@google.com
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Alongside the loose object counts, it can be useful to show the number
of packs and packed objects. This way we can check whether the repo has
an appropriate ratio of packed to loose objects to help determine
whether it's behaving correctly.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 bugreport.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/bugreport.c b/bugreport.c
index bf10857183..45cc1764e0 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -214,6 +214,41 @@ static void get_loose_object_summary(struct strbuf *obj_info) {
 		    total_count_questionable ? " (problem during count)" : "");
 }
 
+struct packed_object_cb_data {
+	struct packed_git *last_pack;
+	int pack_count;
+	int object_count;
+};
+
+static int packed_object_cb(const struct object_id *oid,
+			    struct packed_git *pack,
+			    uint32_t pos,
+			    void *data) {
+	struct packed_object_cb_data *cb_data = data;
+
+	if (!cb_data)
+		return 1;
+
+	if (pack && pack != cb_data->last_pack) {
+		cb_data->last_pack = pack;
+		cb_data->pack_count++;
+	}
+
+	cb_data->object_count++;
+
+	return 0;
+}
+
+static void get_packed_object_summary(struct strbuf *obj_info)
+{
+	struct packed_object_cb_data cb_data = {NULL, 0, 0};
+
+	for_each_packed_object(packed_object_cb, &cb_data, 0);
+
+	strbuf_addf(obj_info, "%d total packs (%d objects)\n",
+		    cb_data.pack_count, cb_data.object_count);
+}
+
 static const char * const bugreport_usage[] = {
 	N_("git bugreport [-o|--output <file>]"),
 	NULL
@@ -292,6 +327,9 @@ int cmd_main(int argc, const char **argv)
 	get_header(&buffer, "Loose Object Counts");
 	get_loose_object_summary(&buffer);
 
+	get_header(&buffer, "Packed Object Summary");
+	get_packed_object_summary(&buffer);
+
 	report = fopen_for_writing(report_path.buf);
 	strbuf_write(&buffer, report);
 	fclose(report);
-- 
2.25.0.341.g760bfbb309-goog

