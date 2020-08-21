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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963D3C433E3
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D43E20724
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrTlqILO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgHUVmI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgHUVl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 17:41:59 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69571C061573
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 14:41:58 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id f18so2017517wmc.0
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 14:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Zjk95pttvzZ8tvFZWB6qQy/t3H6QfpLlWhU32dZ+QXA=;
        b=ZrTlqILORdlUub03X4jmbsl8smER0RVG86fckkR+M0Ci7/zKRLPFBmVgKk39fcnJF0
         D+bCPcwPRwlv0aubYE4oj5PTRR/tJYfCxb5Ye3byM4H5xkKm/6Wwf2sblkt25wCBiIBP
         oimbordRBS94ACgCOOnCgLyhIJ+fzshcXjwNtbWD1v+65MBMzxfe4C+1/acJU6b9ryh4
         QO6WNY6Sb1DUwAQ7gRFAHk+VW+RTaDyEGm9w77eJjTiOfG8DNtfl9pH0TKQJdklgOHui
         Z3DHiBky4bnrrVTwO/pJgKy7P7YWQd2VvEd5mk37kHCimNgaLo0v9/BFYpCK5jMYpBLL
         gAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Zjk95pttvzZ8tvFZWB6qQy/t3H6QfpLlWhU32dZ+QXA=;
        b=cBiageCNZsvs9sB0LkZBrae+XF9oFflJwhKR2WSfWmMN/rn7llKLj9SISFJnAc2Li4
         hAE0UliCdlwXIYbNK4UJO2OZS6VUe0qnYXjjZFQCWwg109gGh5ZOqXUiM0Y7Sf9v68Hg
         LaIK5OrZMU5NBufQpYcLZxclTSQH3QCFH8hXUfIosZWKrnG4oJ6j6WJPV5GGPGZhgIlP
         6MhLuq6KCJUNFyu6l37muZTmHuF9Vtm4FgvMyXVz0AGEPwizq2VVZny3bszK5HXI5GMW
         8HzgA+9E+1iheH/XBgnU+uyA4T8ONMNZu/tWxSJTzC5rArKISImRYb9B1TLgDvhC/l5g
         eJEA==
X-Gm-Message-State: AOAM5333VP+/qoizR8sDXV3yxUjj9khszLMIVVHkSl5OzEa9APXnMjYG
        XusrT2TJJpOGVZtk/Re29IzuqFLrniQ=
X-Google-Smtp-Source: ABdhPJy9Z28AvnzbeexnR+Ge//jVhoVP6NTRziNXnS7mKnOhjNuV5APzcc6qJFcg4YMa8XMeFLPTOg==
X-Received: by 2002:a7b:ca48:: with SMTP id m8mr3939389wml.36.1598046116046;
        Fri, 21 Aug 2020 14:41:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 31sm7191645wrp.87.2020.08.21.14.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 14:41:55 -0700 (PDT)
Message-Id: <6b971667960549fb5fbd293e1880ec34169e5aea.1598046110.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.684.v4.git.1598046110.gitgitgadget@gmail.com>
References: <pull.684.v3.git.1597687822.gitgitgadget@gmail.com>
        <pull.684.v4.git.1598046110.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Aug 2020 21:41:47 +0000
Subject: [PATCH v4 5/8] ref-filter: add `short` modifier to 'tree' atom
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

