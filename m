Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB5FC05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 09:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbjBBJyM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 04:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjBBJxt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 04:53:49 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C66A2E815
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 01:53:17 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id l8so921807wms.3
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 01:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSeG8G5IBWUhE7M7m2tnVGyhtyadLy69PJCQ+du+Y8E=;
        b=fvqmnqhB98CeslHf11s4yEQyjHDsHxgWER0+sMWDZWs4B33n26GnjuibtXka7R5f1a
         YNTb1y3fMXdg8hb9ADW8hI8L/6NzTRBnFPlVhQK+jcSHb4s3QsAht7j2oH3R5pN50jKk
         J923/2E+CpweXz5eWgPBtwpaSacqQCNMJGPaSSTiRFNXMs41a2q47tAa39pq1FGOrIUH
         ER/HwUJfbIZeJwyRgbxrSQtHZWy3IfGnou5YH08cnlmgD6yZ+b57bILRrg7fvFT8/pkG
         mn6LxBQDIDSnqPIZmvNWMLym1mT9AkIbr60ZlmPgnO7RvGV3oj2lCw26pChywV1Fr7lx
         roYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zSeG8G5IBWUhE7M7m2tnVGyhtyadLy69PJCQ+du+Y8E=;
        b=6Q93960S4G06ePaGhThWaRleiHUUhy5nFJ4j5xL9lhfCAVYE0bAbONcEJc/SvE0mMH
         QV0gexeGybnDqwkVJBNMbDujRiEAumHjc/IqnhgmGTrdpC7dJGmDA1gm3IrlZf74SCDT
         WqLwflFlrXGf6/k06Smc51Au4qwas+HAyqNt+DT6m+methY480rICyvE4CEuaijMIli+
         i6K78H4J/NeJO5FIAjxI49ESVHVNdJwo0U3oVe48nFHRzjbT02/u8Ser7t4imEBHGFWO
         8zoIgIgjQx6SlxIEhA6XZbvxHBukB+LA+yiqLuq2LsSC2GVL+BVjLPyqgwLsZ40gd4Q7
         vHNg==
X-Gm-Message-State: AO0yUKU+S6Jfc97rqa1ZE/VegKZawiEvCcwV1ZOazNwcgK23Yr5nIcit
        N0yQcrIyklXIf6bgUxDJMZSMtkOibLKoN0rh
X-Google-Smtp-Source: AK7set+CixBIlSMo34J+3mt7r0OxdfqBWeBMa73eIsDayoIP/ccUuRCD8230hgu4QIiMw0a4a/1lNQ==
X-Received: by 2002:a05:600c:3b0f:b0:3de:1d31:1048 with SMTP id m15-20020a05600c3b0f00b003de1d311048mr4895659wms.29.1675331595199;
        Thu, 02 Feb 2023 01:53:15 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i13-20020a1c540d000000b003db03725e86sm4356234wmb.8.2023.02.02.01.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:53:14 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 18/19] push: refactor refspec_append_mapped() for subsequent leak-fix
Date:   Thu,  2 Feb 2023 10:52:49 +0100
Message-Id: <patch-v6-18.19-aa33f7e05c8-20230202T094704Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1392.g63e6d408230
In-Reply-To: <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
References: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com> <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The set_refspecs() caller of refspec_append_mapped() (added in [1])
left open the question[2] of whether the "remote" we lazily fetch
might be NULL in the "[...]uniquely name our ref?" case, as
remote_get() can return NULL.

If we got past the "[...]uniquely name our ref?" case we'd have
already segfaulted if we tried to dereference it as
"remote->push.nr". In these cases the config mechanism & previous
remote validation will have bailed out earlier.

Let's refactor this code to clarify that, we'll now BUG() out if we
can't get a "remote", and will no longer retrieve it for these common
cases where we don't need it.

1. ca02465b413 (push: use remote.$name.push as a refmap, 2013-12-03)
2. https://lore.kernel.org/git/c0c07b89-7eaf-21cd-748e-e14ea57f09fd@web.de/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/push.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 60ac8017e52..97b35eca3ab 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -63,16 +63,9 @@ static struct refspec rs = REFSPEC_INIT_PUSH;
 static struct string_list push_options_config = STRING_LIST_INIT_DUP;
 
 static void refspec_append_mapped(struct refspec *refspec, const char *ref,
-				  struct remote *remote, struct ref *local_refs)
+				  struct remote *remote, struct ref *matched)
 {
 	const char *branch_name;
-	struct ref *matched = NULL;
-
-	/* Does "ref" uniquely name our ref? */
-	if (count_refspec_match(ref, local_refs, &matched) != 1) {
-		refspec_append(refspec, ref);
-		return;
-	}
 
 	if (remote->push.nr) {
 		struct refspec_item query;
@@ -120,12 +113,24 @@ static void set_refspecs(const char **refs, int nr, const char *repo)
 				die(_("--delete only accepts plain target ref names"));
 			refspec_appendf(&rs, ":%s", ref);
 		} else if (!strchr(ref, ':')) {
-			if (!remote) {
-				/* lazily grab remote and local_refs */
-				remote = remote_get(repo);
+			struct ref *matched = NULL;
+
+			/* lazily grab local_refs */
+			if (!local_refs)
 				local_refs = get_local_heads();
+
+			/* Does "ref" uniquely name our ref? */
+			if (count_refspec_match(ref, local_refs, &matched) != 1) {
+				refspec_append(&rs, ref);
+			} else {
+				/* lazily grab remote */
+				if (!remote)
+					remote = remote_get(repo);
+				if (!remote)
+					BUG("must get a remote for repo '%s'", repo);
+
+				refspec_append_mapped(&rs, ref, remote, matched);
 			}
-			refspec_append_mapped(&rs, ref, remote, local_refs);
 		} else
 			refspec_append(&rs, ref);
 	}
-- 
2.39.1.1392.g63e6d408230

