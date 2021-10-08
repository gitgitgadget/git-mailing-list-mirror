Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B03AC433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 473AD60FF2
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhJHTg4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 15:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbhJHTgx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 15:36:53 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA378C061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 12:34:57 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id s15so32909406wrv.11
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 12:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4QXNP84vGh7XaZsgJkrsq1mob3oSVYRUlAmTgOEM9/c=;
        b=DZnxu1JbfDHEwpcjQteup49rj4lB4mIkZROHRUwutKy+CwrEPvvrEHfZMrCiomPtSk
         8dwOF6S+ia9gLFcFGRswAvW1ew+3NpGIsxgwjRsFoXPAR/Ma+Pr3sT8QP+4xEwgqngWU
         wVmL1e9ynKEV7Nx3JJxQ0Bv1htoYC5o6Y4CUXWo/KisBxzBOc53Gz6iglcCwM5rWp52H
         VyWxMRzpI0zbdojK4yeqjyjzpp/ptPbOII4u4FtLl3fIHWSBZA1v7bqi5uKtTEbSixjN
         zlNsoMqvP7XbQRhEa333RLNqXKt1meaqjPPbgApv2g7Ci0lj/0hczw7TjSv4Brkc9Ij/
         Bijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4QXNP84vGh7XaZsgJkrsq1mob3oSVYRUlAmTgOEM9/c=;
        b=LNvTEv8CoiGMbAUQin2LUIvl3XbL+6T33BnG1StVXPkd+KdZnmPJIhe0HuMklIrqE5
         Is2RGcPPgLB+GXTgieAIj80bdcpp1CW0h+3j2gG4TXrlIsnnvTw1IHPLg5th6zIcgr17
         oHezTMhlFieaDgZ4aMsN++JYboRENUmuPEmpQOl09QIfb4pufuMCOvt4dB3SYOYk1Ok/
         ezB9eZxTA9cBR4YvVDVHsrzz3sDv/LeXsPOa4WI3KSSYQTcAXvLm/lsP4APfwYyWaYcX
         T7snh8s+enxO3jp/YKINWsqv3eqETMZD5EwZuWkHmHmGPMuHI6yQykiUItTdeC0wH5rr
         vNxA==
X-Gm-Message-State: AOAM533CRXMmCb8+b4sX72RxpG0pyhxvucICLzgTxhuj+Q01NevUoFKO
        vw2Kec8NHjMPtB03nC94c2W9scfhm6kZuA==
X-Google-Smtp-Source: ABdhPJzwwtQuksP5ugMOJFRWOuTmJH0yQsim5QuR4f7V7KYjOfi1hy+OvSbsqXdOGqmmMoNlCTTygA==
X-Received: by 2002:adf:a209:: with SMTP id p9mr6413730wra.70.1633721696319;
        Fri, 08 Oct 2021 12:34:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c204sm13056157wme.11.2021.10.08.12.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 12:34:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/3] object-name: show date for ambiguous tag objects
Date:   Fri,  8 Oct 2021 21:34:48 +0200
Message-Id: <patch-v3-3.3-8bde4e174b7-20211008T193041Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1492.g76eb1af92bc
In-Reply-To: <cover-v3-0.3-00000000000-20211008T193041Z-avarab@gmail.com>
References: <cover-v2-0.2-00000000000-20211004T142523Z-avarab@gmail.com> <cover-v3-0.3-00000000000-20211008T193041Z-avarab@gmail.com>
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

Before this we'd emit a "tag" line of:

    hint:   b7e68c41d92 tag v2.32.0

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-name.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/object-name.c b/object-name.c
index 7a5355b4cf7..29859d3eebe 100644
--- a/object-name.c
+++ b/object-name.c
@@ -391,9 +391,12 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 	} else if (type == OBJ_TAG) {
 		struct tag *tag = lookup_tag(ds->repo, oid);
 		const char *tag_tag = "";
+		timestamp_t tag_date = 0;
 
-		if (!parse_tag(tag) && tag->tag)
+		if (!parse_tag(tag) && tag->tag) {
 			tag_tag = tag->tag;
+			tag_date = tag->date;
+		}
 
 		/*
 		 * TRANSLATORS: This is a line of
@@ -405,7 +408,9 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 		 * object.c, it should (hopefully) already be
 		 * translated.
 		 */
-		strbuf_addf(&desc, _("%s tag %s"), hash, tag_tag);
+		strbuf_addf(&desc, _("%s tag %s - %s"), hash,
+			    show_date(tag_date, 0, DATE_MODE(SHORT)),
+			    tag_tag);
 	} else if (type == OBJ_TREE) {
 		/*
 		 * TRANSLATORS: This is a line of ambiguous <type>
-- 
2.33.0.1492.g76eb1af92bc

