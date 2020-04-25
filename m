Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A03C54FCB
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 20:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A94AC2076C
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 20:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEI8UmBL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgDYUnU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 16:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgDYUnU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Apr 2020 16:43:20 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDBAC09B04D
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 13:43:20 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x25so15191500wmc.0
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 13:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=Iln18u0Op50R3h5XGatxTPfZEKYMynP2JsInlsWgkdQ=;
        b=hEI8UmBLfq+BUFRJXEoouZLuRUSHqv0HXRCIi7Pudy8t+NfvCZ1Fec9JlYqLxMC7jX
         llRTDdPeMxO6VngWER1Wb8emev1xDpQEYPdM6V8ead1wpZaO+IgGzbNK3WUxoqp0lkW8
         rBny2pTX48Rc/aZB/HNpc2ua/6+rctdm5gQANrOMc5stMywhGZfPBODVCID0BZe/8/7v
         b30DQ5fWsxwDzMvfOKrUkikkyakxFwYx7dFC8jI+470YXOJ0ullV8tNBeGbchFOFFqbg
         DTRre2/UWrBnaTUXiR39QM1Nm70mWLgdKAb+cXnUKVtxdlZHTYdWA9lotVQleeUL9cmq
         XhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Iln18u0Op50R3h5XGatxTPfZEKYMynP2JsInlsWgkdQ=;
        b=JX4Hku787I/WcKJgjzppVgsk9bLRUjZnGnkA6xIBZU4KO11RBSq4z8JZfTzRGh4D9O
         PaECg/RRgVOd9GA1r6OoGLGW2iN7CtpqEtrIicyXjg/ZQqqoujHnd2TXVDE4JM7SEjBi
         mA5BtoBNY4zppF554VWNSBMk99+O/c4R16anslsxpG9OBClxyaaWL+nW6JzvtbM6YN/X
         GVwYKMFDMlvLtyF84foltpSzkopTqzMMJw6JuvURkpFqNmLPMQeUsg+vt5bi2v3MOSqW
         KYW3ygo0LUgnYZ73vshvAdglZBwJ66Xn/4nOF83Bt8cPnZIgzz6BGIW7Hs1Xva0fCM5l
         Ke+Q==
X-Gm-Message-State: AGi0Pualxd0osxRv5aI0Q5O6FolU6259Vf/McpuadwvmnZn2u5D74a9c
        R5Qmk8zNBR2iwR2LF6jsUED+B5r5
X-Google-Smtp-Source: APiQypJNjc22NgPXh52UC0XclSMtUHiy2oOVoeBnGfW4pQ8PGnT00UOX+wNmfYTSiRL9PApQExpaHQ==
X-Received: by 2002:a1c:66d5:: with SMTP id a204mr17750152wmc.69.1587847398801;
        Sat, 25 Apr 2020 13:43:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q10sm13236258wrv.95.2020.04.25.13.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 13:43:18 -0700 (PDT)
Message-Id: <pull.617.git.1587847397970.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?Rapha=C3=ABl?= Gertz via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sat, 25 Apr 2020 20:43:17 +0000
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-617%2Frapsys%2Fmaint-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-617/rapsys/maint-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/617

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
index 65a3a9e62e8..76e71259824 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1406,7 +1406,7 @@ sub href {
 
 		# since we destructively absorb parameters, we keep this
 		# boolean that remembers if we're handling a snapshot
-		my $is_snapshot = $params{'action'} eq 'snapshot';
+		my $is_snapshot = defined $params{'action'} && $params{'action'} eq 'snapshot';
 
 		# Summary just uses the project path URL, any other action is
 		# added to the URL
@@ -5998,7 +5998,7 @@ sub git_history_body {
 		      $cgi->a({-href => href(action=>$ftype, hash_base=>$commit, file_name=>$file_name)}, $ftype) . " | " .
 		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff");
 
-		if ($ftype eq 'blob') {
+		if (defined $ftype && $ftype eq 'blob') {
 			print " | " .
 			      $cgi->a({-href => href(action=>"blob_plain", hash_base=>$commit, file_name=>$file_name)}, "raw");
 

base-commit: af6b65d45ef179ed52087e80cb089f6b2349f4ec
-- 
gitgitgadget
