Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7484DC433FE
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 12:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353226AbiALMkO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 07:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353217AbiALMkK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 07:40:10 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6139C06173F
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 04:40:09 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h10so4036688wrb.1
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 04:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p0cdrvJ8UYhDAygs04WS4nUuvkSCByODPUyvcaEkRLw=;
        b=KLhIGUkx+D4/1bkdSOn93iVLHfbXlCiRUHGlhSvqapg/jcyPSsnpfouW+u8NLgk7mA
         zHw2imYMPgQQqT2VmYM0pKJXDgCTyU4x6RhbNo1YGxUn9iX7lgvJlRZvaKilKUAtrBoI
         nYFF5T7QHf/ZItP06lqw6ee+AdIrL5sjuszmhsaqoe4AkPbZkcV0wHduH3PHAh8e413C
         cmY647SiWYzG5RtJJfZyYXclegvuFn+BHMZwAr9mbqTGVsiwxYDQxJxis6HOE1XqfT5D
         5U6TzKpj6s/eT096zasxd6THh9+j5YpctuAdE20bTyDuQ6rwDXXJDNlCkdfPP/BlXFnR
         wBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p0cdrvJ8UYhDAygs04WS4nUuvkSCByODPUyvcaEkRLw=;
        b=pcey/jKxFNxAzJOf12kcdfNL2qMrD+XiqliJrtOYt4u3mTLUWIY2stKJRJsVbLu/UP
         x3ZaffXmmhPhwTscLSeTttBJMkdf7Dw0wrwjV8FpJPDr5gl3cPPrIr3zz80TZSj9S2N/
         lT7SLjXhrj12gxP0sbdgu7+Ih3fdLp2CMA8gn7JbxhD2w+crqRvQQ4l59qSs22X0iy7m
         4paVF5or0GZGVTIb8FHyaCXkGz1PxvWY8/oGf1yGsAfUub/Hf29bKXM7NPt0eFl00E0o
         a7SAh560iSGfBO3Qwyx/MLc+Ig8Ye9uHJJMti5oQc22bxDJ8SecOyB4ZHElvzUBctCPQ
         dDew==
X-Gm-Message-State: AOAM533nubEZMv/hC9Ka+QUqSfJDmxH0yImTyubuGwBMD5SIpt77ACUf
        +dKyp9C96WNkKOBLerV0yVHBzxUsSBQWjA==
X-Google-Smtp-Source: ABdhPJxWLf/NQA6KTDKSaZxEmZCAsJH/yHHkb8pd4Nm5uBOtpdANKBXqCnx1Cn51D8oDRlbjejkXuQ==
X-Received: by 2002:a5d:4575:: with SMTP id a21mr309805wrc.281.1641991208227;
        Wed, 12 Jan 2022 04:40:08 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j13sm5174242wmq.11.2022.01.12.04.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 04:40:07 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 4/6] object-name: show date for ambiguous tag objects
Date:   Wed, 12 Jan 2022 13:39:23 +0100
Message-Id: <patch-v7-4.6-2e5511c9fa5-20220111T130811Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.848.gb9d3879eb1d
In-Reply-To: <cover-v7-0.6-00000000000-20220111T130811Z-avarab@gmail.com>
References: <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com> <cover-v7-0.6-00000000000-20220111T130811Z-avarab@gmail.com>
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

As with OBJ_COMMIT we punt on the cases where the date in the object
is nonsensical, and other cases where parse_tag() might fail. For
those we'll use our default date of "0" and tag message of
"". E.g. for some of the corrupt tags created by t3800-mktag.sh we'd
emit a line like:

    hint:   8d62cb0b06 tag 1970-01-01 -

We could detect that and emit a "%s [bad tag object]" message (to go
with the existing generic "%s [bad object]"), but I don't think it's
worth the effort. Users are unlikely to ever run into cases where
they've got a broken object that's also ambiguous, and in case they do
output that's a bit nonsensical beats wasting translator time on this
obscure edge case.

We should instead change parse_tag_buffer() to be more eager to emit
an error() instead of silently aborting with "return -1;". In the case
of "t3800-mktag.sh" it takes the "size < the_hash_algo->hexsz + 24"
branch.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-name.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/object-name.c b/object-name.c
index 743f346842a..7c6cb60ceff 100644
--- a/object-name.c
+++ b/object-name.c
@@ -403,20 +403,25 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
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
 		 * ambiguous tag object output. E.g.:
 		 *
-		 *    "deadbeef tag Some Tag Message"
+		 *    "deadbeef tag 2021-01-01 - Some Tag Message"
 		 *
 		 * The second argument is the "tag" string from
 		 * object.c.
 		 */
-		strbuf_addf(&desc, _("%s tag %s"), hash, tag_tag);
+		strbuf_addf(&desc, _("%s tag %s - %s"), hash,
+			    show_date(tag_date, 0, DATE_MODE(SHORT)),
+			    tag_tag);
 	} else if (type == OBJ_TREE) {
 		/*
 		 * TRANSLATORS: This is a line of ambiguous <type>
-- 
2.34.1.1373.g062f5534af2

