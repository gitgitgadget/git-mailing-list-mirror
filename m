Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B056AC43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 11:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CF0F21D42
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 11:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxNtUR1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgIRLTf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 07:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgIRLTe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 07:19:34 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42234C06174A
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 04:19:34 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 34so3273695pgo.13
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 04:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RqByowbAp/WKK91LsRuCZSWcIkQDc5H71fNPjOa11t4=;
        b=TxNtUR1gqcHxBkL3zeKPw0srQqVlvNRGdAdNfoDzmAEtTkDOvk6aCXDovj1oGP0IZY
         NfJLdIV6o0BtbJOn2Mp1QfkqmeFJwFSvSm8eIS0xn1S/iupsfU+fsP5RcnajWtlijLK9
         nx8OMQkwpwZ0rMEQh/poNDiDOR+gvGT47Gw5y0RDbNFvxB4OqIdVVS44N7haUqJ2LmCy
         fnmlEj1JDDfHR2shE+moBbn75U0PR042WrbU51m/skXcisG3A5q5zJruuAqbjbxLR2y3
         /avq4CNh0YExINFr0u91gqTm4/Rif6wP2rYTbcqkP9KCTxUzxqtvECJ6JmJjEMJIisA7
         McJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RqByowbAp/WKK91LsRuCZSWcIkQDc5H71fNPjOa11t4=;
        b=rlZInWO1fUx5heaLwCjIcS5CLtfF8u6ptFFzxs9dZIFbs6kRgVKwiwlr2JbCImXSVP
         7lHK4DzjEpX910adjYMiF7CBaohLtRnFIZyxkeAi9u4BWrYmVNHJRoM3Ex5yJYvJyCuF
         LdgXJXAnqthGXu9QffkfzW8Yn/aiOBcHNDmV+1WK1SlZiQs3URL7Rei4tnh/shWg4Asc
         R6/B2l+hglRwUtYgugUGVxQ3CZfma2nwLHUsazuezSMTp251Y0XOD7tIwBB3hMGY9qYx
         kqLePGpGQoPPvbB/3J2xm94iByKOt8JtQ9Y4620dN0DLdwfmgN2y5rMhhd2zxiTsErst
         cRIg==
X-Gm-Message-State: AOAM530xHY0I70oUiEXvOSNblrc0OhhSjRzvtwG12xNda+8niMBPdTXJ
        XNuK0HEoF8vlieHp5JPEsh+aN7PsnJc=
X-Google-Smtp-Source: ABdhPJwZPXnC0YY78ekkq2b47Z85lyU4NPWmAa933JiJvQnv2HwHJ2Wd1CTATRbM5nOMDE0OaqissA==
X-Received: by 2002:a63:5a5d:: with SMTP id k29mr26245205pgm.51.1600427973608;
        Fri, 18 Sep 2020 04:19:33 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id x4sm3034120pff.57.2020.09.18.04.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 04:19:33 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 1/4] hooks--pre-push.sample: prefer $() for command substitution
Date:   Fri, 18 Sep 2020 04:19:02 -0700
Message-Id: <ed1ade73281bb78ab3a1d4fd1291a951ca52f0b4.1600427894.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7
In-Reply-To: <cover.1600427894.git.liu.denton@gmail.com>
References: <cover.1600427894.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The preferred form for a command substitution is $() over ``. Use this
form for the command substitution in the sample hook.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 templates/hooks--pre-push.sample | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/templates/hooks--pre-push.sample b/templates/hooks--pre-push.sample
index 6187dbf439..64b5707553 100755
--- a/templates/hooks--pre-push.sample
+++ b/templates/hooks--pre-push.sample
@@ -41,7 +41,7 @@ do
 		fi
 
 		# Check for WIP commit
-		commit=`git rev-list -n 1 --grep '^WIP' "$range"`
+		commit="$(git rev-list -n 1 --grep '^WIP' "$range")"
 		if [ -n "$commit" ]
 		then
 			echo >&2 "Found WIP commit in $local_ref, not pushing"
-- 
2.28.0.618.gf4bc123cb7

