Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A248C54FCB
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 20:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C4562072B
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 20:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhJvTr2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgDYUmW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 16:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgDYUmV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Apr 2020 16:42:21 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803ADC09B04D
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 13:42:21 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id d17so15813764wrg.11
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 13:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=JSA4xZhlA6B2Zxbdqe7yNKm8yvfPps1VkxFWIpSH4p8=;
        b=DhJvTr2SOqsv77lvh4zrO5MpIaYKGTVZ57SWrBcmFkhGhGrdyiZUAz26Fsub42aY28
         w0cjs0x1c1973CLdcFkft5BWdycpBLXaIlByZo+HoxTZ5JSyAhK7CvFRnmyiyX/J31iE
         kDZBO9zZ3wcPboIn5x/0SSLWkkNTJjcp4l45/nmacHBHWmp1Uohv34p06dPzWbPswsFP
         06R7d2xYdCn49rRwnXwaZt2BdGv0BrOyvk+gMGBuFJAG8+Pbqog8Rm4PiUnh9kuf+XuE
         bN57EkaBSXhPMgWBFRidWzgJ2rZUecWTS67rMCA3YFjN/Z4V5u0w9zDyK5dtLxQoX90U
         pESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=JSA4xZhlA6B2Zxbdqe7yNKm8yvfPps1VkxFWIpSH4p8=;
        b=kYeZ0O5SMIYxvdfB4LOIVfRVvtnVQYNzToy+CZPd3AA0hGX90xO/3FQX2nbRUI4niB
         j3G7Co37fmOh0yP69+g75EXON7sN2Kn3p8FUNireGtJohG0nDZip4gvdilP/E8Yqkhex
         8bJR7llXxh+pPpaD2dHfxEPtXvyDphDV53+gyPTXnoKRis47KdGIhr085PGraucIjDmz
         Oo//OvsT5QsPlcgjwZEXm1uywoWhfHystmnk14KIGdrCJeMGVWFTGHxt5ueJDMveYtuL
         nxskUfHezP7aU7ds44l4B+Aj41pTX14J8LsJp81cRZuBAe9qQAiv8+ZZvZ8C4Y+hgLx3
         cuPg==
X-Gm-Message-State: AGi0PuaZ8C1o1nToXa4sWUpHJ1ZUTkbs5YvdB6o3zSb3mgTysAB/8sqs
        lv9V8Ajqhpjq0Ewshvv0z46ihmz9
X-Google-Smtp-Source: APiQypLHHPHdu868WFBIBn2u6bF3aPoc5vovWKyAAqDuHr3zMIQZHXsIOeAa7ZKKN6T2UkTR5mqYxQ==
X-Received: by 2002:adf:fe45:: with SMTP id m5mr19977882wrs.124.1587847339979;
        Sat, 25 Apr 2020 13:42:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h13sm13304162wrs.22.2020.04.25.13.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 13:42:19 -0700 (PDT)
Message-Id: <pull.767.git.git.1587847338677.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?Rapha=C3=ABl?= Gertz via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sat, 25 Apr 2020 20:42:18 +0000
Subject: [PATCH] commit:fix use of uninitialized value [...] in server log
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Rapha=C3=ABl=20Gertz?= <git@rapsys.eu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Rapha=C3=ABl=20Gertz?= <git@rapsys.eu>

This change fix the message about uninitialized value when trying to
access undefined hash indexes.

The error message fixed:
Use of uninitialized value $params{"action"} in string eq at gitweb.cgi
line 1377

Add myself as warning fix author.

Signed-off-by: Raphaël Gertz <git@rapsys.eu>
---
    gitweb: fix tests on uninitialized hash indexes to avoid uninitialized
    value warnings in server log
    
    It's happened that I tried to solve lots of meaningless warnings in web
    server error log.
    
    I think it makes no sense to spam error log with warnings about
    uninitialized value when trying to run careless tests on undefined hash
    indexes.
    
    This is a simple fix that I did long ago that check carefully the index
    before running tests on it.
    
    I added myself as warning fix author as well.
    
    My goal is to avoid re-applying the patch on each distribution update.
    
    The warning message fixed in web server error log : Use of uninitialized
    value $params{"action"} in string eq at gitweb.cgi line 1377
    
    Raphaël Gertz: gitweb/README: add myself as warning fix author
    gitweb/gitweb.perl: fix careless test on undefined hash indexes
    
     gitweb/README | 3 +++ gitweb/gitweb.perl | 4 ++-- 2 files changed, 5
    insertions(+), 2 deletions(-)
    
    Signed-off-by: Raphaël Gertz git@rapsys.eu [git@rapsys.eu]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-767%2Frapsys%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-767/rapsys/master-v1
Pull-Request: https://github.com/git/git/pull/767

 gitweb/README      | 3 +++
 gitweb/gitweb.perl | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/gitweb/README b/gitweb/README
index 471dcfb691b..8964478a3fc 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -66,5 +66,8 @@ AUTHORS
 Originally written by:
   Kay Sievers <kay.sievers@vrfy.org>
 
+Perl warning fix:
+  Raphaël Gertz <git@rapsys.eu>
+
 Any comment/question/concern to:
   Git mailing list <git@vger.kernel.org>
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1a02a1242d5..37dfce202a0 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1420,7 +1420,7 @@ sub href {
 
 		# since we destructively absorb parameters, we keep this
 		# boolean that remembers if we're handling a snapshot
-		my $is_snapshot = $params{'action'} eq 'snapshot';
+		my $is_snapshot = defined $params{'action'} && $params{'action'} eq 'snapshot';
 
 		# Summary just uses the project path URL, any other action is
 		# added to the URL
@@ -6012,7 +6012,7 @@ sub git_history_body {
 		      $cgi->a({-href => href(action=>$ftype, hash_base=>$commit, file_name=>$file_name)}, $ftype) . " | " .
 		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff");
 
-		if ($ftype eq 'blob') {
+		if (defined $ftype && $ftype eq 'blob') {
 			print " | " .
 			      $cgi->a({-href => href(action=>"blob_plain", hash_base=>$commit, file_name=>$file_name)}, "raw");
 

base-commit: e870325ee8575d5c3d7afe0ba2c9be072c692b65
-- 
gitgitgadget
