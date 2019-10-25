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
	by dcvr.yhbt.net (Postfix) with ESMTP id 51CBE1F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 02:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391266AbfJYCwE (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 22:52:04 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:39415 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732696AbfJYCwE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 22:52:04 -0400
Received: by mail-pf1-f202.google.com with SMTP id l20so776773pff.6
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 19:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=djyI6SNlQ0jDLXCD3DOue9Fp7Psc2/wAxoMej5JQWjI=;
        b=Oeo1AmxbP8dRMTaljvpr+2ulSQrr3cdxw3Vs82WEgyW2UEg0WCdRZay1ddrNM+7O7q
         sZ/vhkpGgcbWafca8V3Rp6FFFPGffmD/iKRGc5e6lIrB20kNIvhrM3pNmGLO0sYfe3uH
         Bg63n6Ix1raxxUmd8/TlOuRStO28wdiXip2AafvBnqXRhWlZ43dx2FxYcYzMUJx5QHxM
         8V7rijEFov8pn0awu830nxLIeVtl1Nvpkfsl6uouj+rcZzksUytI5TBQlLXnuv1kbOt3
         7UFFuEkIrbPIYemt4mvDHnVNgMa6iTU7b5krGyYWo2T9shXbHJOrv56uDDR5EFd5CBLD
         qkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=djyI6SNlQ0jDLXCD3DOue9Fp7Psc2/wAxoMej5JQWjI=;
        b=DQRkra1GBUaDJ6CyNtKjbYLnV6CAjzV/mSAl+VbkkgMHop+XQBNaG756i9VlxKSSsc
         iSzLBg7unnxk4rVnID9vRVO8WCUxLN9Yu+rCeKN0TkyRbAw+B8enWsYr5SkcDIj0fjbS
         jWYnOWcfe6utept0LaT6lBCIiyLJQYmAI/Qry11jSkt2JBR3IsSNo8dazKEsvgFSywsT
         Jd3xcHy5/cKaLgxrjgym2cxPgLWDc1Mee6lUuh1LsUjQt6GUV8YGc6ShB/uxQBgpCEsY
         vX3IJNVe8FPXKllCicsI5k0ngM+19ArMETLU9d9UIChVj0sbvXmQG//hjg7WHyEVRzBT
         5ueQ==
X-Gm-Message-State: APjAAAW7zR/wJLKnPL5GH9O3xklUci7parJvv/p4fAcp7S2bCxPPlUvl
        GJs4+J2vlh0od9Fo52mrC07S4WX6lQqEaZ7mzQk4LoX2+LiUwiutsGqpvnWDDwBC4CySI7BTu+b
        7PxGk/QHGGK1nIOeP5otvoUjpP8ih8qh7mkO4oTvghSRfR/j4PivT8rDYxrr1Sd0fgWJukvsnFA
        ==
X-Google-Smtp-Source: APXvYqxteAZHBLlOzNCWnLra/tP7eq9hdovAl1JHdRFQ7qUvFhTgnrl9J08+pnjNKc39wmlCKfnBNMdVtqCe4vAXbEA=
X-Received: by 2002:a63:df42:: with SMTP id h2mr1347789pgj.405.1571971923372;
 Thu, 24 Oct 2019 19:52:03 -0700 (PDT)
Date:   Thu, 24 Oct 2019 19:51:27 -0700
In-Reply-To: <20191025025129.250049-1-emilyshaffer@google.com>
Message-Id: <20191025025129.250049-8-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20191025025129.250049-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v3 7/9] bugreport: add packed object summary
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alongside the list of loose objects, it's useful to see the list of
object packs as well. It can help us to examine what Git did and did not
pack.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 bugreport.c         | 21 +++++++++++++++++++++
 bugreport.h         |  6 ++++++
 builtin/bugreport.c |  4 ++++
 3 files changed, 31 insertions(+)

diff --git a/bugreport.c b/bugreport.c
index 54e1d47103..79ddb8baaa 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -219,3 +219,24 @@ void get_loose_object_summary(struct strbuf *obj_info)
 			    objects.nr);
 	}
 }
+
+void get_packed_object_summary(struct strbuf *obj_info)
+{
+	struct strbuf dirpath = STRBUF_INIT;
+	struct string_list contents = STRING_LIST_INIT_DUP;
+	struct string_list_item *entry;
+
+	strbuf_reset(obj_info);
+
+	strbuf_addstr(&dirpath, get_object_directory());
+	strbuf_complete(&dirpath, '/');
+	strbuf_addstr(&dirpath, "pack/");
+	list_contents_of_dir(&contents, &dirpath, 0, 0);
+
+	// list full contents of $GIT_OBJECT_DIRECTORY/pack/
+	for_each_string_list_item(entry, &contents) {
+		strbuf_addbuf(obj_info, &dirpath);
+		strbuf_addstr(obj_info, entry->string);
+		strbuf_complete_line(obj_info);
+	}
+}
diff --git a/bugreport.h b/bugreport.h
index 09ad0c2599..11ff7df41b 100644
--- a/bugreport.h
+++ b/bugreport.h
@@ -24,3 +24,9 @@ void get_populated_hooks(struct strbuf *hook_info);
  * will be discarded.
  */
 void get_loose_object_summary(struct strbuf *obj_info);
+
+/**
+ * Adds a list of the contents of '.git/objects/pack'. The previous contents of
+ * hook_info will be discarded.
+ */
+void get_packed_object_summary(struct strbuf *obj_info);
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index b2ab194207..da91a3944e 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -68,6 +68,10 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 	get_loose_object_summary(&buffer);
 	strbuf_write(&buffer, report);
 
+	add_header(report, "Packed Object Summary");
+	get_packed_object_summary(&buffer);
+	strbuf_write(&buffer, report);
+
 	fclose(report);
 
 	launch_editor(report_path.buf, NULL, NULL);
-- 
2.24.0.rc0.303.g954a862665-goog

