Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36E2C04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 07:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95DB7611EE
	for <git@archiver.kernel.org>; Mon, 24 May 2021 07:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbhEXHy4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 03:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbhEXHyn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 03:54:43 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A33C06138F
        for <git@vger.kernel.org>; Mon, 24 May 2021 00:53:14 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r12so27488035wrp.1
        for <git@vger.kernel.org>; Mon, 24 May 2021 00:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=22IHVNWW1hX0BHNHuewy05W2nm2PzCGuQmdt63jGpcs=;
        b=sVzLJ7Xw/oN+XLxmCsCC4wZgQr6QyLR2ZJNeHcpLmGpcWmLtzTNMxdWfs9fR0cYrNI
         AMMIRWJGKZ9bjyQ9hS/3k308qDfl7/b375ykzsnQa8uRVkPPjX7m9RiZXMCYtbb5nqkJ
         MIWMxpm+OCHEXejbHvP9Mwrkjb1QJAgYoPUvbX8haF4TMDEYb2v0BWd2bE2nlxm3wsQh
         Jth+MW9NWe5kkEyFr95uiZ9bRHbfHTbVXbCEBnDM9+ByZ0LZzpFTOzxComVzOgUbK1Es
         FxtLALrSahquYkAVaT+o/y5JueAxI3ZnnwY+C/vNKzU56f9AZnDmnzA4LCjUFq+/wBTA
         KVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=22IHVNWW1hX0BHNHuewy05W2nm2PzCGuQmdt63jGpcs=;
        b=nSraapMsvrXHFgxT5C5Z+c6JvCqmXY/XLhJJpGksHUIpioTUQmclu1JoGPLh7VMXbL
         tSJyXyU3mNCJEzkhOWReMFTkMaaZ/z5OJAeb58OilkNPfU/PN6GjokJ2JHQo31KM2Rh6
         38DP7WeK+DmrXEZV0STs06mb5z+7qZlKCZSijm4DJckO212XNdaKKwpfQ8LwHEUEjtGf
         T5SdH3HRU3LsYP7jGE2EvTDtcO9UgHrqEX0Tyt2oiPx+i65j0CHdfrF7Mln9BBR9kan4
         X5sXUfRB0teaGM8i5+J6DziKu6zxoIbjnSMRLFIKmbJWTEG5U73tocz5xe2r0vxk/F5B
         T1uQ==
X-Gm-Message-State: AOAM531pTKih6S5cix9GmnzGRD5fgUn7JnwHCULKAWKx345zDAY8UjYL
        jj7EMqtM6RNPr220u9/9IKoZsOKaDhYhS/4a
X-Google-Smtp-Source: ABdhPJzlW/+QbUEBn0whVrIRkKGJTQMIIzsPmjQ+3sMRTU/wb8QgC0RNv6MTwA3oWKv9/cT7bIgexQ==
X-Received: by 2002:a5d:4e8c:: with SMTP id e12mr20819562wru.94.1621842793098;
        Mon, 24 May 2021 00:53:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u126sm8540459wmb.9.2021.05.24.00.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 00:53:12 -0700 (PDT)
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
Subject: [PATCH v4 09/13] send-email: get rid of indirect object syntax
Date:   Mon, 24 May 2021 09:52:58 +0200
Message-Id: <patch-09.13-dd24f1249f5-20210524T074932Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.385.g46e826f1e55
In-Reply-To: <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com>
References: <cover-00.13-0000000000-20210523T085231Z-avarab@gmail.com> <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com>
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
index 83f764a8bf9..f1542cb3ea6 100755
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
2.32.0.rc1.385.g46e826f1e55

