Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F7022023D
	for <e@80x24.org>; Mon, 22 May 2017 19:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759292AbdEVTs2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 15:48:28 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35865 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761726AbdEVTsZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 15:48:25 -0400
Received: by mail-pf0-f181.google.com with SMTP id m17so91692699pfg.3
        for <git@vger.kernel.org>; Mon, 22 May 2017 12:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xud4vI/Tv3+p9eZ67FpX0cVCa8lwTamdf1SGpzg/Cw4=;
        b=WLHMB0oJcsBvPglbbEWFQxPzDQ9j3aitdoWf8wqXSfliDDNaENnL2Fg00K75wCVCQf
         Ofdh3Eo+GGkvConsATARohRXTrZ9QuFdWCHlZKnuAXNr81TLvmmgoND6AcUOpFsKVb+e
         oGi4KNOWes6EuW4EJ0KuaQdliZ2dOhLjs/36lLx5jJrI2LxDIIdhIPKD9AMzbCXMCtyD
         pBIb93YrpM8bz6zEgqx3lNOk7P5yPfmr2lDwLq6r1yPOd189CmM9vShh4PBoxgMgJ+uq
         jHUdkDC0InhU7veezmGsp+MLAEZO1LK1XfmAZxg+wTacuUl89xJKypqxv+j3dZJNhEWA
         x8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xud4vI/Tv3+p9eZ67FpX0cVCa8lwTamdf1SGpzg/Cw4=;
        b=cyKdSbo7yyPPKlTd2/y5V/Phc9cCeIl2LyZtm71bdcZFPt+eu8DquxHc84sH45flNu
         277R3OBY+ACw3TjqCvopt3Luw5Euq/Z+Debhdpv2h3/3Wfz2GH+m2PIxy0sWQOHFDXbv
         txwmWS99gK73jyXr+9FvMUqZg/aO0+y5+rVeUZKpmDvmmObTuBDZDStCF33b9r8Phd3w
         8kPSlCgAjSSPj0CmqK89e6O0FFXInLJEaTI2ojInea4JsYZz0GZMZGAuR1L7BWgvkOiQ
         z97AE852LUkjoZmQkaWg36A9zTj7SHaKhnPPB+/bKy5V12dGvYfOhkJX2TYBIOpO0Tpc
         Li1w==
X-Gm-Message-State: AODbwcBlp9aXX2E7ooXBelo8mJ/Fh/7PigFn00K95LeOOVkJL/T/gEkU
        pXczVud8UexTrUHg
X-Received: by 10.84.205.69 with SMTP id o5mr31087499plh.106.1495482494527;
        Mon, 22 May 2017 12:48:14 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:6dc1:8d70:6f8f:1c2a])
        by smtp.gmail.com with ESMTPSA id a85sm31969689pfg.7.2017.05.22.12.48.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 12:48:13 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 4/6] builtin/fetch.c: respect 'submodule.recurse' option
Date:   Mon, 22 May 2017 12:48:04 -0700
Message-Id: <20170522194806.13568-5-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170522194806.13568-1-sbeller@google.com>
References: <20170522194806.13568-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c                 |  1 +
 t/t5526-fetch-submodules.sh | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/submodule.c b/submodule.c
index 5d7aa711c8..0bf268b196 100644
--- a/submodule.c
+++ b/submodule.c
@@ -94,6 +94,7 @@ static int submodule_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "submodule.recurse")) {
 		int v = git_config_bool(var, value) ?
 			RECURSE_SUBMODULES_ON : RECURSE_SUBMODULES_OFF;
+		config_fetch_recurse_submodules = v;
 		config_update_recurse_submodules = v;
 	} else if (!strcmp(var, "submodule.fetchjobs")) {
 		submodule_config_reading = SUBMODULE_CONFIG_EXISTS;
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index f3b0a8d30a..162baf101f 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -71,6 +71,16 @@ test_expect_success "fetch --recurse-submodules recurses into submodules" '
 	test_i18ncmp expect.err actual.err
 '
 
+test_expect_success "submodule.recurse option triggers recursive fetch" '
+	add_upstream_commit &&
+	(
+		cd downstream &&
+		git -c submodule.recurse fetch >../actual.out 2>../actual.err
+	) &&
+	test_must_be_empty actual.out &&
+	test_i18ncmp expect.err actual.err
+'
+
 test_expect_success "fetch --recurse-submodules -j2 has the same output behaviour" '
 	add_upstream_commit &&
 	(
-- 
2.13.0.18.g7d86cc8ba0

