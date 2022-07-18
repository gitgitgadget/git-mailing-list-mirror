Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AFEC43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 19:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbiGRTvo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 15:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235703AbiGRTvb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 15:51:31 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA5632076
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 12:51:30 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id s18-20020a17090aa11200b001f1e9e2438cso833461pjp.2
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 12:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wM/v15Qj1ww+RBCgAadbyRIjYsmkO3Gn9nN2VSkeD/0=;
        b=HZRB1SHN4ybasT1g1OHaDIMuPbNAw4l+prPJj+Ul15Xx3MPYeQZUcCj8ulefbnNUs4
         j1RH+colZN7tzu9t64UD/EUkrjmALFBALBv3QuyllZ7BPicIngHZiW1AEeLiQ4ZYwNPJ
         N22rggOawv9Umb/bS47qJvso15lRP9uCka6EmrwYaL9RnJPDwyMsg2rjDUbLD2kVRLP9
         wczGtprU7CuLIQuT0c7apCbQ+bb2uyTUWpd7ly4BKXqw/IvLK1++hkmsqrqK7b4GvKwF
         o0fxGModK1VGSgkCe2RXkmb1l8dK/KW+lX6h/iDwATJWyuXnju9qxu65900Uzn3AkQny
         X5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wM/v15Qj1ww+RBCgAadbyRIjYsmkO3Gn9nN2VSkeD/0=;
        b=Ib5nqM6MeSZG4DwIFbMXoY9XA+YnfrronbdNKLZqfy4ANhSMlHDS9I5MyrlOR9Ip+B
         MjAIC1JRLAo0XXjF9S0UWfSdbMnMWDRbnJgZV9BQZUsgbLiPUuxtUtn8Tqm4OfzWc9Lx
         gHfJZfL1J4ZJVvrlP9NDtxhVmxup0qEx8aoazYnQUKfv6SmZSTW71M9NIk0N+zFxwaR7
         ws3/3iHX91hhaL7qqIL9L39eUEW6fHRRCH7tHc5cRsYs2+mQBY7aXGi3QdOyuEU6UoRs
         ms7zabAIJMVFvsVT8sjuQK3JOBKa+RNil23CJa4KlUARUs8hC1HUKE9l5HjRTUIQLgXY
         jdcA==
X-Gm-Message-State: AJIora+XkRblEcCoivN/WiFHoS1Vqv72hqOhy9aU/ixOyWCcck0oVNyT
        IbhPRbVniBIIlDjeTPfd0468fqb64bMCdw==
X-Google-Smtp-Source: AGRyM1tKxGClYgLBFJno7RDbXEbJG0jp4rRCrpjmT/bQ60ddTppkblC0WuhXceQmkRkSc2Ncy8seaw==
X-Received: by 2002:a17:90b:3e89:b0:1f0:4233:b20e with SMTP id rj9-20020a17090b3e8900b001f04233b20emr34217813pjb.0.1658173889310;
        Mon, 18 Jul 2022 12:51:29 -0700 (PDT)
Received: from HB2.. ([106.212.244.137])
        by smtp.gmail.com with ESMTPSA id s13-20020a170902b18d00b0016c35b21901sm9855838plr.195.2022.07.18.12.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 12:51:28 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, congdanhqx@gmail.com,
        christian.couder@gmail.com, avarab@gmail.com, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, johncai86@gmail.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v6 3/4] ident: rename commit_rewrite_person() to apply_mailmap_to_header()
Date:   Tue, 19 Jul 2022 01:21:01 +0530
Message-Id: <20220718195102.66321-4-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.37.1.120.g63d6f8c201
In-Reply-To: <20220718195102.66321-1-siddharthasthana31@gmail.com>
References: <20220716074055.1786231-1-siddharthasthana31@gmail.com>
 <20220718195102.66321-1-siddharthasthana31@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

commit_rewrite_person() takes a commit buffer and replaces the idents
in the header with their canonical versions using the mailmap mechanism.
The name "commit_rewrite_person()" is misleading as it doesn't convey
what kind of rewrite are we going to do to the buffer. It also doesn't
clearly mention that the function will limit itself to the header part
of the buffer. The new name, "apply_mailmap_to_header()", expresses the
functionality of the function pretty clearly.

We intend to use apply_mailmap_to_header() in git-cat-file to replace
idents in the headers of commit and tag object buffers. So, we will be
extending this function to take tag objects buffer as well and replace
idents on the tagger header using the mailmap mechanism.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: John Cai <johncai86@gmail.com>
Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 cache.h    | 6 +++---
 ident.c    | 4 ++--
 revision.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/cache.h b/cache.h
index 16a08aada2..4aa1bd079d 100644
--- a/cache.h
+++ b/cache.h
@@ -1689,10 +1689,10 @@ struct ident_split {
 int split_ident_line(struct ident_split *, const char *, int);
 
 /*
- * Given a commit object buffer and the commit headers, replaces the idents
- * in the headers with their canonical versions using the mailmap mechanism.
+ * Given a commit or tag object buffer and the commit or tag headers, replaces
+ * the idents in the headers with their canonical versions using the mailmap mechanism.
  */
-void commit_rewrite_person(struct strbuf *, const char **, struct string_list *);
+void apply_mailmap_to_header(struct strbuf *, const char **, struct string_list *);
 
 /*
  * Compare split idents for equality or strict ordering. Note that we
diff --git a/ident.c b/ident.c
index 1eee4fd0e3..7f66beda42 100644
--- a/ident.c
+++ b/ident.c
@@ -387,8 +387,8 @@ static ssize_t rewrite_ident_line(const char *person, size_t len,
 	return 0;
 }
 
-void commit_rewrite_person(struct strbuf *buf, const char **header,
-			    struct string_list *mailmap)
+void apply_mailmap_to_header(struct strbuf *buf, const char **header,
+			       struct string_list *mailmap)
 {
 	size_t buf_offset = 0;
 
diff --git a/revision.c b/revision.c
index 14dca903b6..6ad3665204 100644
--- a/revision.c
+++ b/revision.c
@@ -3792,7 +3792,7 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 		if (!buf.len)
 			strbuf_addstr(&buf, message);
 
-		commit_rewrite_person(&buf, commit_headers, opt->mailmap);
+		apply_mailmap_to_header(&buf, commit_headers, opt->mailmap);
 	}
 
 	/* Append "fake" message parts as needed */
-- 
2.37.1.120.g63d6f8c201

