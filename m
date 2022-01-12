Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D43C433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 12:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353223AbiALMkM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 07:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353207AbiALMkI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 07:40:08 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B0FC061751
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 04:40:08 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id p1-20020a1c7401000000b00345c2d068bdso3361243wmc.3
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 04:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oLIaSa/nS7slHkrLWNOzZQ/LatRlbJ0OD1rWECFMFQ8=;
        b=DoOp8DAlLMZFe5bwuZURvD1Q4JE+OtjKro9oLJdvrAfo2n/96k6Dz8QVSYxgl28c7l
         Ukc41UJsh2I1iclaI2tTgbHqev0y7aI8lYWVxpiFNym9I7XXPOEEHGk493kX0yHqdCfH
         18GSItfXpuP9MorWiraJMDJ5AU2j12mbGP5OnzDgkcI2cbB/IFxk/e8Ah1Onml3KUclx
         p2VeGjuxWlrOF9zvHv4KFgmcQmx49INZGYi7ppjsSmFon6aP+drN/1+3ZDChfhK7nl9s
         Vm0/sINpvm/VRN3s6TSz0I/ivnU8uX3i7rONAnpiC7uZ5Be2QpKDxJqsEKmcgw/0IIk6
         Yb/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oLIaSa/nS7slHkrLWNOzZQ/LatRlbJ0OD1rWECFMFQ8=;
        b=Kj4Z1fQL2p0GOJA/n27neQvJs0UXeaufhYRHHQWtmdXE9NK3F+GFZ6ElGxW4VCdEN3
         3NoOHGdhqTAvTfDQ7zvPCk6psVJzTaWyiu2b2SSe8CgHRhP3BCB1yi5hKNM3RP7UonMa
         TwaZEbaoLBO1rb0AtdJJPuxkMYQ11jk+Vd57QjeA9xz2YGsDiILN4m5CZIYCyOXH42oy
         dkrD+KKxCztE68wS9bbNE8/ADb3SjtnP/Mynx3DhRUMB2azavIgkPnI7NRAuhx5plvZy
         0PQsjPYiayMLU0LtJt7UOQk0mf2GzJKunS1Uy3TaVOq1KgPX8SJIRp6TQRu7m60TSDSV
         qWeg==
X-Gm-Message-State: AOAM531LQVYIvxJM/oRVOOXEV6mtv3/b/rzCYTRMB66qABRmH4Mcr23v
        6suOq3nlSGmk2aPwH/J9fwqIZSrkFUWeSg==
X-Google-Smtp-Source: ABdhPJxiF9ZkoGz8w8Tgyyhl+9DUy3BmxNgJYJU2+Fx4mEqOAFgjgeL+nuuQYYiKncn7IqvaWtEp9w==
X-Received: by 2002:a7b:c152:: with SMTP id z18mr6797085wmi.50.1641991206500;
        Wed, 12 Jan 2022 04:40:06 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j13sm5174242wmq.11.2022.01.12.04.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 04:40:05 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 2/6] object-name: explicitly handle OBJ_BAD in show_ambiguous_object()
Date:   Wed, 12 Jan 2022 13:39:21 +0100
Message-Id: <patch-v7-2.6-b7027dfc843-20220111T130811Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.848.gb9d3879eb1d
In-Reply-To: <cover-v7-0.6-00000000000-20220111T130811Z-avarab@gmail.com>
References: <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com> <cover-v7-0.6-00000000000-20220111T130811Z-avarab@gmail.com>
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
index 01feeeafb72..5ed7e49edc7 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -96,7 +96,7 @@ test_expect_success POSIXPERM 'ambigous zlib corrupt loose blob' '
 	error: unable to unpack cafe... header
 	error: inflate: data stream error (incorrect header check)
 	error: unable to unpack cafe... header
-	hint:   cafe... unknown type
+	hint:   cafe... [bad object]
 	hint:   cafe... blob
 	fatal: ambiguous argument '\''cafe...'\'': unknown revision or path not in the working tree.
 	Use '\''--'\'' to separate paths from revisions, like this:
-- 
2.34.1.1373.g062f5534af2

