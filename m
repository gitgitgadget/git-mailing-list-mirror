Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E217420401
	for <e@80x24.org>; Fri, 16 Jun 2017 04:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750947AbdFPEbI (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 00:31:08 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:33571 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750866AbdFPEbH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 00:31:07 -0400
Received: by mail-it0-f66.google.com with SMTP id g184so1191571ita.0
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 21:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lpS5RdaKN6LugvglI7R/FcE3J5YyijhYxt5XY3s+0zc=;
        b=j7uil0FO2FiDzPpbqR7/y/YxMXEPhFVgdJ+xZSY6Yjiswnv7tXW04KLN3YfWMjWgnC
         SndYAgV+iWaKZa6TUHQvp42hW9RnvGw9pXa/StHL+MdJFJHmUee9eXmqOzJLfr6Z9eX4
         uHXaT4BsIzavmf2eMiBVIWn+pDQQpsgzWPGWAs1FMuT0RwpTK2AmrbzzrykeUHaxZVCX
         5+rnf99hFIJEwp+UqKV9cHB48/fXfHvtXv3MetXxccLD+qb6gqDwYFq1bz8gCvzv7/2+
         qR/x5WMSamvGMNHGvSXk5SMiwNJvMDOlxvMCpCPvbzKqyEe6b2zaEqm0aJehGKSjTHn4
         OjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lpS5RdaKN6LugvglI7R/FcE3J5YyijhYxt5XY3s+0zc=;
        b=bcuq8qYh5NNueT8r2OMGT9XFrNShEb5L+K7f/wpjBpyZJIUQ/IeGxVA8bz8gxumkgN
         XhgfylTKb/zGjXgAGWaUkC7tOBHCJW8c4YbuLeV0K/fD34Ru2nmcTHZS/nF4Th9f5rCl
         4jDI4hqpcXecYnL28A+lrVL6sTIiaJqvzI9XPp6d67RmvcBvBrbHbgKUBKUaTARTlts9
         DFUSp23bZgAEuQdaC4REEs9rXC6xykVxrZckTi6V4ByQNp4K69MRe6BNf66q9ddl925C
         Cc+pcVUTuV4DC6QgtwjPcYZnShe2NapzAwK3TCH28PFWVGEcm6cJTGzWxeX1sbqBlywI
         DB+w==
X-Gm-Message-State: AKS2vOxhv75I8RTVsoKEODZ3YksjpB7BUwS7a1uJ7wtksOSVX7t8kx//
        xzh6LXpqG2iwCfnWrBw=
X-Received: by 10.36.108.131 with SMTP id w125mr8719348itb.91.1497587466800;
        Thu, 15 Jun 2017 21:31:06 -0700 (PDT)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id p22sm627405iod.22.2017.06.15.21.31.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Jun 2017 21:31:05 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, houstonfortney@gmail.com, kostix+git@007spb.ru,
        peff@peff.net, sxlijin@gmail.com,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH 2/3] wt-status: add optional stash status information
Date:   Fri, 16 Jun 2017 00:30:49 -0400
Message-Id: <20170616043050.29192-3-liambeguin@gmail.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <20170616043050.29192-1-liambeguin@gmail.com>
References: <20170616043050.29192-1-liambeguin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the `status.showStash` configuration option to allow git-status to
show information about currently stashed entries.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 Documentation/config.txt |  5 +++++
 wt-status.c              | 24 ++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 23b807065d92..e83b0f641574 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2992,6 +2992,11 @@ status.displayCommentPrefix::
 	behavior of linkgit:git-status[1] in Git 1.8.4 and previous.
 	Defaults to false.
 
+status.showStash::
+	If set to true, linkgit:git-status[1] will display the number of
+	entries currently stashed away.
+	Defaults to false.
+
 status.showUntrackedFiles::
 	By default, linkgit:git-status[1] and linkgit:git-commit[1] show
 	files which are not currently tracked by Git. Directories which
diff --git a/wt-status.c b/wt-status.c
index bf651f16fae8..7114eec123c8 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -801,6 +801,27 @@ static void wt_longstatus_print_changed(struct wt_status *s)
 	wt_longstatus_print_trailer(s);
 }
 
+static int stash_count_refs(struct object_id *ooid, struct object_id *noid,
+			    const char *email, timestamp_t timestamp, int tz,
+			    const char *message, void *cb_data)
+{
+	int *c = cb_data;
+	(*c)++;
+	return 0;
+}
+
+static void wt_longstatus_print_stash_summary(struct wt_status *s)
+{
+	int stash_count = 0;
+
+	for_each_reflog_ent("refs/stash", stash_count_refs, &stash_count);
+	if (stash_count > 0)
+		status_printf_ln(s, GIT_COLOR_NORMAL,
+				 Q_("Your stash currently has %d entry",
+				    "Your stash currently has %d entries", stash_count),
+				 stash_count);
+}
+
 static void wt_longstatus_print_submodule_summary(struct wt_status *s, int uncommitted)
 {
 	struct child_process sm_summary = CHILD_PROCESS_INIT;
@@ -1537,6 +1558,7 @@ static void wt_longstatus_print(struct wt_status *s)
 	const char *branch_color = color(WT_STATUS_ONBRANCH, s);
 	const char *branch_status_color = color(WT_STATUS_HEADER, s);
 	struct wt_status_state state;
+	int show_stash = 0;
 
 	memset(&state, 0, sizeof(state));
 	wt_status_get_state(&state,
@@ -1642,6 +1664,8 @@ static void wt_longstatus_print(struct wt_status *s)
 		} else
 			printf(_("nothing to commit, working tree clean\n"));
 	}
+	if (!git_config_get_bool("status.showStash", &show_stash) && show_stash)
+		wt_longstatus_print_stash_summary(s);
 }
 
 static void wt_shortstatus_unmerged(struct string_list_item *it,
-- 
2.9.4

