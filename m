Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4974FC433E1
	for <git@archiver.kernel.org>; Wed, 13 May 2020 19:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED80F2054F
	for <git@archiver.kernel.org>; Wed, 13 May 2020 19:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KgShDzhs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390594AbgEMTM7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 15:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390571AbgEMTM6 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 15:12:58 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404D3C061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 12:12:57 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id dh14so735994qvb.4
        for <git@vger.kernel.org>; Wed, 13 May 2020 12:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sXvnFw5DSynKaqJB4JyX+C4cj+Wzy+yU2qOfv+2H8HQ=;
        b=KgShDzhsUxfkcrU+E4MGvqb1Y0hM4icJrkZOvzig9nsh0u9GciFvRvqBLv2ocCdqty
         EV/FxuW6LNLQZk7Ml5nXLvFWTKCEGmWw9ijXJHdIjeed/Ipb2j6npGt+pYHuSR7M+rJa
         vzO5ksR61ns8H+ZdnqmAelVJ3kup0A5snS+EUrlPVkbISgFT+MaJOj7DM9IAH24NvOk9
         6hCDSJIIjXJencSETISJdWdfMRNImOvFHeULOiu1I3/kRzbEGatTH76wdALBecKnuQ1p
         riQIz8KSdoUIj2pBZ5ImBEPcZxZyMdiqmnXFz1n6c8Ls3oZluY3+dgVf3XLtVMRA6L2v
         RRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sXvnFw5DSynKaqJB4JyX+C4cj+Wzy+yU2qOfv+2H8HQ=;
        b=oEHK0gVm8gJxEkoeh5waQOd4OLaWJSERPmf2QNFoF5alkRR1lePv5Ey0a8aB2zujsL
         68q8pXBVYpqV6HrMcjOmfEUBwLJwYp9rqgvY6baNHz4D5hmWNQCCIG0T6m1KPFtNUScJ
         dW4n9EQBAJAxYOv5xUFcJS+NLi/xi6NhTac6HVYgMmrdfQYfQGYaYFFbOZx9/W4nZvGW
         B17Z5Lw89upcCRdjYy6Bj8bQYz+6Qt/fizmV7z7ah3FfpoWGut0xKxF3HGICLxtfociA
         8zntarSy3ZI8dSnRTjgT8ej/qMUcLokMYRms2FHDp3P8FdOWb1s7pjkpICA0aIDr2Cky
         u7xA==
X-Gm-Message-State: AOAM530Qr2mySXfk5grsbW2DTukp8xA0yM/O4R2KJbV7xRNWBz70SYOt
        D+GvxAy14QGG//rzLQWfIqS3KQPNzREw+SP2Vb/zlQ9z3BcKGih8WZJJt3pGuXy8AhCSlyyzxds
        SbY3kq4FAY0doSlC/SHVOvw9dcM7yEOpfTLJTitoOvoSr6lvs8DEAvboTS6TdQjVGsHhpLs27xx
        gS
X-Google-Smtp-Source: ABdhPJwCpTpX0V6LoigeYjZAS97cJttPy5KPGPqNBegF9M1hRSuRjFRPM+P/vKUQ07tDIyB58ddCGTblHXsxoVFLFu2Z
X-Received: by 2002:ad4:4c4d:: with SMTP id cs13mr1125575qvb.207.1589397176374;
 Wed, 13 May 2020 12:12:56 -0700 (PDT)
Date:   Wed, 13 May 2020 12:12:46 -0700
In-Reply-To: <cover.1589394456.git.jonathantanmy@google.com>
Message-Id: <bee4fc7241596a6b4206fa8b52dfdaea88180f37.1589394456.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1589218693.git.jonathantanmy@google.com> <cover.1589394456.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH v2 1/3] t5551: test that GIT_TRACE_CURL redacts password
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        sandals@crustytoothpaste.net, gitster@pobox.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Verify that when GIT_TRACE_CURL is set, Git prints out "Authorization:
Basic <redacted>" instead of the base64-encoded authorization details.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t5551-http-fetch-smart.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 6788aeface..acc8473a72 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -185,6 +185,18 @@ test_expect_success 'redirects send auth to new location' '
 	expect_askpass both user@host auth/smart/repo.git
 '
 
+test_expect_success 'GIT_TRACE_CURL redacts auth details' '
+	rm -rf redact-auth trace &&
+	set_askpass user@host pass@host &&
+	GIT_TRACE_CURL="$(pwd)/trace" git clone --bare "$HTTPD_URL/auth/smart/repo.git" redact-auth &&
+	expect_askpass both user@host &&
+
+	# Ensure that there is no "Basic" followed by a base64 string, but that
+	# the auth details are redacted
+	! grep "Authorization: Basic [0-9a-zA-Z+/]" trace &&
+	grep "Authorization: Basic <redacted>" trace
+'
+
 test_expect_success 'disable dumb http on server' '
 	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/repo.git" \
 		config http.getanyfile false
-- 
2.26.2.645.ge9eca65c58-goog

