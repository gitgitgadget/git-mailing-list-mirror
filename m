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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF78CC433E9
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4B2422D74
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730896AbhAEToO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 14:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730878AbhAEToL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 14:44:11 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E02C061795
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 11:43:30 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id m5so327485wrx.9
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 11:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wwUGvVur+FvIq4/QiGKaq0bgr2Q0NO9gp1We0037vu0=;
        b=JrkiuciiZ4sLW0HSjMGfTjdBrHx9U6wZGggXw1jlY/e1jdG6L4xFccObC8FUXazMzm
         QtmeBsYwakKnuYAVWk9usAUeC0Zqs6XA4HzT3o8MCvTC0XM2jZXHlu7hoZUi+mfTcTTF
         0TBodYjf8mAR5bAglxvV20vQbhJFVYhifert4DPKU8M+bia6y8k6s92GAvJSXe/4ndNz
         qagFB063y94IKcqfqV+rK+NcWKXlZSelP8PeiUq04KQ3I7KqhfItbwcP5mOphaAlfYT6
         tgoBfoNPJLqEyPsgLSdVBHCmFF05OaeNLR+X7h9evVYsXaxl45H+u8nB3GdgVNdZZCwO
         CJCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wwUGvVur+FvIq4/QiGKaq0bgr2Q0NO9gp1We0037vu0=;
        b=kp+DOQpQffVe0POFcI2tJZcov9NUIlnNARLUAwG5L+qGzPNTDOchLTSBaGpYHDeU7A
         e531WWZce1bQLsimPefRLXtG9vlyit7huNl24abfOq0huVfIbx+lO+0xQBld2T8nn8xQ
         7JCGexcl9Wa9JTRbkjbANPfRU9Q0w8XVLoAC3NBWOuBAZFhIgFiAyVFb/qKMgiWVvdQm
         8OAbuNIv6UrjyS/czROtAXbUJ0kBwJGMKEhRP8TmghwuqlJMyWtw76V+30o31eRXG2v8
         3+1nar0XtMfpyJ0E/UFgeo+r85MxIzEvzbD6i0TPKomHJleDL9k5ef87ATczOWTh+M9S
         K9Yw==
X-Gm-Message-State: AOAM531UIXmS8jrlcAtIsFAGCoBWFYG3vG3pdxWb8/+6+eiaDz96auym
        sfaCEUt2TPqHKzynrYwO5iaGqa6tZB+faA==
X-Google-Smtp-Source: ABdhPJxb0ARPyZVM2A0cw885rYZlQ4c8C1rxOs3Cz7gXgwZ3/xeMXT0LpoQ1y8YZqFf7OS2NHicXrg==
X-Received: by 2002:adf:ba49:: with SMTP id t9mr1067185wrg.183.1609875808903;
        Tue, 05 Jan 2021 11:43:28 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s6sm151113wro.79.2021.01.05.11.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 11:43:28 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 02/23] mktag doc: grammar fix, when exists -> when it exists
Date:   Tue,  5 Jan 2021 20:42:31 +0100
Message-Id: <20210105194252.627-3-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201223013606.7972-1-avarab@gmail.com>
References: <20201223013606.7972-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend the wording of documentation added in 6cfec03680 (mktag:
minimally update the description., 2007-06-10). It makes more sense to
say "when it exists" here, as we're referring to "the message".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-mktag.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
index a158428eb9f..1b0667e372a 100644
--- a/Documentation/git-mktag.txt
+++ b/Documentation/git-mktag.txt
@@ -29,7 +29,7 @@ has a very simple fixed format: four lines of
   tagger <tagger>
 
 followed by some 'optional' free-form message (some tags created
-by older Git may not have `tagger` line).  The message, when
+by older Git may not have `tagger` line).  The message, when it
 exists, is separated by a blank line from the header.  The
 message part may contain a signature that Git itself doesn't
 care about, but that can be verified with gpg.
-- 
2.29.2.222.g5d2a92d10f8

