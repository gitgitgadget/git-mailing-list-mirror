Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4D9C433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbiCUXLO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbiCUXIg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:08:36 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E4D2FE67
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:22 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so366988wmp.5
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hrqf3sc2tLzo/0SxSSl2f0FvWbdi52hqNZQvOYAGboU=;
        b=CRmcfez7lL1Sw/RFJZIoOWPg+JE5wDbcbZGmNTfbjf4rBz6vPQsnyRxTQnoi6Mu037
         5MO+XlVtWpLg2LmwxDb63/lSTwTXhlAdOIf0o0VgqXlxGr8Rv2jRMiHf6FmRbcTxESTq
         Sym27SilCFs5MTCFg6b0eIRntqQ3P3okFR/r709/kWXsxSClgM05TI++gExMnr/WVLBc
         tbSiwty4D980nhwj15zF8uT06tVTOBP2e9t4QasJqC+cyoE1UiLy7843eHqfDtiDHVTh
         s7/IXYUmXQPLa4fwy/n0IoNerVN35ROhAVRlSahIM+vPaokFw+iJarQ4l05wRFfl5Sol
         Dn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hrqf3sc2tLzo/0SxSSl2f0FvWbdi52hqNZQvOYAGboU=;
        b=a1p1mSGhm/VlEkpzoCgjdbfK7JGPNK+PiiHM5UZYSkLkZN3a6INZBk3IQ+NHYF1+xM
         WR2j0pS23RQUX81Ia0kKLdCe+XwmIxBam+oOMKxw23t76u6ADeiIBo7TUIDhFN9s6jWT
         MhhjlnrPeKL9XrRJfXFxlIi5AQMLRcYbVdO453YTFw8jvXKZ/ahddQtBRsA1AK6IYDUm
         YtjmZzXOpfgJGsm70cBgQEeP803+HWUrUntEqcf/QuwbIkyn5SN4uN/YGX70vFkqnHB8
         0ylxwXcH0zmkFUtzE5JPqbxoYnvQiz4nHBy0BxO6UxS1MK6sFxSUbV9ZdS0GUE8XCEQR
         /0Lw==
X-Gm-Message-State: AOAM531pvnxrYo6LL/veOSbpkV+q3yWBfXDwfWGjWPI8Q+b/KPYNIdLG
        7rBM/lZmlXPno/K1Y5N03CiIBFOsmEY=
X-Google-Smtp-Source: ABdhPJxl6esMWi+St0bHQlUPjFl3+qEfsPuzhsm7632kHdQSOLO+2YS9iHVpEkKDNOZggcQMV4ghAg==
X-Received: by 2002:a05:600c:3c8b:b0:37f:1546:40c9 with SMTP id bg11-20020a05600c3c8b00b0037f154640c9mr1078239wmb.161.1647903372597;
        Mon, 21 Mar 2022 15:56:12 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:56:12 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 33/41] run-command.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:55:15 +0000
Message-Id: <20220321225523.724509-34-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220321225523.724509-1-gitter.spiros@gmail.com>
References: <20220321225523.724509-1-gitter.spiros@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The C standard specifies two constants, EXIT_SUCCESS and  EXIT_FAILURE, that may
be  passed  to exit() to indicate successful or unsuccessful termination,
respectively. The value of status in exit(status) may be EXIT_SUCCESS,
EXIT_FAILURE, or any other value, though only the least significant 8 bits (that
is, status & 0377) shall be available to a waiting parent proces. So exit(-1)
return 255.

Use the C standard EXIT_SUCCESS and EXIT_FAILURE to indicate the program exit
status instead of "0" or "1", respectively. In <stdlib.h> EXIT_FAILURE has the
value "1": use EXIT_FAILURE even if the program uses exit(-1), ie 255, for
consistency.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 run-command.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index a8501e38ce..5a5d865716 100644
--- a/run-command.c
+++ b/run-command.c
@@ -319,7 +319,7 @@ static void child_die(enum child_errcode err)
 
 	/* write(2) on buf smaller than PIPE_BUF (min 512) is atomic: */
 	xwrite(child_notifier, &buf, sizeof(buf));
-	_exit(1);
+	_exit(EXIT_FAILURE);
 }
 
 static void child_dup2(int fd, int to)
-- 
2.35.1

