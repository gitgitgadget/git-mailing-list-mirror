Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF9AC433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 20:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237955AbiCWUed (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344752AbiCWUeW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 16:34:22 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A401F8CCFC
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:42 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r7so2671941wrc.0
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7UgGi0F5TBDLAaxDmScj2H6wUswTT/Wloob8GZ0wb0Q=;
        b=MaqhD9ASiM8npp8pYf3+tl0zNIi1QUH/nUJa5i+i5ceXCD1QpPDNl6yaFDW9LAboS4
         PEPCCGVjkva/3Ahhnyyqj95PkheMGw7h9K70Z50OLE9UqTsYlbLLBswz87sn1mkhMVZm
         2Wqr92pF0PRE+fgWQlOTjCXYFq3Z8RUIzm9iHGVCuzYPUO5D1u84H5FCpMEs0snBESAt
         iFnqu54igXcuOWOzSV/s0RJ+S+nTalQcXRyIUJgyzzdz7zJlxH8X1q6sjNnK60mbe8y3
         lnvIQRZYFJl5BQ61LLJOIvthB8PqTdtW5aN5a2U1lASwm3A/W9tEZ3aVqfcWoc+TO917
         oUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7UgGi0F5TBDLAaxDmScj2H6wUswTT/Wloob8GZ0wb0Q=;
        b=ooOdZyHKGuUy/hPM4fLVzBOoToOIkWHNPU8SMvrF5emUAPFmoLk+PxG+1rh78BU0XG
         udVnVcxhqawrVVF2NxS2tDzXgFQChArRC/s+K6x3m9kTGisQSHJom/dn2OOow+dkKI/R
         3bpKA5CBy4niacofS0zY/Nz/u5CouRKy5MOrZquaZi73SpKaV2ydgjjM/YEyU3gxt/kv
         BnJD1nD+h2ENPpiKB815ea60W5Lo83kGSdDNnUFBcKP3cU0fDicj7JE6lpBpUEA8BXLk
         wOQFs1F2gZ/Loilh2rRWRdG1rpF21XKqklQz8SCXSgTX+4kYugmzNmL3pt7yn+eLrwiq
         bRaw==
X-Gm-Message-State: AOAM530lRMUd3Dw9z3MU+6wLEHRJ4uiKqHSqnfddd4SDF0WntHNbCI8T
        jZH5OySDFPrzBfMofl+ghus+ZYX94WHYeg==
X-Google-Smtp-Source: ABdhPJwvaHj1Vv1tdL+4f9Ft8WM9AzIp7a7g5adfz6BYtlnX+x1BGeprSW0kjX6YJvaJKYUvfR4EiA==
X-Received: by 2002:a05:6000:1689:b0:204:19f5:541f with SMTP id y9-20020a056000168900b0020419f5541fmr1548713wrd.704.1648067560755;
        Wed, 23 Mar 2022 13:32:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d6dac000000b00204119d37d0sm849843wrs.26.2022.03.23.13.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:32:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 16/27] revisions API: have release_revisions() release "commits"
Date:   Wed, 23 Mar 2022 21:32:06 +0100
Message-Id: <patch-v2-16.27-bc36810e56e-20220323T203149Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1452.ga7cfc89151f
In-Reply-To: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com> <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the the release_revisions() function so that it frees the
"commits" in the "struct ref_info".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 revision.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/revision.c b/revision.c
index 90bac9ada03..13b568aea76 100644
--- a/revision.c
+++ b/revision.c
@@ -2937,6 +2937,7 @@ void release_revisions(struct rev_info *revs)
 {
 	if (!revs)
 		return;
+	release_revisions_commit_list(revs);
 	object_array_clear(&revs->pending);
 }
 
-- 
2.35.1.1452.ga7cfc89151f

