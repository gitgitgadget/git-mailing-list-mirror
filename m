Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82395C43465
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 10:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4365220EDD
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 10:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vJryKzte"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgIUKk2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 06:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgIUKk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 06:40:26 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DC1C0613D3
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 03:40:25 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d4so11618584wmd.5
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 03:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GrSwXg1chwf57onYPkE0t51b6FsPqSH+dCG3ha5WJ0c=;
        b=vJryKzteTPwLdqH1cJbQGNxL6gWXZb3CnXXDZE1gsbH3xXuGX/qG8Y8sBsOxPU7TIW
         Yrh5UsI3vcbbgclws1pS7ttDHUqef/gLaokQGhXl0r+f8dCqn9kyfpAuNXTgcEVRm+Zk
         icBaUMAItJHPakB5SrAAgIbmWjri75xVO1h9j34blgrfm8mHhBPgWZBkLxsBP4sklAmH
         qFV3bZ1d2ACkGF4kFgoaPKpYGd+4XRhYDZpa1hCelvOxMnC3jb8CWEuiQvlWT3V2cCNH
         zS0fFM3uiYOalU3pzf3U3Lt1VQRUK4+lYRdKnjHJ+AQbwJOiH8/cpZkzOO/bvgvF59e7
         LPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GrSwXg1chwf57onYPkE0t51b6FsPqSH+dCG3ha5WJ0c=;
        b=iWE9vA4E3qSw0ajGYYcNy8rLkKAPNbqPa39DDhuWFBTITDoeMmybIANHws4zYQcB0X
         rMA0BLoX8mL19lbavzSMQsYuD1MzE4nytFbizOwIUu5LELbMfgy9vvWd/JIaIDaEQ/aO
         JqzJID/uiNBTK/pnKUD2RqYW+SbCQdiWB58Ug0KJGOgGdQ3nHJBPS2/DOtqb//Ynrsop
         pav+GhyEIX4CYrgSkchMj+gHfZsSlu9JjYX0w21pmMe47NKV7KFCZSfd8ePzV75xkcSC
         Sf2DFPvQSovDX4MP/7bcvr9AHo/WpiLXlzo8bTRc09Jav4mQTPWqIaFHDV/YBq2Gv6uy
         P96Q==
X-Gm-Message-State: AOAM530J42HtCSOGQOHnAheOex92azFgI9GrFfcfy0d7e7i91O1b7CCh
        dOu0ksmua+nbEyvE1SNwAykElJMQ22vuvA==
X-Google-Smtp-Source: ABdhPJxcbH5Ixz4+vpPfHJABq/+WnCdKvBqNcPAA7K4xps4yU/bIZqUfF8CXl+SaXHXNwe81tT9A2w==
X-Received: by 2002:a1c:1f08:: with SMTP id f8mr7858260wmf.168.1600684824095;
        Mon, 21 Sep 2020 03:40:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 9sm18647833wmf.7.2020.09.21.03.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:40:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, imon Legner <Simon.Legner@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 09/18] remote-mediawiki tests: use a more idiomatic dispatch table
Date:   Mon, 21 Sep 2020 12:39:51 +0200
Message-Id: <20200921104000.2304-10-avarab@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <20200916102918.29805-1-avarab@gmail.com>
References: <20200916102918.29805-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the dispatch table code in test-gitmw.pl to use a hash where
subroutine references are the values. This is more obvious than a hash
where the values are strings we'll use to go searching around in the
symbol table for the function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/mw-to-git/t/test-gitmw.pl | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/contrib/mw-to-git/t/test-gitmw.pl b/contrib/mw-to-git/t/test-gitmw.pl
index 0ff76259fa..afc4650b1a 100755
--- a/contrib/mw-to-git/t/test-gitmw.pl
+++ b/contrib/mw-to-git/t/test-gitmw.pl
@@ -214,12 +214,12 @@ sub wiki_upload_file {
 
 wiki_login($wiki_admin, $wiki_admin_pass);
 
-my %functions_to_call = qw(
-	upload_file    wiki_upload_file
-	get_page       wiki_getpage
-	delete_page    wiki_delete_page
-	edit_page      wiki_editpage
-	getallpagename wiki_getallpagename
+my %functions_to_call = (
+	upload_file    => \&wiki_upload_file,
+	get_page       => \&wiki_getpage,
+	delete_page    => \&wiki_delete_page,
+	edit_page      => \&wiki_editpage,
+	getallpagename => \&wiki_getallpagename,
 );
 die "$0 ERROR: wrong argument" unless exists $functions_to_call{$fct_to_call};
-&{$functions_to_call{$fct_to_call}}(@ARGV);
+$functions_to_call{$fct_to_call}->(@ARGV);
-- 
2.28.0.297.g1956fa8f8d

