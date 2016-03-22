From: Stefan Beller <sbeller@google.com>
Subject: [RFC_PATCHv4 7/7] WIP status/diff: respect submodule.actionOnLabel
Date: Mon, 21 Mar 2016 19:06:12 -0700
Message-ID: <1458612372-10966-8-git-send-email-sbeller@google.com>
References: <1458612372-10966-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Jens.Lehmann@web.de, sschuberth@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 22 03:06:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiBiX-0000nu-Oq
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 03:06:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758229AbcCVCGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 22:06:38 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34381 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753978AbcCVCGe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 22:06:34 -0400
Received: by mail-pf0-f174.google.com with SMTP id x3so287823277pfb.1
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 19:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W8HA/MK2PdPUPhVRJpX5Dw04Un2QyKFRyiAnwgLFQuo=;
        b=PiXI8LnuLuL5oksGmVtm9cU9tJPvcVwZuZff0RGvXch6g15iiGu0vLo6k4appJ4n9Q
         5nx4yPuko+WW3FV78sPYOPCr0cp6dplM7lYjZrzRpzb+GK6Y/vmjk/fx0BLSoAZ8kAOD
         i1OZCvyGRegG7QeyVNERK6QZBLvQoj1hlySUHEZaPoVL/4AyLPfn2LXu5GKVl+yPqFyv
         MNiHmenFwfv5qFRRpqzJtLXVTbczfEWMhv3/riQjCWHeg3F03AhWNnx6qnO/2HldsxO5
         f0F0t8U3EFkGJSNRI1+sOVnPU3uXNtx9yVfr4lazkyZ55NRlPjZRElEkK0RYJdaGn53p
         IV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W8HA/MK2PdPUPhVRJpX5Dw04Un2QyKFRyiAnwgLFQuo=;
        b=lfRjAgIZiTBHe6zH/I9Jw0H2kzUY5gQ06k2iah3osziVBROh2EfaAK0Tm2eE+JH3g8
         3hNI6KKJ/tQ+TXKU7KHg1rMieDRMeoC9o+VLOZX0Mq6s44DhkwZGWSijDvQ/iLDDpawG
         qd4/FyLV2NnwRtLkFcyJ4GzwDoGn8pk+WpvHNhnjAgTjfhlKFEXQWFhQsgSQW4QnfqXa
         u7O4qydg8OLF5jwADfRXP7SbjV0H95UghRRlwhzBXU9j2YxMXa7uCWC29q+lM0PJqm5m
         f2oHZ1pr+YKO8GIUYUJHR+qr5I5F4pV/vCJr6SpXV27zwZlIS1mMaBUFZtHHMGcIwFrh
         PAyA==
X-Gm-Message-State: AD7BkJJZ1KF0h2Lcp8O6vMB7EVQ6WgavoXB0UlFYXJ6QB4NjoW0IqZfT2KIRgw59YQSaMSeh
X-Received: by 10.98.10.136 with SMTP id 8mr50481588pfk.67.1458612393609;
        Mon, 21 Mar 2016 19:06:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:f1b0:8994:3428:87f7])
        by smtp.gmail.com with ESMTPSA id ql1sm43667996pac.24.2016.03.21.19.06.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 21 Mar 2016 19:06:32 -0700 (PDT)
X-Mailer: git-send-email 2.7.0.rc0.45.g6b4c145
In-Reply-To: <1458612372-10966-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289486>

When 'submodule.actionOnLabel' is set, submodules which are selected by
a label will be inspected in status and diff. If a submodule is not
selected, it is ignored.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c                | 15 +++++++++++++++
 t/t7400-submodule-basic.sh | 13 +++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/submodule.c b/submodule.c
index 458189c..86c0a49 100644
--- a/submodule.c
+++ b/submodule.c
@@ -20,6 +20,8 @@ static struct string_list changed_submodule_paths;
 static int initialized_fetch_ref_tips;
 static struct sha1_array ref_tips_before_fetch;
 static struct sha1_array ref_tips_after_fetch;
+static struct string_list action_labels = STRING_LIST_INIT_DUP;
+static int use_action_labels;
 
 /*
  * The following flag is set if the .gitmodules file is unmerged. We then
@@ -161,10 +163,20 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 {
 	const struct submodule *submodule = submodule_from_path(null_sha1, path);
 	if (submodule) {
+		char *ignoreMode;
 		if (submodule->ignore)
 			handle_ignore_submodules_arg(diffopt, submodule->ignore);
 		else if (gitmodules_is_unmerged)
 			DIFF_OPT_SET(diffopt, IGNORE_SUBMODULES);
+
+		if (!use_action_labels)
+			return;
+
+		if (submodule_applicable_by_labels(&action_labels, submodule))
+			ignoreMode = "none";
+		else
+			ignoreMode = "all";
+		handle_ignore_submodules_arg(diffopt, ignoreMode);
 	}
 }
 
@@ -175,6 +187,9 @@ int submodule_config(const char *var, const char *value, void *cb)
 		if (parallel_jobs < 0)
 			die(_("negative values not allowed for submodule.fetchJobs"));
 		return 0;
+	} else if (!strcmp(var, "submodule.actiononlabel")) {
+		use_action_labels = 1;
+		string_list_append(&action_labels, value);
 	} else if (starts_with(var, "submodule."))
 		return parse_submodule_config_option(var, value);
 	else if (!strcmp(var, "fetch.recursesubmodules")) {
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 58da5c4..52ea3c6 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1281,4 +1281,17 @@ test_expect_success 'clone and subsequent updates correctly auto-initialize subm
 	test_cmp actual expected2
 '
 
+test_expect_success 'status ignores unlabeled submodules' '
+	# Add submodules with and without label
+	# perform a change on disk
+	# observe the change indicated by git status
+	# the submodule not in the label system is ignored.
+	true && true
+'
+
+test_expect_success 'diff applies to action-on-label selection' '
+	# similar to status
+	true && true
+'
+
 test_done
-- 
2.7.0.rc0.45.g6b4c145
