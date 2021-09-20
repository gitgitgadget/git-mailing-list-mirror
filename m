Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DAFC433F5
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 07:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64520610A8
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 07:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbhITHj2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 03:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbhITHj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 03:39:28 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C48C061574
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 00:38:01 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d6so27062094wrc.11
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 00:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=81sG84XMBOihdyL56zh+JBXiDK1N7mJQP0gmGgbTfR4=;
        b=KA9kOX3iLUEh+ogwU/FICDnoEwuDy4DdIM8sQEmE9m4JjnvcJ4zg8kPzJUO3HIWJTa
         Kq9Cst1H70p43jz1W/pv8+Gm3/U/rftKI9HSSGZSZz7gTdMrxZeV8ero9LStsChvGYU1
         ql9v+hP4CwIeJ6quCkzhWy/Midy36FPvKM1Q4kKH5o5shxEDfDRRXeqqoIzIvWikNMTS
         BJ0kNp5GXmR+1DDwfvxxzv1mjfI+Ek2VSAAYg//TBw3cYpjaKqyrAvLw2kaE6A/RcEfC
         0gAxcb7D1shJY6+dJ1+TvGimZuIwWFCwho1WWns998OU0NTYE0c/W+G/EmwqU23Ad3ZR
         Ytag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=81sG84XMBOihdyL56zh+JBXiDK1N7mJQP0gmGgbTfR4=;
        b=6Hq+HEAlHkS9IuRaD9MMuEF0vcGC6WyCkmiUT3tCwyld5l00E0bKVeoCl5uwcFkXdz
         dcwzqn4GU3RDxpN09G6nA+HfzaTFFfuSEQutjJPOHIDnwLUnig/CYmRI7kqBs5H5ke3U
         a9c+BippqNWS5b9KwI6ywPm2CCLlYaYnBmnpP23tinXALPxSbR454uVbXmNUbKja21j4
         7vsmQoDJ7gRnxo29JzX6+ky+6POClnphSzva3jmH7HmgMrR000c2fpWbKIT1iJnIZMti
         ngA2u20DJNFNeb+mekj52QMRE10mbHMUTwLUzw5OxSaitDHnrvsR9Sn3qPkxaa86ScR3
         9/XQ==
X-Gm-Message-State: AOAM532ruIr0VOUqwQjpbNw94dUkG7TQi8UQjWIK4nJ0Ii/dqLKqH1E9
        obcobUeOjovQZjBxzFHK9op6KfP3XS0=
X-Google-Smtp-Source: ABdhPJxk/o9j0HC3x31hR5AOPd5zCyuhXnD1NVMuPcmFliqN5AI6QxSB7llYrHSgMMbgdmhoHmXznw==
X-Received: by 2002:a05:6000:104e:: with SMTP id c14mr26463011wrx.130.1632123480363;
        Mon, 20 Sep 2021 00:38:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o7sm13617989wmc.46.2021.09.20.00.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 00:38:00 -0700 (PDT)
Message-Id: <4f2f3fc4be468bbde953bd0135e59cd7a36f107f.1632123476.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1042.git.1632123476.gitgitgadget@gmail.com>
References: <pull.1042.git.1632123476.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Sep 2021 07:37:55 +0000
Subject: [PATCH 3/4] verify_tag: use repo_dwim_ref() to get ref fullname and
 ref_flags
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Since verify-tag cannot currently use %(symref) correctly, we need
to get the ref flags from pretty_print_ref() caller. So use
repo_dwim_ref() in cmd_verify_tag() to get fullref name and ref flags
and pass to pretty_print_ref(), which can help us fix %(symref)
feature.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/verify-tag.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 403f2080efa..efc8282782a 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -59,6 +59,8 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 	while (i < argc) {
 		struct object_id oid;
 		const char *name = argv[i++];
+		char *refname;
+		int ref_flags;
 
 		if (get_oid(name, &oid)) {
 			had_error = !!error("tag '%s' not found.", name);
@@ -70,8 +72,10 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
+		if (repo_dwim_ref(the_repository, name, strlen(name), &oid, &refname, 0, &ref_flags, 1))
+			name = refname;
 		if (format.format)
-			pretty_print_ref(name, &oid, &format, 0);
+			pretty_print_ref(name, &oid, &format, ref_flags);
 	}
 	return had_error;
 }
-- 
gitgitgadget

