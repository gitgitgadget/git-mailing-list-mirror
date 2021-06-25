Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2C5C48BC2
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 19:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D61D61952
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 19:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhFYTlU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 15:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhFYTlU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 15:41:20 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6C4C061574
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 12:38:58 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id r3so2422009wmq.1
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 12:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=sZMAMY9NPSw0SP4dVqJDxVCiTBB512OE+MbS6KYJzs4=;
        b=GeHTp23ECCu4+VWdU2pjUilZ7erlta0o+Yt4rCFM2ArlqcpYhDGdcKyMed/iogAm9S
         XwNHUacF882W9mUxif6YvX67F/uGgHuHUxNWlUndBeHtxtLfwEJ/7QF0vxH0ajvDTvHo
         KRHlI2QCOM37TgnyvnRqwViDcBKvvpl157e4u78uTK3P8iKcnRIxWlWPMtmg0r5ibK4X
         R0zkniA8IpyfXgCVLsxYqM8SUklP5zzGImaJwhFCw6pUffVI9Y5nBu5QstzH7xyItCyU
         d7Fensxk/1W78Ftf3vbxfcgjF3HJ58EhVoun8aWub61T60CmrX8UaugMwjiKkWM2M3kS
         lpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sZMAMY9NPSw0SP4dVqJDxVCiTBB512OE+MbS6KYJzs4=;
        b=Ch4Q0K+fIxgESIyg1dZBAcZlM684LeKDWDZHCJJxU2U5NcItoRiu+UqgWH/LygMJ2X
         KaSyUgF8lI2clJ1AsMfBQFsEwK3lidRctkGpp2dGxXeVSKHygIxJ7rTAmFZKqZrQTyVo
         O+j9GlzH+roCSnokejRxaDcAExVpCq5V0pxJpGWEbaK5ntyj3t5MRu2S9nsWJx5M4na2
         dXVXmXYZgwRWkAizBFe4PKBMIDsgFjFVTrE+WTbbiqqF2blxFrgZvbxFioXacXhh75qO
         6ihRAvFlcxC5TvBB0rxM/hs71BiXoOLvsIvxlIGqtBYqttyDP/nVBteTELrbunhKzaUX
         OILw==
X-Gm-Message-State: AOAM531APmICfY1kvA7CvHulrUhdlMZxyUkvfRBvEHg8MPZLMK1k9VF1
        92OBsAmsgRQxLX5OT23Z4HBo2Jbh+GSQQsu1tUMxxQ==
X-Google-Smtp-Source: ABdhPJwEm+7OGOiP+u+hn0zNsV3yex/A18oFctene/E+Hzq1O+JenQmnSct3aOZM5j2w1X+YxumKwQ==
X-Received: by 2002:a7b:c5d2:: with SMTP id n18mr12529809wmk.97.1624649936527;
        Fri, 25 Jun 2021 12:38:56 -0700 (PDT)
Received: from localhost.localdomain ([46.246.3.237])
        by smtp.gmail.com with ESMTPSA id c18sm6679233wrt.83.2021.06.25.12.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 12:38:56 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Barret Rhoden <brho@google.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH v3 1/3] blame: correct name of config option in docs
Date:   Fri, 25 Jun 2021 21:38:49 +0200
Message-Id: <20210625193851.2233114-2-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210625193851.2233114-1-rybak.a.v@gmail.com>
References: <20210619112912.76136-1-rybak.a.v@gmail.com>
 <20210625193851.2233114-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As can be seen in files "Documentation/blame-options.txt" and
"builtin/blame.c", the name of this configuration option is
"blame.markUnblamableLines".

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/config/blame.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/blame.txt b/Documentation/config/blame.txt
index 9468e8599c..4d047c1790 100644
--- a/Documentation/config/blame.txt
+++ b/Documentation/config/blame.txt
@@ -27,7 +27,7 @@ blame.ignoreRevsFile::
 	file names will reset the list of ignored revisions.  This option will
 	be handled before the command line option `--ignore-revs-file`.
 
-blame.markUnblamables::
+blame.markUnblamableLines::
 	Mark lines that were changed by an ignored revision that we could not
 	attribute to another commit with a '*' in the output of
 	linkgit:git-blame[1].
-- 
2.32.0

