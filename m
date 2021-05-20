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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFDAC433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 08:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56B38610A2
	for <git@archiver.kernel.org>; Thu, 20 May 2021 08:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhETIUs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 04:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbhETIUl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 04:20:41 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10D0C061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 01:19:19 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id a4so16701047wrr.2
        for <git@vger.kernel.org>; Thu, 20 May 2021 01:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZrrdEqMCRDF5/Q5A0hIEtL3208jmftOezmToY775kEg=;
        b=eBw1MNWw1PDT9rtN6SOw8jiLTMn0LhUOZxWXdTjp8Hda0/Z9aOhoFz4MBbhTUAn8aV
         yekMfckvIJjpi1esTQgR7jeTh3CPST3BmpN9CoFlMoNTX75opaf8FXT8sb7y0e75+ZaT
         rA/QQVRnZ6B7Gs5DbOXjgRINJ9vhwh+JANft2CQwvb7GYWNHGYCdKOWuoLFws9srfKr0
         wGChvF1VsCivJ++2Ah6YPfGQgBcmUsxUpdFOkoiFpehzEB0iL/fF70vDD7V6mhx/Tpw9
         WPkvYVSSnJvnV/gb9clgIl9LFBOT89EfqyT+UHHymXZX2b0TaAVmYLDCF+Jr9mYN4fqU
         J2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZrrdEqMCRDF5/Q5A0hIEtL3208jmftOezmToY775kEg=;
        b=WCZHhi66B5btX8xfExsZsiq+hRuB2CxAUDAd8iDuqWDyyqRBp9fCW7nCcyJSa6+42+
         //O0dcVTH36iGxYTuDD9dh9F/Eo/j7xYLa1kgR3cSBk2W89xycuG6fkaQQ1UcyY7V2F0
         PO66KIY2aGMZWX+uinMuZuqujqIfSATuXnzOZVlsY9O1CYwDe5YjdMfKuwgxtkHvW4kC
         ZTFfafTv8iI0zDtBY6BDrNmIA/9p+qvIlfb5xJo0OqMCc2ug6OHHF4zR4CM7etDjJuKF
         EpFXFJ215aAQp4CVDwOatVUj4kw5TT/5L0ikIEVvvYMSNBWedDEmuhF+V4Lp3uy3jJzd
         Ln/Q==
X-Gm-Message-State: AOAM530tFkp1gKZBYCk7gWd9g9m/a/WckRIpVLVaqRyfdRc7oeeTnKIZ
        ddd/NqndS+FywT5SFFfSv23mi+whTV8/xw==
X-Google-Smtp-Source: ABdhPJzrgOBSaYMj8+9sLktCymwp/bT6KO/pTgTGdW9s3QHuFqWeeHe7gCOzGvN4MtUemqBhXegjkQ==
X-Received: by 2002:a5d:62d0:: with SMTP id o16mr3087111wrv.164.1621498758281;
        Thu, 20 May 2021 01:19:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y20sm8900004wmi.0.2021.05.20.01.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 01:19:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/10] send-email: get rid of indirect object syntax
Date:   Thu, 20 May 2021 10:19:03 +0200
Message-Id: <patch-06.10-fc27024f838-20210520T081826Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.405.g5d387561bb3
In-Reply-To: <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com>
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com> <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com>
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
index da46925aa05..f9c780ceed6 100755
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
2.32.0.rc0.405.g5d387561bb3

