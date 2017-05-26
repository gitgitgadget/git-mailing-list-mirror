Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05BFB209FD
	for <e@80x24.org>; Fri, 26 May 2017 03:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946829AbdEZDf2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 23:35:28 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35611 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1946697AbdEZDfR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 23:35:17 -0400
Received: by mail-pf0-f193.google.com with SMTP id u26so43062316pfd.2
        for <git@vger.kernel.org>; Thu, 25 May 2017 20:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qxR96mY7e/JEB//4vuce30pF39bO4Wn0DGGD1anDnIk=;
        b=Gk4wHxDFxuQjN+7kxU5YSC79dwvIgwLG4DCgFB1UronB3lHN2mdcorn4Tk5nUaz3xc
         s191+IisyO/nVUqF7YGI6PsiFu5oBG4vzORD7k5QMawVKvPKNjghPvbJ+W1WPiQIZfvO
         +3zWR2PGqFhbedKELBfAidipEVejkN032eEiTkOJmZqlMcJ5yClP4X2w66vC0hz58znU
         tUar2LHNimqOU7eC0fdtqiyRVf7Spra2b+ihivjixIAJ4MyMpMCRC7trONmJw4/Spz7r
         y7+JrG5EPXc+A1wuqRYvbrG5sb07M1MP89pTcRfzJKEz5ZVUmDP+zpYVO9D9m0WdFdab
         pbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=qxR96mY7e/JEB//4vuce30pF39bO4Wn0DGGD1anDnIk=;
        b=JtXXQhGf9crNk3nyi+/XCDtYXBixf+srCFTxQC8CbgHyrgn/9+1qvUfdZlMAZJfjre
         cYiYflVxEdc2dTbCz3S1NeYPlBdJUckVphuudkhfWtqc4QQ6NtxkD/7sTj4Qutk0qxG5
         782Hu7adKQzwM+P9zJDZ1qf7W57jqnIofVMoYqUtEpK0AGa5KI/aGLRtqLemvW7wEo/f
         nDmTqdX1yrJ9ZCQUyFc9qMSHMWwGCv0S14bD8ho7m749FDaJqb2MHxsxQTozvQ3QozZS
         xSA5NW//QFKyFx8hdBatOS9bM6ToGCCCRzJLViPm6rPwBf3V+DHlg+JAlkzfkOGtVxOj
         NM2w==
X-Gm-Message-State: AODbwcCXeHXqHHywCmYz9xJ3ZSzfblHh3ic2Fmufi3VcqzNA3AKeT/XW
        q06ZN18OC9VSDg==
X-Received: by 10.84.231.139 with SMTP id g11mr40407707plk.71.1495769716617;
        Thu, 25 May 2017 20:35:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:546a:ce73:1719:5041])
        by smtp.gmail.com with ESMTPSA id o194sm17093923pfg.117.2017.05.25.20.35.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 May 2017 20:35:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 04/13] config.mak.uname: set FREAD_READS_DIRECTORIES for Linux and FreeBSD
Date:   Fri, 26 May 2017 12:35:01 +0900
Message-Id: <20170526033510.1793-5-gitster@pobox.com>
X-Mailer: git-send-email 2.13.0-491-g71cfeddc25
In-Reply-To: <20170526033510.1793-1-gitster@pobox.com>
References: <CACsJy8CzgHc=qe5w=FGJJ=ZU0a+JiqBrjWHV7SH3rAPKmOOKoA@mail.gmail.com>
 <20170526033510.1793-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

This variable is added [1] with the assumption that on a sane system,
fopen(<dir>, "r") should return NULL. Linux and FreeBSD do not meet this
expectation while at least Windows and AIX do. Let's make sure they
behave the same way.

I only tested one version on Linux (4.7.0 with glibc 2.22) and
FreeBSD (11.0) but since GNU/kFreeBSD is fbsd kernel with gnu userspace,
I'm pretty sure it shares the same problem.

[1] cba22528fa (Add compat/fopen.c which returns NULL on attempt to open
    directory - 2008-02-08)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 config.mak.uname      | 3 +++
 t/t1308-config-set.sh | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index 399fe19271..a25ffddb3e 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -36,6 +36,7 @@ ifeq ($(uname_S),Linux)
 	NEEDS_LIBRT = YesPlease
 	HAVE_GETDELIM = YesPlease
 	SANE_TEXT_GREP=-a
+	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	HAVE_ALLOCA_H = YesPlease
@@ -43,6 +44,7 @@ ifeq ($(uname_S),GNU/kFreeBSD)
 	HAVE_PATHS_H = YesPlease
 	DIR_HAS_BSD_GROUP_SEMANTICS = YesPlease
 	LIBC_CONTAINS_LIBINTL = YesPlease
+	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 endif
 ifeq ($(uname_S),UnixWare)
 	CC = cc
@@ -201,6 +203,7 @@ ifeq ($(uname_S),FreeBSD)
 	GMTIME_UNRELIABLE_ERRORS = UnfortunatelyYes
 	HAVE_BSD_SYSCTL = YesPlease
 	PAGER_ENV = LESS=FRX LV=-c MORE=FRX
+	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 endif
 ifeq ($(uname_S),OpenBSD)
 	NO_STRCASESTR = YesPlease
diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index ff50960cca..72d5f1f931 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -183,6 +183,14 @@ test_expect_success 'proper error on non-existent files' '
 	test_cmp expect actual
 '
 
+test_expect_success 'proper error on directory "files"' '
+	echo "Error (-1) reading configuration file a-directory." >expect &&
+	mkdir a-directory &&
+	test_expect_code 2 test-config configset_get_value foo.bar a-directory 2>output &&
+	grep "^Error" output >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success POSIXPERM,SANITY 'proper error on non-accessible files' '
 	chmod -r .git/config &&
 	test_when_finished "chmod +r .git/config" &&
-- 
2.13.0-491-g71cfeddc25

