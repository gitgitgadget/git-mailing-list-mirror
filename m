Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29609C83007
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 12:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08E3E21BE5
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 12:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q3buQ6j6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgD2MW4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 08:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726558AbgD2MWz (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 08:22:55 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC997C03C1AD
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 05:22:53 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id w18so1009201qvs.3
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 05:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FRRM9hc+pUxWkBOHzMIJFEwjHQLJi4u580g73H4Udmw=;
        b=q3buQ6j6Vpnb8SEnWMitjXomAEQWvRd9gf3o0vJRb0QiMgI9/YlU7WgP093avHIN0G
         59wnz7Yv33qI3TphdbRwhYDdo1IbCQ2Ley5NCHdOpoWiE44cJ7XdLAX07DEGx2N1dY5a
         ORMxtX85BjpcSlYPePpPEoUxJDoYTrMvFbJ1xNVqC61d1dO98mCnN4Bc1eMtbebcaTIg
         +GeY0WwCTXnQzZVPyt4XV9ud40NHm8/omXIcuRp588iwTVlrbAdA8+V7mNNAkkn2tOI+
         6mU3ADd6Vt0LiuUQPuDwpovVTiZHKSoYVuwq43SJsAy29BR6PNWxrxbT10cnSTzFYQCl
         T1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FRRM9hc+pUxWkBOHzMIJFEwjHQLJi4u580g73H4Udmw=;
        b=XgFWeVrvM3spe1D2gFXC9Tk1j+YT25sYaoT0RSIEM2S8TRn+uwXzROdOcUC0gcCSzP
         CCo7cLaUIoUPAg9/wadsIFcs7R8rFbmJ0EWFEkIUY+FVdKfV4tkFT01BMio1XbVgx/t9
         A7Qe1+4/fo4wEJrRRphxoDsPmpFsjGSv0+DSAXosC914eT4CPkH0wXEg+uTs+aKXMkgb
         yjuIG8uqYvUfTiMZIPgDkmnARpK57FPBdWPGCxXWx6FctoUWZovsj0iIGVIfUwW9CHGG
         gc4Uuup6XiYNQicPjjU/n0S1RYbCGefi4Wo0vTI0Hn4kG+t+2nOCHIjjLZybOiqlubN7
         QvFQ==
X-Gm-Message-State: AGi0PuY+YUDm357KpvZvD3sfQRyQP/YLsXdyWd4lUqVBL54lk9RF1NzV
        BD3dn25g//dNl03NMLIqo2X33oZS
X-Google-Smtp-Source: APiQypLMPyd3dz7nRIejtmTQDR0wfY88Fsjf/RZAnjErohgMZNDGgbjufwgt0DsiJqFHLof7nxi9vw==
X-Received: by 2002:a0c:8045:: with SMTP id 63mr33284828qva.68.1588162972785;
        Wed, 29 Apr 2020 05:22:52 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id t27sm15389383qkg.4.2020.04.29.05.22.50
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 05:22:52 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 2/4] lib-submodule-update: consolidate --recurse-submodules
Date:   Wed, 29 Apr 2020 08:22:24 -0400
Message-Id: <d5809877af3e20eb9ff459a91d3099846fd32197.1588162842.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.2.548.gbb00c8a0a9
In-Reply-To: <cover.1588162842.git.liu.denton@gmail.com>
References: <cover.1588162842.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Both test_submodule_switch_recursing_with_args() and
test_submodule_forced_switch_recursing_with_args() call the internal
function test_submodule_recursing_with_args_common() with the final
argument of `--recurse-submodules`. Consolidate this duplication by
appending the argument in test_submodule_recursing_with_args_common().

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/lib-submodule-update.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index a3732d3f6c..81457b4c31 100644
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -632,7 +632,7 @@ test_submodule_forced_switch () {
 # Internal function; use test_submodule_switch_recursing_with_args() or
 # test_submodule_forced_switch_recursing_with_args() instead.
 test_submodule_recursing_with_args_common () {
-	command="$1"
+	command="$1 --recurse-submodules"
 
 	######################### Appearing submodule #########################
 	# Switching to a commit letting a submodule appear checks it out ...
@@ -840,7 +840,7 @@ test_submodule_recursing_with_args_common () {
 # test_submodule_switch_recursing_with_args "$GIT_COMMAND"
 test_submodule_switch_recursing_with_args () {
 	cmd_args="$1"
-	command="git $cmd_args --recurse-submodules"
+	command="git $cmd_args"
 	test_submodule_recursing_with_args_common "$command"
 
 	RESULTDS=success
@@ -957,7 +957,7 @@ test_submodule_switch_recursing_with_args () {
 # away local changes in the superproject is allowed.
 test_submodule_forced_switch_recursing_with_args () {
 	cmd_args="$1"
-	command="git $cmd_args --recurse-submodules"
+	command="git $cmd_args"
 	test_submodule_recursing_with_args_common "$command"
 
 	RESULT=success
-- 
2.26.2.548.gbb00c8a0a9

