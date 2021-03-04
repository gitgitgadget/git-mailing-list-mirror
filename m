Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76108C43333
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 20:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D90C64F6F
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 20:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238965AbhCDUSd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 15:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238911AbhCDUSN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 15:18:13 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3755DC06175F
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 12:17:33 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id e10so28831006wro.12
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 12:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YXbfKpBiPYjDdZBiSoHqg8jk6QrUTHtzbdPOQu4RfR8=;
        b=o861odke5sAU8ExVhTrUHlYCpSa5eL4Z628/bOEHwN7Nd4TgPKS0//GVHntOnRp6w+
         8eSGmMOZzbcGbv3UA+ZaMLJZk21SRsdg0itnFZtneFWO+VVN/SNqbHk+aGualrhlZhru
         XAfYaxAy8OO8fCd9SE04MfXw1xlQiwI45OIsRfZ6kdssYuySprlwcXY8XSDFlNXZApvD
         mMdeQWj6BMhdiHzkQ67HrV+XRPfTjBS9xMuisH+x3Wew6ncEMscCRt/kyJkWP3meIUF4
         JBP/3qEzEh8pwtXb0n96Dc481hcXgSM39UGtqzCKatKD/fOK/xqKUPF8pHdPhCSttcPe
         8fjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YXbfKpBiPYjDdZBiSoHqg8jk6QrUTHtzbdPOQu4RfR8=;
        b=arYAxqJbg3cMjD/YrbcaDdfGYjrHJFhUYdkXiSnvPABtEV2t8OYPebYY3YSRkzHHLG
         raNgCyfUKnFXbLTZaDKi7vTnQDL1AD30z2qwn2bbTYaAjsyZztyeqJAfyd3hP16Xbfnr
         zBCpqdYS0AmAZx+IJeLfsOLhgGRzhXVMTgw7PpGz2oTizmgr6hHvfq+gPx28YWWLxOg+
         1zDn9KqGyMlrsZUrdjeElSPvRrNtbI1KJD36KF/ojBo3BvjoP2zrzjUnID2isiDPWmHh
         VmSh5MhBbLYBMPQeyKmSIW7CuwQZVAST+PlzEpsLmxTg0qZmrRPpOqpuyF2/ZJVB6u7U
         w5bw==
X-Gm-Message-State: AOAM5326meyhrrVi2KK5V/Mvh4A5yhv4+GViNNc6Y0jat3NA2l5D20O/
        OlaxNug+FQTe2CedT1g2JTzK4LR1wEQ=
X-Google-Smtp-Source: ABdhPJxD4crxZMYi0TI59dPtc8doPoTM8nCd/qujFFieEDqeCZWUhqo5DyJ1c4EO24h1bOdyep4dhg==
X-Received: by 2002:a5d:5051:: with SMTP id h17mr5802864wrt.80.1614889051977;
        Thu, 04 Mar 2021 12:17:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 18sm765763wmj.21.2021.03.04.12.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 12:17:31 -0800 (PST)
Message-Id: <89100959528c6a3c16622cf86e6920273f5ed2d3.1614889047.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.893.git.1614889047.gitgitgadget@gmail.com>
References: <pull.893.git.1614889047.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Mar 2021 20:17:24 +0000
Subject: [PATCH 5/8] unix-stream-server: add st_dev and st_mode to socket
 stolen checks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

When checking to see if our unix domain socket was stolen, also check
whether the st.st_dev and st.st_mode fields changed (in addition to
the st.st_ino field).

The inode by itself is not unique; it is only unique on a given
device.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 unix-stream-server.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/unix-stream-server.c b/unix-stream-server.c
index f00298ca7ec3..366ece69306b 100644
--- a/unix-stream-server.c
+++ b/unix-stream-server.c
@@ -120,8 +120,11 @@ int unix_stream_server__was_stolen(
 
 	if (st_now.st_ino != server_socket->st_socket.st_ino)
 		return 1;
+	if (st_now.st_dev != server_socket->st_socket.st_dev)
+		return 1;
 
-	/* We might also consider the ctime on some platforms. */
+	if (!S_ISSOCK(st_now.st_mode))
+		return 1;
 
 	return 0;
 }
-- 
gitgitgadget

