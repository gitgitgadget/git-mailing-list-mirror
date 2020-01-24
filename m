Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3931C35241
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 03:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B632C22522
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 03:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LOXWf8wZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbgAXDfm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 22:35:42 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:47499 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729880AbgAXDfj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 22:35:39 -0500
Received: by mail-pl1-f202.google.com with SMTP id h3so435068plt.14
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 19:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KokYk1QYEDbftX+PB6HNSmTNk7153BXKySC1YaTHrRQ=;
        b=LOXWf8wZ/i7i2CstOUj3i0rgdQdqMcPuR0788TXS0klJ7zTy2ocPd1IJE0d4fmpbHX
         fJzoU//71rEwB7MDIXOvYIibVGYVn4kotGS0K004ybhYP2xlYYdmDs+18EYUeTe1pzJJ
         OQWVCFvwbKq3/lvG0iMz1HxxGe7lOKs3dunMKWcCSgWbd3EMSnU3GlFogkCLe8pJzg24
         q7gVgbTXcqD7LUEGAlR4BEZKBFs8CDTeiVFXLYxZ6jXlsutzSJVtes615hgBq3cYt9p4
         LOWG0N8euY2u4HGCZobnt2mDvbl0BDvDTwv7xCtoz7rpBRu9cEr9Ir77BnRId53jiGQe
         QZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KokYk1QYEDbftX+PB6HNSmTNk7153BXKySC1YaTHrRQ=;
        b=EECLCb2e5bJcRTEkpBj7FFlYCJiCXrR7MZd46L8g+olgP9i13HvZhohdHfAkk7Ud7V
         BhF7SlP1hVxCksrAOWj/UcL8dGL28C3bcXqyc4GDha7Ju39W0wCFh/ciyHVdvQEsi+mo
         CoLHH0BjsZQZHzDMoAHn/OcMIVDuR63TlmLvBv3cZmX2xg4boAm66X2LvGgYHcG1QtUZ
         4tlyfhGoJNozKlgwFeNz9Oo55sVzqMHKAb5Uh4ncazEGsWWmmeIduSVf0ATGUAyfeCa+
         /RjDuIoMbZmQtPR1+fBuXTYU3yTZf+XurTDGKDKkjF6MHZXNJQrLjIeqdegcSc4UpHvX
         7DZQ==
X-Gm-Message-State: APjAAAUfi7m2EHC+ICBkuD+959lIp74gaeA/gUrfDJ2OLRJqpdIUUQWf
        iZvBYm+v/qARwyJ2J/wcMNRDYxG3Jv62daUe/koIrrM0r5ClGNa9Uj0R1elmzNdJzKGC8i31NO6
        ZamU1WrHAhKhqAD7FJZhh2hnhjihcC5ohHvg53If3WK0n3DZvwJGRUHciHWhjexNlWC8dnGRYNA
        ==
X-Google-Smtp-Source: APXvYqzgl0omCiXT63yLHEjc+/H6GUTOQ8PU7PqoafvvRIwoVZqsy6Dt2LH02kDWmpIcie2xotk1u6CHa52ZJQl4uaU=
X-Received: by 2002:a63:2ac2:: with SMTP id q185mr1773993pgq.417.1579836938756;
 Thu, 23 Jan 2020 19:35:38 -0800 (PST)
Date:   Thu, 23 Jan 2020 19:34:33 -0800
In-Reply-To: <20200124033436.81097-1-emilyshaffer@google.com>
Message-Id: <20200124033436.81097-13-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200124033436.81097-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v5 12/15] bugreport: count loose objects
From:   emilyshaffer@google.com
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

The number of unpacked objects in a user's repository may help us
understand the root of the problem they're seeing, especially if a
command is running unusually slowly.

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
The refactor removed much of the code Dscho suggested; and yet it
remains true that he helped me while developing this commit (although
his suggestions didn't survive). Shall I leave the Helped-by line or
remove it?

 - Emily


 bugreport.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/bugreport.c b/bugreport.c
index 4c77009f1b..bf10857183 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -10,6 +10,7 @@
 #include "bugreport-config-safelist.h"
 #include "khash.h"
 #include "run-command.h"
+#include "object-store.h"
 
 static void get_curl_version_info(struct strbuf *curl_info)
 {
@@ -171,6 +172,48 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
 	}
 }
 
+static int loose_object_cb(const struct object_id *oid, const char *path,
+			   void *data) {
+	int *loose_object_count = data;
+
+	if (loose_object_count) {
+		(*loose_object_count)++;
+		return 0;
+	}
+
+	return 1;
+}
+
+static void get_loose_object_summary(struct strbuf *obj_info) {
+
+	int local_loose_object_count = 0, total_loose_object_count = 0;
+	int local_count_questionable = 0, total_count_questionable = 0;
+
+	local_count_questionable = for_each_loose_object(
+					loose_object_cb,
+					&local_loose_object_count,
+					FOR_EACH_OBJECT_LOCAL_ONLY);
+
+	total_count_questionable = for_each_loose_object(
+					loose_object_cb,
+					&total_loose_object_count,
+					0);
+
+	strbuf_addf(obj_info, "%d local loose objects%s\n",
+		    local_loose_object_count,
+		    local_count_questionable ? " (problem during count)" : "");
+
+	strbuf_addf(obj_info, "%d alternate loose objects%s\n",
+		    total_loose_object_count - local_loose_object_count,
+		    (local_count_questionable || total_count_questionable)
+			? " (problem during count)"
+			: "");
+
+	strbuf_addf(obj_info, "%d total loose objects%s\n",
+		    total_loose_object_count,
+		    total_count_questionable ? " (problem during count)" : "");
+}
+
 static const char * const bugreport_usage[] = {
 	N_("git bugreport [-o|--output <file>]"),
 	NULL
@@ -246,6 +289,9 @@ int cmd_main(int argc, const char **argv)
 	get_header(&buffer, "Configured Hooks");
 	get_populated_hooks(&buffer, nongit_ok);
 
+	get_header(&buffer, "Loose Object Counts");
+	get_loose_object_summary(&buffer);
+
 	report = fopen_for_writing(report_path.buf);
 	strbuf_write(&buffer, report);
 	fclose(report);
-- 
2.25.0.341.g760bfbb309-goog

