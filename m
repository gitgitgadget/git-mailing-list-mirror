Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF1A420357
	for <e@80x24.org>; Fri, 14 Jul 2017 22:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751180AbdGNW2x (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 18:28:53 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33698 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbdGNW2v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 18:28:51 -0400
Received: by mail-pg0-f53.google.com with SMTP id k14so51814474pgr.0
        for <git@vger.kernel.org>; Fri, 14 Jul 2017 15:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D7wZv/yY9ELwCwOfCc2fFhvERtIqxqRmmx2FTex2SZY=;
        b=bgCT6JpV+pkdJM7/1ypp1MzxURIhMue+jLa23ihMm8/CFHZejc3vYF8loBKSetmuiM
         P2RYZKKo3iDg4nnA+/ti+ZWBZHA4wShSbdWQ23gI7UEy/XSXwUREpzyMEfxMjOKzdHK4
         67eCd2J0s5M0Qj5XRJS1T/jBCZuBMZX5Y7zoOfVdF0Lg1q+c7v1qsfGmc9Gs8Dl73vE/
         QmDVJYkd4PGCXfs431oWxvB8WjH8ICuB90wCHUw7T4qcQLNDQhCEWo4ZuosBW1Fy2H50
         T0OsNhSr9h5PSX8Xg0AfN0nlsEfhFv6gfdGI38K72RTmK7BeJBrV7bDFtGakqMmLIxHn
         U5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D7wZv/yY9ELwCwOfCc2fFhvERtIqxqRmmx2FTex2SZY=;
        b=ir2ZKezQXnqaszHp5e63512WYe53wqV0/rU8Vdy9BMEbUONoba9fqB8PPLIhEoXNZy
         AX9JrMtebruyF8eTZcJbsahYOSnTnThZhZZbREFaofFBGbzfTbhnWVze5bxOA+S/Gnmc
         Z+L37x2SEdVAjLuFKfMpxealz2ef4MQ1CsGK+cbE1PYZ++DC7kE7VdlAr/YRgtmqRZmd
         PM+1ZoFeYZcSW8+vJUudr3vl8LksOFV8vvfztGWRFNbUelM3A16tZLlcarZcqQDtkMjH
         Irn31KzTT0NACiKgsaElLJi6rOsyEQfiDLf+2Y7LJQmo58AnNC8zk1vX3Agaj+L+lRIc
         fAwA==
X-Gm-Message-State: AIVw112Xk4oVaxHBQN5HjA6sghiCmvDi3IDefEnXdk+SlKLPBvZomHgq
        DQdtwUuOtfmgUKRTj1nH/A==
X-Received: by 10.98.148.25 with SMTP id m25mr7606389pfe.7.1500071329927;
        Fri, 14 Jul 2017 15:28:49 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 204sm19749989pfc.32.2017.07.14.15.28.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Jul 2017 15:28:48 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, gitster@pobox.com,
        jrnieder@gmail.com, jacob.keller@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 2/3] repository: have the_repository use the_index
Date:   Fri, 14 Jul 2017 15:28:25 -0700
Message-Id: <20170714222826.81148-3-bmwill@google.com>
X-Mailer: git-send-email 2.13.2.932.g7449e964c-goog
In-Reply-To: <20170714222826.81148-1-bmwill@google.com>
References: <20170711220408.173269-1-bmwill@google.com>
 <20170714222826.81148-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Have the index state which is stored in 'the_repository' be a pointer to
the in-core index 'the_index'.  This makes it easier to begin
transitioning more parts of the code base to operate on a 'struct
repository'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 repository.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/repository.c b/repository.c
index 8e60af1d5..c0e0e0e7e 100644
--- a/repository.c
+++ b/repository.c
@@ -4,7 +4,9 @@
 #include "submodule-config.h"
 
 /* The main repository */
-static struct repository the_repo;
+static struct repository the_repo = {
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, &the_index, 0, 0
+};
 struct repository *the_repository = &the_repo;
 
 static char *git_path_from_env(const char *envvar, const char *git_dir,
-- 
2.13.2.932.g7449e964c-goog

