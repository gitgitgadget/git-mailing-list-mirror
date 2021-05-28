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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CD8C4708E
	for <git@archiver.kernel.org>; Fri, 28 May 2021 09:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F40A9613B6
	for <git@archiver.kernel.org>; Fri, 28 May 2021 09:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236209AbhE1JZy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 05:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbhE1JZk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 05:25:40 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2865AC0613ED
        for <git@vger.kernel.org>; Fri, 28 May 2021 02:24:04 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso6409448wmc.1
        for <git@vger.kernel.org>; Fri, 28 May 2021 02:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Ccp4jAR8aBm0TTvorAB3HUQqDUytbWlk6QrCX2oTao=;
        b=O4eozcz/JVmzOjrLGWhQapFcOnZuQa2/4078M8YFIRCmA7+JyTb31f3yz+A19BH4ar
         Ad80g/QHln3zK28vleb6kfHBMEbN2DJd4Q3AS8vauJlRch6Snw1Q1jSt5u55K8v5c9IA
         krsuG3SWBSLsh6Q74kjBlLK6+cTcUkjJ2fwqOjduBxJwsKEtCTBPtSfOytYMvUHgq+W9
         gmxufUrZUMSd6Vj9g4tIfyIuK+66UNssVlY7Bukwg2CtRGLXlYeAq+doDsmoVtWJHmSn
         r4BhMjCPke77JcZ0ngGLlrDLciEzkDvP4SUuHe5ZIGr4fmIMQCYHL7FfrZNbn3ebHmuK
         slfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Ccp4jAR8aBm0TTvorAB3HUQqDUytbWlk6QrCX2oTao=;
        b=D9yh0TyNqdOLJpVJ5AkmBTnwt9B3Kr39GEiQqFl1vy7cGD79AytvXqz8M4sJoyHac9
         pgtOdHka6/tYOgCfnbSlb/ydsin8MtlP3SDDiDy6EpyGEEuOrOSQp9OwzyCJyxGuEzuL
         +ozZV8EM8xaiBrXp0gIpK1Iyy89vBESzfx4PbsfEJ+CBER1EMlHiPk7UbQsjmAlsAsnD
         Cxq5pQPvcnxXdF4KaGbdoRVqBINaSSl4QCahagWknrEYigdrEoO2Fic1OrZjnqwdzaOU
         vRhyFfkcNc1EY+8G8p/BP57R1bHBJe8aVUhwgGff9N8Io0Xk0hjaK4fZQGG67wpbi3tl
         6/LA==
X-Gm-Message-State: AOAM533vzHWzFfGTAlnRJvHtkvARomqZFfQmvF9cBHyJBEDp5PkYctZT
        3xLEsRNFfGR2XgK+AiPO2VNdQ5N9F3cRDw==
X-Google-Smtp-Source: ABdhPJxLdvl8Bv6BWw1YYlpWciCKT4zUED/Mb/FwRdyIeD+xOcOz2iLg4RGehIE0jtCgmwlzuBsh9Q==
X-Received: by 2002:a05:600c:2cd2:: with SMTP id l18mr7498976wmc.142.1622193842423;
        Fri, 28 May 2021 02:24:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18sm5842009wmj.15.2021.05.28.02.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:24:01 -0700 (PDT)
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
Subject: [PATCH v5 09/13] send-email: get rid of indirect object syntax
Date:   Fri, 28 May 2021 11:23:48 +0200
Message-Id: <patch-09.13-881b1093409-20210528T092228Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.458.gd885d4f985c
In-Reply-To: <cover-00.13-00000000000-20210528T092228Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com> <cover-00.13-00000000000-20210528T092228Z-avarab@gmail.com>
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
index 44dc3f6eb10..cc1027d8774 100755
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
2.32.0.rc1.458.gd885d4f985c

