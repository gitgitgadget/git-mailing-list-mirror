Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63FF920954
	for <e@80x24.org>; Fri,  1 Dec 2017 22:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751444AbdLAWuX (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 17:50:23 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:44288 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbdLAWuW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 17:50:22 -0500
Received: by mail-io0-f194.google.com with SMTP id w127so12886517iow.11
        for <git@vger.kernel.org>; Fri, 01 Dec 2017 14:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ReVj2W7Hzh0xG4YWPyIK7QGZ6J6SaXIjn0QcHhz4fYM=;
        b=jQUsC3SRsMcBpya7dueXzZQHKOsqFjp/UpX2xaC6+6dyBVcxk95rLICLdMVstmLZrs
         dhmgxr+Ka//lnAKPz9p/jgl1aiBj+gLX5i8NsLiXjBnrPFeUNdmDtnpAQdrF2U5jxt5Y
         wJHRxGxcO6e6ofdh5h4NZ8GbnlkSH75DxXqBi1NgE2BFik6P2Vcp3wYk316Whm0uHBXI
         rpHkKwjid/QqMlTQad2+YgGsypNh71Rvi4Deg4l3bfKCmiAg1a9qT2q+wI1NPD0xLJCN
         +9IpkvwFC6p5zItu+5TcD6PiXeOxGCM1aUYj1P/HVWIS45YIVjnSUTRcPENz/j9fwMjZ
         8+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ReVj2W7Hzh0xG4YWPyIK7QGZ6J6SaXIjn0QcHhz4fYM=;
        b=KHFNwyCaX/T04e9uaHZbapfOqne32jQ/dzRoHNCk0MSHWD69317aYs7NrdntOtkqkf
         bHDNeBHtYeDtXM0qTCzaK2NIZKT5jesoXvU59tknBWNlPPH8owa97dhKMZ+BMMKGhPZz
         sRmU98NIrYCH5is8KrPasIc1eYDDL0hsUFfsd8CvRY/Hr5lKGnd6pCAGwnvd8k4khTPD
         SkYbLDVmjMKxEBkw7ozFd9cWY1ubGlMdPOF9Er7f23OCKl/9c0ej+XkQ9VDeHzN96MXS
         uJUs0aKKxQIbvOA2rFK4+F3swRbNc1VLnhgR4nSAvurdFwawGEw3Cvmvhrft4UfW/gdB
         J52g==
X-Gm-Message-State: AJaThX5ejI7D08mLNxHuuSP4BLUZWZVwr6Be5d7DlAx/Cxv+lDpzvut0
        9cvWa+bMTLFs4BY7rNSnGGaU5cPtEr8=
X-Google-Smtp-Source: AGs4zMYca0M2CjgNQKr9QY5I/kArMVYffe2b+RGL4uMrudDYrKtj4n0RjybJWbCEvbyiBPkU1HhLAg==
X-Received: by 10.107.17.149 with SMTP id 21mr15304094ior.203.1512168621423;
        Fri, 01 Dec 2017 14:50:21 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([100.96.218.44])
        by smtp.gmail.com with ESMTPSA id p17sm3420475iod.15.2017.12.01.14.50.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Dec 2017 14:50:20 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, jacob.keller@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [WIP 1/2] submodule: refactor acquisition of superproject info
Date:   Fri,  1 Dec 2017 14:50:06 -0800
Message-Id: <14e821d45e4ac2faea1f9023d43c43c4675672e7.1512168087.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.15.1.273.g588edb5b8.dirty
In-Reply-To: <cover.1512168087.git.jonathantanmy@google.com>
References: <cover.1512168087.git.jonathantanmy@google.com>
In-Reply-To: <cover.1512168087.git.jonathantanmy@google.com>
References: <cover.1512168087.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 submodule.c | 76 +++++++++++++++++++++++++++++++++++++------------------------
 submodule.h |  3 +++
 2 files changed, 49 insertions(+), 30 deletions(-)

diff --git a/submodule.c b/submodule.c
index bb531e0e5..ce511180e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1977,16 +1977,24 @@ void absorb_git_dir_into_superproject(const char *prefix,
 	}
 }
 
