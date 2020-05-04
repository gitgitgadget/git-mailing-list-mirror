Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5913C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 19:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1ED7206B8
	for <git@archiver.kernel.org>; Mon,  4 May 2020 19:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVDn2qp5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgEDTDx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 15:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725981AbgEDTDx (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 15:03:53 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE700C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 12:03:52 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x18so419632wrq.2
        for <git@vger.kernel.org>; Mon, 04 May 2020 12:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=q9NuaAvYc4TMXl8Vc00eXBn/gp7cRyZftwBh5NUsgbc=;
        b=BVDn2qp5JFnkpNnsQOnZQvX9vw6rzHbXP30fOcOkKPkaCufy2zZrbT9QLyV24q93iq
         TX5fGOAm1fUfuEjYbc8wFo/4a658+KOp60pi/z0la3PKZtm4Ybv2Ms+KqcQE6tQa+Ury
         oaFQ/08kveaI1DGV0V9QUePC9un5VfTszuyqhPhwqvtC2zZxu9SpNGe2RQHNcONCiz8M
         4m76gVt901axUiMxzjWLniRA+asSHLLPhyi9CpRpNMDhSYIc+QXLALDXGDqxsGqxDB8t
         0zlmzAvfnt0xKwe7KbjqrhInrzFLhXRKQYAIlDCCrOrI9rnC+UWiiTtdjMCQ+nXnHpuV
         scJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=q9NuaAvYc4TMXl8Vc00eXBn/gp7cRyZftwBh5NUsgbc=;
        b=CGg+DFB2FNqpUwQOSWhCShFixbX3dl2Z7En8GhEnMNYiYHmUVSDG6ooQePdnXm8znu
         Cd1HjufajcP27hUsAJdbc8GtrMU2BuNFltOQDEcYlmNN13tfOi9YR8G6WTIeP0L2DEpD
         EYgo8HxyRr5wjdsB6IIgUKNaFqXORiWIrUzbGxvJ/to+W+RZyXF9XXc8jQ+NPLVjqR3f
         3nbCjz07E2JHhUIr8qlRlNCKnNHfn5F0TvL6dw1V88iIbEweGI0Q1bVgWakDhAxWUZAu
         siyKcKfDvUXjn5+OMTy3V41TMyD7YfIFT11emsW23cbJrGP2cXsiDdZz+H+Qlv9gXi/w
         +Zcw==
X-Gm-Message-State: AGi0PubGBG7eNovqv6eHo0dvatQ1BSsYlTdsShQnM94JtqfsdJTom+Ej
        ZYphzVYEmytq0W0yrcMoW/tgkblf
X-Google-Smtp-Source: APiQypKH6hDGOcT98Naxsoi96dgoPBilZRwZzvC2wJIbQmKrhLAJ+JymuDggArXWplJyCEzya/dPbg==
X-Received: by 2002:a5d:68cb:: with SMTP id p11mr520076wrw.349.1588619031447;
        Mon, 04 May 2020 12:03:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h2sm542553wmf.34.2020.05.04.12.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 12:03:51 -0700 (PDT)
Message-Id: <dfa5fd74f859b2186d0222f98417128c52903fe7.1588619028.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v11.git.1588619028.gitgitgadget@gmail.com>
References: <pull.539.v10.git.1588018418.gitgitgadget@gmail.com>
        <pull.539.v11.git.1588619028.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 May 2020 19:03:37 +0000
Subject: [PATCH v11 01/12] refs.h: clarify reflog iteration order
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
index a92d2c74c83..9421c5b8465 100644
--- a/refs.h
+++ b/refs.h
@@ -432,18 +432,21 @@ int delete_refs(const char *msg, struct string_list *refnames,
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

