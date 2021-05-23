Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDEBC47081
	for <git@archiver.kernel.org>; Sun, 23 May 2021 08:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33BA3610C8
	for <git@archiver.kernel.org>; Sun, 23 May 2021 08:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbhEWI6C (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 May 2021 04:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbhEWI55 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 May 2021 04:57:57 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9B4C06138B
        for <git@vger.kernel.org>; Sun, 23 May 2021 01:56:29 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r12so25287691wrp.1
        for <git@vger.kernel.org>; Sun, 23 May 2021 01:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wmftQ5mGCEZYWpgi2EdyIEenIjUFZnD+t9yLMJSTulE=;
        b=l+uTJf62TyatVjPYq5xW/GBcOWjCwzTSg4khZxaP1vWOJ9HROmyrSvKQrvUS6FJEng
         3irj1chdafljLohooAaxrZjigNWwV5RCWNgzSNMcJNf8R6efBmHcsTyVXCFe3rnGlNbq
         EQNdgHNEsu+t5Rl6OCoL0f8EcTG1lGg9qqagG/35kCJRYAc6M5cM1OT/Y/M7nHwTNbxj
         i4NRLFWdPA1uEPn0dL9/5DeeY1BVZDzFb2BQUvRFJxQ9yY8y8lpkGe8SZmCnEYIbkSv3
         KHumXrLU8dd0gUq1PxI+OIPVP1PCG5H47Jcd21fAeGXbXSDxKfYoGCvPKVFPGFG6Yns6
         dK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wmftQ5mGCEZYWpgi2EdyIEenIjUFZnD+t9yLMJSTulE=;
        b=LzxN6Q1c4EwUlNFdH6iXOfebwv333PVbzS0hPUClyStRr5jRgS2VRZo7JtxjAED43X
         Pd/2M8UUPR6PV4XD5hBt1lojvndaQvEggboKuf+Or/BkbGf7v9CR8xlHG03tFjbsygMW
         sINSAmNKu2bEOD7EX8S7YL0+/yEgYwIUZICH8QvabJJRaHkQDPAgV87JiaPV6x0Cuot4
         +ky5MApFVZrzogFeNyulpJduHflbZNdZwRtIy1hLfaUatcrM+riU93ZIKTix06K95X1G
         vrnYklgMxB0Hq0V0lPq+se6tp89ZCcH+KXPH3WNuPONnuLnOO0xaw/7gfkzwdFJJoD6K
         MsdA==
X-Gm-Message-State: AOAM532mbV66wstGN5pjwKXXXNtKIdN5ZF8AZg93aBPN+jE43G8IThc7
        JJiXm7XigqJ5qbiG1Ck07fxMNaqNHZ9x3Its
X-Google-Smtp-Source: ABdhPJyIIFCJ3akiBj5EjIh3nSU2RVDXZp1uxNvQD9SYYHvKyHtI41n6bGQsDuWnE4gzSHL6ZiTHRw==
X-Received: by 2002:a5d:4046:: with SMTP id w6mr17240695wrp.15.1621760187833;
        Sun, 23 May 2021 01:56:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s15sm9577839wrt.54.2021.05.23.01.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 01:56:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 08/13] send-email: use function syntax instead of barewords
Date:   Sun, 23 May 2021 10:56:13 +0200
Message-Id: <patch-08.13-e1fc71e3f9-20210523T085231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.406.g05cb3eebfc
In-Reply-To: <cover-00.13-0000000000-20210523T085231Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com> <cover-00.13-0000000000-20210523T085231Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change calls like "__ 'foo'" to "__('foo')" so the Perl compiler
doesn't have to guess that "__" is a function. This makes the code
more readable.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-send-email.perl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 56bd5b0e50..83f764a8bf 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -696,7 +696,7 @@ sub is_format_patch_arg {
 		if (defined($format_patch)) {
 			return $format_patch;
 		}
-		die sprintf(__ <<EOF, $f, $f);
+		die sprintf(__(<<EOF), $f, $f);
 File '%s' exists but it could also be the range of commits
 to produce patches for.  Please disambiguate by...
 
@@ -782,7 +782,7 @@ sub get_patch_subject {
 	my $tpl_in_reply_to = $initial_in_reply_to || '';
 	my $tpl_reply_to = $reply_to || '';
 
-	print $c <<EOT1, Git::prefix_lines("GIT: ", __ <<EOT2), <<EOT3;
+	print $c <<EOT1, Git::prefix_lines("GIT: ", __(<<EOT2)), <<EOT3;
 From $tpl_sender # This line is ignored.
 EOT1
 Lines beginning in "GIT:" will be removed.
-- 
2.32.0.rc0.406.g05cb3eebfc

