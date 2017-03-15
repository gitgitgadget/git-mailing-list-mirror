Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CE89202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 13:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753462AbdCONPX (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 09:15:23 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56058 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752561AbdCONPP (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Mar 2017 09:15:15 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 8989520A41;
        Wed, 15 Mar 2017 09:15:14 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 15 Mar 2017 09:15:14 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
        date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=GoW
        /8j6c4Bhokv39UHf71civOhk=; b=E0XfC5oyoItE0Hy9Da02ZFjjK20J7h2MITQ
        6lsvIQRGAjf/4y4ljQDWbXCfxJnn5rC4feRAmSgLSAvPcQHWAtPk2GMlD+qrbXG4
        cBisdezrldjCU0J5FRk1kihvBK7waldgRqQ2OHApsey6RcmJr9eNeluQXKWgRUuv
        nUk4vNxw=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc
        :x-sasl-enc; s=smtpout; bh=GoW/8j6c4Bhokv39UHf71civOhk=; b=kXotd
        E6qZjx/3EpHSQMYJ1Oyti75HAv2+MSUzVEWHlgZ/XZOMMp1IlA5ine7Qj44JqGvu
        8WKc5yre8vVwrpQ+vco5svTv5UKx3k6FFVY64fnOlcfaRJyOIRiYrpsMvR1b5YXu
        U/wcK4sYAAzoJLY0v0Pa+PwRTURBPcXTj4PloM=
X-ME-Sender: <xms:Yj7JWOPofu0cN5jJWiX2t-aegWZCEWUSZ1aqPt_GWmT6eH8xpzwIsA>
X-Sasl-enc: i0RU9yAaws/Ntt39NHgJmVXg6mha2GyFCfhh/9GK1Hhq 1489583714
Received: from localhost (skimbleshanks.math.uni-hannover.de [130.75.46.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id 31DE67E2E3;
        Wed, 15 Mar 2017 09:15:14 -0400 (EDT)
From:   Michael J Gruber <git@drmicha.warpmail.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/3] git-prompt: add a describe style for any tags
Date:   Wed, 15 Mar 2017 14:15:09 +0100
Message-Id: <8d8fcdb4134090328662bf6fa5dfdba6c73fb6a5.1489581340.git.git@drmicha.warpmail.net>
X-Mailer: git-send-email 2.12.0.384.g157040b11f.dirty
In-Reply-To: <cover.1489581340.git.git@drmicha.warpmail.net>
References: <cover.1489581340.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-prompt has various describe styles, among them "describe" (by
annotated tags) and "default" (by exact match with any tag).

Add a mode "tag" that describes by any tag, annotated or not.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 contrib/completion/git-prompt.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 97eacd7832..c6cbef38c2 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -82,6 +82,7 @@
 #     contains      relative to newer annotated tag (v1.6.3.2~35)
 #     branch        relative to newer tag or branch (master~4)
 #     describe      relative to older annotated tag (v1.6.3.1-13-gdd42c2f)
+#     tag           relative to any older tag (v1.6.3.1-13-gdd42c2f)
 #     default       exactly matching tag
 #
 # If you would like a colored hint about the current dirty state, set
@@ -443,6 +444,8 @@ __git_ps1 ()
 					git describe --contains HEAD ;;
 				(branch)
 					git describe --contains --all HEAD ;;
+				(tag)
+					git describe --tags HEAD ;;
 				(describe)
 					git describe HEAD ;;
 				(* | default)
-- 
2.12.0.384.g157040b11f.dirty

