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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3121B1F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 02:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391226AbfJYCv5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 22:51:57 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:33365 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732696AbfJYCv5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 22:51:57 -0400
Received: by mail-pg1-f202.google.com with SMTP id g187so661565pgc.0
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 19:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bP6thc16j4zFuCStHrLp95eyVnwkGKKniBg+7jQB8PU=;
        b=tEQKronj8D9JGjbsw+6qWfvFJKyQXrehpQ3p714vWFwdBLWhPDZvAVGpfZaJGHmQz9
         ipV+Ws05cyXP/2+B1zebWncsmmEcdnFre7WOHdFq4LHRIDgb08BCOeThFZ/5097dXRgn
         18+4B22kWLiOwqtOD3pBtW7tuNYL1usRSomg+mIPXT4VeGrbLOFtjOanwsVQ8MzVIRjg
         /vZd+05T1pKmWO5DQwnud7SNYpHP4mHWqtkMuRkFmKeZTXRhPoRBCuLp/9S2DagtqLt8
         DPwjq6CvUpaF4mvoy2kA/21lPxft5maMK3W44CWMOroIh8Cps8LNIycPqZQHPAyZmA4w
         38jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bP6thc16j4zFuCStHrLp95eyVnwkGKKniBg+7jQB8PU=;
        b=CSZkWpij82rxNBDoJMC3DpU02NF4LOdvPc7eUNxkI4MsVOHdl/NIPjl64Ms/60CDtX
         SlPIVWDxsUmmBbVxU5WrBAUbP+lQlHNWgSVtCsx8lT5YJ6c3Ck7/R1AZvzFnTDvSWRxG
         J7r1MlT/+TRfeDsSemPQbI1EpQM7o9bqQzkZzmT9xdwUgmCcnDVJ2r/UDIhm9aYwokbK
         q2WSdyKPhf8EBnFWQrABtiqOCP4rKsrrBJpEzA71A6RV/7PSUS9jtxo0EAOLWw+YNima
         WKzaDnmvXhNiwbBsgMESZmWJBwIDBn5bz7UfoZkJJ7C9VyffAfwXfns0xDS9ovKdNfyX
         4ShA==
X-Gm-Message-State: APjAAAUUXAyzVtw+qoC7+X9sIFhGVN34Kziaul9gay96z26EikeBCuog
        U215lkI8j9m4EPF4SNpPqyOIBCt1lmNn5n1y+ujQYRTVmzHFW2rLvwv+nXSCtIuTv06mufOb3Qs
        UG71QVfM6X+1bFhP6ho6NVcZrEtWRZ1QJLCTzmx7IjbbzPzoxk5jTBwVY8KPRy8u6jW1uLLbE9w
        ==
X-Google-Smtp-Source: APXvYqxTRsL8OaBhevdbh+ccDVwSRAVwM8ZyBHXa4K0zjyxJAXNUHPI5x/1RY/HYMLWscQzJK5FxooN1olVyq5msMWk=
X-Received: by 2002:a63:d26:: with SMTP id c38mr1476218pgl.84.1571971915917;
 Thu, 24 Oct 2019 19:51:55 -0700 (PDT)
Date:   Thu, 24 Oct 2019 19:51:25 -0700
In-Reply-To: <20191025025129.250049-1-emilyshaffer@google.com>
Message-Id: <20191025025129.250049-6-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20191025025129.250049-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v3 5/9] bugreport: collect list of populated hooks
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Occasionally a failure a user is seeing may be related to a specific
hook which is being run, perhaps without the user realizing. While the
contents of hooks can be sensitive - containing user data or process
information specific to the user's organization - simply knowing that a
hook is being run at a certain stage can help us to understand whether
something is going wrong.

Without a definitive list of hook names within the code, we compile our
own list from the documentation. This is likely prone to bitrot. To
reduce the amount of code humans need to read, we turn the list into a
string_list and iterate over it (as we are calling the same find_hook
operation on each string). However, since bugreport should primarily be
called by the user, the performance loss from massaging the string
seems acceptable.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 bugreport.c         | 44 ++++++++++++++++++++++++++++++++++++++++++++
 bugreport.h         |  6 ++++++
 builtin/bugreport.c |  4 ++++
 3 files changed, 54 insertions(+)

diff --git a/bugreport.c b/bugreport.c
index afa4836ab1..9d7f44ff28 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -103,3 +103,47 @@ void get_whitelisted_config(struct strbuf *config_info)
 	strbuf_reset(config_info);
 	strbuf_addbuf(config_info, &configs_and_values);
 }
+
+void get_populated_hooks(struct strbuf *hook_info)
+{
+	/*
+	 * Doesn't look like there is a list of all possible hooks; so below is
+	 * a transcription of `git help hook`.
+	 */
+	const char *hooks = "applypatch-msg,"
+			    "pre-applypatch,"
+			    "post-applypatch,"
+			    "pre-commit,"
+			    "pre-merge-commit,"
+			    "prepare-commit-msg,"
+			    "commit-msg,"
+			    "post-commit,"
+			    "pre-rebase,"
+			    "post-checkout,"
+			    "post-merge,"
+			    "pre-push,"
+			    "pre-receive,"
+			    "update,"
+			    "post-receive,"
+			    "post-update,"
+			    "push-to-checkout,"
+			    "pre-auto-gc,"
+			    "post-rewrite,"
+			    "sendemail-validate,"
+			    "fsmonitor-watchman,"
+			    "p4-pre-submit,"
+			    "post-index-changex";
+	struct string_list hooks_list = STRING_LIST_INIT_DUP;
+	struct string_list_item *iter = NULL;
+
+	strbuf_reset(hook_info);
+
+	string_list_split(&hooks_list, hooks, ',', -1);
+
+	for_each_string_list_item(iter, &hooks_list) {
+		if (find_hook(iter->string)) {
+			strbuf_addstr(hook_info, iter->string);
+			strbuf_complete_line(hook_info);
+		}
+	}
+}
diff --git a/bugreport.h b/bugreport.h
index 7413e7e1be..942a5436e3 100644
--- a/bugreport.h
+++ b/bugreport.h
@@ -12,3 +12,9 @@ void get_system_info(struct strbuf *sys_info);
  * config_info will be discarded.
  */
 void get_whitelisted_config(struct strbuf *sys_info);
+
+/**
+ * Adds the paths to all configured hooks (but not their contents). The previous
+ * contents of hook_info will be discarded.
+ */
+void get_populated_hooks(struct strbuf *hook_info);
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 70fe0d2b85..a0eefba498 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -60,6 +60,10 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 	get_whitelisted_config(&buffer);
 	strbuf_write(&buffer, report);
 
+	add_header(report, "Populated Hooks");
+	get_populated_hooks(&buffer);
+	strbuf_write(&buffer, report);
+
 	fclose(report);
 
 	launch_editor(report_path.buf, NULL, NULL);
-- 
2.24.0.rc0.303.g954a862665-goog

