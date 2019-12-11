Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67606C43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 23:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B352173E
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 23:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hK4aXSew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfLKXiZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 18:38:25 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:46655 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfLKXiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 18:38:25 -0500
Received: by mail-pj1-f73.google.com with SMTP id p5so138202pjt.13
        for <git@vger.kernel.org>; Wed, 11 Dec 2019 15:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2n0ARIFZ+bKKIk+3zmGlXwqYBErQRL9hFppXuTglf40=;
        b=hK4aXSewe7l132Ngf9ROgQ5PhUgdXVChk1+2XIKPVOnR9ZQ2mLFprtTGqvNdwBqsr2
         IApL5mAE8OHgShIR2o/N7L03tXvX6f+lsR8uVra0c6mAGYS1uYTCJd1U0chVX8h7KZ3A
         kVU3v6Q+8lJB1CqgIwx2uiB4RqQyxUcQjyrGTa6434IdqeJJavOsT08FLWcfSdTed8ER
         4i1dC4MqJ3sMB3v+7Ldp7HUN2rgYMa2exGjVCrLvR95tkS00TcSJAzb03vJ7wqMQTQ26
         VLBTOolUn5N2GOvwqegmwAqqko2ZcrIwHWqKYpqy9+6DsTEpPGAJICvmMUCV0vRg8xge
         bCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2n0ARIFZ+bKKIk+3zmGlXwqYBErQRL9hFppXuTglf40=;
        b=tgVN+mcLYZ1m5bRNbgtUoI1rtg5AF3tiIck+Z4IgzA2fAfsipzyNqHn59zSkdrClzM
         vn+qXoqpirC8bZZUee5JrBLy/HafQ1n1kumMsXzmWA2HDCkY5xHPAXfHVdZfdUkG/n1K
         NtXMw4Pk0ZSyN92GDE2B8JdKLbgrZzWPjguwHQUaDhg98TjzvacFR51gvL2RGw+YEOne
         Tp4ju0xZlDAPQFsFYwzcGYvSrXch8FpiczzWz/Zw+WXVLQHoZkUrBTCGbuNkbWIyLd54
         luKAWx40KRm3cQaPZ7hWMZrFNdl+RkrM1WqVlxWcdxTOu0Q21HsmdWL5TQRhcmu/mSwY
         Zw3A==
X-Gm-Message-State: APjAAAVkvR2P4RwxwYGjsN8HZ4G8P87BWSBcNZrEoJ7NPE+K5sB3OV0m
        zJ5VYRIH01r5k4VVIdjc3SERY+vkTOuxLfu0FCDFwz81B9XWC+KwQAn/IvpYJrY210Qw+U0Cl5K
        OOnGHxQPjz/kU0JEZvCsW714VN8ecvH0zQNAZ8KxGIV2XlCFAIwcVlrCxL8XQVUTXanjuEbttJw
        ==
X-Google-Smtp-Source: APXvYqxc0afp3mgXlommUfOeP1YysIfijp5iEuvU2chNN5cV0GX07qUvmr+oT7pAeNokkn9gygWlYOd5aAh8BAOB5tU=
X-Received: by 2002:a63:70e:: with SMTP id 14mr6993580pgh.266.1576107504494;
 Wed, 11 Dec 2019 15:38:24 -0800 (PST)
Date:   Wed, 11 Dec 2019 15:38:20 -0800
Message-Id: <20191211233820.185153-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
Subject: [PATCH v2] config: add string mapping for enum config_scope
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Matthew Rogers <mattr94@gmail.com>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a user is interacting with their config files primarily by the 'git
config' command, using the location flags (--global, --system, etc) then
they may be more interested to see the scope of the config file they are
editing, rather than the filepath.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---

Since v1, the only change is removing locale markers around the strings
returned from the helper.

As mentioned in lore.kernel.org/git/20191211232540.GE8464@google.com I'm
still not sure whether it's better to return "local" for
CONFIG_SCOPE_REPO. Since that's the scope returned for both local and
worktree (.git/config, .git/config.worktree) configs, I'm happy to leave
it the way it is to indicate "one of the configs in the repo".

 - Emily

 config.c | 17 +++++++++++++++++
 config.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/config.c b/config.c
index e7052b3977..baab4a916e 100644
--- a/config.c
+++ b/config.c
@@ -3312,6 +3312,23 @@ enum config_scope current_config_scope(void)
 		return current_parsing_scope;
 }
 
+const char *config_scope_to_string(enum config_scope scope)
+{
+	switch (scope) {
+	case CONFIG_SCOPE_SYSTEM:
+		return "system";
+	case CONFIG_SCOPE_GLOBAL:
+		return "global";
+	case CONFIG_SCOPE_REPO:
+		return "repo";
+	case CONFIG_SCOPE_CMDLINE:
+		return "cmdline";
+	case CONFIG_SCOPE_UNKNOWN:
+	default:
+		return "unknown";
+	}
+}
+
 int lookup_config(const char **mapping, int nr_mapping, const char *var)
 {
 	int i;
diff --git a/config.h b/config.h
index 91fd4c5e96..c8bf296dcc 100644
--- a/config.h
+++ b/config.h
@@ -303,6 +303,7 @@ enum config_scope {
 };
 
 enum config_scope current_config_scope(void);
+const char *config_scope_to_string(enum config_scope);
 const char *current_config_origin_type(void);
 const char *current_config_name(void);
 
-- 
2.24.0.525.g8f36a354ae-goog

