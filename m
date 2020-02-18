Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D51C34033
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 08:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE54520658
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 08:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEkxjZfU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgBRInq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 03:43:46 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45795 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgBRInq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 03:43:46 -0500
Received: by mail-wr1-f68.google.com with SMTP id g3so22790746wrs.12
        for <git@vger.kernel.org>; Tue, 18 Feb 2020 00:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NfPWVYm5oJnAy6N3ND7qYx88WtkIig5hT6uesdXdV6c=;
        b=DEkxjZfUWhDFncxn0Eu94UaYPDHoocJf38uDmyyCbnxrFae1JWczWw5LHrJ97FjHp4
         yAUMnHKgHj9vOBmFurUr8X7RCPveGE+9sbPwMMijiYAuMT4h9Z6VzatnJQx4HiVBG3ic
         uyv6Ewt8OgslJnCQfuV6XGv1wgpWILil3Bjju3MXBMS0KckbwhvKF7me9FZhNn8T1B7x
         SiW7ugilLfZ1Kc7wQMyGI21CpxlPcW5o/tRPKUIJk+8D/SiG+b/Fuwp4Wla1sP0V8CT+
         D2q8RBn6PXKam3OLQn8J5IFAiyG+BboqZCghTSs2Lnt3899Uh6LvuaW5jZ1+wbUAbvFm
         lFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NfPWVYm5oJnAy6N3ND7qYx88WtkIig5hT6uesdXdV6c=;
        b=jAQ1xw6+uE2ID1ZfY/ajMUd76QfESuAi43whgsbKJS+cBdYJ7t2rSmwLvgg/6u65Ot
         ZacVhY2bhD/UEXkdrh/E3QZ0cBh/boWut6bo5mQl8vScNASn1KLOdAnWeVKUAJ4q/7Ma
         ZfEN+YiCnfCdF6YMBAKfL1scobh61NEQy9mj94y+fxjJJXFWFRXwApPbxfEWOT18enpe
         Yj+Xxt5ScKbFSdQfBEYDN8HeHL0aXM3/7w8nh090BSY5MSRBTZGMphvUDpA/iQ2H/Xbk
         7B4wnVeZomBE+ktazMKBctpUI6cK1U4ISyLYBmZ98AW/awVu1WgqWzoLdgsM+9Ww+FEO
         mP0g==
X-Gm-Message-State: APjAAAWDdI3lQOUoQeF3o2bPCAtlNjzWh/gP2rniiPdCZ8jinrjIsVOo
        wB89HSSyO0uR3t8Y9nGmHBB08ApR
X-Google-Smtp-Source: APXvYqwDcwdUzBgvrdH+piiyJwDvj5XEUsa3HhrQhCLy1fg+uGg7c+cP6ORYlA/YDvbBdEczksWFWA==
X-Received: by 2002:a5d:5183:: with SMTP id k3mr27147256wrv.414.1582015422635;
        Tue, 18 Feb 2020 00:43:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a26sm2770770wmm.18.2020.02.18.00.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 00:43:42 -0800 (PST)
Message-Id: <e4b0773becd7cc5693fd02094d2849f305c0b162.1582015420.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v6.git.1582015420.gitgitgadget@gmail.com>
References: <pull.539.v5.git.1581344060.gitgitgadget@gmail.com>
        <pull.539.v6.git.1582015420.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 Feb 2020 08:43:36 +0000
Subject: [PATCH v6 1/5] refs.h: clarify reflog iteration order
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/refs.h b/refs.h
index 545029c6d80..87c9ec921b9 100644
--- a/refs.h
+++ b/refs.h
@@ -444,18 +444,21 @@ int delete_refs(const char *msg, struct string_list *refnames,
 int refs_delete_reflog(struct ref_store *refs, const char *refname);
 int delete_reflog(const char *refname);
 
-/* iterate over reflog entries */
+/* Iterate over reflog entries. */
 typedef int each_reflog_ent_fn(
 		struct object_id *old_oid, struct object_id *new_oid,
 		const char *committer, timestamp_t timestamp,
 		int tz, const char *msg, void *cb_data);
 
+/* Iterate in over reflog entries, oldest entry first. */
 int refs_for_each_reflog_ent(struct ref_store *refs, const char *refname,
 			     each_reflog_ent_fn fn, void *cb_data);
 int refs_for_each_reflog_ent_reverse(struct ref_store *refs,
 				     const char *refname,
 				     each_reflog_ent_fn fn,
 				     void *cb_data);
+
+/* Call a function for each reflog entry, oldest entry first. */
 int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_data);
 int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void *cb_data);
 
-- 
gitgitgadget

