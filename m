Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33834C433E7
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 19:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCD3420EDD
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 19:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBtKRdKM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393122AbgJPT3F (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 15:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408086AbgJPT3C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 15:29:02 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE4DC061755
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 12:29:02 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id i1so4259444wro.1
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 12:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CzrCPnbUvNSakWF2bvkdGZ4dwzkAgsYCMdLnhb7Mw8c=;
        b=eBtKRdKMYGn/qCuXP0RQG0m+Who+9XbZ37zYP1QRijQde2l++KYrbcqbch2RPe4W3E
         ew2stUdOLlL5iU1uQiU5kelfuMqJlWmn3wMOrvT7rXmbZ2tuz39Hp/HHnDiV4wNqU4n7
         ATqoqh7trlTZwkX+5mnaReq9UMhpFOs6lGIeVa8QO/CxV28W1AJCimwNjSr2bd6JfFeJ
         voQfAwDvNk4dP6GyEhPu5NOxMJ9PRBdfRxqFhcXaZ9JcpUjhhDU8TV0t5BfRQvyQPuaJ
         rfyilCjCTTXLhiCu1kUOT22t6eaChpuj+uKpNJh3MOxP+Vna38OKXw5gTl+j2x/p4YFL
         GzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CzrCPnbUvNSakWF2bvkdGZ4dwzkAgsYCMdLnhb7Mw8c=;
        b=pJuznAm4TypBZVWGZ+bLMVwHg+PgVakf1vSvcszv0We5glr2yi+NIA8IfSFka1AwF4
         3R4+XTVEH/8row23ldYR/UMk/ze1OtsCBAIpx691l7cQ2C37vKRG8uFSZ3jDENsqSlWM
         tug3QSSGBHtsjLAjF2kJ6azcbHfnLTXV8iAezSJWnxMBjIxak/jmzWoPH6zuYS/lJaIv
         PtX6byEbbT7aaWnehxXNKDpV2VB/amD+5onnoxRFYG2QkiTTLtHpSHUUszS95KzTxLfg
         28/Uyfv1lWjuS5QJ3rkE/UJOtw6MM8/lnQCukEhVMhCPJY12eZ4pZtDsw99CmZsnAcLM
         IcLQ==
X-Gm-Message-State: AOAM532SlsE3i344KZ96ucTZf9SksL+WYjmzK9U26KOLcKysM8vz6WQV
        FrV24fwJ4zJpJPNl0EIG8+T6A2+pIKk=
X-Google-Smtp-Source: ABdhPJyB/6WtTOoRHPaEPbocjaDIHJQ3PMyIQcj++VdMVOr0R3VoteV7jZr4Tx7pF7Bey0gdk9Yk2A==
X-Received: by 2002:adf:a31c:: with SMTP id c28mr6004995wrb.351.1602876536756;
        Fri, 16 Oct 2020 12:28:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d20sm4998662wra.38.2020.10.16.12.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 12:28:54 -0700 (PDT)
Message-Id: <bbae029cc868fbc7e628706ba60dfa2c7fd6192d.1602876532.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.878.v4.git.git.1602876532.gitgitgadget@gmail.com>
References: <pull.878.v3.git.git.1602710025.gitgitgadget@gmail.com>
        <pull.878.v4.git.git.1602876532.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Oct 2020 19:28:51 +0000
Subject: [PATCH v4 2/3] t6006, t6012: adjust tests to use 'setup' instead of
 synonyms
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

With the new ability to pass --run=setup to select which tests to run,
it is more convenient if tests use the term "setup" instead of synonyms
like 'prepare' or 'rebuild'.  There are undoubtedly many other tests in
our testsuite that could be changed over too, these are just a couple
that I ran into.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6006-rev-list-format.sh   | 2 +-
 t/t6012-rev-list-simplify.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index bc95da8a5f..99a1eaf332 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -339,7 +339,7 @@ commit $head1
 .. (hinzugef${added_utf8_part_iso88591}gt) foo
 EOF
 
-test_expect_success 'prepare expected messages (for test %b)' '
+test_expect_success 'setup expected messages (for test %b)' '
 	cat <<-EOF >expected.utf-8 &&
 	commit $head3
 	This commit message is much longer than the others,
diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.sh
index b6fa43ace0..7254060240 100755
--- a/t/t6012-rev-list-simplify.sh
+++ b/t/t6012-rev-list-simplify.sh
@@ -168,7 +168,7 @@ test_expect_success '--full-diff is not affected by --parents' '
 #
 # This example is explained in Documentation/rev-list-options.txt
 
-test_expect_success 'rebuild repo' '
+test_expect_success 'setup rebuild repo' '
 	rm -rf .git * &&
 	git init &&
 	git switch -c main &&
-- 
gitgitgadget

