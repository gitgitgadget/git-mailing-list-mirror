Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52085201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 16:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751745AbdF3Q2a (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 12:28:30 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35073 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751322AbdF3Q23 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 12:28:29 -0400
Received: by mail-pg0-f50.google.com with SMTP id j186so65963106pge.2
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 09:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lbRjlOjz28YkcK+TL3Gz+j7dwV5ozZkJhDIbJDohhRs=;
        b=SHZtjPmh/IBBQjx+1qQ/oEgFFw4GWnzGDRVJ+uPAlRU5HONkN18wqWLUDEgkZ3m/bn
         Y38MldqwFkbQzmuDqqCTFkyZvfeReZEnPYaxPAIr2S5/KHwcwnfcL1g3h1GJB/ki0Dow
         6IlCHwornIXLgbwTg2e1IQTFc+ZgQ+51jRWSye2rdlhVx+RwOrsfvtNsJlBD0hHDgZXZ
         8v7HQJW5gvucOugs3lftUpP9Znqhi5noNU3UO2DcqcCsiGlD1yIX5HVMQBduwi0J+NHP
         PT51raM7pT2sh8Y0VlRE+EABLCKaU/LcojnG4wPypz6t6fdCqF4JWsziV9fjdszLVJ1h
         g4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lbRjlOjz28YkcK+TL3Gz+j7dwV5ozZkJhDIbJDohhRs=;
        b=I5AYDn57Vh2t57eKssBj2I+5cyonTxOCvBUoyQVsEMyq6IsrloS6fi5YsrQaVZwpXt
         DSrnoR/3+lk/FCUH/kIpgZYKrJ64zkeOf9Ej6gEWAbWDAKhfTya6CbwMytP0rhixhcWD
         xpuvSynjntBjWy6WLTAhnDboacsE3++WeXrbU5IvG5I7eE+h4Mr/8gkmyvw2uLDH+lsk
         tVWZ4ougS/dC8CiXR/fHde/fOdGNzSf5H2D66uk6SLIhbZncV05fN+k9Yi7K2Zh3TQIP
         Bui6MeAlZpHHHFz9ESV2WAxQWNKFd1pTdlnaXkZtNuYBCJO2QMb+kdLG1EsBKDTcrPBD
         sNCA==
X-Gm-Message-State: AKS2vOw0hBlaXC2hi4XiDI5gW8NbD8hLkroyoJveaT/6ZvltVkB7HDO0
        2T1G561cLqYXZHyM
X-Received: by 10.84.217.214 with SMTP id d22mr25074084plj.269.1498840108665;
        Fri, 30 Jun 2017 09:28:28 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id d71sm21077205pfe.106.2017.06.30.09.28.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 09:28:27 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     s_shestakov@playrix.com, kostix+git@007spb.ru,
        Matthieu.Moy@grenoble-inp.fr, tboegi@web.de
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] status: suppress additional warning output in plumbing modes
Date:   Fri, 30 Jun 2017 09:28:26 -0700
Message-Id: <20170630162826.27711-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <70c9a162-ac2f-c347-d13b-f24ac24d1133@web.de>
References: <70c9a162-ac2f-c347-d13b-f24ac24d1133@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When status is called with '--porcelain' (as implied by '-z'), we promise
to output only messages as described in the man page.

Suppress CRLF warnings.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Maybe something like this?

 builtin/commit.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/commit.c b/builtin/commit.c
index 00a01f07c3..3705d5ec6f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1126,6 +1126,11 @@ static void finalize_deferred_config(struct wt_status *s)
 			die(_("--long and -z are incompatible"));
 	}
 
+	/* suppress all additional output in porcelain mode */
+	if (status_format == STATUS_FORMAT_PORCELAIN ||
+	    status_format == STATUS_FORMAT_PORCELAIN_V2)
+		safe_crlf = SAFE_CRLF_FALSE;
+
 	if (use_deferred_config && status_format == STATUS_FORMAT_UNSPECIFIED)
 		status_format = status_deferred_config.status_format;
 	if (status_format == STATUS_FORMAT_UNSPECIFIED)
-- 
2.13.0.31.g9b732c453e

