Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BEDA20323
	for <e@80x24.org>; Sat, 18 Mar 2017 11:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751307AbdCRLt7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 07:49:59 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35392 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751025AbdCRLt6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 07:49:58 -0400
Received: by mail-pg0-f68.google.com with SMTP id g2so13340286pge.2
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 04:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tg7C408YfZP5YGeIqMjym6H4+vVcG3byJTkJnaPRovs=;
        b=OBQkHvK7qAgakFCb5z53WpbFfK1PYCcmljTWfftUG6i0RnG0V3jQHgRkXI/op+4duK
         grk9unPYS5ZQp/xXDmeZZmE4IihQoz88zavCPB0Q8UJMZF1swj6Q0kI8kQJA9Iz3PuWH
         6QrxBk1r+RJEAjDQTpDTRri4ZqQKUO23ldvvOZzFW8U7J8/c7U11WwXG5y1ZVJOttJpX
         +bM6zs1BqK2rBcjGdxWqik0bX/ZT+b2qki2gwL1S+fzLVA15Q454bD+6RqtekLiTstMq
         kB9kg01iM/6QVqAYdCcdOwAmbIXCHtzsRp0y3Kx4LwPvm6aiEJAU//SYjQ4ZfdVRZoCU
         r9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tg7C408YfZP5YGeIqMjym6H4+vVcG3byJTkJnaPRovs=;
        b=Tmz+mCd+2pHGz8G+72FNzhb68vxAeYZTsjqx2s+f6ySDnaebCrcqYGZdKcRaJAnlCC
         55X2/RyDDYgiiW1E2Cti7qw0jMsjA8sZFDe3R/NXakndhiqLje0vrlPQaelO6ogGEVbL
         iI0nnl5lx4zDI3LPTJUBTErwBgmMu4aWLcAJdpYpG0YMRhj1aYj5yBOml+IVmUfn3m3u
         704SPhtDkll+ezGjqweOmAlugU43MV1zTbw1j3AFayROZRFKQsq+GmSmQRJO8hrsUQbo
         ruJjdQjKgQflVgVl0qSjAGfxVthd8j9obTQRh+VqAsSbFSHxy/Ud3HwHLe4yfdzYfBhB
         daYA==
X-Gm-Message-State: AFeK/H0HEDIk4P465Ox8fn8Yp2U/wu8TpoHeQiahdDPzTFVRMw6AZJ0bItYcbZ4LYmDdIg==
X-Received: by 10.98.32.24 with SMTP id g24mr22402837pfg.115.1489831343867;
        Sat, 18 Mar 2017 03:02:23 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id d3sm21748911pfc.51.2017.03.18.03.02.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Mar 2017 03:02:23 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Mar 2017 17:02:18 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 1/4] environment.c: fix potential segfault by get_git_common_dir()
Date:   Sat, 18 Mar 2017 17:02:03 +0700
Message-Id: <20170318100206.5980-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170318100206.5980-1-pclouds@gmail.com>
References: <20170216120302.5302-1-pclouds@gmail.com>
 <20170318100206.5980-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

setup_git_env() must be called before this function to initialize
git_common_dir so that it returns a non NULL string. And it must return
a non NULL string or segfault can happen because all callers expect so.

Normally if somebody has called get_git_dir(), or set_git_dir() then
setup_git_env() is already called. But if you do setup_git_directory()
at top dir (which skips set_git_dir) and never call get_git_dir, you'll
get NULL here.

test-ref-store.c will hit this problem because it's very lightweight,
just enough initialization to exercise refs code, and get_git_dir() will
never be called until get_worktrees() is, which uses get_git_common_dir().
---
 environment.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/environment.c b/environment.c
index 42dc3106d2..2986ee7200 100644
--- a/environment.c
+++ b/environment.c
@@ -214,6 +214,8 @@ const char *get_git_dir(void)
 
 const char *get_git_common_dir(void)
 {
+	if (!git_dir)
+		setup_git_env();
 	return git_common_dir;
 }
 
-- 
2.11.0.157.gd943d85

