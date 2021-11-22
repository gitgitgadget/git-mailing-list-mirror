Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D28C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 17:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239132AbhKVR4t (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 12:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239142AbhKVR4j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 12:56:39 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C886C061756
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 09:53:30 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso377282wmh.0
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 09:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bUVgjI/gWKHf+bhQq1xm5p7rRI9c73YXrbmBH1lI+sU=;
        b=R0GjZBzzsXDbLW+ymOD85lR8XluuEwTXGb6m3MtnuvtEVc2Q14KYSNgQ8cXZWO50BV
         1BE7QXs+65oJp9Lnze3HFPSddVbR7HKgd0RFBen/mBvCtGBF35zUa+PAbBq7U337aDU7
         Dik7RitEHxv0Ag+rO1bPC4OM/Qlq0keX+IyKDG5BxITFUWDty1q2La6+A2LZ2GzyRJak
         8l/M7p7RSF9EMDo0fLNUuE7gVyMDNiLaMRJDHsG36IxFZw/Glu+BQzhXZIsOu8TbLtv9
         +L5C6OpvR1Kh5qhAAW7xpvQa2tU04XfX5tWD88DfqCGWkR4o1dr3FTZK2ecg/1GTFXGA
         SeEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bUVgjI/gWKHf+bhQq1xm5p7rRI9c73YXrbmBH1lI+sU=;
        b=zrlTq1Qy2wZ75wLl/NKmBzxvQyuymNg23w3vszcy29ptJXQFYcq5tiQpOP/UYezoYt
         2wEUyX4GuI5sMMgP0qSXgm9E5viQT89sueLUfoy81ScyXnlW/XUnnLOK/DO/QSoAshlT
         vu3jNxSDLty79dfjHdSvpW02xWw78KfiVYwgG3XKdVeP2AiWL6sttxUzgWDxEFz3j+Pc
         jKQ11BZir4EmQgSaAhiGjFdQaiZTUu1nzWeQuEkLYwUqPVmFrwSvW6Wh5QqAahNarnoD
         nlfDJpHH/C0Mqex3HVnFZB4pAy6LoIPLFdMN9wL7Mz4P/JqEgwffqbl9YD5+c63/jSgn
         s01Q==
X-Gm-Message-State: AOAM531PaVAYf7n2Xoflsw6brku+zcOfJhf/KjPwR5mAOutWm9BqrIZa
        I4wMHcvj+fMQJGSN9n7MVmSOnfhVlBa0YA==
X-Google-Smtp-Source: ABdhPJybqfAkzUzqVJVtzJbj0IeRB/aRQra/Exwn2K8oB/bYpFS2OeUw8N+wPP16VX6/cZFWR3NNbA==
X-Received: by 2002:a1c:6a0e:: with SMTP id f14mr31445661wmc.58.1637603608229;
        Mon, 22 Nov 2021 09:53:28 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l11sm9531664wrp.61.2021.11.22.09.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 09:53:27 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 1/3] object-name: remove unreachable "unknown type" handling
Date:   Mon, 22 Nov 2021 18:53:23 +0100
Message-Id: <patch-v4-1.3-2e7090c09f9-20211122T175219Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.822.gc64b680fd55
In-Reply-To: <cover-v4-0.3-00000000000-20211122T175219Z-avarab@gmail.com>
References: <cover-v3-0.3-00000000000-20211008T193041Z-avarab@gmail.com> <cover-v4-0.3-00000000000-20211122T175219Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove unreachable "unknown type" handling in the code that displays
the ambiguous object list. See [1] for the current output, and [1] for
the commit that added the "unknown type" handling.

The reason this code wasn't reachable is because we're not passing in
OBJECT_INFO_ALLOW_UNKNOWN_TYPE, so we'll die in sort_ambiguous()
before we get to show_ambiguous_object():

    $ git rev-parse 8315
    error: short object ID 8315 is ambiguous
    hint: The candidates are:
    fatal: invalid object type

We should do better here, but let's leave that for some future
improvement. In a subsequent commit I'll improve the output we do
show, and not having to handle the "unknown type" case simplifies that
change.

Even though we know that this isn't reachable let's back that up with
an assert() both for self-documentation and sanity checking.

1. 5cc044e0257 (get_short_oid: sort ambiguous objects by type,
   then SHA-1, 2018-05-10)
2. 1ffa26c461 (get_short_sha1: list ambiguous objects on error,
   2016-09-26)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-name.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/object-name.c b/object-name.c
index fdff4601b2c..59e934262e7 100644
--- a/object-name.c
+++ b/object-name.c
@@ -361,6 +361,8 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 		return 0;
 
 	type = oid_object_info(ds->repo, oid, NULL);
+	assert(type == OBJ_TREE || type == OBJ_COMMIT ||
+	       type == OBJ_BLOB || type == OBJ_TAG);
 	if (type == OBJ_COMMIT) {
 		struct commit *commit = lookup_commit(ds->repo, oid);
 		if (commit) {
@@ -376,8 +378,7 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 
 	advise("  %s %s%s",
 	       repo_find_unique_abbrev(ds->repo, oid, DEFAULT_ABBREV),
-	       type_name(type) ? type_name(type) : "unknown type",
-	       desc.buf);
+	       type_name(type), desc.buf);
 
 	strbuf_release(&desc);
 	return 0;
-- 
2.34.0.822.gc64b680fd55

