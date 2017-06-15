Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9ABF20D19
	for <e@80x24.org>; Thu, 15 Jun 2017 23:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752473AbdFOXQJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 19:16:09 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36842 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752424AbdFOXQH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 19:16:07 -0400
Received: by mail-wm0-f67.google.com with SMTP id d17so2100390wme.3
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 16:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=LroAcE8oOLKZLlusxUhaTKCPxxIbkYDUxpilZpD38Q4=;
        b=Fs1eyRmTN5kPcuPolK/fs+I8VlR37mKL+hq2Fo9hYNE7/ZKPBIk1ZvM9sQoywSuACH
         DQedk7BTOswN2rjav33mrWLCXV4gcxDtnYFj4z1dZf6jNUTvrkTn+ScLxZ7a2Tsyc0Fa
         bbkgiBtCTuYH3cW+MPUyOzWHyLfM9wlUKrb1G7AE7fVCdPi9zJqNRrHvjldaM++LLkbJ
         MLCDJ4qPTcxLec5gCjJPRsM8SNokWIkCQQtHwsMeqpNz96h+tfVSSVdm+CEC/mfKcXeG
         xAEcsfanGXaFlTtyAjIiMx/bQZWqe06kQ+SqcLQ/d0S/EgmOWpR/8HUh7IjWf+jJtxis
         3Ndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=LroAcE8oOLKZLlusxUhaTKCPxxIbkYDUxpilZpD38Q4=;
        b=RgYMaMJJPW4MPY+6lxJrqCiHZJ4fu73LDRCxW/oNDp+KLiw7m7amyDwWeRgn4i+uP1
         SnAEr1bX+broQcM4rlP0qhSOQUbwutEb1/CDyNqCgHC/Rda8r1p94fqdXTl5MayNdUqR
         iy/FygdG3hlRgMX0jqh6r8JHFvkgk8FB7sxTG78CCS8x54+qWfId+I2czHew4mS8DEd7
         64BDHBjRjotdS70HOzK+kyW2v9S50KScpXdZhujZkoApme+b7aq0hIiTy0DoYJLNlBCR
         ///6git/AgSJYT/l7AuB9hnl69ktJVUCLx+8p6FezjDAxTawn2kpdyyGFbX+m99LSdXb
         T9+A==
X-Gm-Message-State: AKS2vOwM+Bw5svL5Y6ySUg50us5sjQPE5mlxQKhrZ4PSRzodOtUru4Ez
        0Ah0QEYsZJisor0hYoY=
X-Received: by 10.80.166.101 with SMTP id d92mr5141411edc.132.1497568565637;
        Thu, 15 Jun 2017 16:16:05 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id o15sm305130edo.68.2017.06.15.16.16.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Jun 2017 16:16:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 2/6] coccinelle: add a rule to make "type" code use FREE_AND_NULL()
Date:   Thu, 15 Jun 2017 23:15:45 +0000
Message-Id: <20170615231549.20085-3-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc
In-Reply-To: <20170615231549.20085-1-avarab@gmail.com>
References: <20170615231549.20085-1-avarab@gmail.com>
In-Reply-To: <xmqqa858zzb3.fsf@gitster.mtv.corp.google.com>
References: <xmqqa858zzb3.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/coccinelle/free.cocci | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/contrib/coccinelle/free.cocci b/contrib/coccinelle/free.cocci
index c03ba737e5..35fb992621 100644
--- a/contrib/coccinelle/free.cocci
+++ b/contrib/coccinelle/free.cocci
@@ -9,3 +9,11 @@ expression E;
 @@
 - if (!E)
   free(E);
+
+@@
+type T;
+T *ptr;
+@@
+- free(ptr);
+- ptr = NULL;
++ FREE_AND_NULL(ptr);
-- 
2.13.1.508.gb3defc5cc

