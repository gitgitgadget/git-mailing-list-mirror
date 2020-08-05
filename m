Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70429C433E3
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 21:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C20E206F6
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 21:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbSKq/Us"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgHEVwD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 17:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgHEVvy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 17:51:54 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C0EC061756
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 14:51:54 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id f18so5238095wmc.0
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 14:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eC0RldrHJKKcuVrYX6mEuMdA03cruZ1Gex1FZxdHl60=;
        b=TbSKq/UsXGIoGav1h/CEZqld6ozpjbDgTezg7Tuzc8fA2cGSe/QOJQYtAWqrEKRgJ/
         3FPTLtU78zB5VL1gx/brP7LBv8S3RAzUyqeAVAxOPWDDUVxLIfdaRrlyxewVeBP34Ay+
         uDI2p/qZHPzhcTRpbUdU630FIiwmXE5ISUUiurlhNIY5uMza4MNiq7O1Nyu8PW2GyP5t
         arjVMQwHf5GgpgkJm+69VUE18fpfwTgxL8s+jm7bFGJODxQc6jMEEjwLFYMixCitx/jR
         Og/EdnpKFT2vI1jns13ff2XoNVDRrW0WghsbMJLRrvT4MeMU1+Fabp9civrmLSupI8HW
         Glhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eC0RldrHJKKcuVrYX6mEuMdA03cruZ1Gex1FZxdHl60=;
        b=qDwMFt+sqpmIIpSN0rkYKTwA4PTOWaTtRPgTPTVPwWAtxCKBxMOAmOIhxUZWUZo3VD
         0xpQq8SkrTmXq72UucCS8eQWxrVkuUQTcpz2jKvM4D5F3fHipsPPECC1ZkefXnyia8p+
         W+slFb6flnvgpQWGgn/6NEl5X/mwRYUXApnV1bzsBMC2A2boXxtwgI1Ieg7D9CiIVxj7
         HMpGR0GDXrM46nPB859r7tGnXqUn9tuFUcZzAhUincj4uqnBra2Ai9gRPqHD8hHtfenY
         aV+J5HeAwca9TpIHj1PNqteM+9byF6IgD2SlVcX8mvsneOSu2bC9q74ucu7K3sZGr06o
         VQBA==
X-Gm-Message-State: AOAM531cU3W2Zw2HC5otmDHU6IMSKRdicbJwUbhE5ThC+wzhiuK1PntO
        CfRKvWAAv6HWxDI6nfyy0T6w06Mm
X-Google-Smtp-Source: ABdhPJwFodwMPK4TL9UOhBk5mPyL/gaEgrDINg0JK5vL+KBjXjMPtESrVkcAYWrFhaaj+s0H72amSA==
X-Received: by 2002:a1c:2e4e:: with SMTP id u75mr3973556wmu.134.1596664312755;
        Wed, 05 Aug 2020 14:51:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p14sm4533410wrx.90.2020.08.05.14.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 14:51:52 -0700 (PDT)
Message-Id: <dda7400b14aef8688a8d10728f03e01293a82da6.1596664306.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.684.v2.git.1596664305.gitgitgadget@gmail.com>
References: <pull.684.git.1595882588.gitgitgadget@gmail.com>
        <pull.684.v2.git.1596664305.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Aug 2020 21:51:41 +0000
Subject: [PATCH v2 5/9] ref-filter: add `short` modifier to 'tree' atom
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

Sometimes while using 'tree' atom, user might want to see abbrev hash
instead of full 40 character hash.

Just like 'objectname', it might be convenient for users to have the
`:short` and `:short=<length>` option for printing 'tree' hash.

Let's introduce `short` option to 'tree' atom.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Heba Waly <heba.waly@gmail.com>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 Documentation/git-for-each-ref.txt | 2 ++
 ref-filter.c                       | 9 ++++-----
 t/t6300-for-each-ref.sh            | 6 ++++++
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index e6ce8af612..40ebdfcc41 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -222,6 +222,8 @@ worktreepath::
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
 be used to specify the value in the header field.
+Field `tree` can also be used with modifier `:short` and
+`:short=<length>` just like `objectname`.
 
 For commit and tag objects, the special `creatordate` and `creator`
 fields will correspond to the appropriate date or name-email-date tuple
diff --git a/ref-filter.c b/ref-filter.c
index cc544eadaf..f9d85661eb 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -497,7 +497,7 @@ static struct {
 	{ "objectsize", SOURCE_OTHER, FIELD_ULONG, objectsize_atom_parser },
 	{ "objectname", SOURCE_OTHER, FIELD_STR, oid_atom_parser },
 	{ "deltabase", SOURCE_OTHER, FIELD_STR, deltabase_atom_parser },
-	{ "tree", SOURCE_OBJ },
+	{ "tree", SOURCE_OBJ, FIELD_STR, oid_atom_parser },
 	{ "parent", SOURCE_OBJ },
 	{ "numparent", SOURCE_OBJ, FIELD_ULONG },
 	{ "object", SOURCE_OBJ },
@@ -1005,10 +1005,9 @@ static void grab_commit_values(struct atom_value *val, int deref, struct object
 			continue;
 		if (deref)
 			name++;
-		if (!strcmp(name, "tree")) {
-			v->s = xstrdup(oid_to_hex(get_commit_tree_oid(commit)));
-		}
-		else if (!strcmp(name, "numparent")) {
+		if (grab_oid(name, "tree", get_commit_tree_oid(commit), v, &used_atom[i]))
+			continue;
+		if (!strcmp(name, "numparent")) {
 			v->value = commit_list_count(commit->parents);
 			v->s = xstrfmt("%lu", (unsigned long)v->value);
 		}
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 64fbc91146..e30bbff6d9 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -116,6 +116,9 @@ test_atom head objectname:short $(git rev-parse --short refs/heads/master)
 test_atom head objectname:short=1 $(git rev-parse --short=1 refs/heads/master)
 test_atom head objectname:short=10 $(git rev-parse --short=10 refs/heads/master)
 test_atom head tree $(git rev-parse refs/heads/master^{tree})
+test_atom head tree:short $(git rev-parse --short refs/heads/master^{tree})
+test_atom head tree:short=1 $(git rev-parse --short=1 refs/heads/master^{tree})
+test_atom head tree:short=10 $(git rev-parse --short=10 refs/heads/master^{tree})
 test_atom head parent ''
 test_atom head numparent 0
 test_atom head object ''
@@ -167,6 +170,9 @@ test_atom tag objectname:short $(git rev-parse --short refs/tags/testtag)
 test_atom head objectname:short=1 $(git rev-parse --short=1 refs/heads/master)
 test_atom head objectname:short=10 $(git rev-parse --short=10 refs/heads/master)
 test_atom tag tree ''
+test_atom tag tree:short ''
+test_atom tag tree:short=1 ''
+test_atom tag tree:short=10 ''
 test_atom tag parent ''
 test_atom tag numparent ''
 test_atom tag object $(git rev-parse refs/tags/testtag^0)
-- 
gitgitgadget

