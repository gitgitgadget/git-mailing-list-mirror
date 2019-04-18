Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA5F520305
	for <e@80x24.org>; Thu, 18 Apr 2019 04:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbfDREyK (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 00:54:10 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36232 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbfDREyJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 00:54:09 -0400
Received: by mail-lj1-f196.google.com with SMTP id r24so722266ljg.3
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 21:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LNXlHzpPp/Le/TZ9O5YAczgs5QVGAOFV0ohYEkQKIi4=;
        b=ipREz264+Nxnk7KuSo7qfg4QbDaQ6BjbNNrExmTGTcJ27mIa0k1MD5s5w3fz9Ih03P
         Qz+GOLMO9g34vRm1GhiCiCzX5ZY7qRqouq6C5qfF7v3idzujEkgmwObVhv9BkDwtPKRY
         Nwojdlmprrlsd2zQaxYMqMQRH7Hl7PwxYiamCKHqYkLyM1errTDVtLmFqu1s2YhzTBZG
         HzEClGgF//0COogXW6Tps0fcr3odGogkuDGqzjP7+BtrE3NBn1zY6yze/IR+YC/ytSGN
         iLSXkWyyrtHI1NtjG6XPyg6sDJ+RAYWYae2u/8uC8zFaeIrIS0VJ8exTqGaTKkfNAZXO
         FDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LNXlHzpPp/Le/TZ9O5YAczgs5QVGAOFV0ohYEkQKIi4=;
        b=XS55lQBfPyWiMJJY+i8GK7l6wiC2lnhp19zg+E2q5tPQOWDM/1AiNzVxeT9Oh+lj5e
         p+WclSMB/I2KsqCUg4Eq55FjuVtRS8qDxrZLWcrXRcU307suBjkKtljoSELWz9AhCeFp
         XnlneBQK6NYQoQm2SNxvhVI/fQrCPdiNpBHne8aBytAhMK58K5KEONoURNjJP0X+eHNm
         y4KVAgXJGvFDZn8D+dQ/aoOTR+3c+7v9xB07YTTYLrIg/8OxibWnqV2LB6XgDO1yJlz3
         XNTTeMr/xAtvPdf1qJP0Tzh+fQq10ZDJQnrDnAoL2hOWucudAx2Nsd0LoYfDq7TcTKMR
         OhZA==
X-Gm-Message-State: APjAAAV5JPvpWaoIYgIHN/0r1tvVM5EuY/lrJ/R6ATfSUHxn2B6LaJkq
        VRoXjN2qCueSWqF5z4EGmYXpckdv
X-Google-Smtp-Source: APXvYqyRnA6MYtvCCh3EGXHnGofso+sj0s/H0616kTl/zhtgQPRX73Rv2qdntEJxo5QFD3X3EDNALA==
X-Received: by 2002:a2e:8050:: with SMTP id p16mr2668969ljg.160.1555563247514;
        Wed, 17 Apr 2019 21:54:07 -0700 (PDT)
Received: from vkochan-ThinkPad-T470p.lan ([93.75.250.209])
        by smtp.gmail.com with ESMTPSA id y23sm200849lfy.31.2019.04.17.21.54.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 21:54:06 -0700 (PDT)
From:   Vadim Kochan <vadim4j@gmail.com>
To:     git@vger.kernel.org
Cc:     Vadim Kochan <vadim4j@gmail.com>
Subject: [PATCH 1/1] configure.ac: Properly check for libintl
Date:   Thu, 18 Apr 2019 08:04:19 +0300
Message-Id: <20190418050419.21114-1-vadim4j@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some libc implementations like uclibc or musl provides
gettext stubs via libintl library but this case is not checked
by AC_CHECK_LIB(c, gettext ...) because gcc has gettext as builtin
which passess the check.

So check it with included libintl.h where gettext may unfold into
libintl_gettext which will cause check to fail if libintl_gettext are
needed to be linked with -lintl.

Signed-off-by: Vadim Kochan <vadim4j@gmail.com>
---
 configure.ac | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index e0d0da3c0c..be3b55f1cc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -763,9 +763,19 @@ AC_CHECK_LIB([c], [basename],
 GIT_CONF_SUBST([NEEDS_LIBGEN])
 test -n "$NEEDS_LIBGEN" && LIBS="$LIBS -lgen"
 
-AC_CHECK_LIB([c], [gettext],
-[LIBC_CONTAINS_LIBINTL=YesPlease],
-[LIBC_CONTAINS_LIBINTL=])
+AC_DEFUN([LIBINTL_SRC], [
+AC_LANG_PROGRAM([[
+#include <libintl.h>
+]],[[
+char *msg = gettext("test");
+]])])
+
+AC_MSG_CHECKING([if libc contains libintl])
+AC_LINK_IFELSE([LIBINTL_SRC],
+	[AC_MSG_RESULT([yes])
+	LIBC_CONTAINS_LIBINTL=YesPlease],
+	[AC_MSG_RESULT([no])
+	LIBC_CONTAINS_LIBINTL=])
 GIT_CONF_SUBST([LIBC_CONTAINS_LIBINTL])
 
 #
-- 
2.14.1

