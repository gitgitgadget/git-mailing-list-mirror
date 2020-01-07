Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7BCC33C9B
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C8E12075A
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxuOkYkO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgAGEx3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 23:53:29 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34810 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbgAGEx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 23:53:28 -0500
Received: by mail-qk1-f194.google.com with SMTP id j9so42012390qkk.1
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 20:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aKyjgKssg7R/2ksPBvTIV7gBrzFlvGG0s959AGd855Y=;
        b=MxuOkYkOJ0UOxiCHcfq/C9RtY6lG9QOeZ+76nqjcamyMUo+YQ14Te2xFygfUEUfWeO
         16ECPPPqeDDi0hV2oJ7iFbmH3+k1IftCkiX0b2NhbLmTo9nHW8DN8Opk75+vRdWOs8aX
         MJAsygTuszmuVUAVa5cFY7rpy1t5tacPJeZPXxr6Ay3XjZ6rew7i1D04ANEz7CY/VRFA
         zRGNDGJr1Tvmvmde0XO47NLqgbxoTRoDPLzbwCmp3+Q6lLC0gBZPgEPa0AVd/xSscAOY
         tsd/paVQxTlQeFTYh1WfGhl9ecbmMwhIOuJk5Wy5QincARmzEj61FMfnCoEvT4enXi5a
         JESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aKyjgKssg7R/2ksPBvTIV7gBrzFlvGG0s959AGd855Y=;
        b=FMpnZLIaA0EMRC3NXxWg4w748zlHNNIHULvN0oMip/tWMPrdOrU4XVUe1LTtejTo+u
         3zCwZ53tf+pYS654HArGFzHMRDa9T/fVrFcbI/Y49WYRgYwFxlQzrhG2cipUc+6l36Hz
         tI00sSRqTQdH1uR052JqKygzuBAFoDYl53b4YfdvnJiOMoBu7CcAHMvVHBPEEy2P5WNr
         W5AselqswbXFNvc1ak8Koc2hCul/TsuNXWwnWIch8+vG8wg1ibT0BmAx9g+VDGXABh+8
         qXGZ1IX+hzP2JnUS9C4gQOfOf8BHJ12mq8LJ9losOxu8tSX5gMd9EwqvIDL/hfijrDgm
         M72A==
X-Gm-Message-State: APjAAAU4+A2re7VmTXiIu2gmD3FsMbsOJ+GidAJ4nfRgNjMFl9eglwDW
        nRx2rRsK2sLRicPFhUTk5TbGcIEd
X-Google-Smtp-Source: APXvYqwRMV5dh58GryNvs58mKa5O9dV4UhhpxSYcSI9fbQ7d40z5/gJxzoTjsMubCX8oUfoDyIERiQ==
X-Received: by 2002:a37:684b:: with SMTP id d72mr87724849qkc.293.1578372807539;
        Mon, 06 Jan 2020 20:53:27 -0800 (PST)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id t2sm21663893qkc.31.2020.01.06.20.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 20:53:26 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 01/16] t2018: remove trailing space from test description
Date:   Mon,  6 Jan 2020 23:52:58 -0500
Message-Id: <a0199f1e48b88a93ec181113752fab132b22fa91.1578372682.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.rc1.180.g49a268d3eb
In-Reply-To: <cover.1578372682.git.liu.denton@gmail.com>
References: <cover.1577454401.git.liu.denton@gmail.com> <cover.1578372682.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t2018-checkout-branch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index 822381dd9d..e18abce3d2 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='checkout '
+test_description='checkout'
 
 . ./test-lib.sh
 
-- 
2.25.0.rc1.180.g49a268d3eb

