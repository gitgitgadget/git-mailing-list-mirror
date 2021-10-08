Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8DEC433FE
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4770B60FF2
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhJHTgx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 15:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbhJHTgw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 15:36:52 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44609C061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 12:34:56 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t2so32806873wrb.8
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 12:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U4kfnP3HLRYUszCGARU85I9x8qo+W0Iu7RgnbGfql/g=;
        b=Xxfl3TrxA0ywA9jaF15ad7qF6NeXHyN7Fh5cpLx4sDZSE9Q8lb0Aiu9xrpPqFWn2vO
         bZgp8z7+nTzU/IGzX00+aWbYY0cvePJK2PP24W88SpvnPsd8dlUHlKUwqFkqq4a9swAK
         CuLf8MGwd3WslM4RD3lK/sFb3oOU9sHINw4W/RSWm5j/vipAaf7eZfXYG1CNaw45w8zm
         /Dn5pAdu2PLEuzz0zCSCBrs+lxGCQgL0iASzmTLmD/Ke4NF7FBrIJnIhwbQmHlnWpw2G
         cnczrTNXRm1ILtUVcKAlWDec3/KjZgQjvILF4B2tTHTUXxs73cEOQWxZzttqUEKi30K5
         sHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U4kfnP3HLRYUszCGARU85I9x8qo+W0Iu7RgnbGfql/g=;
        b=GosNuHTK69LRL99/B9p+djQRHpAbU5szjXIzij+BYw/2dlHPxjWmtkPlkzW8tcSm3A
         q6EzgPvmcbuLDIUPg+wt622Z0Pj14JluvxoD1jLD9OyS1AoPPkfdPnsXXaPIgCCTedkL
         qu0PHiBjH3P1BVYcNblxj/dEcfX/qoFQS4bWzNtEHyHElqSJaum8b+P4rP8sdHr/jgGO
         TYJFBbwBTduDOWDUocNs7Wbdsh/Hdhj201DuAJZNXdLlYyUigaH+wxiZ0HE+SYHlV0rw
         7Wt9Re1PN3oDNDcr7W0XhpjWFHPK6lGNOmBiDidL2233RQ2L1OVDkVDR1kCKAVa59fen
         Q9ag==
X-Gm-Message-State: AOAM530LjniD3qVIOksq4Jqf9CJcJtlqxOfGhc/17IoYlVvvJ8L+SGQg
        d/EsQLefv0WTaP96DisXoYh7EffcJh3O2A==
X-Google-Smtp-Source: ABdhPJx4RYurhfb3ibWITE8gEYGckiC47oe6F1bLb0eigI0wQGHP2P5J3PNCtfXKrPc3hiy6tGQQtw==
X-Received: by 2002:a1c:c908:: with SMTP id f8mr5516208wmb.142.1633721694530;
        Fri, 08 Oct 2021 12:34:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c204sm13056157wme.11.2021.10.08.12.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 12:34:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/3] object-name: remove unreachable "unknown type" handling
Date:   Fri,  8 Oct 2021 21:34:46 +0200
Message-Id: <patch-v3-1.3-fb29e10ee35-20211008T193041Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1492.g76eb1af92bc
In-Reply-To: <cover-v3-0.3-00000000000-20211008T193041Z-avarab@gmail.com>
References: <cover-v2-0.2-00000000000-20211004T142523Z-avarab@gmail.com> <cover-v3-0.3-00000000000-20211008T193041Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the "unknown type" handling when displaying the ambiguous
object list. See [1] for the current output, and [1] for the commit
that added the "unknown type" handling.

The reason this code wasn't reachable is because we're not passing in
OBJECT_INFO_ALLOW_UNKNOWN_TYPE, so we'll just die in sort_ambiguous()
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
2.33.0.1492.g76eb1af92bc

