Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB8AC6FD1D
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 11:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjC3LVw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 07:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjC3LVt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 07:21:49 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1338D6584
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 04:21:47 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id x17so24065926lfu.5
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 04:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680175305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18VUQChVySzZTfeMQYMbPluCon1ca8ZPe6tnnFlEHcQ=;
        b=DJUQQIjcwWkbtk7ZDHjZ1Iv5mQh1sNGq/0RpaQHroC5iJtKgtZAmlA2H6pvTdMOUrF
         tU12R1FKcgGNwzAeM6b9JHr01VVzM2N662q9twilugD5mFVaJ4b/0lLpBhMGehg2mV5T
         ziLA5Wx3aNdTyZ6KGlBFnhQWSuDo0icdCDZqcn/zUoQbcjJCREjJDkzF7HbofBiWV/57
         Tk01Iz9dGNPk5XbfDnLvRXOR9haCmEnLORk7+CdO6InP7J1wu0WexPWXvL65O2Ny3O0M
         j53ybtjq/IaeAEcFQbA/973mZGnEi5X7u53w8/jYN/v2XO3ClYeNwINOFNeHvNFfuKHJ
         S+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680175305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18VUQChVySzZTfeMQYMbPluCon1ca8ZPe6tnnFlEHcQ=;
        b=P3QqLFwJKpfjtpR3X6hS1cbybD7FkepNm+EYLWtCpKPEKOifGD5XtSTI6bKF6QpTHV
         Q1FNClu2g8Fobne576f56ZMJcstt6vUT6Dz6A1t24omEHo7QAo9uThbLHYalBYex1WWq
         T8iaLiEpO66gjzk8h82ND3xdliju1XNGYeD4KdhaaGyr93/jIH/AwzC+SFT9XvUaKS2T
         mezAv5HqfQJK0g7Age6KchfPWvnSYd86Zp7KPex4A0pd0/KRP9XFLORHNsbYGvpqbXBS
         D68Od2OKmLHxubm73Oy54R9wg/LmygpWY/yvQvpPeOcPUF+83Pov+RdwpeK1Vu2/wAR5
         2g2g==
X-Gm-Message-State: AAQBX9c7HV3LCQ95v2+YtBUo9OEdo1Np6tclidhxnaBJrdvFXv5xMvLU
        M4W7EUbl676Vtbmiq7UNcXtXN7RxmOoPgg==
X-Google-Smtp-Source: AKy350aBCTk2QBnFGj4FbiOBwPsNo6JSE8bmUWNEjFLo+SbGy6GtACulwRREilhBekgMjCkjQDtsNg==
X-Received: by 2002:ac2:5288:0:b0:4eb:2d47:602 with SMTP id q8-20020ac25288000000b004eb2d470602mr183721lfm.59.1680175305049;
        Thu, 30 Mar 2023 04:21:45 -0700 (PDT)
Received: from localhost.localdomain ([2001:4641:9d1:0:9575:60ad:3b58:51c5])
        by smtp.gmail.com with ESMTPSA id y26-20020ac2447a000000b004cc82b7080bsm5869024lfl.200.2023.03.30.04.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 04:21:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
Subject: [PATCH 1/2] ref-filter: remove unused ref_format member
Date:   Thu, 30 Mar 2023 13:21:32 +0200
Message-Id: <20230330112133.4437-2-oystwa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330112133.4437-1-oystwa@gmail.com>
References: <20230330112133.4437-1-oystwa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

use_rest was added in b9dee075eb (ref-filter: add %(rest) atom,
2021-07-26) but was never used. As far as I can tell it was used in a
later patch that was submitted to the mailing list but never applied.

Signed-off-by: Øystein Walle <oystwa@gmail.com>
---
Would be nice to have a link to the email thread here, but I don't know
how.

 ref-filter.h | 1 -
 ref-filter.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/ref-filter.h b/ref-filter.h
index aa0eea4ecf..0f4183233a 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -75,7 +75,6 @@ struct ref_format {
 	const char *format;
 	const char *rest;
 	int quote_style;
-	int use_rest;
 	int use_color;
 
 	/* Internal state to ref-filter */
diff --git a/ref-filter.c b/ref-filter.c
index ed802778da..20e0a72f24 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -596,7 +596,6 @@ static int rest_atom_parser(struct ref_format *format,
 {
 	if (arg)
 		return err_no_arg(err, "rest");
-	format->use_rest = 1;
 	return 0;
 }
 
-- 
2.34.1

