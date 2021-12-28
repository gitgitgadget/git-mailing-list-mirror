Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AC5C433F5
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 14:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbhL1OfT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 09:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbhL1OfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 09:35:16 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3D0C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 06:35:16 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id k18so2030132wrg.11
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 06:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LzzqLBOmd1rTFhAavOLKeBSWJBt84z+MerLYu5aTUWo=;
        b=ikfi9xsv6HOsBCGSM+vi2rGSXScnj/YxO6Dez4g3X/kzwFkp+zSfi5+znE51lhqrWl
         Mbl9bnUVDTGc3o4ZjTEMbIeyjXj7mW41PElJFoMsQVe1WJMNsqaGO5bykJgz1QHj3lHc
         Qx1YJsdrANPMj2wzbMVycxacYrcEMnF2wns8BX5TgEeuu5Ap3uRhwdjmRUgDXBlwpNZy
         1HrD95KEvXJJdg63J4tB1/kL6Fd4+8koYNRI3yeOBZLuVAMt3nhPPYsOJop4qFyVvx3A
         lIgQS75pmLvayvDzmtDf2+xYbvZ9qBP9eB4Wux23dzn7GwUyuTQNK7Ezazihlkns5MrR
         YcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LzzqLBOmd1rTFhAavOLKeBSWJBt84z+MerLYu5aTUWo=;
        b=zfJvPa6wpm5tzHHDKk0FDcPdpMU5TR23Strt2/R1wkpPNqErAKy0Up73o6jKt4KGoU
         qHoDXdtlwg0G9GHH7UzY9iiemj8Kfn92wqSdngxobsAhNceXIMcI3B+q1Sz5tMlPaluu
         sT5dCsdpqhOtDb/tZTiL4PtaT7QCIBaOJKFSjNQwI0I4Uo608yJKvLMKoNl4HAm4k9ra
         cJMngA6J/SN/edMDiFrUG8xfbbeg5ub7T3a2N0RT8u1z7gojnU3yE6LbeawdIBBN58l+
         sZKVQSvzXxy+0fjp6Z1x5OetjyTfCbLp+Xlwe4M7FdIwBESUR0QJu0de0aEUChTJgScN
         C6JQ==
X-Gm-Message-State: AOAM533MgqLtKrhL9RAwdkL58slgxNfIBRnYoofoAtBf4dCTd53YeGpF
        Abuc/kizCzVzqMxWgeEgsNrpTpkq5qXN/Zrg
X-Google-Smtp-Source: ABdhPJz26BFp60+Y+adlWnBC6SMNH1TgU1PQzI6DzGM0cE65WbZA7IiruDuIJZ18NVhLvlVnurp9xg==
X-Received: by 2002:a5d:6702:: with SMTP id o2mr16636673wru.292.1640702114379;
        Tue, 28 Dec 2021 06:35:14 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m35sm42780660wms.1.2021.12.28.06.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 06:35:13 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 2/6] object-name: explicitly handle OBJ_BAD in show_ambiguous_object()
Date:   Tue, 28 Dec 2021 15:34:58 +0100
Message-Id: <patch-v6-2.6-c78243dc701-20211228T143223Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1257.g2af47340c7b
In-Reply-To: <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com>
References: <cover-v5-0.6-00000000000-20211125T215529Z-avarab@gmail.com> <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend the "unknown type" handling in the code that displays the
ambiguous object list to assert() that we're either going to get the
"real" object types we can pass to type_name(), or a -1 (OBJ_BAD)
return value from oid_object_info().

See [1] for the current output, and [1] for the commit that added the
"unknown type" handling.

We are never going to get an "unknown type" in the sense of custom
types crafted with "hash-object --literally", since we're not using
the OBJECT_INFO_ALLOW_UNKNOWN_TYPE flag.

If we manage to otherwise unpack such an object without errors we'll
die() in parse_loose_header_extended() called by sort_ambiguous()
before we get to show_ambiguous_object(), as is asserted by the test
added in the preceding commit.

So saying "unknown type" here was always misleading, we really meant
to say that we had a failure parsing the object at all, i.e. that we
had repository corruption. If the problem is only that it's type is
unknown we won't reach this code.

So let's emit a generic "[bad object]" instead. As our tests added in
the preceding commit show, we'll have emitted various "error" output
already in those cases.

We should do better in the truly "unknown type" cases, which we'd need
to handle if we were passing down the OBJECT_INFO_ALLOW_UNKNOWN_TYPE
flag. But let's leave that for some future improvement. In a
subsequent commit I'll improve the output we do show, and not having
to handle the "unknown type" (as in OBJECT_INFO_ALLOW_UNKNOWN_TYPE)
simplifies that change.

1. 5cc044e0257 (get_short_oid: sort ambiguous objects by type,
   then SHA-1, 2018-05-10)
2. 1ffa26c461 (get_short_sha1: list ambiguous objects on error,
   2016-09-26)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-name.c                       | 14 ++++++++++++--
 t/t1512-rev-parse-disambiguation.sh |  2 +-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/object-name.c b/object-name.c
index fdff4601b2c..9750634ee76 100644
--- a/object-name.c
+++ b/object-name.c
@@ -361,6 +361,16 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 		return 0;
 
 	type = oid_object_info(ds->repo, oid, NULL);
+
+	if (type < 0) {
+		strbuf_addstr(&desc, "[bad object]");
+		goto out;
+	}
+
+	assert(type == OBJ_TREE || type == OBJ_COMMIT ||
+	       type == OBJ_BLOB || type == OBJ_TAG);
+	strbuf_addstr(&desc, type_name(type));
+
 	if (type == OBJ_COMMIT) {
 		struct commit *commit = lookup_commit(ds->repo, oid);
 		if (commit) {
@@ -374,9 +384,9 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 			strbuf_addf(&desc, " %s", tag->tag);
 	}
 
-	advise("  %s %s%s",
+out:
+	advise("  %s %s",
 	       repo_find_unique_abbrev(ds->repo, oid, DEFAULT_ABBREV),
-	       type_name(type) ? type_name(type) : "unknown type",
 	       desc.buf);
 
 	strbuf_release(&desc);
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index 60d2a457067..d68c411bfc7 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -101,7 +101,7 @@ test_expect_success POSIXPERM 'ambigous zlib corrupt loose blob' '
 	error: unable to unpack cafe... header
 	error: inflate: data stream error (incorrect header check)
 	error: unable to unpack cafe... header
-	hint:   cafe... unknown type
+	hint:   cafe... [bad object]
 	hint:   cafe... blob
 	fatal: ambiguous argument '\''cafe...'\'': unknown revision or path not in the working tree.
 	Use '\''--'\'' to separate paths from revisions, like this:
-- 
2.34.1.1257.g2af47340c7b