-const char *get_superproject_working_tree(void)
+/*
+ * Get the full filename of the gitlink entry corresponding to the
+ * superproject having this repo as a submodule.
+ *
+ * full_name will point to an internal buffer upon success.
+ *
+ * Return 0 if successful, 1 if not (for example, if the parent
+ * directory is not a repo or an unrelated one).
+ */
+int get_superproject_entry(const char **full_name)
 {
+	static struct strbuf sb = STRBUF_INIT;
+
 	struct child_process cp = CHILD_PROCESS_INIT;
-	struct strbuf sb = STRBUF_INIT;
 	const char *one_up = real_path_if_valid("../");
 	const char *cwd = xgetcwd();
-	const char *ret = NULL;
 	const char *subpath;
 	int code;
-	ssize_t len;
 
 	if (!is_inside_work_tree())
 		/*
@@ -1994,11 +2002,15 @@ const char *get_superproject_working_tree(void)
 		 * We might have a superproject, but it is harder
 		 * to determine.
 		 */
-		return NULL;
+		return 1;
 
 	if (!one_up)
-		return NULL;
+		return 1;
 
+	/*
+	 * No need to reset sb, since relative_path() will do it if
+	 * necessary.
+	 */
 	subpath = relative_path(cwd, one_up, &sb);
 
 	prepare_submodule_repo_env(&cp.env_array);
@@ -2017,45 +2029,49 @@ const char *get_superproject_working_tree(void)
 	if (start_command(&cp))
 		die(_("could not start ls-files in .."));
 
-	len = strbuf_read(&sb, cp.out, PATH_MAX);
+	strbuf_read(&sb, cp.out, PATH_MAX);
 	close(cp.out);
 
-	if (starts_with(sb.buf, "160000")) {
-		int super_sub_len;
-		int cwd_len = strlen(cwd);
-		char *super_sub, *super_wt;
+	code = finish_command(&cp);
 
+	if (starts_with(sb.buf, "160000")) {
 		/*
 		 * There is a superproject having this repo as a submodule.
 		 * The format is <mode> SP <hash> SP <stage> TAB <full name> \0,
 		 * We're only interested in the name after the tab.
 		 */
-		super_sub = strchr(sb.buf, '\t') + 1;
-		super_sub_len = sb.buf + sb.len - super_sub - 1;
-
-		if (super_sub_len > cwd_len ||
-		    strcmp(&cwd[cwd_len - super_sub_len], super_sub))
-			die (_("BUG: returned path string doesn't match cwd?"));
-
-		super_wt = xstrdup(cwd);
-		super_wt[cwd_len - super_sub_len] = '\0';
-
-		ret = real_path(super_wt);
-		free(super_wt);
+		char *tab = strchr(sb.buf, '\t');
+		if (!tab)
+			die("BUG: ls-files returned line with no tab");
+		*full_name = tab + 1;
+		return 0;
 	}
-	strbuf_release(&sb);
-
-	code = finish_command(&cp);
 
 	if (code == 128)
 		/* '../' is not a git repository */
-		return NULL;
-	if (code == 0 && len == 0)
+		return 1;
+	if (code == 0)
 		/* There is an unrelated git repository at '../' */
+		return 1;
+	die(_("ls-tree returned unexpected return code %d"), code);
+}
+
+const char *get_superproject_working_tree(void)
+{
+	const char *full_name;
+	char *super_wt;
+	size_t len;
+	const char *ret;
+
+	if (get_superproject_entry(&full_name))
 		return NULL;
-	if (code)
-		die(_("ls-tree returned unexpected return code %d"), code);
 
+	super_wt = xstrdup(xgetcwd());
+	if (!strip_suffix(super_wt, full_name, &len))
+		die("BUG: returned path string doesn't match cwd?");
+	super_wt[len] = '\0';
+	ret = real_path(super_wt);
+	free(super_wt);
 	return ret;
 }
 
diff --git a/submodule.h b/submodule.h
index f0da0277a..29ab302cc 100644
--- a/submodule.h
+++ b/submodule.h
@@ -134,6 +134,9 @@ extern void absorb_git_dir_into_superproject(const char *prefix,
  * Return the absolute path of the working tree of the superproject, which this
  * project is a submodule of. If this repository is not a submodule of
  * another repository, return NULL.
+ *
+ * The return value, if not NULL, points to the same shared buffer as the one
+ * returned by real_path().
  */
 extern const char *get_superproject_working_tree(void);
 
-- 
2.15.0.531.g2ccb3012c9-goog

