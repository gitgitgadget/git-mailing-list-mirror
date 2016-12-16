Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F4121FF40
	for <e@80x24.org>; Fri, 16 Dec 2016 19:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756934AbcLPTDi (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 14:03:38 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:36047 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756428AbcLPTDg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 14:03:36 -0500
Received: by mail-pg0-f42.google.com with SMTP id f188so34934650pgc.3
        for <git@vger.kernel.org>; Fri, 16 Dec 2016 11:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5BiMZA2BianGjfPQU+wvGjv4dNZhquLZ2u/IaAAD2YM=;
        b=aAXjR+g0a+fFhhcDrPZ+5sZ2jVT+TuNx9uC6BGH8kXsIu5C/IEp2qz7XB6EtHOZ+Yp
         mwVNFufbsYE8PuU9n5/ODtRla1ilIb8D4O0woaGGFIn6HCgSiiQgAppzVrSLbOk/zQgv
         KGXG9UaBtFx196jZRhDexIedMeImTPTkeBrT2cb6DHUEBsGRVuW8Xv8+3hG2DBNHx5Mg
         fzKP4k4wORGlQ4zHPuJOxaknkp/3mGvjLBlzyd+vSivV0/gk3D+I9nOBVcPa/W2zefeN
         88N6d2SoHaqmllNRT1ltxmWmAiGLVtwGGsFhNttQmu0A7klA1qs1roS2jRDrLziJAl63
         p+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5BiMZA2BianGjfPQU+wvGjv4dNZhquLZ2u/IaAAD2YM=;
        b=cq6Cr1/0E+VGotOKquMsVAkquGNwm70lrVMrvyZgEgULA37IVELNDWwxMzf4S2E3Xn
         gEVXY5EA1fYEfXyhkWICr6LsQPQ8/JyqwsfmMHOSvGi/DUuwmz74VsPG70Vy65xg1dQl
         xy98gsSqkKpBL2QRD1Xxyc2w+mwZcoaTJjBfCcgaw1umBcGo69nQ5zAhGqaYCBpLQt2x
         IAl2wcqzvOjo5+CbSa/wy7tZbac+mDk27b1i4NpcyrSCj/Qk9P06i8pCcr9ta9PYqACO
         SvHL1Dwf+pRUXeD7NyCu7APOmAPq90LfjQ2fQNvHsTieahCKGJ9ZQx9NuFuRmfhs+VfY
         XAKg==
X-Gm-Message-State: AKaTC01iT261IQUAZYikwiE7oERAKbaslC36togu14mkXPhN3VD5G3f62K1Inn0N4Bi2Fv9r
X-Received: by 10.84.178.7 with SMTP id y7mr9960424plb.147.1481915014503;
        Fri, 16 Dec 2016 11:03:34 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id x90sm13573389pfk.73.2016.12.16.11.03.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Dec 2016 11:03:33 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, sbeller@google.com, jonathantanmy@google.com,
        gitster@pobox.com, jacob.keller@gmail.com, j6t@kdbg.org,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v7 1/7] submodules: add helper to determine if a submodule is populated
Date:   Fri, 16 Dec 2016 11:03:16 -0800
Message-Id: <1481915002-162130-2-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481915002-162130-1-git-send-email-bmwill@google.com>
References: <1480555714-186183-1-git-send-email-bmwill@google.com>
 <1481915002-162130-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the `is_submodule_populated()` helper function to submodules.c.
`is_submodule_populated()` performes a check to see if a submodule has
been checkout out (and has a valid .git directory/file) at the given path.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 submodule.c | 15 +++++++++++++++
 submodule.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/submodule.c b/submodule.c
index c85ba50..ee3198d 100644
--- a/submodule.c
+++ b/submodule.c
@@ -198,6 +198,21 @@ void gitmodules_config(void)
 	}
 }
 
+/*
+ * Determine if a submodule has been populated at a given 'path'
+ */
+int is_submodule_populated(const char *path)
+{
+	int ret = 0;
+	char *gitdir = xstrfmt("%s/.git", path);
+
+	if (resolve_gitdir(gitdir))
+		ret = 1;
+
+	free(gitdir);
+	return ret;
+}
+
 int parse_submodule_update_strategy(const char *value,
 		struct submodule_update_strategy *dst)
 {
diff --git a/submodule.h b/submodule.h
index d9e197a..c4af505 100644
--- a/submodule.h
+++ b/submodule.h
@@ -37,6 +37,7 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 		const char *path);
 int submodule_config(const char *var, const char *value, void *cb);
 void gitmodules_config(void);
+extern int is_submodule_populated(const char *path);
 int parse_submodule_update_strategy(const char *value,
 		struct submodule_update_strategy *dst);
 const char *submodule_strategy_to_string(const struct submodule_update_strategy *s);
-- 
2.8.0.rc3.226.g39d4020

