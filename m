Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCE9C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 17:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239614AbhKVR4r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 12:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239505AbhKVR4m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 12:56:42 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4E0C061758
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 09:53:31 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 133so16303373wme.0
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 09:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ll8r5Be3Os7X5TOWYVqKgtbg76oC38p7tyM4/Txj4FY=;
        b=nGogrZqX+M1o2vB4fNVwuKXh2qX8Zejd5JwwXHIZZGuUCC+IaylvxNQ6S3C4cCaeeu
         u0cES6BezsXr3+7hjbxEeO5iVHZrYNZQLowlqFgg27Dtdtan6cBaTwb5aXuNKRnlEFBv
         ynnbrcvqO4ew3rHJ23fo3Jr7ubzvMDeAYnsWSxJHlRG89FbxG5mIic4fZwhcYTb7vDYX
         CSMJOGGlhxcc+MXSu3wKdc8dfE7Jo3c9ppfRXCJlTUw2CsC8a2KOm5TbGjxWu7Iov3QS
         KTUpbwWi/HLgEo7KvIW1HIKBmr0qNcCBA0quJhkIEC2F3d4TDuQJPhssKz1kUUCE+cfU
         Ucrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ll8r5Be3Os7X5TOWYVqKgtbg76oC38p7tyM4/Txj4FY=;
        b=aIJ5mZ4qFjr9O4ox7wS4lbtzRvg7suInbzMSLRoEA9+Vs9WE21a/9b0Bba5TXBk4yU
         krgUc3nomlF1BNNb9gpoo49bHMHr4kqI4QzN24RD5EhAeyOAoGr2YlTxhza23TDrkoga
         d6zR8EnForR1LiUkVkAXrNHX+o+PkVUuInSPkg55gt2R/3g/MeYRGz8LHAcLhLkj2tN9
         3yQF+4E9j1avJjAXUvdw3Z9ftruH7jf/BA+lTOHFXnNe3z9XVSvYrBAPxH/cx2pHARI/
         lkt9PVOVfKFQQ0NkUxZu52sPDv86LOrziYWANJKvnLkCI++YoXVBMlMvwpAhjYLI/66U
         N17A==
X-Gm-Message-State: AOAM532AOR/kUVPzcLSagFPqn8gTtOXUIZSAMlpzLNrNmHnh8itDNeWA
        5L6hhaXRPzcFs3/LRKY4Rz87RtN5+V1RpQ==
X-Google-Smtp-Source: ABdhPJyMgFR7pdmoaXnCJciEZeW8dzHJDJnSAT4eU9/OTumwZbh+T9CTaxqtmyENF/WpRrFfIBT1ag==
X-Received: by 2002:a05:600c:190e:: with SMTP id j14mr30605672wmq.75.1637603610139;
        Mon, 22 Nov 2021 09:53:30 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l11sm9531664wrp.61.2021.11.22.09.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 09:53:29 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 3/3] object-name: show date for ambiguous tag objects
Date:   Mon, 22 Nov 2021 18:53:25 +0100
Message-Id: <patch-v4-3.3-9d24bab635d-20211122T175219Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.822.gc64b680fd55
In-Reply-To: <cover-v4-0.3-00000000000-20211122T175219Z-avarab@gmail.com>
References: <cover-v3-0.3-00000000000-20211008T193041Z-avarab@gmail.com> <cover-v4-0.3-00000000000-20211122T175219Z-avarab@gmail.com>
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
2.34.0.822.gc64b680fd55

