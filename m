Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0AFC433ED
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 14:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2B9761370
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 14:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhDYORL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Apr 2021 10:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbhDYORH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Apr 2021 10:17:07 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F76C061756
        for <git@vger.kernel.org>; Sun, 25 Apr 2021 07:16:27 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n84so1358716wma.0
        for <git@vger.kernel.org>; Sun, 25 Apr 2021 07:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eZaOHLbd9c9hwOiQ1D59vt9rFpyoV3rXsJbli+E796U=;
        b=WfsQ7oGT+NCYD+Jsk91yDfceaPcLzFHlvANRYIpqhFlos6zpIcfNKOfg6hOKa99nQr
         nHb/jFE5utMWJSv/pZ4vk/K/bUWyL+tSXK33T09J7Xov6GAjsHbFJfMyBEvokpACW1Ht
         /j6E4QGpUhdZ5UzjuDy3GYSZ6oSA5mh1c5yn+Jr9xNWFpmt7EfjvLqyRagQ7IePu7n0r
         t8cLF0dPhtTPv1+fbRKt+jRp36YT3ungTg3n14wCS56OHNV3Amycl0q2elZs0F0z0PZd
         rjlru2RQOH/tzzQUdOENsD1pCuUlCIC7C9U4uwMqyDvObrUSpJlBDif6leLyK6w0XZ1B
         TPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eZaOHLbd9c9hwOiQ1D59vt9rFpyoV3rXsJbli+E796U=;
        b=oi7f1jGp6bE5UC3hgyj4BNt0tavaX6/VwSEe0dsvVqcUrt94xpjUeoLM7W7bCgECDK
         j/FHD0+MEiBVa2U7iddD7V/5qr0QrTfZK/Eo9aeKRQL6UeB6b2Uq1w+XHSQsJRlc2LfI
         jUZK4zufIfjDUq3N8UhgJBMtOKPKZPS57XrEdMHgl38K10T2AbkH0qxgtxuWgUlVEduG
         0e3xJKPUEOZcuIO7vLap/EzATJt93BY8lMD7dp6inYoNwf9NahJk4aACP7ohHfWvCJbb
         iCyMwfmjiAZnEIAOQ7pG7SKUc4O3fLWV8t3LmvpN0llfXC+EL4yVq066fjjAxIOxMBGo
         tSug==
X-Gm-Message-State: AOAM530iGEhTCtT0RYu7UErosNX68Pzia8tG0kYc5HIhSiRatXJxjaAT
        q9Mlc7LTtxD2M4lTi9dSHlWdV+Ol0iw=
X-Google-Smtp-Source: ABdhPJzd/uzhOiz+BRe9/9hEo7bn7LK1u8z7EE4vSZE1uWfyMl3oSQ8mehzSaA6z6+fZQ9XfVeiQnw==
X-Received: by 2002:a1c:e444:: with SMTP id b65mr14784452wmh.49.1619360186752;
        Sun, 25 Apr 2021 07:16:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t6sm15920913wrx.38.2021.04.25.07.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 07:16:26 -0700 (PDT)
Message-Id: <217f571f8ef5f3a46c0cbb1ceca022a18e5b43d2.1619360180.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.v2.git.1619360180.gitgitgadget@gmail.com>
References: <pull.929.git.1617994052.gitgitgadget@gmail.com>
        <pull.929.v2.git.1619360180.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 25 Apr 2021 14:16:16 +0000
Subject: [PATCH v2 09/12] mailinfo: also free strbuf lists when clearing
 mailinfo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

mailinfo.p_hdr_info/s_hdr_info are null-terminated lists of strbuf's,
with entries pointing either to NULL or an allocated strbuf. Therefore
we need to free those strbuf's (and not just the data they contain)
whenever we're done with a given entry. (See handle_header() where those
new strbufs are malloc'd.)

Once we no longer need the list (and not just its entries) we can switch
over to strbuf_list_free() instead of manually iterating over the list,
which takes care of those additional details for us. We can only do this
in clear_mailinfo() - in handle_commit_message() we are only clearing the
array contents but want to reuse the array itself, hence we can't use
strbuf_list_free() there.

However, strbuf_list_free() cannot handle a NULL input, and the lists we
are freeing might be NULL. Therefore we add a NULL check in
strbuf_list_free() to make it safe to use with a NULL input (which is a
pattern used by some of the other *_free() functions around git).

Leak output from t0023:

Direct leak of 72 byte(s) in 3 object(s) allocated from:
    #0 0x49a85d in malloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:145:3
    #1 0x9ac9f4 in do_xmalloc wrapper.c:41:8
    #2 0x9ac9ca in xmalloc wrapper.c:62:9
    #3 0x7f6cf7 in handle_header mailinfo.c:205:10
    #4 0x7f5abf in check_header mailinfo.c:583:4
    #5 0x7f5524 in mailinfo mailinfo.c:1197:3
    #6 0x4dcc95 in parse_mail builtin/am.c:1167:6
    #7 0x4d9070 in am_run builtin/am.c:1732:12
    #8 0x4d5b7a in cmd_am builtin/am.c:2398:3
    #9 0x4cd91d in run_builtin git.c:467:11
    #10 0x4cb5f3 in handle_builtin git.c:719:3
    #11 0x4ccf47 in run_argv git.c:808:4
    #12 0x4caf49 in cmd_main git.c:939:19
    #13 0x69e43e in main common-main.c:52:11
    #14 0x7fc1fadfa349 in __libc_start_main (/lib64/libc.so.6+0x24349)

SUMMARY: AddressSanitizer: 72 byte(s) leaked in 3 allocation(s).

Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
---
 mailinfo.c | 14 +++-----------
 strbuf.c   |  2 ++
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/mailinfo.c b/mailinfo.c
index 5681d9130db6..95ce191f385b 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -821,7 +821,7 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 		for (i = 0; header[i]; i++) {
 			if (mi->s_hdr_data[i])
 				strbuf_release(mi->s_hdr_data[i]);
-			mi->s_hdr_data[i] = NULL;
+			FREE_AND_NULL(mi->s_hdr_data[i]);
 		}
 		return 0;
 	}
@@ -1236,22 +1236,14 @@ void setup_mailinfo(struct mailinfo *mi)
 
 void clear_mailinfo(struct mailinfo *mi)
 {
-	int i;
-
 	strbuf_release(&mi->name);
 	strbuf_release(&mi->email);
 	strbuf_release(&mi->charset);
 	strbuf_release(&mi->inbody_header_accum);
 	free(mi->message_id);
 
-	if (mi->p_hdr_data)
-		for (i = 0; mi->p_hdr_data[i]; i++)
-			strbuf_release(mi->p_hdr_data[i]);
-	free(mi->p_hdr_data);
-	if (mi->s_hdr_data)
-		for (i = 0; mi->s_hdr_data[i]; i++)
-			strbuf_release(mi->s_hdr_data[i]);
-	free(mi->s_hdr_data);
+	strbuf_list_free(mi->p_hdr_data);
+	strbuf_list_free(mi->s_hdr_data);
 
 	while (mi->content < mi->content_top) {
 		free(*(mi->content_top));
diff --git a/strbuf.c b/strbuf.c
index e3397cc4c72a..4df30b45494d 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -209,6 +209,8 @@ void strbuf_list_free(struct strbuf **sbs)
 {
 	struct strbuf **s = sbs;
 
+	if (!s)
+		return;
 	while (*s) {
 		strbuf_release(*s);
 		free(*s++);
-- 
gitgitgadget

