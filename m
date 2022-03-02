Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABE3C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 04:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239404AbiCBEUH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 23:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiCBEUG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 23:20:06 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862721C12F
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 20:19:24 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id x15so713426wru.13
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 20:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=cSj0svtJC4XYerZk2siDftcfo4vZgzCJwSit1103VpU=;
        b=qt4hv1CoWG4oBfjpNFuUMqfX66IjuAp9VyYpJpP57BuHG6OmWg2YCAmuWIkrKa1qvc
         lGS20NZtTPKpeYA9tiVJzyr4krS9bQp/M/JcaUfEWud9IBSiNFXWnq5drZTFawYX2KxP
         JDVboFAaLlQ0iSmcoKZtpYNBa6+sAMnP233995YcgTm+l47+Fb2m+W0RaWLJyU+FyflA
         9PDovs/vPBH+jrpwdcRAJdELc7vShhdI7Cog4lH3n96wO29X0RV5KpYRYDtVf4HKKNZD
         dKcdISETI+z5NsX9VvwLNBMmcCxMGa5YKty/AHXEGwWi0f9/qvGarYK+tUZ1hr7QavEn
         +iew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cSj0svtJC4XYerZk2siDftcfo4vZgzCJwSit1103VpU=;
        b=YbeQB6/TJo+FY7m3l3Gorv7lKDthY9bPV0yum1N3JLxfM12KslvUFwazrM8T7tOK2x
         U0e7iui0ThwXo1AUVSZl8o1HprHn1Q74dK6Ah8RiqbSWbcwvWXJ9hmD+lwBIUiIQefZT
         zYh99qSBtgUJxGNWt6AtvvAJNG7LGi1XYQt6Tzv4sAJ6ybFyFxkUAwLbt+SgH4mCCJ/N
         XutK/2i4oYjIsH/BFpKH0ZtvjH10mGrr9lWCH+yQ2+WRuyYOVmPy4XJb1hf4H/ewNU0R
         n19Ref4wCSYqT8lJtsp8wjlVs9kDa9LrENt8ZYuiXzTzHloClD4/gSxg17gwL5ER64os
         2yWg==
X-Gm-Message-State: AOAM531fH+JFgkR8rl4lZVuhC8yfJZfLnDBcZZY8O+6wp4fKCWL1yZt8
        W7xMU9cRazU/n38NffSfasVHUvhYJzs=
X-Google-Smtp-Source: ABdhPJxfH3eLUUzCXbtna23p8lASLemllSao9hDvaVp8cjhQAs8S0H2a9EX7UktNniNjeVf3SWQ7ew==
X-Received: by 2002:adf:806e:0:b0:1e3:2a17:bd60 with SMTP id 101-20020adf806e000000b001e32a17bd60mr20594789wrk.719.1646194762797;
        Tue, 01 Mar 2022 20:19:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c3b8500b00380fc02ff76sm4662066wms.15.2022.03.01.20.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 20:19:22 -0800 (PST)
Message-Id: <pull.1167.git.1646194761463.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Mar 2022 04:19:21 +0000
Subject: [PATCH] merge-ort: exclude messages from inner merges by default
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

merge-recursive would only report messages from inner merges when the
GIT_MERGE_VERBOSITY was set to 5.  Do the same for merge-ort.

Note that somewhat reverts 0d83d8240d ("merge-ort: mark conflict/warning
messages from inner merges as omittable", 2022-02-02) based on two
facts:

  * This commit basically removes the showing of messages from inner
    merges as well, at least by default.  The only difference is that
    users can request to get them back by turning up the verbosity.
  * Messages from inner merges are specially annotated since 4a3d86e1bb
    ("merge-ort: make informational messages from recursive merges
    clearer", 2022-02-17).  The ability to distinguish them from outer
    merge comments make them less problematic to include, and easier
    for humans to parse.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    merge-ort: exclude messages from inner merges by default
    
    cf. https://lore.kernel.org/git/xmqqwnheuq79.fsf@gitster.g/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1167%2Fnewren%2Fmerge-ort-squelch-inner-msgs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1167/newren/merge-ort-squelch-inner-msgs-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1167

 merge-ort.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 55decb2587e..be85273c727 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -639,8 +639,9 @@ static void path_msg(struct merge_options *opt,
 
 	if (opt->record_conflict_msgs_as_headers && omittable_hint)
 		return; /* Do not record mere hints in headers */
-	if (opt->record_conflict_msgs_as_headers && opt->priv->call_depth)
-		return; /* Do not record inner merge issues in headers */
+	if (opt->priv->call_depth && opt->verbosity < 5)
+		return; /* Ignore messages from inner merges */
+
 	sb = strmap_get(&opt->priv->output, path);
 	if (!sb) {
 		sb = xmalloc(sizeof(*sb));

base-commit: 715d08a9e51251ad8290b181b6ac3b9e1f9719d7
-- 
gitgitgadget
