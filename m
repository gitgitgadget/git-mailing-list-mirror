Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFC7C433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 05:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbiA0F1I (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 00:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236166AbiA0F1A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 00:27:00 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4575C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 21:26:59 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id w11so2631979wra.4
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 21:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hQ5h/lD9ocJdPAkDpgDWI0K6o6E0R0dg6EXEJKKX9WM=;
        b=fbqJZM1ExBtt1i1kUKnnOnDBQ8+NoJToPdofekq1l+Eiuezf1fHIate8yjg/SUUQwi
         Bsh2LR1hc9tzookOf0Ev1x+EOB8auis9L1AP+eFj9azCT4y4wS0NjFibgYKiVQ46pTgR
         93w4Tm7LtZpN0A68a8LqMfdhQ+FCz/d1whGG0var8730tPqZLxCancLHZSaQSs3tcMbP
         ChR9ljPWrPF3oThCRoXCdA2h8Cx1OGEIMJl2OAUhwtcPqZAjimoFo+Mr8d2kHCA1eyMA
         Wb1UUksFiqpGEAjPwQElcd51vvjIwJ9cYee7g75r/8WrwM3KxtYbxxxuiVSfrvNw7vMG
         9PEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hQ5h/lD9ocJdPAkDpgDWI0K6o6E0R0dg6EXEJKKX9WM=;
        b=PAfWoJ9TVf7JbzAboTk5fKPxCDJoDrpW1HSY6GQWpd1wXyb7lF+IsHypAc2jNVaNZo
         eU14zBm2/T6PSvUQ7LsCbOyxtwNQODTuMupMFZNpaHAo/WPN6CQn1BWQfHX5TOQ7Os9q
         KnBQVDGyPFPQmXOnXMZ8jOd71a3D/jfYO1Y0/w9k/qD9tcM7iVnjY4zzm/xShrzDoA+Z
         iywb7e1NfasjsPnMMyN55ENbYgpYPu0INS7xCJ8L46GSf7x9SHoEU/WRIgrLjx4tI2d0
         6Lg2H1VgyBw2dXX7TOdKcC69cRj2c3/NVEe3y4yRCKlQw8cl11YmLbTXpVp6NSOhL8SG
         HeCQ==
X-Gm-Message-State: AOAM533wLpP4p8V/3X86JAcHnAzTwP15H+1GJQhmbl2yZt0IWlE2dMql
        OxZW7Txv9z6EoFNofs+kcatrfqU6R6nUAw==
X-Google-Smtp-Source: ABdhPJw2Z3JJSLv6chNPO5eVlVGvqDz9LKksO5pGaHciMhlP6rhu7BqggGmUmwZYJepbB4Y4HlBRuw==
X-Received: by 2002:a05:6000:178d:: with SMTP id e13mr1466843wrg.317.1643261218097;
        Wed, 26 Jan 2022 21:26:58 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z5sm6017661wmp.10.2022.01.26.21.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 21:26:57 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 5/7] object-name: show date for ambiguous tag objects
Date:   Thu, 27 Jan 2022 06:26:47 +0100
Message-Id: <patch-v8-5.7-6237f07e3a9-20220127T052116Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.890.gd7e422415d9
In-Reply-To: <cover-v8-0.7-00000000000-20220127T052116Z-avarab@gmail.com>
References: <cover-v7-0.6-00000000000-20220111T130811Z-avarab@gmail.com> <cover-v8-0.7-00000000000-20220127T052116Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the ambiguous tag object output nicer in the case of tag objects
such as ebf3c04b262 (Git 2.32, 2021-06-06) by including the date in
the "tagger" header. I.e.:

    $ git rev-parse b7e68
    error: short object ID b7e68 is ambiguous
    hint: The candidates are:
    hint:   b7e68c41d92 tag 2021-06-06 - v2.32.0
    hint:   b7e68ae18e0 commit 2019-12-23 - bisect: use the standard 'if (!var)' way to check for 0
    hint:   b7e68f6b413 tree
    hint:   b7e68490b97 blob
    b7e68
    [...]

Before this we'd emit a "tag" line without a date, e.g.:

    hint:   b7e68c41d92 tag v2.32.0

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-name.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/object-name.c b/object-name.c
index f31b50bc315..cbf459f5664 100644
--- a/object-name.c
+++ b/object-name.c
@@ -408,19 +408,24 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 			 * TRANSLATORS: This is a line of ambiguous
 			 * tag object output. E.g.:
 			 *
-			 *    "deadbeef tag Some Tag Message"
+			 *    "deadbeef tag 2022-01-01 - Some Tag Message"
 			 *
-			 * The second argument is the "tag" string
+			 * The second argument is the YYYY-MM-DD found
+			 * in the tag.
+			 *
+			 * The third argument is the "tag" string
 			 * from object.c.
 			 */
-			strbuf_addf(&desc, _("%s tag %s"), hash, tag->tag);
+			strbuf_addf(&desc, _("%s tag %s - %s"), hash,
+				    show_date(tag->date, 0, DATE_MODE(SHORT)),
+				    tag->tag);
 		} else {
 			/*
 			 * TRANSLATORS: This is a line of ambiguous
 			 * tag object output where we couldn't parse
 			 * the tag itself. E.g.:
 			 *
-			 *    "deadbeef tag [bad tag, could not parse it]"
+			 *    "deadbeef [bad tag, could not parse it]"
 			 */
 			strbuf_addf(&desc, _("%s [bad tag, could not parse it]"),
 				    hash);
-- 
2.35.0.890.gd7e422415d9

