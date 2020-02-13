Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E32FC3B18C
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 18:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2470217F4
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 18:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkOSnBmg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgBMS7P (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:59:15 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54201 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728222AbgBMS7O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 13:59:14 -0500
Received: by mail-wm1-f66.google.com with SMTP id s10so7442544wmh.3
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 10:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YsSaa/Z5vJG5CKfKt+TlxmKS+vUz5pHfvqPlP5QYe48=;
        b=LkOSnBmgchmcUg8MTbR9QkYWgECrHCDHSyt5Zt1H1JJ9PYmbKzscsWn0jdGb26wWhY
         DryT7J7CH+TBve/BqK21ztEzILvbjkCzl/RtfjbVJu5V5/td3c8JYPAWyWfaQGxHDE99
         JtmbcTjT7d5svvZKKBqk3XXzVcy/7/yTDTAzuzsVa2wnAjkPCLWFvFA0630wNoOgDsD1
         w4Tk9M6jwbNPkh8EM798o5JONK033sJpImXHOdDtoMbUyuJ/mcqk2M0xhOd1MlEfFk+n
         oEJ1yXhV5jBoz9kz17/MkshDyyDNgqYkPnGXkosW+00v+XSc8cXP+hKUooTjczESwmKc
         Z1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YsSaa/Z5vJG5CKfKt+TlxmKS+vUz5pHfvqPlP5QYe48=;
        b=h/EBdGgIP3NdL1RWtqqw65SvlHSNk+FxjMruwMzm/eC4Vq+kQkDPq6gq8EMZEJuI9W
         QxOnKR8xl5UGOPHFbLsPLo5AGmTcZdheTuHV6AX6OJNV+v/+msmik1eRQxTenhWWIKhx
         IGs9k3rT0ijM+DB8XVa/4O0F3VOXd9aPfEAec9oBHIbfcUeTEoPiC6npzSs89X2mCgB8
         RTwBXdfacHOPCtUGJsvPkN5tFzCc/kIexU2YhlL8MO6Gsh7CqOy4VU5DR0VOkvYP7y5C
         Kg7lH2HQLEpeMxRNSRwLKvcKeD7+OyeyHBMYDX0X9Ge5Ckevd1reIePGrrymUYGVsH90
         jj3Q==
X-Gm-Message-State: APjAAAUbbzt/ENScRMP5IpT+r4hZ52zZRiYGeuNCSJsm8sDHV62Iw4mY
        Ia/vVnlYyND8zML3ooty6csa+Jsm
X-Google-Smtp-Source: APXvYqzmPi3Se7legm1dMdihaXAaAwwwEK2dBpHCew5H1LWNlTutD1AcpUhcJqpjpIVTkEgwzZA4FQ==
X-Received: by 2002:a05:600c:2503:: with SMTP id d3mr6997318wma.84.1581620353311;
        Thu, 13 Feb 2020 10:59:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n8sm3780841wrx.42.2020.02.13.10.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 10:59:12 -0800 (PST)
Message-Id: <d156d04ca87f9fcffb1c08a08576dddcdc64c055.1581620351.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.535.git.1581620351.gitgitgadget@gmail.com>
References: <pull.535.git.1581620351.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 13 Feb 2020 18:59:09 +0000
Subject: [PATCH 2/3] t5509: initialized `pushee` as bare repository
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Hariom Verma <hariom18599@gmail.com>

`receive.denyCurrentBranch` currently has a bug where it allows pushing
into the current branch of a non-bare repository as long as it does not
have any commits. This would cause t5509 to fail once that bug is fixed
because it pushes into an unborn current branch.

In t5509, no operations are performed inside `pushee`, as it is only a
target for `git push` and `git ls-remote` calls. Therefore it does not
need to have a worktree. So, it is safe to change `pushee` to a bare
repository.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 t/t5509-fetch-push-namespaces.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5509-fetch-push-namespaces.sh b/t/t5509-fetch-push-namespaces.sh
index 75cbfcc392..e3975bd21d 100755
--- a/t/t5509-fetch-push-namespaces.sh
+++ b/t/t5509-fetch-push-namespaces.sh
@@ -20,7 +20,7 @@ test_expect_success setup '
 	) &&
 	commit0=$(cd original && git rev-parse HEAD^) &&
 	commit1=$(cd original && git rev-parse HEAD) &&
-	git init pushee &&
+	git init --bare pushee &&
 	git init puller
 '
 
-- 
gitgitgadget

