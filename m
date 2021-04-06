Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCB6C433B4
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 18:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 213ED60FF0
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 18:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbhDFSNL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 14:13:11 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:33686 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbhDFSNL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 14:13:11 -0400
Received: by mail-lf1-f45.google.com with SMTP id o126so24298875lfa.0
        for <git@vger.kernel.org>; Tue, 06 Apr 2021 11:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eqhK08kXxi5g3XQPybkaYtR17KFkJhs6Nth03tFcM3s=;
        b=UrlFt3qW3DHh5mPSeegTAPi8Bc4rch7CdLRqF8NSb8WMQpnN+cmC383huMMMsveQpc
         i2WMyJS/8Nj2kKsmNwjr3GVqy+vgn/faBSwRfJNKmCnJL0/ngRybll8pTlaS+BkB5ery
         Q/YhwB/XKVhOQsjTh60+7t1KYzbgjtyeFlehTx08VVewy8jQSZaqXw8vqOVuJ/GZOWpK
         VF7DhGSvbFUTofcNAx4E8yj4qe0QFJByHQ7FqDpjJ0pAwJdUvOI/UIAq0ss1UFUxTaHH
         FsfbK0FzjmFz76IgovlU2n/DC3J0Ns1oKesO7IGRRGv5EGrOBRcXCcqbBqdkYdkdf3cF
         1R/Q==
X-Gm-Message-State: AOAM531qkmmDLyqBQC9BTD0ZxH3iovTtA/3PquPOa1J0JhWddQAvii7L
        hvHb8+yaQoN/F35w6bJrWlJEPFesCjxOjQ==
X-Google-Smtp-Source: ABdhPJzlp6Ym4xoYXcSwsqc0IT2F4/7CgF/u65IvdgoCvICmOtLnFFL6Pl6xpWySy50y6jO0II7Qaw==
X-Received: by 2002:a05:6512:2356:: with SMTP id p22mr21286200lfu.347.1617732781602;
        Tue, 06 Apr 2021 11:13:01 -0700 (PDT)
Received: from localhost.localdomain (dygkyxjlgy9q-6c1cgkky-4.rev.dnainternet.fi. [2001:14bb:150:99d:2507:5bfd:aa2:2a10])
        by smtp.gmail.com with ESMTPSA id c2sm2235340lfc.221.2021.04.06.11.13.00
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 11:13:01 -0700 (PDT)
From:   =?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>
To:     git@vger.kernel.org
Subject: [PATCH] completion: treat unset GIT_COMPLETION_SHOW_ALL gracefully
Date:   Tue,  6 Apr 2021 21:12:47 +0300
Message-Id: <20210406181247.250046-1-ville.skytta@iki.fi>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If not set, referencing it in nounset (set -u) mode unguarded produces
an error.

Signed-off-by: Ville Skyttä <ville.skytta@iki.fi>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e1a66954fe..6d77f56f92 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -427,7 +427,7 @@ __gitcomp_builtin ()
 
 	if [ -z "$options" ]; then
 		local completion_helper
-		if [ "$GIT_COMPLETION_SHOW_ALL" = "1" ]; then
+		if [ "${GIT_COMPLETION_SHOW_ALL-}" = "1" ]; then
 			completion_helper="--git-completion-helper-all"
 		else
 			completion_helper="--git-completion-helper"
-- 
2.25.1

