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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74947C433E6
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 12:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D1B464FC3
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 12:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbhCKM4n (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 07:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbhCKM4S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 07:56:18 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B878C061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 04:56:18 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso9308356pjb.3
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 04:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dNaP624IGfc3du47FxmhKPPKGD1GMjh3akmFU5Coi7E=;
        b=ZW0tD/RU5sqd489KaPcd+atSG3F/H1MjV2231mKCyRunKr/g4Sihx/Pq/FQBwq/0Q0
         viexCOh8QZIyeB1xK3yccloJmoHV/Y6hGpNNV+isc4PPSXQn7vhUA3GPQQpmm00UdUiM
         4mlfe92NgZCguOTUQqd2r0u1MkL5yn0qPNSUQHppGDdOWBQD+T82mFnRAk+d1ox7T0h0
         QCscGbdClxy+KOt2EcA37Ib9ZcVHVGDiUxe9wT3d646PDwmLzFRCLh/7bTr21G+L9A56
         SKzbsJv+Y8jS2za2mrMA9XN1wihZrm+HhBx8djTWEa2lxi0YwqBfNTPOYg9Tk5HjgZs1
         Z15w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dNaP624IGfc3du47FxmhKPPKGD1GMjh3akmFU5Coi7E=;
        b=qjlCMASEpVFGB2rfftolfcSFRhxcdW/kpe77CoXxRJpr9AFz8IwaAAU4B5NCoAqp9e
         TFGCL8sKbMdrgtQ3299KDpIfqktgLyMppMA+FnQ4cLUVvLCu497E2TIxP8DsMknP6m0R
         Y3RRI8gcrp/AW1mXZlfG8KQaomPZUBVunc5Ggdo/3bpRmf6Xuz3MYz93uad+NcuH2q5X
         NU82JtxnY5820iHGdNt43cD0psbUJVxUuK6EV5MjCLktzEZo273mf6kQP0o/nWCJGesH
         9bL/zbrg7D6R6JoEc2Y2yMZ9Zf5mzm0qNx8dbh5dWS0FG/qSIJ6QK7S1fld0mIoTm6//
         DscQ==
X-Gm-Message-State: AOAM530P+PL9N4Xz/YBA0Ae0FZ0iWFjwuaDlZlqIfqh1JEwgSEC73diu
        afaNB33o952AP6LNLbAa7gnouHelpvfpWQ==
X-Google-Smtp-Source: ABdhPJy92YlsvUKjOt4Kt9kSeTWMe5s2YXAH2BJaE19y080qXWSXqdYa71A9E7ta8whrHO32qJNUTg==
X-Received: by 2002:a17:90a:c797:: with SMTP id gn23mr8985474pjb.180.1615467377824;
        Thu, 11 Mar 2021 04:56:17 -0800 (PST)
Received: from ubuntu.mate (subs03-180-214-233-84.three.co.id. [180.214.233.84])
        by smtp.gmail.com with ESMTPSA id o1sm2389418pjp.4.2021.03.11.04.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 04:56:17 -0800 (PST)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     worldhello.net@gmail.com, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 1/3] po/README: document PO helper
Date:   Thu, 11 Mar 2021 19:55:09 +0700
Message-Id: <20210311125511.51152-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210311125511.51152-1-bagasdotme@gmail.com>
References: <20210311125511.51152-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document about PO helper script (po-helper.sh). It covers about
installing the script and short usage examples.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 po/README | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/po/README b/po/README
index efd5baaf1d..9beffc2954 100644
--- a/po/README
+++ b/po/README
@@ -286,3 +286,25 @@ Testing marked strings
 
 Git's tests are run under LANG=C LC_ALL=C. So the tests do not need be
 changed to account for translations as they're added.
+
+
+PO Helper
+---------
+
+To make maintaining XX.po file easier, the l10n coordinator created
+po-helper.sh script. It is wrapper to gettext suite, specifically
+written for the purpose of Git l10n workflow.
+
+To install the script, checkout "po-helper" branch, then copy
+utils/po-helper.sh to somewhere on $PATH, and mark it executable.
+
+Below are the usage examples:
+
+  - To start new language translation:
+        po-helper.sh init XX.po
+  - To update PO file:
+        po-helper.sh update XX.po
+  - To syntax check:
+        po-helper.sh check XX.po
+
+Run po-helper.sh without arguments for usage help.
-- 
2.25.1

