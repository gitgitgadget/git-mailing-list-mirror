Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400C1C433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbiCUXLJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbiCUXJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:09:26 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DED2B1B5
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:53 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id t11so22679266wrm.5
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/GhEQD87gYxu1vWW6ojun3MPQgZxaF8ByZgXin9ujVw=;
        b=acURERipm91Vi/LVN0lkcEdXTcCPtniCbwthV3fm8RF+zuiS+mCCkvnZNqCJ2VF7lL
         boSt1mF//7932dPMlaxDnbZ46kDtxsyUbK/dK+LJHlr7TC3dZHFnIsvBmE5AI/6zi66r
         PLCuKcq7L2GL2eQyn/3/viZ8ErzwePIGtMuIRaxkb/tpgkvF17l6Nf2WwJMpBjbdrxCd
         38vnHhm+i5CCsi9nu7vivisXRVMFQcSFRbF2wTnNlauuA8nKsnw7sExAuP0gYD1/mcWz
         zZeMdrv84CrgorVHW1yz8OI5sx3Ciu4vwdRRsT/3UOrEmqO63eTaopgKAvu5VWV+8vIj
         MvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/GhEQD87gYxu1vWW6ojun3MPQgZxaF8ByZgXin9ujVw=;
        b=l6S4fJUPKvLmo9i3CoMbz7ur2vMzaHgT5p+37tHz6RWmSpbIs1MocTBHpLLT37Co+7
         Ug3ghlZUgtsKyes7HSOIbV4wry58jmjARg2WpCV5G6xyNOXqqnwq1klc9xyn7rJq+6SS
         +Y22wFlySKWdoXXsp72A/5dCL0Zp7zrtCu7LdAN7zfEjYy4BTvs3nqCKUP0l4Ko6r+uo
         kiwQPTlWp290TJ0pyC7b5tJ+ULwHdBXZ8dhBqiyH9fUbm3BB2sPXqbUTtZJszEHShv3S
         aaxaWwCvxQ3GI/rJDY1Xkn9HkZCqJKYuDK48pDRPESDfmlMI5xzVURxrH4PsaeCgaRHX
         smzw==
X-Gm-Message-State: AOAM530rozNxuxl+YR/D3iwQug4b8v96W6iLw5Snt3dL9AKLiWLeS12m
        2j5v9XBZytc0t2rNbDrouK+7RV+tdcY=
X-Google-Smtp-Source: ABdhPJw06VR7P9PFUCNo9bW3EOTm5/UoazpB/8yMsp8g0tWw+KDicVVjujsKMeRWKYMChLnewQZM9Q==
X-Received: by 2002:adf:f70a:0:b0:1ee:33bf:3864 with SMTP id r10-20020adff70a000000b001ee33bf3864mr19383116wrp.4.1647903351839;
        Mon, 21 Mar 2022 15:55:51 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:55:51 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 12/41] pull.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:54:54 +0000
Message-Id: <20220321225523.724509-13-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220321225523.724509-1-gitter.spiros@gmail.com>
References: <20220321225523.724509-1-gitter.spiros@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The C standard specifies two constants, EXIT_SUCCESS and  EXIT_FAILURE, that may
be  passed  to exit() to indicate successful or unsuccessful termination,
respectively. The value of status in exit(status) may be EXIT_SUCCESS,
EXIT_FAILURE, or any other value, though only the least significant 8 bits (that
is, status & 0377) shall be available to a waiting parent proces. So exit(-1)
return 255.

Use the C standard EXIT_SUCCESS and EXIT_FAILURE to indicate the program exit
status instead of "0" or "1", respectively. In <stdlib.h> EXIT_FAILURE has the
value "1": use EXIT_FAILURE even if the program uses exit(-1), ie 255, for
consistency.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 builtin/pull.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 4d667abc19..3b16e891ea 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -489,7 +489,7 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 		fprintf_ln(stderr, _("Your configuration specifies to merge with the ref '%s'\n"
 			"from the remote, but no such ref was fetched."),
 			*curr_branch->merge_name);
-	exit(1);
+	exit(EXIT_FAILURE);
 }
 
 /**
-- 
2.35.1

