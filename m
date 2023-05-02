Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A20C77B7E
	for <git@archiver.kernel.org>; Tue,  2 May 2023 04:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjEBELX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 00:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjEBELS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 00:11:18 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA0A172E
        for <git@vger.kernel.org>; Mon,  1 May 2023 21:11:17 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-38dfbbfe474so861924b6e.0
        for <git@vger.kernel.org>; Mon, 01 May 2023 21:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683000676; x=1685592676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1MQiioMygkcIAq2Zy3wLLzdcwYhFysh069tboWawS1Y=;
        b=PmAaXt4fUfhDCP+qwzTHgb6WaDU5QP2YVENeMOYXikncBjQE7FYTo8V4D1Q/dUyulq
         9MoXkdqq5BkSUY51ap80buy9BQHIaYCYrjOfZ/+4D3xZ2tNN8EJYMRjQ/CscmRfiLIDS
         7uBlsYkV+o4uhLSxfDkjLzNPZcaipG+kmIHJjGSNatv2/gxZ+s3VUaGFxx9acYSJGMuO
         a00BW8dqZxh+OpAuNrNZgIe8LclvYm0yn8tjOgDtaHzbj/vuKKxaEAj1dWX7v3jlI8d+
         GbS/634MNsd9k/SM5be6UrLJOsWfdbxHRy75zSwUCD+mVtbUUKAFpaHZyJ33IzWDdL/R
         Hnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683000676; x=1685592676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1MQiioMygkcIAq2Zy3wLLzdcwYhFysh069tboWawS1Y=;
        b=HqvA/Xxymk//wlDTptqmdE5+1R9mIWNOuNWOHCMgMd1xK2NTz6Is1B25Wd5xyFEA9a
         jUB+T4raxXPRqxHAQOKyDYBINuE/dMBWeJUPs1RjL2XLNbEh7vxeoFCePc0nE3Bo2ENK
         lFIMmSGJzMrUtE71aUfkPMHGCCATzIcGUVMI3fFCbBNqC04OKYc+h4Cp1KeNQExMLspv
         gvXkSLPBi54Py2FIa08vwUBSDJdMT5bLJUEK39nv0B/ca85RU0Zj8POzeswzJgJhshhi
         NowAedMcSe/H7SVCMaSBTFYm+alryI8jLNYQox4maXcvHF4m+zo6x1HObRCsh3djoIwu
         WW9Q==
X-Gm-Message-State: AC+VfDyCCIlwlbLLS9+fSnWxOSOiVZVe70/cxUYg6p1YcCnci0xsarHV
        0LUHp9XuSfiYuV+ln4NQ6bwWylYB8kk=
X-Google-Smtp-Source: ACHHUZ5Gec/Z4g4lQQYHQtnpvbM7fRUlsswyJf4EVR2N3n2Ztn/S1K60qk6E6PvUpO3tbOS40Lhfzw==
X-Received: by 2002:aca:f06:0:b0:38c:cdf:24f3 with SMTP id 6-20020aca0f06000000b0038c0cdf24f3mr7217710oip.49.1683000676225;
        Mon, 01 May 2023 21:11:16 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id p129-20020acabf87000000b00383cc29d6b2sm12077544oif.51.2023.05.01.21.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 21:11:15 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 1/3] test: add simple shared library
Date:   Mon,  1 May 2023 22:11:11 -0600
Message-Id: <20230502041113.103385-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230502041113.103385-1-felipe.contreras@gmail.com>
References: <20230502041113.103385-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It doesn't contain anything, it's just preparation for further commits.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 .gitignore  | 1 +
 t/Makefile  | 9 +++++++++
 t/lib/git.c | 1 +
 t/lib/git.h | 4 ++++
 4 files changed, 15 insertions(+)
 create mode 100644 t/lib/git.c
 create mode 100644 t/lib/git.h

diff --git a/.gitignore b/.gitignore
index e875c59054..c249487b9d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -237,6 +237,7 @@
 *.iobj
 *.ipdb
 *.dll
+*.so
 .vs/
 Debug/
 Release/
diff --git a/t/Makefile b/t/Makefile
index 3e00cdd801..d85e3e661d 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -65,6 +65,15 @@ prove: pre-clean check-chainlint $(TEST_LINT)
 $(T):
 	@echo "*** $@ ***"; '$(TEST_SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
 
+lib/git.o: lib/git.c
+	$(QUIET_CC)$(COMPILE.c) -o $@ $<
+
+lib/libgit.so: CFLAGS := -fPIC -Ilib/ $(CFLAGS)
+lib/libgit.so: lib/git.o
+
+%.so::
+	$(QUIET_LINK)$(CC) -shared -o $@ $^ $(LIBS)
+
 pre-clean:
 	$(RM) -r '$(TEST_RESULTS_DIRECTORY_SQ)'
 
diff --git a/t/lib/git.c b/t/lib/git.c
new file mode 100644
index 0000000000..40d96ee354
--- /dev/null
+++ b/t/lib/git.c
@@ -0,0 +1 @@
+#include <git.h>
diff --git a/t/lib/git.h b/t/lib/git.h
new file mode 100644
index 0000000000..58a28085f5
--- /dev/null
+++ b/t/lib/git.h
@@ -0,0 +1,4 @@
+#ifndef GIT_H
+#define GIT_H
+
+#endif /* GIT_H */
-- 
2.40.0+fc1

