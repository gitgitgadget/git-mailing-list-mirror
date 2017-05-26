Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19B891FA14
	for <e@80x24.org>; Fri, 26 May 2017 19:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S944589AbdEZTKs (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 15:10:48 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36755 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934044AbdEZTKb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 15:10:31 -0400
Received: by mail-pf0-f169.google.com with SMTP id m17so19304237pfg.3
        for <git@vger.kernel.org>; Fri, 26 May 2017 12:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5oqMTj5igpHhVZwR1dDRcqfVvjTRwTDv3RPHTPp9mQE=;
        b=rntFusXxJFfju5ydsWHOxd/ciuik/vtv3u/VhYzsYzLy/RLbL+4YAnw7wN+38LHd05
         NF5VfX7C4JkiHLZsj0dql7Eb8nmvT1s+dY+kbhn01/PTsEK40PPc31pio0vRkS997qEA
         bzbTHCWfOPujwT7CoKBwMC8CgK0AMovItb5FiGZDCZg9G2E8tBJ6DxZBFAeiXUzA4pjA
         uEvHail7rhV1IbcpIfpMkFYpVtBm2/jrPo/J0uWVALmFHUkdCeJ7fdvhccunsYlbDMvx
         2aLzGImbD5XOT/Q9hHgbZ6P1LqEjhKiszlo+6kRONJLr3NfjvKa23nJ5dsOauFgpEe6B
         loRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5oqMTj5igpHhVZwR1dDRcqfVvjTRwTDv3RPHTPp9mQE=;
        b=ilISvkAw9zYOGv6s2TsCD3C6dkehp9lyjskn/QIZASeW7Osf8CJE3+buOzUc66FE69
         khPVmn5w8zKSwVv/mFHMxCevYK14FLUGrHUl0QZOGb38FbPgNpnpieYJqLSuqvg9HaV9
         05GWqYKraaloPZPyoXbx9sOe7aRzS+Xrx16nhOpDvwaUVvm9qnI5oPjGIMaTlqxZ4Sps
         8q+Lnz7QQSOkZxw+ckBJA1aThzxxX6gdhxFRrEcanA7Pz1CTe20N8DzJzEQMtzIo4i/3
         yU0DEne/G1AmTSY5CnWUqtwUMWA/ICPrBIzJqgG1YeN1DpRmaqWECTkOD8JW7ugbY0Ts
         vRSQ==
X-Gm-Message-State: AODbwcDpS7VhYqkxXPaiXuumCLnMFlS+gYy6QsVS+QOlzLt4qhR+H5vG
        QKIDQY1/0aOEMJ1o
X-Received: by 10.98.70.198 with SMTP id o67mr4040716pfi.79.1495825830493;
        Fri, 26 May 2017 12:10:30 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:818a:1f3a:57c6:8d29])
        by smtp.gmail.com with ESMTPSA id g86sm3573602pfe.116.2017.05.26.12.10.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 26 May 2017 12:10:29 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 8/8] builtin/fetch.c: respect 'submodule.recurse' option
Date:   Fri, 26 May 2017 12:10:17 -0700
Message-Id: <20170526191017.19155-9-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.17.g582985b1e4
In-Reply-To: <20170526191017.19155-1-sbeller@google.com>
References: <20170526191017.19155-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/fetch.c             |  7 +++++++
 t/t5526-fetch-submodules.sh | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 5f2c2ab23e..c1ec3b03c3 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -73,6 +73,13 @@ static int git_fetch_config(const char *k, const char *v, void *cb)
 		fetch_prune_config = git_config_bool(k, v);
 		return 0;
 	}
+
+	if (!strcmp(k, "submodule.recurse")) {
+		int r = git_config_bool(k, v) ?
+			RECURSE_SUBMODULES_ON : RECURSE_SUBMODULES_OFF;
+		recurse_submodules = r;
+	}
+
 	return git_default_config(k, v, cb);
 }
 
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
2.13.0.17.g582985b1e4

