Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1620D203C1
	for <e@80x24.org>; Wed,  7 Dec 2016 15:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932179AbcLGPhF (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 10:37:05 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35800 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752941AbcLGPgv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 10:36:51 -0500
Received: by mail-pg0-f66.google.com with SMTP id p66so23822017pga.2
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 07:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EdNaglYsk3ZRagZvIP6XqHS3ZBNaE9Zd+yULOJ42sQQ=;
        b=MqkMFj/VV1Whky/bez5CMx1jR5FEv/yIx8rOnI5IHhQarEkQwno+4QV4k4w+WFs4wV
         j8IUE5uNyMibEqMm6sAxKFqI+06fm+YHPjQ6CDDnlUeVvMLj/1UuwecD2zllVV8nHjLx
         dVfKrf388PsL6GyhHg7D774bCaqoBB7f5ygEPWsLluVw9pjmLTr+qcoP+g0/dIxbhlTt
         hAD7RsQk2GTd8mcR7zR25UJ1iRKBIR/G5rfSY3IfYOdwgMMscoEzJr1bJDMiUYISrZAS
         HqyjmZ6kOXBrbmG2/BSBcllHHJuLeYCdJJSiYN9km7kwwR44xK5gwfTMT9rZTyKuqKSO
         QvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EdNaglYsk3ZRagZvIP6XqHS3ZBNaE9Zd+yULOJ42sQQ=;
        b=i3dVeT5arCYEn+P5ykDn6C67O8woier8e7UVEmIS0sYPXbi12NK9g1Y5CmwELfW8js
         I8m/Kuh4K2PPq+seKBCwpQOx71lNmZxeq/rXVpjJi74D45C85YhE5XcqIVPqC1gNzvUh
         IQWgSgBvJSfjNLPiu8hjiQFCPBalFDPaCDd/zMYeVVtHfQ2dN4//svGMinAgF4BsrgV0
         DPhKIeqL5sOD6yhLvGIGlsfMgcHTyYdzNaO5cAoqHOFJv1BvjA4qGMINa52rXoI2jpf9
         KfPCMBCCvCyi7ih3M8fruRheiMjvOMPT8xHlQtwC3K9c/VpdTSVHa2ifks+kCim0sTfc
         cAsQ==
X-Gm-Message-State: AKaTC02it2KJ44GFjNEncvLTk2Go/cWnTXjkp9JTscEKtJVlywfydXlja099DQ/yFmUEDg==
X-Received: by 10.84.171.228 with SMTP id l91mr148850670plb.4.1481124991317;
        Wed, 07 Dec 2016 07:36:31 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([122.15.255.69])
        by smtp.gmail.com with ESMTPSA id l7sm43584459pfg.35.2016.12.07.07.36.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Dec 2016 07:36:30 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com, jnareb@gmail.com,
        Karthik Nayak <karthik.188@gmail.com>,
        Karthik Nayak <Karthik.188@gmail.com>
Subject: [PATCH v8 09/19] ref-filter: make "%(symref)" atom work with the ':short' modifier
Date:   Wed,  7 Dec 2016 21:06:17 +0530
Message-Id: <20161207153627.1468-10-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161207153627.1468-1-Karthik.188@gmail.com>
References: <20161207153627.1468-1-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Karthik Nayak <karthik.188@gmail.com>

The "%(symref)" atom doesn't work when used with the ':short' modifier
because we strictly match only 'symref' for setting the 'need_symref'
indicator. Fix this by comparing with the valid_atom rather than the
used_atom.

Add tests for %(symref) and %(symref:short) while we're here.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c            |  2 +-
 t/t6300-for-each-ref.sh | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index 49bb120..405a0e5 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -341,7 +341,7 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 		valid_atom[i].parser(&used_atom[at], arg);
 	if (*atom == '*')
 		need_tagged = 1;
-	if (!strcmp(used_atom[at].name, "symref"))
+	if (!strcmp(valid_atom[i].name, "symref"))
 		need_symref = 1;
 	return at;
 }
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index ed36a0a..1935583 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -38,6 +38,7 @@ test_atom() {
 	case "$1" in
 		head) ref=refs/heads/master ;;
 		 tag) ref=refs/tags/testtag ;;
+		 sym) ref=refs/heads/sym ;;
 		   *) ref=$1 ;;
 	esac
 	printf '%s\n' "$3" >expected
@@ -566,6 +567,7 @@ test_expect_success 'Verify sort with multiple keys' '
 	test_cmp expected actual
 '
 
+
 test_expect_success 'do not dereference NULL upon %(HEAD) on unborn branch' '
 	test_when_finished "git checkout master" &&
 	git for-each-ref --format="%(HEAD) %(refname:short)" refs/heads/ >actual &&
@@ -575,4 +577,26 @@ test_expect_success 'do not dereference NULL upon %(HEAD) on unborn branch' '
 	test_cmp expect actual
 '
 
+test_expect_success 'Add symbolic ref for the following tests' '
+	git symbolic-ref refs/heads/sym refs/heads/master
+'
+
+cat >expected <<EOF
+refs/heads/master
+EOF
+
+test_expect_success 'Verify usage of %(symref) atom' '
+	git for-each-ref --format="%(symref)" refs/heads/sym >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+heads/master
+EOF
+
+test_expect_success 'Verify usage of %(symref:short) atom' '
+	git for-each-ref --format="%(symref:short)" refs/heads/sym >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.10.2

