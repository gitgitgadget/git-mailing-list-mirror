Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50326C43381
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 02:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11B8022D5B
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 02:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbhALC1y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 21:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729488AbhALC1w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 21:27:52 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDF9C061794
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 18:27:12 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id b3so135007pft.3
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 18:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I9Ygqg2t8YBYHq4iYhbr64QHVFjSLLX/XSZIkTqLHak=;
        b=f5OPmQbwvZGcpFgCeORSU2LNTETJykmEq/PmtYUp3YSHgpkFtgxHiuHC3/cIvM/tLI
         eaUpd8i5MppG3fx2z3B5DKb18UgPtQ8RpTOMRmLKf4IJ1OvweDORQ0HT8Inzxg5SaYxt
         EqQ+6VRv/AOvQhnrd1UiJLf8++tdVtRXqlv3Gscp9Wl5+uW2eSIKV02hql0mRhuNBuzX
         ht35DhT+rKAIjhJRHyRQbkcw2bHTxJwfXc3BWGSwfy6G1FXBolEY/df0rvua0D9c4F6t
         vhu1g9iIKzr/vQ5baI2nf0CGlJ3J1NcfSCPoPloSIoZbigLw6MuQ+oUbvmdDNzlTzVW9
         up0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I9Ygqg2t8YBYHq4iYhbr64QHVFjSLLX/XSZIkTqLHak=;
        b=qC1liIw1N8bT9j/fZeMLh99TuoMnILk0i6w0sBW/4/I+HkTjJJGV+BN9x7eXt+aig5
         L3inrHwEFYGvgK4LD+Y3CHI/s37RIheHufcSXAkKoMJ1OrUJQgRd+Io1fdyTjQpvSR6V
         hgDEV9Y99mFMNVykt161b4PcR9ghDRG+qEWN/9WDdpZnwbvNmUrJu5mSxOLx9gEkTd/H
         VP3VhZ4XNAQUHs6qkASwz1y+/O2yghiH+bDKYUxPPCsMOAKHGTR8GlfZ4NRXjkUWjJEo
         /RhGcFr2Zg/rubvOEWGl9O5Cz3x4c9Z1q03ArNeOz6t3d4WVkBey1wkSjr8Fgf/JeGxi
         az0w==
X-Gm-Message-State: AOAM533N0OqBgVg2kFVuxy36xhlysoWQ1EtVO86ZPWjQUSds7P1RyZlp
        ViQWFjCLCAOM+Gn5ykzC593PHZeMxxI=
X-Google-Smtp-Source: ABdhPJyxFqAgm5TEqDFXvdQDPtv1VUNVjzbiX1hDaSKKRvhIj+XvFdKF1oyOP5/LhWWcvIxpD52a3A==
X-Received: by 2002:a65:6290:: with SMTP id f16mr2384618pgv.69.1610418431686;
        Mon, 11 Jan 2021 18:27:11 -0800 (PST)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id cq15sm813134pjb.27.2021.01.11.18.27.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jan 2021 18:27:11 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v6 2/3] bundle: lost objects when removing duplicate pendings
Date:   Mon, 11 Jan 2021 21:27:02 -0500
Message-Id: <20210112022703.1884-3-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <xmqq1rer8cbz.fsf@gitster.c.googlers.com>
References: <xmqq1rer8cbz.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

`git rev-list` will list one commit for the following command:

    $ git rev-list 'main^!'
    <tip-commit-of-main-branch>

But providing the same rev-list args to `git bundle`, fail to create
a bundle file.

    $ git bundle create - 'main^!'
    # v2 git bundle
    -<OID> <one-line-message>

    fatal: Refusing to create empty bundle.

This is because when removing duplicate objects in function
`object_array_remove_duplicates()`, one unique pending object which has
the same name is deleted by mistake.  The revision arg 'main^!' in the
above example is parsed by `handle_revision_arg()`, and at lease two
different objects will be appended to `revs.pending`, one points to the
parent commit of the "main" branch, and the other points to the tip
commit of the "main" branch.  These two objects have the same name
"main".  Only one object is left with the name "main" after calling the
function `object_array_remove_duplicates()`.

And what's worse, when adding boundary commits into pending list, we use
one-line commit message as names, and the arbitory names may surprise
git-bundle.

Only comparing objects themselves (".item") is also not good enough,
because user may want to create a bundle with two identical objects but
with different reference names, such as: "HEAD" and "refs/heads/main".

Add new function `contains_object()` which compare both the address and
the name of the object.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 object.c               | 10 ++++++----
 t/t6020-bundle-misc.sh |  2 +-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/object.c b/object.c
index 68f80b0b3d..98017bed8e 100644
--- a/object.c
+++ b/object.c
@@ -412,15 +412,16 @@ void object_array_clear(struct object_array *array)
 }
 
 /*
- * Return true iff array already contains an entry with name.
+ * Return true if array already contains an entry.
  */
-static int contains_name(struct object_array *array, const char *name)
+static int contains_object(struct object_array *array,
+			   const struct object *item, const char *name)
 {
 	unsigned nr = array->nr, i;
 	struct object_array_entry *object = array->objects;
 
 	for (i = 0; i < nr; i++, object++)
-		if (!strcmp(object->name, name))
+		if (item == object->item && !strcmp(object->name, name))
 			return 1;
 	return 0;
 }
@@ -432,7 +433,8 @@ void object_array_remove_duplicates(struct object_array *array)
 
 	array->nr = 0;
 	for (src = 0; src < nr; src++) {
-		if (!contains_name(array, objects[src].name)) {
+		if (!contains_object(array, objects[src].item,
+				     objects[src].name)) {
 			if (src != array->nr)
 				objects[array->nr] = objects[src];
 			array->nr++;
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index 201f34b5c3..b554538e00 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -167,7 +167,7 @@ test_expect_success 'setup' '
 	test_commit_setvar P "Commit P" main.txt
 '
 
-test_expect_failure 'create bundle from special rev: main^!' '
+test_expect_success 'create bundle from special rev: main^!' '
 	git bundle create special-rev.bdl "main^!" &&
 
 	git bundle list-heads special-rev.bdl |
-- 
2.28.0.15.gba9e81f0bd

