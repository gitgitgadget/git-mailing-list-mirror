Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C35C433DF
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 20:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42B5A2074F
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 20:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghxL8h53"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgG0UnO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 16:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgG0UnN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 16:43:13 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46672C0619D2
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 13:43:13 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f1so15625674wro.2
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 13:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=S8/R20ozMrlzYGXJXCAiiYXXKdW78PiK95nJRXRiKYY=;
        b=ghxL8h533G9QIVxN8rh9oxEBLFUWvJ9FKfWrSydhV7uwtRfj/9tFMjY51OOtCZO/2o
         1KUEv6lMRAbYwP+919rHSVunWUOstTwHZuA7loMWNEJ2w5wiO5O6SWZfc5+HCJ+93oJF
         07DE6x+QjufZoiULV8/FcclOjfI3SpWIiXCOtP1t6VL8nqo/CpzGIwnwLFDdpkLRPLeE
         i7jvucrjwTtwc2x75DUyUMqy6j4+mTzF5Y1CGiyuwvvjNXUoVLiijKptSt1Q94I4ojVx
         NlJhoDXiwn8M9EIbwIumulfL560KdbROg81P93gqnsPCze5/Lo8S6CPag7b3p/+YgCEO
         YNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=S8/R20ozMrlzYGXJXCAiiYXXKdW78PiK95nJRXRiKYY=;
        b=FIZ9ngFnMHN+ZKP+X9mD616TqHkvSx+3LCHhdfihg9/SST5KnLuec5eYKNfCRme8tY
         fV9jAngULcwK9K83RkbSVJBAXurlM6pi0YuwSiIK7dWeXzMHuOYMOvGz1XHigM0TrXoz
         spLHB6w3iEMJMc4UmIsVin0TNNWHnT2lZgXg37iV/Zn/FsCKAtJ5sqrG/S6BuatP1C7k
         c0kvEwXK7acBeFiAMXX16LEEXDsPYlyxGWIfFZ1FL6YlxcMnng2KQ3x6TULIFFyW5j2+
         HFdrbF7khKM4qM6qpF9PJedLZRmCVvE0vgKdRkZxrrVv7dA4gIxaH8LeMuR520mXym/k
         mvxQ==
X-Gm-Message-State: AOAM531uBbImgPbEM8jEMwb2lf+SLUELqPV1KTddK4wbdUjYDY4VX8qK
        myJE2ajVTuUGm66R22hTMRRoudIe
X-Google-Smtp-Source: ABdhPJy3k6oyahU2GKe8uvT1JJt0aizs8rh0ODZ76ZMqJ4LESDE/zWTH0KohKiSB+4vwcrePwkX5cg==
X-Received: by 2002:a5d:65d2:: with SMTP id e18mr21393648wrw.70.1595882591867;
        Mon, 27 Jul 2020 13:43:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p15sm13073627wrj.61.2020.07.27.13.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 13:43:11 -0700 (PDT)
Message-Id: <49344f1b5559e7b4c63bad323a4dab5956331dde.1595882588.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.684.git.1595882588.gitgitgadget@gmail.com>
References: <pull.684.git.1595882588.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jul 2020 20:43:05 +0000
Subject: [PATCH 2/5] ref-filter: add `short` option for 'tree' and 'parent'
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

Sometimes while using 'parent' and 'tree' atom, user might
want to see abbrev hash instead of full 40 character hash.

'objectname' and 'refname' already supports printing abbrev hash.
It might be convenient for users to have the same option for printing
'parent' and 'tree' hash.

Let's introduce `short` option to 'parent' and 'tree' atom.

`tree:short` - for abbrev tree hash
`parent:short` - for abbrev parent hash

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Heba Waly <heba.waly@gmail.com>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 ref-filter.c            | 12 ++++++++----
 t/t6300-for-each-ref.sh |  4 ++++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 8563088eb1..d5d5ff6a9d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -983,21 +983,25 @@ static void grab_commit_values(struct atom_value *val, int deref, struct object
 			continue;
 		if (deref)
 			name++;
-		if (!strcmp(name, "tree")) {
+		if (!strcmp(name, "tree"))
 			v->s = xstrdup(oid_to_hex(get_commit_tree_oid(commit)));
-		}
+		else if (!strcmp(name, "tree:short"))
+			v->s = xstrdup(find_unique_abbrev(get_commit_tree_oid(commit), DEFAULT_ABBREV));
 		else if (!strcmp(name, "numparent")) {
 			v->value = commit_list_count(commit->parents);
 			v->s = xstrfmt("%lu", (unsigned long)v->value);
 		}
-		else if (!strcmp(name, "parent")) {
+		else if (starts_with(name, "parent")) {
 			struct commit_list *parents;
 			struct strbuf s = STRBUF_INIT;
 			for (parents = commit->parents; parents; parents = parents->next) {
 				struct commit *parent = parents->item;
 				if (parents != commit->parents)
 					strbuf_addch(&s, ' ');
-				strbuf_addstr(&s, oid_to_hex(&parent->object.oid));
+				if (!strcmp(name, "parent"))
+					strbuf_addstr(&s, oid_to_hex(&parent->object.oid));
+				else if (!strcmp(name, "parent:short"))
+					strbuf_add_unique_abbrev(&s, &parent->object.oid, DEFAULT_ABBREV);
 			}
 			v->s = strbuf_detach(&s, NULL);
 		}
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index b8a2cb8439..533827d297 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -97,7 +97,9 @@ test_atom head objectname:short $(git rev-parse --short refs/heads/master)
 test_atom head objectname:short=1 $(git rev-parse --short=1 refs/heads/master)
 test_atom head objectname:short=10 $(git rev-parse --short=10 refs/heads/master)
 test_atom head tree $(git rev-parse refs/heads/master^{tree})
+test_atom head tree:short $(git rev-parse --short refs/heads/master^{tree})
 test_atom head parent ''
+test_atom head parent:short ''
 test_atom head numparent 0
 test_atom head object ''
 test_atom head type ''
@@ -148,7 +150,9 @@ test_atom tag objectname:short $(git rev-parse --short refs/tags/testtag)
 test_atom head objectname:short=1 $(git rev-parse --short=1 refs/heads/master)
 test_atom head objectname:short=10 $(git rev-parse --short=10 refs/heads/master)
 test_atom tag tree ''
+test_atom tag tree:short ''
 test_atom tag parent ''
+test_atom tag parent:short ''
 test_atom tag numparent ''
 test_atom tag object $(git rev-parse refs/tags/testtag^0)
 test_atom tag type 'commit'
-- 
gitgitgadget

