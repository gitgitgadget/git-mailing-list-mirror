Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E95C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 18:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BB7220758
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 18:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMYVgo4D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390462AbgHQSLh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731120AbgHQSKd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 14:10:33 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2097BC061346
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 11:10:31 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id k8so14682277wma.2
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 11:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Zjk95pttvzZ8tvFZWB6qQy/t3H6QfpLlWhU32dZ+QXA=;
        b=UMYVgo4D3eTkcVsjyIVJDAFgj1JaeLe58IvW5WXUlFkqAVtb9zM2q2QIk3ZDyLAOxv
         ETDvof470U0pevyEA4eC/wXgL7tJlTHqh6xI0x+SwMPxbCr6Z/AivUh4rK6WYxjkINMt
         j52ySlRsR79hI5HZSk648K/670bCwt4VSMvoH87jzazXQBaGKZNsOZC7wri68PV6aKR2
         Zm/2B+Sre9wDPoE8uq81GqJ0Bqy8BvBzT1NsdiPNqpdv0GjNRWGcdE6+Yfv4IzTpsBbp
         gzLaDsVlj3Ow0OrL4Yp6VSrTBP27+6UFODfsUzN2Qv3UxDeLgMgUVFlW+uVLwU6TQ23h
         a+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Zjk95pttvzZ8tvFZWB6qQy/t3H6QfpLlWhU32dZ+QXA=;
        b=IidC0EDgNG5yYtjfnNHs2yotN/s9pzlRtmwWM7uk6ZqnR9fG5baz9dWoHrld7GpkyW
         spqKX+PKNCjrwzOvVTk3Mv3IwYcHsFyZVwXzvR0/6oL06Y+ddtRXmtbn3z8MMzZ4aCuA
         nxdM81OuGlwgVSTP8N9egX0Ypx7fuSwRHTAx769egSOXqlrrs/qhGGAheFUcLjRZMXZK
         729PzcBepQR+PASaIKQil13xkuR8d+KQ1EWzpbk/ot0N7+jOvrYA+fh7DVmGa6u4MIP9
         +F53/z9GpBfDn1rcTtEVgRc6k87hQwIvYc7BipCDg7CSnoR78RJjJ48lkOTRGYuDJW7q
         pZ+g==
X-Gm-Message-State: AOAM5307uKiXiT39EAhTYGuTy2qafPvMsSy+s+vRJNH5Q8PLdgzGtPY+
        hKQgzdr+wwD4/C2iiDjgA3yWZoIo788=
X-Google-Smtp-Source: ABdhPJyX+TJaatnywdvsV3+ji1H4QCzDQz92G54C5uZrR5UJPCHUee/if/ZeFo2Jud4W47gyQMWH9A==
X-Received: by 2002:a7b:c4ce:: with SMTP id g14mr16407003wmk.51.1597687827518;
        Mon, 17 Aug 2020 11:10:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g18sm32768339wru.27.2020.08.17.11.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 11:10:27 -0700 (PDT)
Message-Id: <fd4ed82e8067a81d5cbca6fd5711927108be236f.1597687822.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.684.v3.git.1597687822.gitgitgadget@gmail.com>
References: <pull.684.v2.git.1596664305.gitgitgadget@gmail.com>
        <pull.684.v3.git.1597687822.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Aug 2020 18:10:18 +0000
Subject: [PATCH v3 5/9] ref-filter: add `short` modifier to 'tree' atom
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
index 066975b306..3449fe45d8 100644
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

