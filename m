Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625E9C433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 23:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46FE76108B
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 23:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349805AbhIIX0P (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 19:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349787AbhIIX0K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 19:26:10 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E5FC0613E4
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 16:24:55 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id z1so21419ioh.7
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 16:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/TcU8niDUXEaxWVVkAyw16gXK1x9H/0z7dfA7bm7DdY=;
        b=p1sDMR+RnEhSf78PkucFgw8n5KpzT0TH1iT7Y2OkCvBamkOpes9m+lmAm727bPVAyA
         70iRyQI0o44CdINvmsJ/4SXI82tqY8lXzJ6FcKtoOifdruUM8y1kYoSiptVl9gKbEOXW
         xcjOW5zneQnkUFKlQxzb1teQUILViGBoYW3fWa2Hpy4NlUnJngFedRWx5/GrtDBALxmT
         j96tylC6GETB3GCYg9BgfB/mg0+N51wf0T7U72d3LZIL5Rs0OvzflihseWuV8ty1HNfF
         anD+MWQ0XLZ3pbG4+Fsd1bTMozN9kwA5pwCHzgETB1GU7U/M9F5AoQ4dB7/p9I269LJq
         ThFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/TcU8niDUXEaxWVVkAyw16gXK1x9H/0z7dfA7bm7DdY=;
        b=Gj6UgkrEaVpxEss7qfyc2hV7O+0n3SuSya3Pnjz8zJe97zSlTo0tRglXasKP6XiEW/
         F61w2kQP9Cv2G5KA9VdXAaWGaeFqYay1nt9b3Crswv1UIqcUXfL0QpD2V0+3ojNGt1bK
         kuZs4ECmjgO/sd3uqv++fRgJDi7b6RCivTtzRfgWAuOf+Vil12KRaufK4pHfKjCtmUwB
         oiJB1I4mVv+r1/aRSeuN1O/hFkJNafr5DJDApRabIk/3ffaA+JHIASKgAECXE6c69Zvc
         nYAO+6o4IlhH9yclsDTXubRcjGDY1HRgDM/ODJ66zy0nN69oujkiSduB0eFuBRSVQCKG
         P4pQ==
X-Gm-Message-State: AOAM530ziaTD9alQqMruwodCNkh0Fu/037r8DiLGftXB7yHVtad6EEWD
        4AGA1spqo5++GZNO3SDiMgWBh/Pa3dKmbPoC
X-Google-Smtp-Source: ABdhPJwmD/XJt05bBfhK+gI06LfZCo/aKhvpO2div8p1no1GQnHTpwbX8e69dPfjxfvmHjku19bfkg==
X-Received: by 2002:a6b:28b:: with SMTP id 133mr4695533ioc.107.1631229894372;
        Thu, 09 Sep 2021 16:24:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k5sm1561343iob.45.2021.09.09.16.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 16:24:54 -0700 (PDT)
Date:   Thu, 9 Sep 2021 19:24:53 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com
Subject: [PATCH v2 7/9] builtin/index-pack.c: move `.idx` files into place
 last
Message-ID: <906e75d7076e547fe2947dc701054e554f29dedb.1631228928.git.me@ttaylorr.com>
References: <cover.1631157880.git.me@ttaylorr.com>
 <cover.1631228928.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1631228928.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a similar spirit as preceding patches to `git repack` and `git
pack-objects`, fix the identical problem in `git index-pack`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/index-pack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 3e3736cd95..f267dce49e 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1523,11 +1523,11 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 
 	rename_tmp_packfile(&final_pack_name, curr_pack_name, &pack_name,
 			    hash, "pack", from_stdin);
-	rename_tmp_packfile(&final_index_name, curr_index_name, &index_name,
-			    hash, "idx", 1);
 	if (curr_rev_index_name)
 		rename_tmp_packfile(&final_rev_index_name, curr_rev_index_name,
 				    &rev_index_name, hash, "rev", 1);
+	rename_tmp_packfile(&final_index_name, curr_index_name, &index_name,
+			    hash, "idx", 1);
 
 	if (do_fsck_object) {
 		struct packed_git *p;
-- 
2.33.0.96.g73915697e6

