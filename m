Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A88571F461
	for <e@80x24.org>; Thu, 11 Jul 2019 08:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfGKIUG (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 04:20:06 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:47072 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfGKIUG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 04:20:06 -0400
Received: by mail-ot1-f67.google.com with SMTP id z23so4955198ote.13
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 01:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dereferenced-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=IV1auwxcdZtAwcxkvhE496emdG7y9WCOfhu9LZcvbE0=;
        b=UtAme6aKBbNasbFsjoBufXCAsrDNi7sZ3GhdkuHWUDRVFyFw0Rpy/i/GA4+ff05BYO
         /5sIaZndmfXZWAVV4SaLOdhcVChSFgVam/FkGqJgNhVhnOV9qC9y2qqzBsTOkxYO2iW1
         FTRVN7LYd2qBIyROUc0nYtd3o2hA2AAUSW9/1GDYd78Nn7E3ARXnGuPFx1VR//S4cE4o
         dWOv0duBQO3QUMjZo2MdgDBrBglmSlMeY/n7E0lvLBcrDG3pPXATHITtO1rvP4kw7c6e
         4yE9uHoC+YjfhHteYOjXEbpRLwiMVa8YPcfjttincuazeWWZB++bKpe05aNssPN3xVF8
         pmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IV1auwxcdZtAwcxkvhE496emdG7y9WCOfhu9LZcvbE0=;
        b=Pt5MEcQQlKHANrAOKOrNQcg/RN1NnrfgkngDS7Md/EmgyUb6Ik+Elh9KzRJtvUDfeP
         F/+hQXtpOMJqXpAVmPIkCS85qzxvbE2fGtwmKoujbTm9atZXmv+S7Lkl2GlgsmI8sSCB
         cb3vGLPVUG9vQPlKnpkVSE+uXeMGexMbPWICyT+boMGzMbLvuGfKcgazs879sjn+SVqh
         SeRwYPldhxWMI+ezPbQDB68Hjfw2rGnOO3NZXSfWFk3KguVsBNLaMp6plRzYSIyrbPyR
         B7v3/vBS6oeH2se2H5dbxrDp3bbJkZCUgSHOVTZUsNqV7bYfFvgzOglOBhtFtm3Qf4if
         IG1A==
X-Gm-Message-State: APjAAAWVG/rEudZ/vnSCthR7mEEuhoLWO8Yd3D5MGpw5wJlgZI2WY5hF
        v3ZOVVYdDTAzPkd1LYLTryPotqfB
X-Google-Smtp-Source: APXvYqxmCE/ivRTpoJkAcYMYRN1hJ9HugDl4MnbQI65UnyMqqCFG6hi1bsHKNEmNYHFqfXcfTeEK1A==
X-Received: by 2002:a9d:4d81:: with SMTP id u1mr2233450otk.221.1562833204985;
        Thu, 11 Jul 2019 01:20:04 -0700 (PDT)
Received: from nanabozho.attlocal.net ([2600:1700:8660:6160:4095:967b:6f89:2333])
        by smtp.gmail.com with ESMTPSA id r130sm1877884oib.41.2019.07.11.01.20.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 01:20:04 -0700 (PDT)
From:   Ariadne Conill <ariadne@dereferenced.org>
To:     git@vger.kernel.org
Cc:     Ariadne Conill <ariadne@dereferenced.org>
Subject: [PATCH] log: use mailmap by default
Date:   Thu, 11 Jul 2019 03:19:58 -0500
Message-Id: <20190711081958.2201-1-ariadne@dereferenced.org>
X-Mailer: git-send-email 2.17.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `git log` command shows the author and committer name recorded in
the git repository itself, while other commands respect `.mailmap`
by default.  I believe this is a bad design: it causes log entries to
reflect inaccurate information: anyone who changes their name or
e-mail address will not have that change (recorded in mailmap file)
reflected when using `git log` by default.

Anyone who explicitly wants the current behaviour can clearly request
it by setting the `log.mailmap` setting to `false` in their
`.gitconfig` file.

Signed-off-by: Ariadne Conill <ariadne@dereferenced.org>
---
 builtin/log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 7c8767d3bc..3d2ce8fa3d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -47,7 +47,7 @@ static int default_follow;
 static int default_show_signature;
 static int decoration_style;
 static int decoration_given;
-static int use_mailmap_config;
+static int use_mailmap_config = 1;
 static const char *fmt_patch_subject_prefix = "PATCH";
 static const char *fmt_pretty;
 
-- 
2.17.1

