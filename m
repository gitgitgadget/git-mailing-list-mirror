Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF62C433EF
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 22:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244707AbhKYWKd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 17:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244400AbhKYWIc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 17:08:32 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14845C0613F2
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 14:03:50 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id b12so14447843wrh.4
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 14:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fJSXKM41yteZcDJhWKSFcBpgVcWQjuKHpe2wnlfRUbA=;
        b=DRre+1swiN2sVuKfpF0w87iTIRt6eb3bRZrKV75WZtDeCIU9ql+2FNRRpj3uiXGaX5
         gFSVMbYdyrwskGrr77QjeWTYhDeqxrIFhd4ZRzP80Ow1ceehCS4dH2Jm+OhAocm52ixO
         1Fsf4cGseV4eW7A0ldLLqphjI1g+SYcToV2jEvWQxndCUj6NdOzy2tSPV16gZVUNZ5nJ
         iWRbHEY7h5KP89uoyx/zQ84z0Pii9h/z7+uBzGDpJhiEC7UEmhnjdBWgsD4CXaqGEFlY
         7jaY0eN5DAaSq53vOV55wzmfZ84aqbEjfGEl4g6qqi3xkC1tZ0pvgsc4ot+r8LTr1g/T
         b1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fJSXKM41yteZcDJhWKSFcBpgVcWQjuKHpe2wnlfRUbA=;
        b=ZBx1iBXjecED7mPNJd7UYS3uTeMdE1aJKbMeRZaARu1HoDCVsMTHBMcKfB90BtIBpN
         anlEVMKTM9cHvkvBhfuW7/oo4rMNx5gWAsMVH7l+E0vIVlSfOEVhWBQ6sqWVp9cmii0p
         XUlMb77Q4IvAJs28LCEoqQUKQrSB/wEHFA5lLezgmJJyj+tY8Rx1dF0aXo+6s2Dh6LK5
         NheiDSa1L2w7RXcHTc2Rghs0CiWh8ezfUx9r4RW5JB9gSp+khRGKXiKXSivHeOdR0Eqb
         f2JWKJ8DpUOyEg6PMVn17M4Q58VUetHk63OuukqQgp10jGLN+XWLg2+Yv0tHumPjWIrR
         l5Ig==
X-Gm-Message-State: AOAM533QV++pBa6seXVJjfBYnvZlLOJKEH3QEt+BqTx0lAYlwXcHlKh9
        IJzk/OhKC0FJAoptgLiKTF59O0OyPRPTpA==
X-Google-Smtp-Source: ABdhPJwcn+ILK6LhAQpCMQAsHHDcuVmw9pUhyL96pjibdUdXDGe48w2u7nxIDPg2u6Vg1ppTU7q++g==
X-Received: by 2002:adf:e991:: with SMTP id h17mr9711609wrm.40.1637877828445;
        Thu, 25 Nov 2021 14:03:48 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n2sm8883726wmi.36.2021.11.25.14.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 14:03:47 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 2/6] object-name: explicitly handle OBJ_BAD in show_ambiguous_object()
Date:   Thu, 25 Nov 2021 23:03:40 +0100
Message-Id: <patch-v5-2.6-ee86912f1c1-20211125T215529Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.838.g779e9098efb
In-Reply-To: <cover-v5-0.6-00000000000-20211125T215529Z-avarab@gmail.com>
References: <cover-v4-0.3-00000000000-20211122T175219Z-avarab@gmail.com> <cover-v5-0.6-00000000000-20211125T215529Z-avarab@gmail.com>
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
to say that we had a failure parsing the object at all, if the problem
is only that it's type is unknown we won't reach this code.

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
index ae1c0cf2b21..f1948980dff 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -100,7 +100,7 @@ test_expect_success POSIXPERM 'ambigous zlib corrupt loose blob' '
 	error: unable to unpack cafe... header
 	error: inflate: data stream error (incorrect header check)
 	error: unable to unpack cafe... header
-	hint:   cafe... unknown type
+	hint:   cafe... [bad object]
 	hint:   cafe... blob
 	fatal: ambiguous argument '\''cafe...'\'': unknown revision or path not in the working tree.
 	Use '\''--'\'' to separate paths from revisions, like this:
-- 
2.34.1.838.g779e9098efb

