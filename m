Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DA2C3F2D3
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 17:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 175E824699
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 17:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+xRkm/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgB1RZ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 12:25:29 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45631 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgB1RZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 12:25:28 -0500
Received: by mail-wr1-f66.google.com with SMTP id v2so3786801wrp.12
        for <git@vger.kernel.org>; Fri, 28 Feb 2020 09:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CpVKJbFMMjTb9cR0tK4potz8jjBtuE5DRxKqs606s34=;
        b=a+xRkm/5idSQIfIFTEPf3w5JvyAJFtsk0LKx1Jbdr5nYz95FUUYCQj//ZqE93Ygeb7
         K7R2egUF2rIDV3US6CbjVOSEGFumvHo5H5Q1X12rCo1YzWMcpDqBAG/dRHJhP4yXaM2o
         OTqyoMWTq7r/BzCvUhDnmTBkJSzz5NUifSDUoAXSQkxMqlIyVVB3cew43sb1eKYw7SBp
         TnftAFedjc/2/iiogAH2r0LMz8m/PJcZNkaw4BauDjy8Q8hRz2XdzRAJ5nMS/IrlzWHX
         Y1UHCniA+IduZ4adt5Jia5SjV0uBVDOab6JOTFrYP8vnLaYbbce2PBpsfTpiqsqIg4db
         0eeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CpVKJbFMMjTb9cR0tK4potz8jjBtuE5DRxKqs606s34=;
        b=H6BlBk9g0gOwmXjGM6HvXvkGFnEPyJFbdsuOL+07NNIclY7pSOCzVMMSQSTDxS6ssW
         vYxnCC32steidUsc/8IGl7Ufh7ZZ8kxx9AuyeLVcsXrQAEi/ofGriaz5Z+pFTzTD0QzS
         q/bUrfs4qYcCZoHUpUS55ovejUKlN7z5+5xvWfCWti/QOKJ9F0pOfqN0JDfSYEqaU9JI
         c5t+5OPo2ggAn7VQ62YD4hg61z0E8+wXPuekmQOlkcbwfM/SmdVRYHGSuwTozB8u2khg
         fD48UB12kT8atiW11m7urt8u8P413KDgjz/rRApC/qROW5YVf2zhyhJPQYwAQ37NeP18
         NcmA==
X-Gm-Message-State: APjAAAX8Nh2u/X8VcEN2vEc2vTGevMJx4MM1UlJ4cMGtPX9r22E5gSUD
        xiMmPS8Kg9W5tpt9T1o1ALA36wgdVExfvw==
X-Google-Smtp-Source: APXvYqzL2G0Dm17I2Fp/3J8RQU0qq4fiRqJb3xc5iLzl2UyAzHMRVlk2Zm7NdwH2ocZ2YuJiSSBmzQ==
X-Received: by 2002:a5d:668d:: with SMTP id l13mr5813453wru.107.1582910725726;
        Fri, 28 Feb 2020 09:25:25 -0800 (PST)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id z2sm7376635wrq.95.2020.02.28.09.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 09:25:24 -0800 (PST)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org, Jeff King <peff@peff.net>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH 1/1] remote.c: fix handling of push:remote_ref
Date:   Fri, 28 Feb 2020 18:24:55 +0100
Message-Id: <20200228172455.1734888-1-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To get the meaning of push:remoteref, ref-filter.c calls
remote_ref_for_branch.

However remote_ref_for_branch only handles the case of a specified refspec.
The other cases treated by branch_get_push_1 are the mirror case,
PUSH_DEFAULT_{NOTHING,MATCHING,CURRENT,UPSTREAM,UNSPECIFIED,SIMPLE}.

In all these cases, either there is no push remote, or the remote_ref is
branch->refname. So we can handle all these cases by returning
branch->refname, provided that remote is not empty.

Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
---
 remote.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/remote.c b/remote.c
index 593ce297ed..75e42b1e36 100644
--- a/remote.c
+++ b/remote.c
@@ -538,6 +538,11 @@ const char *remote_ref_for_branch(struct branch *branch, int for_push,
 					*explicit = 1;
 				return dst;
 			}
+			else if (remote) {
+				if (explicit)
+					*explicit = 1;
+				return branch->refname;
+			}
 		}
 	}
 	if (explicit)
-- 
Patched on top of v2.25.1-377-g2d2118b814 (git version 2.25.1)

