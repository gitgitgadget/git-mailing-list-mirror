Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5618CC433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C2D864F06
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbhBXT5f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234632AbhBXTyC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:54:02 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80444C0611C0
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:14 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id t15so3022759wrx.13
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jg49T9UTxeIztOS1FaIL5Iu5Ob9FEZiMVmJUv2/c818=;
        b=Fgj0k2PCFT2A5khmOWTqW3AWbjyM99JQVRbLpa40lsWdc6Rc/fcjJOuykfX9jQXmWN
         O6/L6R0ACM1/yxaTC+R6GqZ60+N9z7DJrAJ/MVzDB3L9X9BGxS1uca3tSdFV7yw4851Y
         nsUlaNSUUtV4wTv9aywBoya/3HFahnT+NEQ7E6u6pl3pyo6BB/on9inVR3MxJj0V534J
         DoYrFhN2QqvoBolBkBkYC0ln+lGECPYVCryn8YF5cwQX0NQ/2ND3LCH3dI9YYpfZ6rTV
         OZoIlbEXnPmZd2CRji3SsrYz3f+2WBw8ZWyF55CM/fUv5AqXmL2q/I1C29xJMkIdqN8F
         5/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jg49T9UTxeIztOS1FaIL5Iu5Ob9FEZiMVmJUv2/c818=;
        b=L0K50U8Q4pVlCZKkKcUPx+WnODWVxRWEpi4Uv2CRczE5d61znOGvUc2Gg/qhduSkkc
         GsA4wt307eiTHjT/8BSWbgAjbgTX41tOXj/3yqZdtYK7zdT11/apIClpSMl/eFDZkZ7c
         sZS4sVdKT9e50FPD3cpSAfV7mQpPOjV+3HJJKSy21LwD05F2eB+ExI3a3/Ob9VNqZJ3/
         2T8eP3R6utGPggBhnHYLjqAM00tMlbg87BOypFo8NVo93X06S0DIdhpphBBDfiv3Bfko
         ZZ4iKqE6x+bB//oPh08PH4NhEfMlgopFbke52tW2JJtobqIo/NCiYqY6AKGI2d2DgxPE
         VM5A==
X-Gm-Message-State: AOAM531kXbJddTz4h6vZUJGkUVJrXEnXU+FwoyfD5A8wfyRdvFyZVS+y
        F8az4dzw3BypKehwvSUOSF82MNRwQM70BQ==
X-Google-Smtp-Source: ABdhPJziUekeQSoxY/vnLJt0AjxRNJMNiFL4v8tEAQDKBfmmwU9rMMF2C6jhGixWprc2YMQbytfYdQ==
X-Received: by 2002:a5d:47af:: with SMTP id 15mr33317453wrb.205.1614196333031;
        Wed, 24 Feb 2021 11:52:13 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y2sm4786072wrp.39.2021.02.24.11.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:52:12 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 24/35] userdiff tests: move away from "RIGHT" in perl.sh
Date:   Wed, 24 Feb 2021 20:51:18 +0100
Message-Id: <20210224195129.4004-25-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215154427.32693-1-avarab@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "RIGHT" token is no longer magical, see recent changes to
t/t4018/README. Let's change it in the recently moved perl.sh
tests. This change was done separately so the earlier commit could
benefit from the "diff --color-moved" detection.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018/perl.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/t4018/perl.sh b/t/t4018/perl.sh
index ac8fff7417a..b53b759353b 100755
--- a/t/t4018/perl.sh
+++ b/t/t4018/perl.sh
@@ -5,9 +5,9 @@
 
 test_diff_funcname 'perl: skip end of heredoc' \
 	8<<\EOF_HUNK 9<<\EOF_TEST
-sub RIGHTwithheredocument {
+sub withheredocument {
 EOF_HUNK
-sub RIGHTwithheredocument {
+sub withheredocument {
 	print <<"EOF"
 decoy here-doc
 EOF
@@ -19,9 +19,9 @@ EOF_TEST
 
 test_diff_funcname 'perl: skip forward decl' \
 	8<<\EOF_HUNK 9<<\EOF_TEST
-package RIGHT;
+package Some::Package;
 EOF_HUNK
-package RIGHT;
+package Some::Package;
 
 use strict;
 use warnings;
@@ -35,13 +35,13 @@ EOF_TEST
 
 test_diff_funcname 'perl: skip sub in pod' \
 	8<<\EOF_HUNK 9<<\EOF_TEST
-=head1 SYNOPSIS_RIGHT
+=head1 SYNOPSIS
 EOF_HUNK
 =head1 NAME
 
 Beer - subroutine to output fragment of a drinking song
 
-=head1 SYNOPSIS_RIGHT
+=head1 SYNOPSIS
 
 	use Beer qw(round finalround);
 
@@ -59,9 +59,9 @@ EOF_TEST
 
 test_diff_funcname 'perl: sub definition' \
 	8<<\EOF_HUNK 9<<\EOF_TEST
-sub RIGHT {
+sub asub {
 EOF_HUNK
-sub RIGHT {
+sub asub {
 	my ($n) = @_;
 	print "ChangeMe";
 }
@@ -69,9 +69,9 @@ EOF_TEST
 
 test_diff_funcname 'perl: sub definition kr brace' \
 	8<<\EOF_HUNK 9<<\EOF_TEST
-sub RIGHT
+sub asub
 EOF_HUNK
-sub RIGHT
+sub asub
 {
 	print "ChangeMe\n";
 }
-- 
2.30.0.284.gd98b1dd5eaa7

