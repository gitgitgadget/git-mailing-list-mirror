Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7CE81F731
	for <e@80x24.org>; Fri,  9 Aug 2019 03:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403873AbfHIDCU (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 23:02:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39753 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729476AbfHIDCU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 23:02:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so45098190pgi.6
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 20:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G2d9hzHtsNy+lwihRcEFRhNq/3DTOD3fwiPkRvW/vqc=;
        b=FlRLPBtchjwxNhGA/wohbt70/APRxYc2Ea6igGtRw+0PLNBODpz6Z1ErgI3Aq1uTsf
         EGtAWVZ/ON8HtTMJeUxdjzSKZioitf3SIWdJP6KtYzmPDitBjEs5H6lkqZLOtHdya7J/
         6HkLzYXcmofx2v6TUb4fvWFe2ofRaPufPhoI5rVgU4/0fBrplVPCSp8tIbab5Y5QAANY
         5Nn1ahYOppVWxPFurwlSBjsv+HELluqumPBirje5W/wCM7JpFdg+tzOjQJnb/ZA2NSdt
         aQCBUhxlkH/kAa87qhGeYP7pahyrdOUZwXpr2bjNGoXfW4UfKrJNx8kpQ8DvsLcp12na
         rofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G2d9hzHtsNy+lwihRcEFRhNq/3DTOD3fwiPkRvW/vqc=;
        b=KUTAUXyHSX5pWLXMC02F7HPqSVPlCzzSsRvPJDVxbUNlbziag1rwp8oehk4wO27+Zk
         4H9cJcv9NuPH8bZ7Tu37vARSfxgXqUhGAzAoB6YW+qIyvdg0GwRz+nby6UYAEy6ApvSi
         vOvo2llkmgipmuNQFE2CJuTr793ezDjOTC6F+gcEI2H6FNy58jot/YpzGpkcJiwgKF1p
         vjbH0RfL16MzKCGQBP9fEhlNTKdhpCi4R9rC3qC9q05ptSti9fdwiiihKELKzfLt62JW
         53INRCVoQjC19fwDa8WtB1YblyQsj5UYJcd3IWh3O57xlt2+CuFbUZ+qke3YVFoxA1IB
         xL5g==
X-Gm-Message-State: APjAAAVPqRvHXrx4yCujT1Trin0NrbC/Y0rdI7L7MiV1Mmxz8PSZdaed
        U8IBzjEug2OK40asX8bda5xRq2IAvtw=
X-Google-Smtp-Source: APXvYqyfDHGqlxSVXutcEXs9LCJ2LcGCLAiuM7OtQAsyFKqKDLEhdID2buOKwupLzfkpwjTWqs5+QQ==
X-Received: by 2002:a17:90a:f491:: with SMTP id bx17mr7349174pjb.118.1565319739224;
        Thu, 08 Aug 2019 20:02:19 -0700 (PDT)
Received: from localhost.localdomain ([205.209.24.227])
        by smtp.gmail.com with ESMTPSA id h1sm124965938pfo.152.2019.08.08.20.02.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Aug 2019 20:02:18 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, johannes.schindelin@gmx.de,
        l.s.r@web.de, michal.kiedrowicz@gmail.com
Subject: [RFC PATCH v5 1/3] grep: make PCRE1 aware of custom allocator
Date:   Thu,  8 Aug 2019 20:02:08 -0700
Message-Id: <20190809030210.18353-2-carenas@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190809030210.18353-1-carenas@gmail.com>
References: <20190807213945.10464-1-carenas@gmail.com>
 <20190809030210.18353-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

63e7e9d8b6 ("git-grep: Learn PCRE", 2011-05-09) didn't include a way
to override the system alocator, and so it is incompatible with
USE_NED_ALLOCATOR as reported by Dscho[1] (in similar code from PCRE2)

Make the minimum change possible to ensure this combination is supported
by extending grep_init to set the PCRE1 specific functions to the NED
versions (using the aliased names though) and therefore making sure all
alocations are done inside PCRE1 with the same allocator than the rest
of git.

This change might have performance impact (hopefully for the best) and
so will be good idea to test it in a platform where NED might have a
positive impact (ex: Windows 7)

[1] https://public-inbox.org/git/pull.306.git.gitgitgadget@gmail.com

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile |  2 +-
 grep.c   | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index bd246f2989..4b384f3759 100644
--- a/Makefile
+++ b/Makefile
@@ -1764,7 +1764,7 @@ ifdef NATIVE_CRLF
 endif
 
 ifdef USE_NED_ALLOCATOR
-	COMPAT_CFLAGS += -Icompat/nedmalloc
+	COMPAT_CFLAGS += -DUSE_NED_ALLOCATOR -Icompat/nedmalloc
 	COMPAT_OBJS += compat/nedmalloc/nedmalloc.o
 	OVERRIDE_STRDUP = YesPlease
 endif
diff --git a/grep.c b/grep.c
index cd952ef5d3..0154998695 100644
--- a/grep.c
+++ b/grep.c
@@ -150,12 +150,22 @@ int grep_config(const char *var, const char *value, void *cb)
  * Initialize one instance of grep_opt and copy the
  * default values from the template we read the configuration
  * information in an earlier call to git_config(grep_config).
+ *
+ * If using PCRE make sure that the library is configured
+ * to use the right allocator (ex: NED)
  */
 void grep_init(struct grep_opt *opt, struct repository *repo, const char *prefix)
 {
 	struct grep_opt *def = &grep_defaults;
 	int i;
 
+#ifdef USE_NED_ALLOCATOR
+#ifdef USE_LIBPCRE1
+	pcre_malloc = malloc;
+	pcre_free = free;
+#endif
+#endif
+
 	memset(opt, 0, sizeof(*opt));
 	opt->repo = repo;
 	opt->prefix = prefix;
-- 
2.23.0.rc1

