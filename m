Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2070C61DA4
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 23:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjBFXJP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 18:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjBFXIy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 18:08:54 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C5A32E64
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 15:08:27 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id m2so38748649ejb.8
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 15:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2eXl3+EDO0/r7rJ8+Sx4W8+/GhtaIl6wOPh90YwjqeA=;
        b=CeBNYKeAlSX0bP/fyVZj2J9GfvJCqwazwvEprIe7r95a301Bxqt/Fa74aSEZjbVCpz
         oraueK79+Lru/GYAzh6NROQn3XtXD9CiwKIv5y98E1d4LwLH+Ur3hshivUPtPOzvrtEj
         orScj8Nwb26Pu7COW75+5H5fRluqbTWUS9iG+OWC5Q1zm3SMHGofCJuzhgeEfFgdCL48
         Yumo8mRNygV8VZi1vxMOnG7AxoJBEEcNXZPs8768sUzMse/Er9qB92vynNuL0uUHRkCR
         vFgnjB1UD5m5KrWYL21yYI8+gJUXknJQANge32ZQw7nJhy9l9x0FunA0TDGV8qmJZYOT
         zNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2eXl3+EDO0/r7rJ8+Sx4W8+/GhtaIl6wOPh90YwjqeA=;
        b=rS4mYJKC9fach3L1TOcAh9PRULhGlugjDzFBb7nc3G6d/L0rdee1FQK4KEizblgnKq
         Ga3YQs/ZPuzMw67yrXd5DEM2KcVTrvuBzxWEohCzTrFzxbyCzxgPbx5ENX3yvvolyyEH
         pCMvq31gTvjWJwZGq8RvdnVR4oRQ3gu4noF+gS4NcwjD8KOIHj9bmzjOWf0FWYzb6bPF
         nfFShkNxNDYyauYvu/jZbU+hHgvI2b8wJujJ8ysFjt2SZHad6iIPzffE6EOKfAwFQV3v
         RVSTeaF7kQfeXaqTOUJ7N7XkYkLJkghhc37MvpnTB5e/SeLCVoYZX9XxXcv/iYaRuFLe
         YmXA==
X-Gm-Message-State: AO0yUKW4Y53DXYc06CoHzo/DG5PZiBHLzDVoitHaojgMtKzxMaNvAer+
        vH8qkCDT5Ehav/x4s+Ql/iUwILsF/8zRK910
X-Google-Smtp-Source: AK7set9gPd530hbriGWfUUDFi3hf3wjig+KoOPmUxTGejI/OFGUY0ii0NUqwl5XZcEA1uMvca7QO+g==
X-Received: by 2002:a17:906:edbb:b0:887:2248:efd5 with SMTP id sa27-20020a170906edbb00b008872248efd5mr951291ejb.77.1675724906615;
        Mon, 06 Feb 2023 15:08:26 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906a18f00b0089d5aaf85besm2673586ejy.219.2023.02.06.15.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 15:08:25 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 18/19] push: refactor refspec_append_mapped() for subsequent leak-fix
Date:   Tue,  7 Feb 2023 00:07:53 +0100
Message-Id: <patch-v7-18.19-d28b710c0ba-20230206T230142Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1425.gac85d95d48c
In-Reply-To: <cover-v7-00.19-00000000000-20230206T230141Z-avarab@gmail.com>
References: <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com> <cover-v7-00.19-00000000000-20230206T230141Z-avarab@gmail.com>
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
2.39.1.1425.gac85d95d48c

