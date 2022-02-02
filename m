Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FA1C433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 02:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243858AbiBBCiD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 21:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243844AbiBBChy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 21:37:54 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50DFC061755
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 18:37:48 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id s9so35506556wrb.6
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 18:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rB1GXXgaPG4nqGNrl25zZ0WJDHbu4Z/7BmEvF3+puqs=;
        b=OJREW0TgcQGNbGWfbXq2+rZ0rgsUyruzjx83J1yzUWQpe+dhxX/eYIRZAFJUb8GAuU
         FS9m0pRHjKuMhWJgJCWCaNy07rBKiplBwcWFnE1mqAUy0fSFsBSeS7lbt6b359N6Aqo7
         sLJF9drANg+3bacGqTqNFhK3IwFKnz/QLtzduyNnZ8KPsgnUiMbx04RXRtyrKywvG3i+
         5W++VCWr+eHGZRYUNuwrWc/EhqyK4e6CX3q/mfR/B0dpfZXzIrNOPAQQ/hmf0E/qJ3ir
         JSjveLO0IBWFap/7QbRbrYqhAWs1XsxD1stBy+hwwtNgjJmN3duoje+hx1x80FWl19oa
         6lmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rB1GXXgaPG4nqGNrl25zZ0WJDHbu4Z/7BmEvF3+puqs=;
        b=q9bkw/0sD7RtkNpe+bGlABSPCFENnH1eOyYgL9M6oDDEBdJ5p5eF51H1oQMEixmTtY
         EFXMvKVnKTxaXZTS3gUfqOaUnEzt9GNWJJC/UvJ2bd8lsypMpQcngVUHr8WvvUuLDWDG
         2Qo29++1r2FjkbdK9l6nsuY601o5qEDUJ4WlFADi4PNBKEnIwkEkyqfL6bEIRZOOfW5d
         43f4FhI1zailsw66tRYW74tjLSOaJRwpkr0xCy5VNIs14XJq1pDN8Q9W7fRy4itqFKpA
         4nsg5cmiSvJqtQRDdzN3aC9n5xhQaHc44dvZDDXqeANNEobzbCHIYXwG66dJ/KpG4LUe
         usXw==
X-Gm-Message-State: AOAM532xX6SbmMMgDjDnBrXL8USLMQ92HuIPZOUBtwen97gs+OPCuVEY
        vEpyKz5gKzha1vA0uonQ5MHLAe6/tNA=
X-Google-Smtp-Source: ABdhPJzGqt0+5ySinveSAX8B81OuJqddRCSDgCRAwszriQlwrF3+bjubICRlqw02NmbF3DgG1mbdEA==
X-Received: by 2002:a5d:4a46:: with SMTP id v6mr13210725wrs.526.1643769467175;
        Tue, 01 Feb 2022 18:37:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z17sm3307859wmf.47.2022.02.01.18.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 18:37:46 -0800 (PST)
Message-Id: <aa63860cd0fe57e9a568e724f683af89f99dcd3e.1643769457.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1103.v5.git.1643769457.gitgitgadget@gmail.com>
References: <pull.1103.v4.git.1642792341.gitgitgadget@gmail.com>
        <pull.1103.v5.git.1643769457.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Feb 2022 02:37:36 +0000
Subject: [PATCH v5 09/10] merge-ort: mark conflict/warning messages from inner
 merges as omittable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Neeraj Singh <nksingh85@gmail.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

A recursive merge involves merging the merge bases of the two branches
being merged.  Such an inner merge can itself generate conflict notices.
While such notices may be useful when initially trying to create a
merge, they seem to just be noise when investigating merges later with
--remerge-diff.  (Especially when both sides of the outer merge resolved
the conflict the same way leading to no overall conflict.)  Remove them.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 43f980d2586..9bf15a01db8 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -638,7 +638,9 @@ static void path_msg(struct merge_options *opt,
 	struct strbuf tmp = STRBUF_INIT;
 
 	if (opt->record_conflict_msgs_as_headers && omittable_hint)
-		return; /* Do not record mere hints in tree */
+		return; /* Do not record mere hints in headers */
+	if (opt->record_conflict_msgs_as_headers && opt->priv->call_depth)
+		return; /* Do not record inner merge issues in headers */
 	sb = strmap_get(&opt->priv->output, path);
 	if (!sb) {
 		sb = xmalloc(sizeof(*sb));
-- 
gitgitgadget

