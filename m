Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC4AC433FE
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 18:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76E9E6103B
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 18:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236300AbhIFSLk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 14:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241664AbhIFSLi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 14:11:38 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B64C06175F
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 11:10:33 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id u21so6009509qtw.8
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 11:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iVDYUMSJe8ooSotiftP7CQwYQuoLNFyOI1qdp8dST1Q=;
        b=RBeKHAe3EjTCNUQoibwz8CodludlG5x8gdy0hrwHwsXXDrQ2+ODLKQGLm8FoyCh9tV
         3KhSwpcbxhsGTio1Qtio0OFW1uzby69plRqMLILTS6roxMWCHHx8kXlYrkFidEwMmvTF
         u+SUgtD6dTMY2NTZpiI0lIJl6Es1kjX6UccgxqiPTwKyB69Ov8y6s5mReQLVNEN5G1B3
         Mdiy8Ts9ga4+foqaASE/GtKxdrgwLBkH+bZ4SO8Ngndo6WmbOB6bnC5uclcxu+nvUqwT
         bfDxrP1GGf/KRWYJLzND+QvVvMVcyxfyT6Iq0Zp8CYplzOaM5L3bgFsnFUvepVTqqzGT
         8pig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iVDYUMSJe8ooSotiftP7CQwYQuoLNFyOI1qdp8dST1Q=;
        b=HvNeTiL21w3tGbJDrxGy7ziLi+BLbHztS9HgH4kDMcEVVtCveWMcRzg2xK6kzSyzt8
         58tJV8aUwfailBpF0VAK9SFinWhc6vNPpoBnRhijlaYvZT814L6CvB0C6EKe2iVd22+k
         vkTq9SLHVDKkAYyV5vnR+/8cCzO84udzYlFJBOVeHpgN7PriASofnNXUq5FW2rgswXCj
         lIMIvoWFpLKGP17q+Cp1SmdIg3LGANV6MKEfJC+8x+NqYQf+Giz3LpCP6RmcUTpNYY4f
         0zPuhgY8SjOj/U7wSpplAk5SbZZAXJb8YbMiGBBctXsfGpoKVAcYxZXpZ62dMV8aeQ6I
         dbOg==
X-Gm-Message-State: AOAM533QEbutbx09ji1PE8skbiwqTnCpGjAEAhclClPaqb3U1ft3JyjP
        335lbt1bBS9L5Pkk/cWOp7dlk2GNVhepHg==
X-Google-Smtp-Source: ABdhPJwAatcHrUvmDsOHjjRJdG/d/9bYsBBytfApJu3tOVWHVbG8H5ZcELpl/QJIKfA3m5wnL2va4Q==
X-Received: by 2002:a05:622a:28a:: with SMTP id z10mr12115663qtw.371.1630951832279;
        Mon, 06 Sep 2021 11:10:32 -0700 (PDT)
Received: from CalumsBeastlyLaptop ([139.147.201.88])
        by smtp.gmail.com with ESMTPSA id l13sm6870731qkp.97.2021.09.06.11.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:10:31 -0700 (PDT)
Received: from calum by CalumsBeastlyLaptop with local (Exim 4.94.2)
        (envelope-from <calum@calumsbeastlylaptop.computercalum.com>)
        id 1mNJ4h-002coK-Fm; Mon, 06 Sep 2021 14:10:31 -0400
From:   Calum McConnell <calumlikesapplepie@gmail.com>
To:     git@vger.kernel.org
Cc:     Calum McConnell <calumlikesapplepie@gmail.com>
Subject: [PATCH 3/3] Document the new gitattributes change
Date:   Mon,  6 Sep 2021 14:10:02 -0400
Message-Id: <20210906181002.625647-3-calumlikesapplepie@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210906181002.625647-1-calumlikesapplepie@gmail.com>
References: <20210906181002.625647-1-calumlikesapplepie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The warning I included might make this feature hard-to-use: but
people are clever, and there are ways around it, which also
grant other useful properties to smudge- and clean- filters.

For instance, if you add at the beginning of each file you filter,
you add GITTATTRIBUTES_FILTERED_VERSION_1, that grants the "no
double clean" property and allows for versioning of the script.

To do this perfectly, you'd want to let the user declare the
script file, and then have git figure out what version of it
to run.  But that would take an understanding of the conversion
code which I lack, and would also be a lot of a work for a
little-used addition to an underused feature.

Signed-off-by: Calum McConnell <calumlikesapplepie@gmail.com>
---
 Documentation/gitattributes.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 83fd4e19a4..33b0087d4f 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -486,6 +486,19 @@ not exist, or may have different contents. So, smudge and clean commands
 should not try to access the file on disk, but only act as filters on the
 content provided to them on standard input.
 
+Sequence "%w" on the filter command line is replaced with the absolute path
+to the root of the repository working tree.  This is useful if you have
+complex scripts specific to your project.  Note that these scripts should
+be mostly static for the life of the project, since the script version that 
+is run may significantly predate or follow the version of the file being
+processed
+
+------------------------
+[filter "unzip-file"]
+	clean = %w/scripts/filter-unzip-clean
+	smudge = %w/scripts/filter-unzip-smudge
+------------------------
+
 Long Running Filter Process
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-- 
2.30.2

