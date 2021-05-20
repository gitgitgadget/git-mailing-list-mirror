Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C75C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 21:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BD4A6135C
	for <git@archiver.kernel.org>; Thu, 20 May 2021 21:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhETVsp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 17:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbhETVso (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 17:48:44 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF33BC061761
        for <git@vger.kernel.org>; Thu, 20 May 2021 14:47:21 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id p20so21611692ljj.8
        for <git@vger.kernel.org>; Thu, 20 May 2021 14:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uNY/uuZEuclC+DcxmOGE52HcpMuUheiuLiV0d50brtE=;
        b=aBCiCq90IiqX5OtzY9cpbPd0GfG5WmYv+EuOo2i1sNMQoH19Tvgi9sEkqM847RlH4h
         bdINA1ZlSIVzFq+b2pkEFGjOBlJYxqT28jFE/OyYm/7S+zM6itTx28IbzgYN/ekafd3E
         L30JG6nzMFLlxf8n23ATie8D//F3XR/do8pZ8kegKiRrXVTfwFxijhFDNhVARFUp8oER
         yD1qU/QeXi0jRtC5vvBnL6otukQo+lQg7pLZ5x3M+2/yDRU1VqnK4G9GsTi6MijWNN0D
         S1LePtObjyFiHiahT2fw2aNDM0GNBYMiQCPpi7ifMXGk3aJXsF6jPnjhd9t4ZWnG6/94
         QKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uNY/uuZEuclC+DcxmOGE52HcpMuUheiuLiV0d50brtE=;
        b=KX/upPnz0kyQgen2Lanyj0/Q5z3BhtEqGBUfs0HY7osVoSeX++t8wsacCSDBfwK9G6
         ep/x8t07D70hitnkM+021lYMC8HkBEodpIjwJ1l0AGxzdpzpKfs58mMDin27DE4E8rs+
         cUYqyivra/uvKPeXL4HxZhvkTL90hWfbHS4w/m4ivlbtbo1/aHnPXLKv5f42bXIgRWrZ
         vicUXdrzFFrKUv7UbwmIg4+oALV87kcpMLXu6d3fxNzMVmQALgyYMHVgKpfEjM3uJesB
         +f3U3Y03l4QngM1GFEBqw2B4R9wPT3ZGBMv9LP3aQDDgTgSXP2vAuY71m3hqf/hbXVAn
         Wo4g==
X-Gm-Message-State: AOAM530/HQjgBNRaVGA/xtVH1/IuPJLwQmKDkdHx8AFgshEl3YOYwgDA
        EKcJBQJrksn06hot3PZi24I=
X-Google-Smtp-Source: ABdhPJycNs/Ks+KIbOJq5snpkk5JOLPpRVoJXrWMOV2bOCBFwGoA50sPBS/pJxV38F0lYcWXE2zGGQ==
X-Received: by 2002:a05:651c:1063:: with SMTP id y3mr4367637ljm.183.1621547240126;
        Thu, 20 May 2021 14:47:20 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id p2sm408414lfh.31.2021.05.20.14.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 14:47:19 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 04/10] t4013: test "git diff-tree -m"
Date:   Fri, 21 May 2021 00:46:57 +0300
Message-Id: <20210520214703.27323-5-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210520214703.27323-1-sorganov@gmail.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210520214703.27323-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We want to ensure we don't affect plumbing commands with our changes
of "-m" semantics, so add corresponding test.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 t/t4013-diff-various.sh          |  1 +
 t/t4013/diff.diff-tree_-m_master | 11 +++++++++++
 2 files changed, 12 insertions(+)
 create mode 100644 t/t4013/diff.diff-tree_-m_master

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index e53ca7aa503f..bdc23b1180b0 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -293,6 +293,7 @@ diff-tree --stat initial mode
 diff-tree --summary initial mode
 
 diff-tree master
+diff-tree -m master
 diff-tree -p master
 diff-tree -p -m master
 diff-tree -c master
diff --git a/t/t4013/diff.diff-tree_-m_master b/t/t4013/diff.diff-tree_-m_master
new file mode 100644
index 000000000000..6d0a2207fb30
--- /dev/null
+++ b/t/t4013/diff.diff-tree_-m_master
@@ -0,0 +1,11 @@
+$ git diff-tree -m master
+59d314ad6f356dd08601a4cd5e530381da3e3c64
+:040000 040000 65f5c9dd60ce3b2b3324b618ac7accf8d912c113 0564e026437809817a64fff393079714b6dd4628 M	dir
+:100644 100644 b414108e81e5091fe0974a1858b4d0d22b107f70 10a8a9f3657f91a156b9f0184ed79a20adef9f7f M	file0
+59d314ad6f356dd08601a4cd5e530381da3e3c64
+:040000 040000 f977ed46ae6873c1c30ab878e15a4accedc3618b 0564e026437809817a64fff393079714b6dd4628 M	dir
+:100644 100644 f4615da674c09df322d6ba8d6b21ecfb1b1ba510 10a8a9f3657f91a156b9f0184ed79a20adef9f7f M	file0
+:000000 100644 0000000000000000000000000000000000000000 b1e67221afe8461efd244b487afca22d46b95eb8 A	file1
+:100644 000000 01e79c32a8c99c557f0757da7cb6d65b3414466d 0000000000000000000000000000000000000000 D	file2
+:100644 000000 7289e35bff32727c08dda207511bec138fdb9ea5 0000000000000000000000000000000000000000 D	file3
+$
-- 
2.25.1

