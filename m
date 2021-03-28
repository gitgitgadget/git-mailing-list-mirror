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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3998C433E8
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 02:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 906006197C
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 02:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhC1CO4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 22:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhC1COK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 22:14:10 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F5BC0613B1
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:14:09 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b9so9305517wrt.8
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mJYxwjZYJ/GhGshQjobm2XPyqoYPLNWcPjjNAQS+q5I=;
        b=J4g6VasLsJrdNeTrZ63ip8muuWwzp2cqVG0peWrIAJOZfkXW+5uCBeJKz4jrDZU4vi
         jAh4JdXatmjG76C5D6eg9otCslde0bljL0pmxduPVz83dhYpe0Ir9NE1yZu2ujeNajUl
         70Ghn0AGvOrYx4IBYx1ebFTMkefLvlg5d6wHyRoU9O8ZmLxQ3ICPh0d6kEssmlR02kn4
         4YoXHVO94892Kg7LTnB6YSuJ5t8xP5LnMHLnUwbbP/7K6+BhJ+Rrc53sMOt/lAE3Il7C
         Mcr1u/D1pZmheVno2xCSvTIT4r5OQzQQwUZAmfrU8q/xyrp/skSI0NHQrcCXzqCFFQT5
         5+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mJYxwjZYJ/GhGshQjobm2XPyqoYPLNWcPjjNAQS+q5I=;
        b=cuxuhGbG+MVzqpjazuXZ5giuvH7LvxryxT5mgsLWYzaqfAbnVObfU7CWdUi0D5I+Av
         mm77hUat3BFQOKHNS/v9HEJo8uXW1rsDqq5cqxJyk0NccIsr6ptQFWSCF4LC9VQHwh0+
         lbPKwlEryo4ELWWOzXqnxRP8HQ+2aQld+Edv3e97jRvIzmFFZYNyX5DQ8gQRdDZyCcAw
         931Wi9Ak8xcW4ms4ZoHOf4InQOEw9lT7UupBzbMOLuDTKx2ivoRaHXYuL1MslK7jAx3D
         w4oTMFQEhDmApuK/PqYTNSXpbkPoKq1vmf/iqG1RHDog+a1itDmxbTYpink01QirrgOt
         eKZg==
X-Gm-Message-State: AOAM5333MzU+Qm9i22pNQZG26swJU9bn2NLcxoNITkhAIgdm9SgXSmdv
        /gtX5YbIcZnrWv5hV/wZnM30r4XQBjjsuA==
X-Google-Smtp-Source: ABdhPJwOAlEkodv/sFBLrjzOA3hpgc6pO8kHBAnUzxL+92iPWGEaOEC2dTxozavqt1sqsK6aL0zeFw==
X-Received: by 2002:adf:bb4c:: with SMTP id x12mr4802474wrg.271.1616897648275;
        Sat, 27 Mar 2021 19:14:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c2sm11291524wrt.47.2021.03.27.19.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 19:14:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 05/10] object-name.c: make dependency on object_type order more obvious
Date:   Sun, 28 Mar 2021 04:13:35 +0200
Message-Id: <patch-05.11-1ebcf1416b8-20210328T021238Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.442.g6c06c9fe35c
In-Reply-To: <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
References: <20210308200426.21824-1-avarab@gmail.com> <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an assert to make it more obvious that we were effectively
hardcoding OBJ_TAG in sort_ambiguous() as "4".

I wrote this code in 5cc044e0257 (get_short_oid: sort ambiguous
objects by type, then SHA-1, 2018-05-10), there was already a comment
about this magic, but let's make sure that someone doing a potential
reordering of "enum object_type" in the future would notice it
breaking this function (and probably a bunch of other things...).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-name.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/object-name.c b/object-name.c
index 4d7f0c66cf2..b6a7328b7a7 100644
--- a/object-name.c
+++ b/object-name.c
@@ -408,6 +408,8 @@ static int sort_ambiguous(const void *a, const void *b, void *ctx)
 	enum object_type b_type = oid_object_info(sort_ambiguous_repo, b, NULL);
 	enum object_type a_type_sort;
 	enum object_type b_type_sort;
+	const enum object_type tag_type_offs = OBJ_TAG - OBJ_NONE;
+	assert(tag_type_offs == 4);
 
 	/*
 	 * Sorts by hash within the same object type, just as
@@ -425,8 +427,8 @@ static int sort_ambiguous(const void *a, const void *b, void *ctx)
 	 * cleverly) do that with modulus, since the enum assigns 1 to
 	 * commit, so tag becomes 0.
 	 */
-	a_type_sort = a_type % 4;
-	b_type_sort = b_type % 4;
+	a_type_sort = a_type % tag_type_offs;
+	b_type_sort = b_type % tag_type_offs;
 	return a_type_sort > b_type_sort ? 1 : -1;
 }
 
-- 
2.31.1.442.g6c06c9fe35c

