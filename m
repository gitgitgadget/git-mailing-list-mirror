Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89843C433F5
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 23:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242434AbhL3Xga (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 18:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242375AbhL3XgU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 18:36:20 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95880C061759
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 15:36:19 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id d198-20020a1c1dcf000000b0034569cdd2a2so14023568wmd.5
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 15:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rB1GXXgaPG4nqGNrl25zZ0WJDHbu4Z/7BmEvF3+puqs=;
        b=qANvZ1Mi5IyKGno9SH0+x7uebwGabnmQsJuXzawJK/2CLMnI4hTnGuAZoUipTQqv+r
         83KnTWszfRs//whedDtwf2Yd1lcjefTVxXSZjLixapMdiiX33J5gs+3lJEbN18x32iLl
         BiEGoRqiok/5pVSOYFihMemaVMRTTNuLdJZu9xaX+AFCcI9a7NiuTRN0qMqNxZMmKCMa
         fRzNavDF4URiKhssMDmO0PgH3SumB2OymTbB47rK3AAcTl8Zz/foovZgobhs5AIA7B0O
         BNw0Ij8lMFzsWTuU5yUtF34N3VNOcDntlxCHu6U2eVH1lJ0s7mPr0MfoXnPdJNT9g/7R
         O3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rB1GXXgaPG4nqGNrl25zZ0WJDHbu4Z/7BmEvF3+puqs=;
        b=HtMNOiWQDcPcFTSAGphRlddtTH/9X9oxW3S3bNUcVXUxtLWNDCforW68RuQq3mLIlH
         AXIwsdy91uPJCwSDnBzldmOQplk4Sgge88gl6XJAN9VaL1EYLhs4dAzk9Eg6ZIX2fDZ7
         G0l+VnSi76GmHDcjMTYkKQPNqYLPbJsMovIhZvex7iXaIlS44e9gspQsIAQodrgQcjrN
         nOzbInUE2XRTJGIK5doB59Vka/kL5gnpkghyt45xrWM2rYD20Hk1+wERE4XmY+Zq2LIg
         bc8PXRSzCpYfKyRAD+9MY6uMRMO95jrMtsAV/nChlnRe7Zd6BLEImt29UcsVSlt5Y8hz
         Ns9A==
X-Gm-Message-State: AOAM5332aS5/bCsGfrpzN5xcUJQJJsootjFy7CokkG/DJiMzJFYAk6z3
        qM2rZNtkjbfsZAbmJhM8LskdvXe4ByA=
X-Google-Smtp-Source: ABdhPJzW7hi++3aoF+NqkixXvVCRgwxQdIwzcl0rtvE6uP0tJSrN7xSBKiTHo6NTc4R8GUUOAS85MA==
X-Received: by 2002:a7b:c5c2:: with SMTP id n2mr28056184wmk.141.1640907378051;
        Thu, 30 Dec 2021 15:36:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c9sm23885826wml.12.2021.12.30.15.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 15:36:17 -0800 (PST)
Message-Id: <64b44ee84f3f649219bcc9d9150b2c5cbe3c7f35.1640907369.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1103.v3.git.1640907369.gitgitgadget@gmail.com>
References: <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
        <pull.1103.v3.git.1640907369.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Dec 2021 23:36:09 +0000
Subject: [PATCH v3 9/9] merge-ort: mark conflict/warning messages from inner
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
