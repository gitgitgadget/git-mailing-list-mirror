Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B42C433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 20:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241128AbiC2UDM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 16:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241106AbiC2UDH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 16:03:07 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481AB1AD1D7
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 13:01:24 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r7so25242561wrc.0
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 13:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=V7h1Et/Fr9IzVlcxje9DvxP4SiiZa9RzpwQpcrE0d14=;
        b=cXzq45EmVFCqyxLlkfsHqRmuRx7r/cicopbAdmXuxiVtSGL5kbrkTUGWtJUox7tJtm
         HpVrrsvtP+ANq9m2sbF05NevJPTAqseb+HohhX4iXnWkvc7MIQcaxjoH130VDSKGPkJh
         0AccpWdqloYfwr+mDtln/qNEe5IMGkj+Fz1INgH1hzEpQ+wv8LkYU4gRyZA6OOih92Zf
         al34xqz/euJQp0MIXTbwkziKdjSDPB02LjLsYvToBVy/EuwgJBTlCZqU5inOjdzVCaMQ
         xjLoPdRuGH1aVKynicR0q4o4uv/9L9RGQsjo3p8T29o0QNAPNxMcPY2mpUQFMm1Wnfrq
         Gnog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=V7h1Et/Fr9IzVlcxje9DvxP4SiiZa9RzpwQpcrE0d14=;
        b=W6HlqQZQC4PIHTh0X6ghJNDKWBx6Tjn0MV9FWMXZ9W9JYlI4sj+68I7FuqtL8JJL+o
         QPJeqJG9+Y6Rm0/pYoKIXty/XMUq0KpQn7eYb2hrq6EviRlDcTEAYxS+3TH4BUJDgEXB
         /J13kImQCczh05jSLf077DNcAIJjfEKLaoaJURq6m0GC+f+P9g+ObMtdQZrj5OLqPT4M
         rjuZIqn2y1jFZHxCtAqAxOyOw0NtAe2GmxirkcIRgTOnRiHpvi730sXXWDizYBzDOMGM
         tNpnrv6Ju5sJqQIo0LnsHTK84WebhROp/DGXbNKsfpEM0RMLZKdzEnK4ltCuAN+91Qto
         4Paw==
X-Gm-Message-State: AOAM530/89TEZz6dWHvhrSDMPHeGh2oyuQ21MJWaR9fWXXjEgXtCSGhE
        nrm7W61qP/qJ43amfgB8HYCfi16bdQ0=
X-Google-Smtp-Source: ABdhPJz8NmWFGnjEfvbHYwZPoPtLs+IQX8ZlWSHrehqmItf6p3O4c18QoPb1B3bt9yLJHp/nwWxBLA==
X-Received: by 2002:a5d:62c9:0:b0:205:c0ef:7cb4 with SMTP id o9-20020a5d62c9000000b00205c0ef7cb4mr17110973wrv.688.1648584082571;
        Tue, 29 Mar 2022 13:01:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a4-20020a05600c348400b0038cd743830esm2984815wmq.29.2022.03.29.13.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 13:01:22 -0700 (PDT)
Message-Id: <f21d283e5ade542b73cb36178c3c33008e2c67df.1648584079.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1190.git.1648584079.gitgitgadget@gmail.com>
References: <pull.1190.git.1648584079.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Mar 2022 20:01:17 +0000
Subject: [PATCH 2/4] branch: give submodule updating advice before exit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Fix a bug where "hint:" was printed _before_ "fatal:" (instead of the
other way around).

Signed-off-by: Glen Choo <chooglen@google.com>
---
 branch.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/branch.c b/branch.c
index 7377b9f451a..133e6047bc6 100644
--- a/branch.c
+++ b/branch.c
@@ -607,11 +607,13 @@ void create_branches_recursively(struct repository *r, const char *name,
 	 */
 	for (i = 0; i < submodule_entry_list.entry_nr; i++) {
 		if (submodule_entry_list.entries[i].repo == NULL) {
+			int code = die_message(
+				_("submodule '%s': unable to find submodule"),
+				submodule_entry_list.entries[i].submodule->name);
 			if (advice_enabled(ADVICE_SUBMODULES_NOT_UPDATED))
 				advise(_("You may try updating the submodules using 'git checkout %s && git submodule update --init'"),
 				       start_commitish);
-			die(_("submodule '%s': unable to find submodule"),
-			    submodule_entry_list.entries[i].submodule->name);
+			exit(code);
 		}
 
 		if (submodule_create_branch(
-- 
gitgitgadget

