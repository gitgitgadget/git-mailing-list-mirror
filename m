Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 695AC202DD
	for <e@80x24.org>; Fri, 20 Oct 2017 01:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751414AbdJTBL4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 21:11:56 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43940 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbdJTBLz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 21:11:55 -0400
Received: by mail-pf0-f195.google.com with SMTP id a8so8576965pfc.0
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 18:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=WkHYt5rC8Wgfz4VlUqw/4yAClFGOnIOnlWw3sqKNPQc=;
        b=xwf30upoVUSv+Jc4O5oCumQKziGqalkubuBqxDFLV784aMuQ16qrLdfnX7lsV/CO0g
         7O00yKX+dK6Io4HeFt+NTtKn632VjX3N2IhMjWVnMWr/3Pp8tRJug9ay8kWLBapahJmT
         T29Tan+uAKcU+0NzMia7za6W0fxXGAAWf+MXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=WkHYt5rC8Wgfz4VlUqw/4yAClFGOnIOnlWw3sqKNPQc=;
        b=ZCj3qzbB1yu1FF3dGF62rGxlZ56BvALK2zk2RHgkBWTNLgZ9ygpvV96hEMJDP3QzPi
         4b8YVUOA6iV9oc07xx8E0L1LDzNpjj5ILAdEon0MeLwj0mWqW5+8+kL4ZXupVWFk+KtF
         J7LHcI+TLvMsN4JpeGIBPKe/X5OY+hX/KwmPIuiX1mpeJ8um86nyXF/FCEStk81KTkvj
         yKattlFbYp/lNufgMducvj9Obo0DiQYMoj9hBY3uxwXarIkdZLNMIQ//R7jC6BP2mc/9
         YLzNBeR/sdQypPj7pSQ8on01UjqmLhYMbafPXndEGqG8We/3cJe1TB06WY9778DsPnxc
         pj1Q==
X-Gm-Message-State: AMCzsaU+FoKYRxLx+qM4LA59kaTnTyptmjUv5PdZqppokEzjUivLCojp
        ROs233Z0PqnDoTnTka4El+hKnO4DHCI=
X-Google-Smtp-Source: ABhQp+RVMOL7/Z1Gd2b/BEPlo7tlw6yZ6Br4MUPT4UbksDa45/0WEPFCVEe7fwM2XN5BqrrBrPVz8Q==
X-Received: by 10.84.229.1 with SMTP id b1mr2866914plk.405.1508461914699;
        Thu, 19 Oct 2017 18:11:54 -0700 (PDT)
Received: from alexmv-linux.corp.dropbox.com (V160-vrrp.corp.dropbox.com. [205.189.0.161])
        by smtp.gmail.com with ESMTPSA id x19sm403583pgc.60.2017.10.19.18.11.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Oct 2017 18:11:53 -0700 (PDT)
From:   Alex Vandiver <alexmv@dropbox.com>
To:     git@vger.kernel.org
Cc:     Ben Peart <peartben@gmail.com>, Alex Vandiver <alexmv@dropbox.com>
Subject: [PATCH 2/4] fsmonitor: Don't bother pretty-printing JSON from watchman
Date:   Thu, 19 Oct 2017 18:11:34 -0700
Message-Id: <6887851348e177728849964cc95ae783b0feb971.1508461850.git.alexmv@dropbox.com>
X-Mailer: git-send-email 2.15.0.rc1.417.g05670bb6e
In-Reply-To: <20171020011136.14170-1-alexmv@dropbox.com>
References: <20171020011136.14170-1-alexmv@dropbox.com>
In-Reply-To: <4f8e3dab26cf50cc6aa055605784680f5c33fcfa.1508461850.git.alexmv@dropbox.com>
References: <4f8e3dab26cf50cc6aa055605784680f5c33fcfa.1508461850.git.alexmv@dropbox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This provides small performance savings.

Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
---
 t/t7519/fsmonitor-watchman                 | 2 +-
 templates/hooks--fsmonitor-watchman.sample | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7519/fsmonitor-watchman b/t/t7519/fsmonitor-watchman
index 377edc7be..eba46c78b 100755
--- a/t/t7519/fsmonitor-watchman
+++ b/t/t7519/fsmonitor-watchman
@@ -51,7 +51,7 @@ launch_watchman();
 
 sub launch_watchman {
 
-	my $pid = open2(\*CHLD_OUT, \*CHLD_IN, 'watchman -j')
+	my $pid = open2(\*CHLD_OUT, \*CHLD_IN, 'watchman -j --no-pretty')
 	    or die "open2() failed: $!\n" .
 	    "Falling back to scanning...\n";
 
diff --git a/templates/hooks--fsmonitor-watchman.sample b/templates/hooks--fsmonitor-watchman.sample
index 7df590d29..60eb7e70b 100755
--- a/templates/hooks--fsmonitor-watchman.sample
+++ b/templates/hooks--fsmonitor-watchman.sample
@@ -50,7 +50,7 @@ launch_watchman();
 
 sub launch_watchman {
 
-	my $pid = open2(\*CHLD_OUT, \*CHLD_IN, 'watchman -j')
+	my $pid = open2(\*CHLD_OUT, \*CHLD_IN, 'watchman -j --no-pretty')
 	    or die "open2() failed: $!\n" .
 	    "Falling back to scanning...\n";
 
-- 
2.15.0.rc1.417.g05670bb6e

