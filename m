Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE06C433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 791A0207DE
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjh9n4lA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgHUVmJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbgHUVl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 17:41:59 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA5FC061574
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 14:41:58 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a15so3180342wrh.10
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 14:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=o5X9jZM8RxMRVE7BT4xW91an31/9I25DwJ1adalSf1Y=;
        b=fjh9n4lAX5DOAI9DyOx4k5WHBPfRy1ASY5ccuZS5MvR1GjMi6N6Vhqr4zZmUFu7e40
         dbO+tL3jqGlAloLaJMUcwNW8W+cY3giz8pPkdmTdqTncQKJHQmMaxkFkGNjt1iAQ9Pvd
         fo728DGO9ip7lxKvlg30j7vKuSPfyP5LvgULkXQtTSjwJV+QMYxTC7SFIqKBUGLFwx74
         1Cogpsu37fPgjGfKUMbSHs9U5yOXf5rZAFpqPsq6HOZB/IH23cIRjctZKfb8gsI2DjWc
         89JZOMeJNbpvzEKSYcww2yuEU24O3rcUfR4lf69yPrV39SbTS/gsewSLYHxwClG0Rg7p
         JeQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=o5X9jZM8RxMRVE7BT4xW91an31/9I25DwJ1adalSf1Y=;
        b=EmQiiYgIcBnZXf4w19pgegGA2chy+sc+hMg7iO1UPAdoUJxP4dYNUb+P9+Wf58PyBj
         9qYC5CB/USBW/jGW4giaHqCj42/55Lgb70/MkWgh89hKJbHTySymSwfQjajaWIc9nhbb
         e1/5x0fjqCJS2Dpp7Soaqy9AzShK5MFpow6CmBMtFlnRO47YsPLYiWdcUn2jPQ/Np4yf
         6WRH2vCnZ0bYzSFqKPd0lrzDA3avGXttUChsy2Ja0T5ZSpSu7ANHVFr4Hy5A9iPGpC53
         e2IHkWixKQpbdWNU6ZJxQRyKB9RE4LN2clVd6B5sr2K0QA9cH4f5CYow0ZjlY2EXH5Mw
         fQug==
X-Gm-Message-State: AOAM533BcBETSiI46KrMiPxVMbZ6We7cN5+sJ+yBIejxtM08WZtQO5KJ
        auqW70pB/NZ2efJeV/BRNKD33RFoYg0=
X-Google-Smtp-Source: ABdhPJxG8aIee4tOlMF5ATrvIDsvRUKp5OTlw4sNd0gKoGY03aPsXz11KPGJgemf6pfwcH1tWRoylw==
X-Received: by 2002:a5d:5704:: with SMTP id a4mr4278487wrv.318.1598046116946;
        Fri, 21 Aug 2020 14:41:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 31sm6446461wrj.94.2020.08.21.14.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 14:41:56 -0700 (PDT)
Message-Id: <5ed5ac259d59b855fc5c956bc8af80fecfc7c971.1598046110.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.684.v4.git.1598046110.gitgitgadget@gmail.com>
References: <pull.684.v3.git.1597687822.gitgitgadget@gmail.com>
        <pull.684.v4.git.1598046110.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Aug 2020 21:41:48 +0000
Subject: [PATCH v4 6/8] ref-filter: add `short` modifier to 'parent' atom
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Hariom Verma <hariom18599@gmail.com>

Sometimes while using 'parent' atom, user might want to see abbrev hash
instead of full 40 character hash.

Just like 'objectname', it might be convenient for users to have the
`:short` and `:short=<length>` option for printing 'parent' hash.

Let's introduce `short` option to 'parent' atom.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Heba Waly <heba.waly@gmail.com>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 Documentation/git-for-each-ref.txt | 2 +-
 ref-filter.c                       | 8 ++++----
 t/t6300-for-each-ref.sh            | 6 ++++++
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 40ebdfcc41..dd09763e7d 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -222,7 +222,7 @@ worktreepath::
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
 be used to specify the value in the header field.
-Field `tree` can also be used with modifier `:short` and
+Fields `tree` and `parent` can also be used with modifier `:short` and
 `:short=<length>` just like `objectname`.
 
 For commit and tag objects, the special `creatordate` and `creator`
diff --git a/ref-filter.c b/ref-filter.c
index 3449fe45d8..c7d81088e4 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -498,7 +498,7 @@ static struct {
 	{ "objectname", SOURCE_OTHER, FIELD_STR, oid_atom_parser },
 	{ "deltabase", SOURCE_OTHER, FIELD_STR, deltabase_atom_parser },
 	{ "tree", SOURCE_OBJ, FIELD_STR, oid_atom_parser },
-	{ "parent", SOURCE_OBJ },
+	{ "parent", SOURCE_OBJ, FIELD_STR, oid_atom_parser },
 	{ "numparent", SOURCE_OBJ, FIELD_ULONG },
 	{ "object", SOURCE_OBJ },
 	{ "type", SOURCE_OBJ },
@@ -1011,14 +1011,14 @@ static void grab_commit_values(struct atom_value *val, int deref, struct object
 			v->value = commit_list_count(commit->parents);
 			v->s = xstrfmt("%lu", (unsigned long)v->value);
 		}
-		else if (!strcmp(name, "parent")) {
+		else if (starts_with(name, "parent")) {
 			struct commit_list *parents;
 			struct strbuf s = STRBUF_INIT;
 			for (parents = commit->parents; parents; parents = parents->next) {
-				struct commit *parent = parents->item;
+				struct object_id *oid = &parents->item->object.oid;
 				if (parents != commit->parents)
 					strbuf_addch(&s, ' ');
-				strbuf_addstr(&s, oid_to_hex(&parent->object.oid));
+				strbuf_addstr(&s, do_grab_oid("parent", oid, &used_atom[i]));
 			}
 			v->s = strbuf_detach(&s, NULL);
 		}
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index e30bbff6d9..79d5b29387 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -120,6 +120,9 @@ test_atom head tree:short $(git rev-parse --short refs/heads/master^{tree})
 test_atom head tree:short=1 $(git rev-parse --short=1 refs/heads/master^{tree})
 test_atom head tree:short=10 $(git rev-parse --short=10 refs/heads/master^{tree})
 test_atom head parent ''
+test_atom head parent:short ''
+test_atom head parent:short=1 ''
+test_atom head parent:short=10 ''
 test_atom head numparent 0
 test_atom head object ''
 test_atom head type ''
@@ -174,6 +177,9 @@ test_atom tag tree:short ''
 test_atom tag tree:short=1 ''
 test_atom tag tree:short=10 ''
 test_atom tag parent ''
+test_atom tag parent:short ''
+test_atom tag parent:short=1 ''
+test_atom tag parent:short=10 ''
 test_atom tag numparent ''
 test_atom tag object $(git rev-parse refs/tags/testtag^0)
 test_atom tag type 'commit'
-- 
gitgitgadget

