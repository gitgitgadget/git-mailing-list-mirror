Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B719AC433FE
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2A0561132
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346959AbhIHBpB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 21:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346864AbhIHBo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 21:44:57 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05060C0613CF
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 18:43:50 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d6so704871wrc.11
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 18:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dXwllSK3ejTtDVxke93zl6uYcgErPFrnWumJWcE2M28=;
        b=H0u80r8m6hFI9XFG+dkUuu6nAmnt6E2bicUViQe7iSb5meQhvoyBpaLaVyy7+aRM8D
         vpCBXbVdk7x6Un6xu2K0FYxazS019DbrHa6CPfYd2YrF2jM5XFILWDYKwbrrcKkgOxKf
         1K7hMsZzSG4+VAOPqOPfR8n8eNZZ2reJh3VhuaKZCfA0D2xdyR9150Le9OpyTFF6v1kM
         BTjm0hS0DvP/JsbJs5AVZK6szB0PE3iwKQw4lVSo89Szu3bTZCju/JrYN+9lVJ3E+Jec
         KdTVmHbC96Ytk938T1j1kJJXRf2UMn4zunbjLyiWBPRHcixyztX29G7a52H5R+7r4IcG
         SMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dXwllSK3ejTtDVxke93zl6uYcgErPFrnWumJWcE2M28=;
        b=ihz50+A9smRFOYOBeD0sG6A36P5N0WvUPWb5N5vwDgo+JQESvMTshKdG97ogtjg1qH
         QIcAaDCqXbHuoms0XyspGDI9md1RtOLdEsaTacrHS634ZtqaxNWgrbdoIXfABll/VnFG
         CsBX2/p+KvspqsikfwmDZ8RgFzIQv62WbBoZpljbrqn4XYS15HrQpdKVAoh28DT3iBIz
         QB+rYexh8YwhT429+frpXOb0tZ/TCz013u8kLybk7I9ZUmB1EUmQ5IycO9e4hRGC4gdn
         BD1NGJNrdqM7Vt2ylr/xc4uRPwmojVPb43O3DZeELZfOB8NAfuwgZ2wq6ob/9CIdKXrx
         hLbg==
X-Gm-Message-State: AOAM532Rn7LF+XKR4O5qsOkoRbo2pnEoyQgKJkl9dkahlsIsBtmtgHWA
        +HnOQB0xHAG7Bis2v4rkY0qIE7L45yc=
X-Google-Smtp-Source: ABdhPJx2W/rTTLcy7i2MwW1FZTVxzcdlq+BzouUA3c+kxyh1+KQBpH4cnkf0u+F+t8sIW2bdYwlMsA==
X-Received: by 2002:adf:ce8d:: with SMTP id r13mr1153211wrn.18.1631065428678;
        Tue, 07 Sep 2021 18:43:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a6sm636553wmb.7.2021.09.07.18.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 18:43:48 -0700 (PDT)
Message-Id: <c7f5ae66a9204a4190b21bcb1338fd80fb907f33.1631065427.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1086.git.git.1631065426.gitgitgadget@gmail.com>
References: <pull.1086.git.git.1631065426.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 01:43:45 +0000
Subject: [PATCH 2/3] stash: avoid feeding directories to update-index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When a file is removed from the cache, but there is a file of the same
name present in the working directory, we would normally treat that file
in the working directory as untracked.  However, in the case of stash,
doing that would prevent a simple 'git stash push', because the untracked
file would be in the way of restoring the deleted file.

git stash, however, blindly assumes that whatever is in the working
directory for a deleted file is wanted and passes that path along to
update-index.  That causes problems when the working directory contains
a directory with the same name as the deleted file.  Add some code for
this special case that will avoid passing directory names to
update-index.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/stash.c  | 9 +++++++++
 t/t3903-stash.sh | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 8f42360ca91..b85cf9d267e 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -313,6 +313,12 @@ static int reset_head(void)
 	return run_command(&cp);
 }
 
+static int is_path_a_directory(const char *path)
+{
+	struct stat st;
+	return (!lstat(path, &st) && S_ISDIR(st.st_mode));
+}
+
 static void add_diff_to_buf(struct diff_queue_struct *q,
 			    struct diff_options *options,
 			    void *data)
@@ -320,6 +326,9 @@ static void add_diff_to_buf(struct diff_queue_struct *q,
 	int i;
 
 	for (i = 0; i < q->nr; i++) {
+		if (is_path_a_directory(q->queue[i]->one->path))
+			continue;
+
 		strbuf_addstr(data, q->queue[i]->one->path);
 
 		/* NUL-terminate: will be fed to update-index -z */
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 0727a494aa4..fc74918ccc0 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1307,7 +1307,7 @@ test_expect_success 'stash -c stash.useBuiltin=false warning ' '
 	test_must_be_empty err
 '
 
-test_expect_failure 'git stash succeeds despite directory/file change' '
+test_expect_success 'git stash succeeds despite directory/file change' '
 	test_create_repo directory_file_switch_v1 &&
 	(
 		cd directory_file_switch_v1 &&
-- 
gitgitgadget

