Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8DAC433E1
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 22:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFBE720866
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 22:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWTdnZMD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgHLWaf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 18:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgHLWae (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 18:30:34 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69B9C061384
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 15:30:33 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id f1so3490434wro.2
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 15:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1TkSPOBlVBrnRR32y3MqpE760aDe95YgWf4+gT8vs94=;
        b=XWTdnZMDZk1lHEnAXEXN8fkWIzYdBn9Ikta43RysWwI6dWUfPoRCWAgzEBnQ55+w/2
         XaK7ELijqm94PQIL/HsX40xd0pSYMl8roDOr5LPCWF2GIiqmuMIokKw6+ybT+jW04/oV
         kIbfdH/t52QLYdkGIjKT8+YS/DiQG/+oZOnnjVTX75BkYvzlr3J+cEKTuI0KkTYc27ca
         d1ATVNkf/98nizaUU1TIhB9lzQ+7whFQUoXYbAegOWBkqlZE4s7HTuhCg+uMuDP60GKi
         7O8Kyo1oYwFi+F3D48ENc2yxXRH+MSlA1ifsFK1T6fnxFCncL+hHCZAKoYrUvashL+p4
         qOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1TkSPOBlVBrnRR32y3MqpE760aDe95YgWf4+gT8vs94=;
        b=BYiC151lurX6QCvMwkQj6Dd6N2lhHMLl5d8IhS+/UnMw/wndEpSqfbdoulIF+0JC+H
         tSvyx6yLbNPDT/h77GWR2MG+P5kwN8VnWfJR8FPj83euPd9ybXUI1FUnIZjsyY+f8of1
         gXR83x60HtpWH0jeshBF4LtI9g/ok6IkVwnO6pnVA3BvjsIF1j9JTr5SwNg7PtD3bOqt
         336zKJrNgcVo2LKGyVVZTu7JIexkS6IUlgxLZp4kdkAIXzdAyb7UoHg4NARB1meJsOes
         RZeQo+rzaA55rtCYVfRjV/ue5H1YdmvmZ1XrOw09DTvDb6hdepHH1oClEAILj+wzjMxP
         zn9g==
X-Gm-Message-State: AOAM533i2R5yynIHy6OWR6Yz4uyM8ELjgDijQs9aXBEVY+WxkXevjk/J
        CIgcrsz9u5WMe13Wm5MhHeCrk5ZO
X-Google-Smtp-Source: ABdhPJx+lE6l6Et0dgzl4kGxU/XkGzakcM/pHe7gTb7KAW+wRZntojVoBtMWGDE9eTHciqPT2lTUoQ==
X-Received: by 2002:adf:9d8f:: with SMTP id p15mr1069029wre.45.1597271431830;
        Wed, 12 Aug 2020 15:30:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b203sm6020820wmc.22.2020.08.12.15.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 15:30:31 -0700 (PDT)
Message-Id: <30cb5c5cd57162837efe1153bf88cb8863206323.1597271429.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.700.git.1597271429.gitgitgadget@gmail.com>
References: <pull.700.git.1597271429.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Aug 2020 22:30:28 +0000
Subject: [PATCH 1/2] userdiff: add tests for Fortran xfuncname regex
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Brandon Casey <drafnel@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The Fortran userdiff patterns, introduced in 909a5494f8 (userdiff.c: add
builtin fortran regex patterns, 2010-09-10), predate the test
infrastructure for xfuncname patterns, introduced in bfa7d01413 (t4018:
an infrastructure to test hunk headers, 2014-03-21).

Add tests for the Fortran xfuncname patterns. The test
't/t4018/fortran-comment-keyword' documents a shortcoming of the regex
that is fixed in a subsequent commit.

While at it, add descriptive comments for the different parts of the
regex.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 t/t4018/fortran-block-data          |  5 +++++
 t/t4018/fortran-comment             | 13 +++++++++++++
 t/t4018/fortran-comment-keyword     | 15 +++++++++++++++
 t/t4018/fortran-comment-legacy      | 13 +++++++++++++
 t/t4018/fortran-comment-legacy-star | 13 +++++++++++++
 t/t4018/fortran-external-function   |  9 +++++++++
 t/t4018/fortran-external-subroutine |  5 +++++
 t/t4018/fortran-module              |  5 +++++
 t/t4018/fortran-module-procedure    | 13 +++++++++++++
 t/t4018/fortran-program             |  5 +++++
 userdiff.c                          |  4 ++++
 11 files changed, 100 insertions(+)
 create mode 100644 t/t4018/fortran-block-data
 create mode 100644 t/t4018/fortran-comment
 create mode 100644 t/t4018/fortran-comment-keyword
 create mode 100644 t/t4018/fortran-comment-legacy
 create mode 100644 t/t4018/fortran-comment-legacy-star
 create mode 100644 t/t4018/fortran-external-function
 create mode 100644 t/t4018/fortran-external-subroutine
 create mode 100644 t/t4018/fortran-module
 create mode 100644 t/t4018/fortran-module-procedure
 create mode 100644 t/t4018/fortran-program

diff --git a/t/t4018/fortran-block-data b/t/t4018/fortran-block-data
new file mode 100644
index 0000000000..63d4e21d0a
--- /dev/null
+++ b/t/t4018/fortran-block-data
@@ -0,0 +1,5 @@
+       BLOCK DATA RIGHT
+       
+       COMMON /B/ C, ChangeMe
+       DATA C, ChangeMe  / 2.0, 6.0 / 
+       END 
diff --git a/t/t4018/fortran-comment b/t/t4018/fortran-comment
new file mode 100644
index 0000000000..7b10d17658
--- /dev/null
+++ b/t/t4018/fortran-comment
@@ -0,0 +1,13 @@
+      module a
+
+      contains
+
+      ! subroutine wrong
+      subroutine RIGHT
+      ! subroutine wrong
+
+      real ChangeMe
+
+      end subroutine RIGHT
+
+      end module a
diff --git a/t/t4018/fortran-comment-keyword b/t/t4018/fortran-comment-keyword
new file mode 100644
index 0000000000..c5dbdb4c61
--- /dev/null
+++ b/t/t4018/fortran-comment-keyword
@@ -0,0 +1,15 @@
+      module a
+
+      contains
+
+      subroutine RIGHT (funcA, funcB)
+
+      real funcA  ! grid function a
+      real funcB  ! grid function b
+
+      real ChangeMe
+      integer broken
+
+      end subroutine RIGHT
+
+      end module a
diff --git a/t/t4018/fortran-comment-legacy b/t/t4018/fortran-comment-legacy
new file mode 100644
index 0000000000..53cd062c1e
--- /dev/null
+++ b/t/t4018/fortran-comment-legacy
@@ -0,0 +1,13 @@
+      module a
+
+      contains
+
+C subroutine wrong
+      subroutine RIGHT
+C subroutine wrong
+
+      real ChangeMe
+
+      end subroutine RIGHT
+
+      end module a
diff --git a/t/t4018/fortran-comment-legacy-star b/t/t4018/fortran-comment-legacy-star
new file mode 100644
index 0000000000..2cbcdc3d8a
--- /dev/null
+++ b/t/t4018/fortran-comment-legacy-star
@@ -0,0 +1,13 @@
+      module a
+
+      contains
+
+* subroutine wrong
+      subroutine RIGHT
+* subroutine wrong
+
+      real ChangeMe
+
+      end subroutine RIGHT
+
+      end module a
diff --git a/t/t4018/fortran-external-function b/t/t4018/fortran-external-function
new file mode 100644
index 0000000000..5a2d85d3aa
--- /dev/null
+++ b/t/t4018/fortran-external-function
@@ -0,0 +1,9 @@
+function RIGHT(a, b) result(c)
+
+integer, intent(in) :: ChangeMe
+integer, intent(in) :: b
+integer, intent(out) :: c
+
+c = a+b
+
+end function RIGHT
diff --git a/t/t4018/fortran-external-subroutine b/t/t4018/fortran-external-subroutine
new file mode 100644
index 0000000000..4ce85fea13
--- /dev/null
+++ b/t/t4018/fortran-external-subroutine
@@ -0,0 +1,5 @@
+subroutine RIGHT
+
+real ChangeMe
+
+end subroutine RIGHT
diff --git a/t/t4018/fortran-module b/t/t4018/fortran-module
new file mode 100644
index 0000000000..c4b737dac3
--- /dev/null
+++ b/t/t4018/fortran-module
@@ -0,0 +1,5 @@
+module RIGHT
+
+use ChangeMe
+
+end module RIGHT
diff --git a/t/t4018/fortran-module-procedure b/t/t4018/fortran-module-procedure
new file mode 100644
index 0000000000..1ce6d854c2
--- /dev/null
+++ b/t/t4018/fortran-module-procedure
@@ -0,0 +1,13 @@
+ module RIGHT
+
+   implicit none
+   private
+
+   interface letters  ! generic interface
+      module procedure aaaa, &
+                       bbbb, &
+                       ChangeMe, &
+                       dddd
+   end interface
+   
+end module RIGHT
diff --git a/t/t4018/fortran-program b/t/t4018/fortran-program
new file mode 100644
index 0000000000..4616895e4b
--- /dev/null
+++ b/t/t4018/fortran-program
@@ -0,0 +1,5 @@
+program RIGHT
+
+call ChangeMe
+
+end program RIGHT
diff --git a/userdiff.c b/userdiff.c
index 1df884ef0b..707d82435a 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -46,9 +46,13 @@ PATTERNS("elixir",
 	 /* Not real operators, but should be grouped */
 	 "|:?%[A-Za-z0-9_.]\\{\\}?"),
 IPATTERN("fortran",
+	 /* Don't match comment lines */
 	 "!^([C*]|[ \t]*!)\n"
+	 /* Don't match 'module procedure' lines */
 	 "!^[ \t]*MODULE[ \t]+PROCEDURE[ \t]\n"
+	 /* Program, module, block data */
 	 "^[ \t]*((END[ \t]+)?(PROGRAM|MODULE|BLOCK[ \t]+DATA"
+		/* Subroutines and functions */
 		"|([^'\" \t]+[ \t]+)*(SUBROUTINE|FUNCTION))[ \t]+[A-Z].*)$",
 	 /* -- */
 	 "[a-zA-Z][a-zA-Z0-9_]*"
-- 
gitgitgadget

