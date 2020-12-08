Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809D0C433FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3350723A04
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgLHA1d (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgLHA1d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:27:33 -0500
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64CFC061793
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:26:52 -0800 (PST)
Received: by mail-oo1-xc42.google.com with SMTP id g20so1776482oos.9
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kzr6hpKrAlHfjV96VJaCsV+AczHLhVlKsiTxozFVnHY=;
        b=HX2pQagnM5gJOhy4ZqNgH0Oc67lDwhOKbQBMqOVRdGYV8+DIW5idsH++l4NGZGjV+G
         H39CYZc0p1x2V+XvQiXpH5BKN+BArfQe2MuSjgAmT/06XfSDNx+azxn841yCdFih9euC
         yxUoXvUKIKqvwDXnCMsOfjGU53vFdc8PnciGaZIcpi+JhJnUb3bCRdxOVRAhgozDcKOV
         3IR7pPQ/zx2e8n5Y7KcoOSecDWsdMizes6xzoDYnI239IDhcUqW/V1tGXhCOVNgemdIB
         7jGF1+u+B0av/7etMEOE+D+axeKNrCj+CBdEqf5I6v/0DJD1ZaejWHor3g0CDwS7ySPb
         rr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kzr6hpKrAlHfjV96VJaCsV+AczHLhVlKsiTxozFVnHY=;
        b=FU2V/p/tEevdu+zxWgujFTa+9ptYTQ430OzdjkmlGUcbMJTCs2GxukrBawg+pZc/jR
         s4xddx60PxZ29abcUKc3Z3x75uRb++7DW0XMSliImY1zm/4Jvl5aFEjW3jXBMPgNRIfj
         1eEeQfYmOa0iaWUwtuks4uZCF9mcoqkBlV5MlU7SHl9a6TBw6B8BMxuePg1Wb7UlNGcf
         rAcRC8wSbURbq7ZcWG3WO32gUpJF9fjKVE0awwcPWSC5/mjCggN0czjoTsPJCctqEZQD
         4hoE9ceI+2v04OBoFwYXqi2ckqEl0EMTmqzds0DPWHUHuUWqZqHnjMa8lGoj/A+3Rs4P
         UvCQ==
X-Gm-Message-State: AOAM531Hkpr2Y+00SiQQOtESmLqyCxs+5v5wuA/1ujYcF4KYqYSixVj0
        ISQYQ0pMwT+nrPFCZltQvc9lZhdSC/w2wjgd
X-Google-Smtp-Source: ABdhPJxsu/9Oh2uCgBFZ/2IRWRxhmtJnllt0PvLxzYqQwiknSV/1MBhBlFsZo9CtyVvrVlikNDv/FA==
X-Received: by 2002:a4a:d148:: with SMTP id o8mr4485376oor.16.1607387212101;
        Mon, 07 Dec 2020 16:26:52 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id u10sm3052782otj.31.2020.12.07.16.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:26:51 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 01/19] doc: pull: explain what is a fast-forward
Date:   Mon,  7 Dec 2020 18:26:30 -0600
Message-Id: <20201208002648.1370414-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208002648.1370414-1-felipe.contreras@gmail.com>
References: <20201208002648.1370414-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We want users to know what is a fast-forward in order to understand the
default warning.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-pull.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 5c3fb67c01..e1605a81b3 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -38,6 +38,20 @@ as set by linkgit:git-branch[1] `--track`.
 Assume the following history exists and the current branch is
 "`master`":
 
+------------
+	  A---B---C master on origin
+	 /
+    D---E master
+------------
+
+Then `git pull` will merge in a fast-forward way up to the new master.
+
+------------
+    D---E---A---B---C master, origin/master
+------------
+
+However, a non-fast-forward case looks very different.
+
 ------------
 	  A---B---C master on origin
 	 /
-- 
2.29.2

