Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1072C43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 12:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 954C62224D
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 12:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jD8Qy0Rh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgIPMOC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 08:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbgIPKcf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 06:32:35 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D995CC0612F2
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 03:30:10 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l9so2425338wme.3
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 03:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GrSwXg1chwf57onYPkE0t51b6FsPqSH+dCG3ha5WJ0c=;
        b=jD8Qy0Rhj90EF4O3SJ3TgHfSFpz9i2h0QjB/VdgJcNR8RsYms9BHa8r81LsLl5rQTd
         48ohKypWuxv7FB3jujPRq1W2QHK8dpYgWnUvOuxudo5FdD7znvHkuToqGArARxZYhDpE
         DctyT6ylNonwNvvDJkRriUuUSDrbbSzOHCj94N/h2UlHlVgi2Lyt//WwxgTwzkFvlHSH
         ZIdrEc63lK4bR/2vD3Ihk8j7KBY/gSlCDKg353N5K/gGAefjXgggznQ7Rcs6uqd3bI9N
         Olcw6O6MAlwL+qV/BNz2ROfSo4xoKeW9jZHkDXWGvdkeDaJQFcdkzHvFxIruDqieACf7
         txEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GrSwXg1chwf57onYPkE0t51b6FsPqSH+dCG3ha5WJ0c=;
        b=TOQOkUZLqI0DB/MS+Z7wx0jvS7GwZbq56KNadH9Gs67jrCihQLMScXbH5poqeTaCI9
         E2tJwypnzTw2fDL+VYz8KZmRZ/C99b/lr25HW6YBbbzkGtGQra7UNSTiHDnNJ/UhAS5E
         Ku+z6ZuDRhlBve/WVfAgQfw99Kjg/2lqnyTmCq+UVVomv7EI0KqlPFVt1xGXETSDtDPp
         PG49cn4KNMFFulsQPEWvfuskzyKdKzDyL8f7qCvkzvK0Xs6yyjcC35yshppWQVsOii9T
         jtdELZnv41j6kHw/s4RMn28VcaE7KXlL4WeNBgnpiw96PAjm0PXiHtoSYwI38s0v823h
         J39g==
X-Gm-Message-State: AOAM5338E3jfkRWPbm85Q+E6I9YrAyF6FazGSJ2wtl5si/Q+cdD7Z4WG
        5djD6o6B3R2KmGM+pQ/CkQIYCE8TbmcAjRFO
X-Google-Smtp-Source: ABdhPJzqGgOkKpb+dDq4MtRAoiFv1fxNmptngZ3gOfx3xugyTnqaR1TXnlNWrdO62AjkAYoYm+7A+A==
X-Received: by 2002:a1c:b407:: with SMTP id d7mr4187500wmf.59.1600252209342;
        Wed, 16 Sep 2020 03:30:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n11sm32172916wrx.91.2020.09.16.03.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 03:30:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>,
        Simon Legner <Simon.Legner@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 10/15] remote-mediawiki tests: use a more idiomatic dispatch table
Date:   Wed, 16 Sep 2020 12:29:13 +0200
Message-Id: <20200916102918.29805-11-avarab@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <20200916102918.29805-1-avarab@gmail.com>
References: <20200916102918.29805-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
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

