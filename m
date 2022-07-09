Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30694C43334
	for <git@archiver.kernel.org>; Sat,  9 Jul 2022 15:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiGIPmo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jul 2022 11:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiGIPmn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jul 2022 11:42:43 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A343D5AA
        for <git@vger.kernel.org>; Sat,  9 Jul 2022 08:42:43 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o31-20020a17090a0a2200b001ef7bd037bbso1254912pjo.0
        for <git@vger.kernel.org>; Sat, 09 Jul 2022 08:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cFJvu+AqqPOe9XgzLb+7cbOS+hj7hA1P6aUDOl8dz74=;
        b=T8c54or2Q8H+ZZBUZgzNwV9eXGrBxRfleEzsy/bqztvTxb8S1ImDU9lf7F79K8BPfj
         JLW/L+nm7YPbusRlB7lJAwBTgV7M2SEBU2EYgEBzxbBS1nFEvTE3RbrdhosWnmSrf5L+
         VIWrZGnu/sA94ZORGdT42gVH8pPdDahTUzip/etcQBFtFaq86JJ5zl5f/qbEDYNoURYc
         5ydkNo19Sr+MgUm44UpGKleelnnoxye0xTwjGywDr6Q/sXPCV7k0Qu3v3GdwIy+XCpP1
         QeAvWECs7H2DBDv+L5ENr+m8rxvbqF1/0nPxI+8l0ADd2mTPwQqgwMB0Clt6MvtE9DzV
         tLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cFJvu+AqqPOe9XgzLb+7cbOS+hj7hA1P6aUDOl8dz74=;
        b=yB3oNUPUwyHMm11aPP+N1Sx2T/1jyRUpUI6HBY4zaXd439zNn5+aYdJqehDqggg4o/
         +c04H9Rs5LFGT7UDfudy1GqbpKCgkk97Ch17jhnqfLBpIWucmftOzwEs6TdajfFFyEl3
         BcLbzdiNAT7r6Rt2qu+Lgo3YF+5E/Jx7naI3fieipdFyZvZd72WmdjsrRKbewxa2ND4m
         zZqb16IFjN/X6LBCgnko6LqA8R9aTzubHyzyM/+IyFN79FsK/DirlMXtrlo7soGlOP6Y
         +3VnQa8MAHQhCyoNuHBNqh2hoI5v8ZqN0QyYF8f23coXKaK6sOcjd2mpOwU0YACX9S2M
         O9OA==
X-Gm-Message-State: AJIora++leinqXtiTWGPb9/DgSnaFu5MbheAIVk10RbiCvhXsHbyHLuN
        j5xr6a9ZO6IXL+sG/3r9kiU5MFi5is/welr0
X-Google-Smtp-Source: AGRyM1uPHHGx/WgJmg0b6qIPpTI5mUSNsE9j+/35WkRgXEXMasVZ1fC12JF0SopBy9VovoViGK/oQg==
X-Received: by 2002:a17:902:e952:b0:16a:74b7:57eb with SMTP id b18-20020a170902e95200b0016a74b757ebmr9264708pll.13.1657381362019;
        Sat, 09 Jul 2022 08:42:42 -0700 (PDT)
Received: from HB2.. ([122.175.103.204])
        by smtp.gmail.com with ESMTPSA id jj9-20020a170903048900b0016be4d78792sm1473833plb.257.2022.07.09.08.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 08:42:41 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, congdanhqx@gmail.com,
        christian.couder@gmail.com, avarab@gmail.com, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, johncai86@gmail.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v3 3/4] ident: rename commit_rewrite_person() to apply_mailmap_to_header()
Date:   Sat,  9 Jul 2022 21:11:48 +0530
Message-Id: <20220709154149.165524-4-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.37.0.6.g69b7ad898b
In-Reply-To: <20220709154149.165524-1-siddharthasthana31@gmail.com>
References: <20220707161554.6900-1-siddharthasthana31@gmail.com>
 <20220709154149.165524-1-siddharthasthana31@gmail.com>
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
 ident.c    | 2 +-
 revision.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index c9dbe1c29a..9edb7fefd3 100644
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
-void commit_rewrite_person(struct strbuf *buf, const char **commit_headers, struct string_list *mailmap);
+void apply_mailmap_to_header(struct strbuf *buf, const char **headers, struct string_list *mailmap);
 
 /*
  * Compare split idents for equality or strict ordering. Note that we
diff --git a/ident.c b/ident.c
index 9f4f6e9071..5f17bd607d 100644
--- a/ident.c
+++ b/ident.c
@@ -393,7 +393,7 @@ static ssize_t rewrite_ident_line(const char* person, struct strbuf *buf, struct
 	return 0;
 }
 
-void commit_rewrite_person(struct strbuf *buf, const char **headers, struct string_list *mailmap)
+void apply_mailmap_to_header(struct strbuf *buf, const char **headers, struct string_list *mailmap)
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
2.37.0.6.g69b7ad898b

