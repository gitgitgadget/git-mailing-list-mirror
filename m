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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B700C4707A
	for <git@archiver.kernel.org>; Sun, 23 May 2021 08:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DF8C6100B
	for <git@archiver.kernel.org>; Sun, 23 May 2021 08:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbhEWI6B (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 May 2021 04:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbhEWI54 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 May 2021 04:57:56 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B45EC061574
        for <git@vger.kernel.org>; Sun, 23 May 2021 01:56:30 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l11-20020a05600c4f0bb029017a7cd488f5so6756270wmq.0
        for <git@vger.kernel.org>; Sun, 23 May 2021 01:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2vvH+sGTEs9tavLp8UCC7MGppAaEii1IXfkTEMjcJIc=;
        b=hZPvps6LLmym6J8u7k+kSbf8Jfw9HTc8h+aIdllYY08YzlSiyo+FHmpHqTzIw4j0fq
         LhTpCH5NqLeB7n7DGzGkWJvtJwpkyoVxXq+J8V0NbWRpYIEQFDmx2CzYhnr0sEbK/SV7
         tCGge1D/3hL0Yn6dVX70ZDdV5F21corfth44aO0IbawPDxDS9KWSvMUhL8pQCjpHGBB4
         jQYa05YNQRGKGOcKOovHnzyQwt/Z14O7jc5r/UdpOPYGqtnNYR/oioa9CVeGXXgzwCEu
         sw47teYuc/nJBtUBZ+R3NNCh80mG2PwcskbrhC6HLjs5epR92bxFGGcx2+ZyzCL2H4vv
         MQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2vvH+sGTEs9tavLp8UCC7MGppAaEii1IXfkTEMjcJIc=;
        b=WlHmDdU0HIk5uT8z7MxXnCHP7fetcbscMOUxcoz3Xp+Fc+Uqa7S3UkeU/IwNnLt91M
         Jxh3oN2s+JPLHdz3rGTEQg0KE3IC4Zb0qm5QVjShefBtXOQfEN2Kx7YKAE2PTNp3DS6w
         ckOpYmDoLjvwrjuWpnRR92NRNwiKfM9MADp41jnmXU4b3ZClnwlGjr/HXSIXfdOCuUfO
         OUNtUgPlVfo0H01OR4sHMCoYSYcV1Vml25GAPdr7xMPwzozctLJaediwxLtQPmYzMfIy
         XUXazz4/CaQdATLSwuo8uPdeRLPbxWEiudXVI69JxmkfxdpKy106Qz+8V1myjEhPOpSW
         MbZA==
X-Gm-Message-State: AOAM530CuskA96JQ4icAQLhhe3bmvYSBl7e8EG5+pQ0TSUCKtSeqXs5v
        89PE36Mx7O7jnFFohojC7xoma5JJB0vWxgpG
X-Google-Smtp-Source: ABdhPJz2jhsdEpkGDYwBRQrv7B9N9s9rLH+qRDdhTY33xGMe2grnFPDP++M0ouwl4hPDLkyVmLkoQA==
X-Received: by 2002:a1c:2743:: with SMTP id n64mr15486883wmn.76.1621760188608;
        Sun, 23 May 2021 01:56:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s15sm9577839wrt.54.2021.05.23.01.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 01:56:28 -0700 (PDT)
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
Subject: [PATCH v3 09/13] send-email: get rid of indirect object syntax
Date:   Sun, 23 May 2021 10:56:14 +0200
Message-Id: <patch-09.13-a806ce06f1-20210523T085231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.406.g05cb3eebfc
In-Reply-To: <cover-00.13-0000000000-20210523T085231Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com> <cover-00.13-0000000000-20210523T085231Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change indirect object syntax such as "new X ARGS" to
"X->new(ARGS)". This allows perl to see what "new" is at compile-time
without having loaded Term::ReadLine. This doesn't matter now, but
will in a subsequent commit when we start lazily loading it.

Let's do the same for the adjacent "FakeTerm" package for consistency,
even though we're not going to conditionally load it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-send-email.perl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 83f764a8bf..f1542cb3ea 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -194,11 +194,11 @@ sub format_2822_time {
 my @repo = $repo ? ($repo) : ();
 my $term = eval {
 	$ENV{"GIT_SEND_EMAIL_NOTTY"}
-		? new Term::ReadLine 'git-send-email', \*STDIN, \*STDOUT
-		: new Term::ReadLine 'git-send-email';
+		? Term::ReadLine->new('git-send-email', \*STDIN, \*STDOUT)
+		: Term::ReadLine->new('git-send-email');
 };
 if ($@) {
-	$term = new FakeTerm "$@: going non-interactive";
+	$term = FakeTerm->new("$@: going non-interactive");
 }
 
 # Behavior modification variables
-- 
2.32.0.rc0.406.g05cb3eebfc

