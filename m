Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995B0C38A2D
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 22:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbiJYWm3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 18:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiJYWm1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 18:42:27 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32B7D7E0D
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 15:42:26 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso402192pjc.2
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 15:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOX2Iwvu6Cao8vptgLUpu/A3nopFIfEu/rUhDIireJA=;
        b=a06I0o88w9WnyDfE375DVgLDricNg3dg70HIFlcYCatYFl2mcGvi/OWaj3cbPq78Lq
         BrW+WAzlz03xjLt/69njNGnq7Zpj1u3GupZkT2neW/I4arf2qSSnTbtZaO/JI0wTCTFb
         smBDXYRE2+wQ4HtsKzXmeNK+BgRU7EREspbjbxQdfzhDsaOqQRADwvqyOsKfzYA+UwJQ
         v1pAPWXmz3Y4NYg9sXviGHEqaEEti7YIrpFf/SIfwUWFeljJWiErb8rRc9t9Sy3gjsP/
         j7eXBQWArGcsoh8n3e8jB+fvn7O/xrlpg61K1Mhb5Xo77VyeLSf+NOo1DbB7gNqF/ePp
         PssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vOX2Iwvu6Cao8vptgLUpu/A3nopFIfEu/rUhDIireJA=;
        b=fgwVyM+XiQl4jlpB1NOcRvSK83ZtrBdSC4VJwCrpcK604nL5JlFJKWQDomb3OBGzxt
         IwmRtsRm/G+40Offglo/fzHLDuFW3+gsOk6sup0qyyw/RfMR5cxF9V+L9I+JQQxI5vyQ
         thKS7w07j1RZ1FxveeO2LqlRYAiRQLYF30eCXl7F/neZ+sS0OG6rfyPP6lzQ7KnKweNR
         Cq7WohSJZtEco+a5SDpdHPoPLibeeo6ZEikPt9fzAO91Iie0ryLk330UBnvslxNPZjab
         rRsruk4HPv/ik4L8LJVCxp/uHYQnoh0zy/iWkGskMyuJVlGiN3UllezM8r6hx5wp6CRA
         sw6g==
X-Gm-Message-State: ACrzQf1n3SdjfOlSHg2Si2L8pZRiMYFuHEk/X2rmNtZeOenQe2x0pIma
        mkBH9PgE7+wwCdrt5se/djWcvYex8ec=
X-Google-Smtp-Source: AMsMyM4fc3iNHUMTSeFQGwiFaszdvL5Z0eS8W0Uvv5tVIlaLAJF1MNtzSRBBAgtf63pde7oHLnP/wg==
X-Received: by 2002:a17:902:f708:b0:178:9b70:310b with SMTP id h8-20020a170902f70800b001789b70310bmr40285332plo.65.1666737746230;
        Tue, 25 Oct 2022 15:42:26 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 62-20020a620441000000b00562ef28aac6sm1441036pfe.185.2022.10.25.15.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 15:42:25 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>
Subject: [PATCH v3 1/4] fsck: remove the unused BAD_TAG_OBJECT
Date:   Tue, 25 Oct 2022 15:42:21 -0700
Message-Id: <20221025224224.2352979-2-gitster@pobox.com>
X-Mailer: git-send-email 2.38.1-359-g84c4c6d5a5
In-Reply-To: <20221025224224.2352979-1-gitster@pobox.com>
References: <pull.1369.v2.git.git.1666667864.gitgitgadget@gmail.com>
 <20221025224224.2352979-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

2175a0c6 (fsck: stop checking tag->tagged, 2019-10-18) stopped
checking the tagged object referred to by a tag object, which is what the
error message BAD_TAG_OBJECT was for. Since then the BAD_TAG_OBJECT
message is no longer used anywhere.

Remove the BAD_TAG_OBJECT msg-id.

Signed-off-by: John Cai <johncai86@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 fsck.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fsck.h b/fsck.h
index 6f801e53b1..7d99f6ea33 100644
--- a/fsck.h
+++ b/fsck.h
@@ -24,7 +24,6 @@ enum fsck_msg_type {
 	FUNC(BAD_NAME, ERROR) \
 	FUNC(BAD_OBJECT_SHA1, ERROR) \
 	FUNC(BAD_PARENT_SHA1, ERROR) \
-	FUNC(BAD_TAG_OBJECT, ERROR) \
 	FUNC(BAD_TIMEZONE, ERROR) \
 	FUNC(BAD_TREE, ERROR) \
 	FUNC(BAD_TREE_SHA1, ERROR) \
-- 
2.38.1-359-g84c4c6d5a5

