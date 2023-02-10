Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD11C05027
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 17:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjBJROO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 12:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbjBJRON (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 12:14:13 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DF638B6A
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 09:14:04 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id d13-20020a17090ad3cd00b0023127b2d602so6127976pjw.2
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 09:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUyMIHkZcQu3YYhZnObLcpbhO0J6Djjhf5TU70n8uVU=;
        b=aCxSZ+g2OPEgIAn1vjO37G9fklF/MIXfpPRL8HGQYpkfTeWxdc2wLWe4rXHTWsNYfF
         ETgzFc+qBMEJqa5Oe9xu3Pn6+6DBHm/j8s5r+wiPK9OGdUxuezfMusfoV0Wi2EhOQIWL
         59wotzHXita0ahkEDrk0pn+dAvPejdGn+/TzWrhlWnWWxCxF0z188bAom+zsn9KhvLem
         UM/rESTZqSdTcama5VV6hX/Bni6/FlVUTf5EY0bkyxHBmkfatEutHH9Wkc8hCxfavh1G
         579+KvDbQzhApxOrIrnTrtBnny3mQYjld1Vk8rZHlADhuAKkGWk3MzU7lHKVKE6HKwv4
         3FKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUyMIHkZcQu3YYhZnObLcpbhO0J6Djjhf5TU70n8uVU=;
        b=XesmVnxY5kU9nV+b32RygfRGooIoLwWrNimxah/9SYFbUBJYvfKP3RPm1X3Czyojm/
         1StFSkhewjEUGRxCAMo+76eFv+BkvAl8EVRhiTQ9kNs0itqMsC7sAzHqM+9UmSS4h6BU
         zxBp78APZVa65Nyos7l6Xzkj4quwx50KtlXHNNyiKbXD4obYanSpjwQxAE1Ubq/5HYTN
         /FhBpL2QLqwg5n6Z1wZL67lc9sbF+luZwGIYfUtoXj1D2b1B1Fd2JUzaDG7dNNbUrzAg
         dZOHckE9uiUHdsFs0mHs6ToPvRwNmbLXXa35U/kYGLPk4zkXTIDXjYrkNshSLYB5nRTd
         Jz9w==
X-Gm-Message-State: AO0yUKVXlUdKvrvTauQWjD40jf8ZtlwzoWL9iopAl50/3V3Gexjg0P7P
        dGBUVFxPliQO0cyPHGrRLfw=
X-Google-Smtp-Source: AK7set8H/Wd1rPAVKYPDTNgqUbuvVBsB8bi5qg7oDsTOp0iTcvtWVFgVrw8nfts50SRK+MfNVOrPkA==
X-Received: by 2002:a17:902:c94e:b0:19a:7217:32be with SMTP id i14-20020a170902c94e00b0019a721732bemr3249931pla.1.1676049244050;
        Fri, 10 Feb 2023 09:14:04 -0800 (PST)
Received: from localhost.localdomain ([2405:201:6805:20dd:94a9:fa14:fe37:b9ef])
        by smtp.gmail.com with ESMTPSA id l10-20020a170902eb0a00b001928c204428sm3622401plb.142.2023.02.10.09.13.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Feb 2023 09:14:03 -0800 (PST)
From:   Vinayak Dev <vinayakdev.sci@gmail.com>
To:     sunshine@sunshineco.com
Cc:     git@vger.kernel.org, vinayakdsci <vinayakdev.sci@gmail.com>
Subject: [PATCH v2 1/3] {apply,alias}: convert pre-processor macros to enums
Date:   Fri, 10 Feb 2023 22:43:36 +0530
Message-Id: <20230210171338.81906-2-vinayakdev.sci@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210171338.81906-1-vinayakdev.sci@gmail.com>
References: <20230210171338.81906-1-vinayakdev.sci@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: vinayakdsci <vinayakdev.sci@gmail.com>

Changes made to alias.c and apply.c in v1, requiring refactoring.

Signed-off-by: Vinayak Dev <vinayakdev.sci@gmail.com>

---
 alias.c | 12 +++++++++---
 apply.c | 19 +++++++++++++++----
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/alias.c b/alias.c
index 00abde0817..61ef2c0c54 100644
--- a/alias.c
+++ b/alias.c
@@ -44,9 +44,15 @@ void list_aliases(struct string_list *list)
 	read_early_config(config_alias_cb, &data);
 }
 
-#define SPLIT_CMDLINE_BAD_ENDING 1
-#define SPLIT_CMDLINE_UNCLOSED_QUOTE 2
-#define SPLIT_CMDLINE_ARGC_OVERFLOW 3
+/* #define SPLIT_CMDLINE_BAD_ENDING 1 */
+/* #define SPLIT_CMDLINE_UNCLOSED_QUOTE 2 */
+/* #define SPLIT_CMDLINE_ARGC_OVERFLOW 3 */
+enum split_cmdline_error {
+	SPLIT_CMDLINE_BAD_ENDING = 1,
+	SPLIT_CMDLINE_UNCLOSED_QUOTE,
+	SPLIT_CMDLINE_ARGC_OVERFLOW
+};
+
 static const char *split_cmdline_errors[] = {
 	N_("cmdline ends with \\"),
 	N_("unclosed quote"),
diff --git a/apply.c b/apply.c
index 5eec433583..1e9cf2f4f2 100644
--- a/apply.c
+++ b/apply.c
@@ -205,8 +205,13 @@ struct fragment {
  * or deflated "literal".
  */
 #define binary_patch_method leading
-#define BINARY_DELTA_DEFLATED	1
-#define BINARY_LITERAL_DEFLATED 2
+/* #define BINARY_DELTA_DEFLATED   1 */
+/* #define BINARY_LITERAL_DEFLATED 2 */
+
+enum binary_type_deflated {
+	BINARY_DELTA_DEFLATED = 1,
+	BINARY_LITERAL_DEFLATED
+};
 
 static void free_fragment_list(struct fragment *list)
 {
@@ -918,8 +923,14 @@ static int gitdiff_hdrend(struct gitdiff_data *state UNUSED,
  * their names against any previous information, just
  * to make sure..
  */
-#define DIFF_OLD_NAME 0
-#define DIFF_NEW_NAME 1
+
+/* #define DIFF_OLD_NAME 0 */
+/* #define DIFF_NEW_NAME 1 */
+
+enum diff_name {
+	DIFF_OLD_NAME = 0,
+	DIFF_NEW_NAME
+};
 
 static int gitdiff_verify_name(struct gitdiff_data *state,
 			       const char *line,
-- 
2.39.1

