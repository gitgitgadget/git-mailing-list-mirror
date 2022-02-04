Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD6EC433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 13:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359063AbiBDNvl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 08:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359038AbiBDNvd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 08:51:33 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D0EC061714
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 05:51:32 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id s10so8888515wra.5
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 05:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7tSCnKlilEMtmbvfnJOSly7qrkNkrxedFOl38ZcdJlw=;
        b=mGsO6CFD2NOrYPTXFu7n1NJ+lNwbpbjzl5pnIh+yNitGpafSAbpU1hUJSXo+C/6MoM
         CtEAWsCe+GkE8IpyrmpQtw2/pvEUmpBAh1Kr0XfWOFZ98xGvEqhgMUsa/axgROsEtlWE
         CrsDB3bmmS37z9fESNKuOp9bGV15MSl+6IyuyunOvGYQ77IWFpID0E0V2gs4zN5QIzJI
         Kho6RJxI8N2N9sf4u0Ny/hUBet9Qj1LbM06trnhL5wM+/3kWBlhWb37LICt7M9FUESj5
         CDZBxjT3W2UeihF4ArrOnsKMYURyE5/4Jn/JEEj1QSD4Yqh8w/beutEYKM+IpjMYAoDC
         ZRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7tSCnKlilEMtmbvfnJOSly7qrkNkrxedFOl38ZcdJlw=;
        b=3lSo8CauTQtC9DSdLDyeaykbUWbUjZsFDFvfbj7eOa6kw66EDGq9vOzNHA0pc0BGOR
         UXKJnghaC/MrXLnWeFTQRtudUa1MNRZPZYWjdP+x+2PwQhA/QUcIgTvJAD0UAiVOwRmK
         1Fv7W7YuVC4ZXh7XTfV6AuA5Srf92q5tXLWC0Wfl6IYd8+P5Mxl+iKlFjxH+tAbKDg5H
         HuZZ7wr9usJEviAHaD/L/A90rCcisUXXAOvd1/oOjjMjmfK/pFE8BlTb6W2vHCg4Zfl5
         zspu44WDLbqPohe7UTUdAy/EWZ0fgmqaeYaC7GwcotN5K8pZP/GodLMU88L2mMhVSrzQ
         TSmQ==
X-Gm-Message-State: AOAM530LmTtgbmwyN014SUKcxmH+vc3J9CrMPM1BE/aOrP3HkPqjdCsX
        BS1PTx3Mcw+3RaHXuEODDHZ1c3kRMxuoyQ==
X-Google-Smtp-Source: ABdhPJzxqi+8KqIv1/nQ1lcC7AlZkrFjSwTihComKBkNcwkDWdLZFWJrmlUBBa5kPA07eLu3o3YOig==
X-Received: by 2002:adf:dec3:: with SMTP id i3mr2453035wrn.691.1643982690623;
        Fri, 04 Feb 2022 05:51:30 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z2sm205963wmi.22.2022.02.04.05.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 05:51:30 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 01/11] object-file.c: split up declaration of unrelated variables
Date:   Fri,  4 Feb 2022 14:51:15 +0100
Message-Id: <patch-v2-01.11-53334bc970a-20220204T135005Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.940.ge7a5b4b05f2
In-Reply-To: <cover-v2-00.11-00000000000-20220204T135005Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220201T144803Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20220204T135005Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split up the declaration of the "ret" and "re_allocated"
variables. It's not our usual style to group variable declarations
simply because they share a type, we'd only prefer to do so when the
two are closely related (e.g. "int i, j"). This change makes a
subsequent and meaningful change's diff smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index 8be57f48de7..ecc77973292 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2118,7 +2118,8 @@ static int index_mem(struct index_state *istate,
 		     enum object_type type,
 		     const char *path, unsigned flags)
 {
-	int ret, re_allocated = 0;
+	int ret;
+	int re_allocated = 0;
 	int write_object = flags & HASH_WRITE_OBJECT;
 
 	if (!type)
-- 
2.35.1.940.ge7a5b4b05f2

