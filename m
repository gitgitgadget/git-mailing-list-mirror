Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61BD51F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 02:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391300AbfJYCwN (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 22:52:13 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:53537 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732696AbfJYCwN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 22:52:13 -0400
Received: by mail-pf1-f202.google.com with SMTP id h2so755588pfr.20
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 19:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aZQXms7nJG+d3PXGj7MQD2IhqYwTjFVvl0TzUNRQbl4=;
        b=fA8NnQXc6wx1Ka58xuiCtfHdJm8M809kqEvm6buYtBKtqb4KEjedlRnbR1Fw148gAW
         zSgXNarRyoN4Wvqukw+bMQHQbWbZL33/gXR7BFmue6WWh2wYD0TJ1RYU3ODEi7U2PqSX
         pG3Xf7I7za7obzbkj8aeiokHSdk1bAKUZXQbsS/0LHvbeSKESLIso95+92HhQwkQJBg6
         qg3g5Ln/mIkcsUxU7FsuwYddSyexXC7OhWFDdkj/Tjq8ASCG49GjCkwDCxafOh0hpAGd
         qOEMJif/KMWbMIgTgH2itRY1WXZ74JGwrNicZNG1c4SAFTtL0mNtb7yEOAvkszZ0VE/V
         sGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aZQXms7nJG+d3PXGj7MQD2IhqYwTjFVvl0TzUNRQbl4=;
        b=ha5sQUn8UfWtS22DSfSEoXysv78cPWKliO9a1IbY7arEeQ5u3n2Yv0U3/m72CbOQD+
         SlCFGlkrxM3+/6w/bwmYSy7DmYV1KbZt7FqDnc8ESY8hgv3fHZ87NnVLNz32tjep7Qqf
         mLFAgEpygwB3uKCET7NN+TEeirxQvTIPLyzuBASVaJblSuXl6GDgfEoUkSA8X2gv7dhc
         gK0PCdPzd0gt7zCz+NJsQs6Lrkm9ZQFZXIB+7c7rW7Ln4IF2NbjQCEs6xkPQGehorlo6
         XRzLZWP8wFtv0Cbilx62mg2jBpdAXs+NRMMsyMc1vVskgKEkeGiBoaZAmA6P/uwGMJCh
         2Ukw==
X-Gm-Message-State: APjAAAX/uUrBraRKTc5l+B9OJDgqq3eN+YFVh8Eo6ExNWxwvZOf3D0O/
        Un7jTC0NfCbhgG0Iu2sBBkqli6xZJhj+4jieXJDIcJM+fF6Tmt3prbCD62jxkqJBXeNI1nUZE8E
        rigEAvbQNHBnOSu+A/fmG4oHNetY+nbCxVW2ZkVx77EtWEctvAx3vDwyMrAot30gPTky+qVUBpQ
        ==
X-Google-Smtp-Source: APXvYqzKRAN0TTMZ8lU+0Huic7RfUJOxnFjY0QI8tudb2ZrbDT8Ke8ah3P6GyuHK4Aj27mscKoPsPbZc5jH9rfBPIPI=
X-Received: by 2002:a63:4304:: with SMTP id q4mr1252641pga.218.1571971930857;
 Thu, 24 Oct 2019 19:52:10 -0700 (PDT)
Date:   Thu, 24 Oct 2019 19:51:29 -0700
In-Reply-To: <20191025025129.250049-1-emilyshaffer@google.com>
Message-Id: <20191025025129.250049-10-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20191025025129.250049-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v3 9/9] bugreport: print contents of alternates file
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In some cases, it could be that the user is having a problem with an
object which isn't present in their normal object directory. We can get
a hint that that might be the case by examining the list of alternates
where their object may be stored instead.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 bugreport.c         | 14 ++++++++++++++
 bugreport.h         |  6 ++++++
 builtin/bugreport.c |  4 ++++
 3 files changed, 24 insertions(+)

diff --git a/bugreport.c b/bugreport.c
index ce15904fec..a7bdc72b7f 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -298,3 +298,17 @@ void get_object_info_summary(struct strbuf *obj_info)
 		strbuf_complete_line(obj_info);
 	}
 }
+
+void get_alternates_file(struct strbuf *alternates_info)
+{
+	struct strbuf alternates_path = STRBUF_INIT;
+
+	strbuf_addstr(&alternates_path, get_object_directory());
+	strbuf_complete(&alternates_path, '/');
+	strbuf_addstr(&alternates_path, "info/alternates");
+
+	strbuf_reset(alternates_info);
+	strbuf_addbuf(alternates_info, &alternates_path);
+	strbuf_complete_line(alternates_info);
+	strbuf_read_file(alternates_info, alternates_path.buf, 0);
+}
diff --git a/bugreport.h b/bugreport.h
index 4f5e2d1b9a..74d1f79960 100644
--- a/bugreport.h
+++ b/bugreport.h
@@ -36,3 +36,9 @@ void get_packed_object_summary(struct strbuf *obj_info);
  * previous contents of hook_info will be discarded.
  */
 void get_object_info_summary(struct strbuf *obj_info);
+
+/**
+ * Adds the contents of '.git/info/alternates'. The previous contents of
+ * alternates_info will be discarded.
+ */
+void get_alternates_file(struct strbuf *alt_info);
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 8aad33a9b0..0784bdc42a 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -76,6 +76,10 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 	get_object_info_summary(&buffer);
 	strbuf_write(&buffer, report);
 
+	add_header(report, "Alternates File");
+	get_alternates_file(&buffer);
+	strbuf_write(&buffer, report);
+
 	// Close file
 	// open file in editor
 	launch_editor(report_path, NULL, NULL);
-- 
2.24.0.rc0.303.g954a862665-goog

