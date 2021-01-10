Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D636C433E6
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 14:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F0F82376F
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 14:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbhAJObG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 09:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbhAJObF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jan 2021 09:31:05 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCA9C06179F
        for <git@vger.kernel.org>; Sun, 10 Jan 2021 06:30:25 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id y12so1980152pji.1
        for <git@vger.kernel.org>; Sun, 10 Jan 2021 06:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DwVHRXCVtJxdfAIdCEwM4zmLv5rFh5bOWni9Nw8h05g=;
        b=CVJCkfRMdAqH+8McAqQ4RhEWQHI+l76hV+XX1Ejusowc6vph2O/RI6eUgGeWZcHfM8
         u0V3k56KcKq4XvzwBAAsIyiCOCxQqzKwWMfzMhnvmTS5b1Oojg2nBWb24LXkDqJjitbM
         edLv80Cfl75GXA8QrhQZpQjkVVV0TLEgAAZbAkW8F5MpI5ZNP7/ky8/++WDxaPc9e9ds
         NaeBtmSAxGuiqBBzK6lvwcKIWh/spdEkO6G/XgETo/MuAYdOdRJWgP7k6J3Jbks8V7DD
         BNFsYQ2+cvyC+aLv+mFqN22a4szVHBraPcprphZDm4JavoOMD/XafhFtt/4YauhzuUW7
         086A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DwVHRXCVtJxdfAIdCEwM4zmLv5rFh5bOWni9Nw8h05g=;
        b=sHhir7Xs/0WwspzX5SEygx0vcPz2cWagedpml1Nab2o9ruFXycUA3TJZJyoffyfE3c
         MPxAt1Q46HJIRZvYMSw5e1Y22QwIqKvYcouykRFf8qCmGoHLEWvy3OaMbpYOKhIvmZ2L
         IJC+bQfOSb6RQ6rSdS3kkF607/msQ+bRab+tW9tMUvHdMSmN0F6n868bRti2sGMuY1G0
         2d4CfQQqTdN1lgd1Lb53FG3TzO/CkIP5DNQV1/LPwOOkdoRnCWKgkXOOlhroJ5l3F2FV
         LWk5lm1HRfEAWlpHq5VWkGkOjE2VHY0nWq92fi9dF1h5yzUxbrRTChnCr4pYysmLqSKj
         yAeQ==
X-Gm-Message-State: AOAM532Tx6bMZzEPqT+rB98p/ZPOBZzmWowuSdGgjrtV3GlBuD9YhUHU
        F5N8SzIBzlX2V0Z0xQNrTIg4H8TIt9k=
X-Google-Smtp-Source: ABdhPJyNXzzXEYZ8osA+m/w9wMQeahN+L2Us8n7knSG1kKm2ccA4KyXddxImPifw+Wv53pDAauVrKg==
X-Received: by 2002:a17:902:694c:b029:db:d939:1061 with SMTP id k12-20020a170902694cb02900dbd9391061mr12454371plt.80.1610289024673;
        Sun, 10 Jan 2021 06:30:24 -0800 (PST)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id a13sm16044863pfr.59.2021.01.10.06.30.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jan 2021 06:30:24 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v5 2/3] bundle: lost objects when removing duplicate pendings
Date:   Sun, 10 Jan 2021 09:30:18 -0500
Message-Id: <20210110143019.5625-3-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <xmqqbldxg466.fsf@gitster.c.googlers.com>
References: <xmqqbldxg466.fsf@gitster.c.googlers.com>
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
index 637cdb5a8e..5c9d5ed94d 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -169,7 +169,7 @@ test_expect_success 'setup' '
 	test_commit_setvar P "Commit P" main.txt
 '
 
-test_expect_failure 'create bundle from special rev: main^!' '
+test_expect_success 'create bundle from special rev: main^!' '
 	git bundle create special-rev.bdl "main^!" &&
 
 	git bundle list-heads special-rev.bdl |
-- 
2.30.0.2.g06d2f50715

