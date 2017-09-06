Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19CA2209AB
	for <e@80x24.org>; Wed,  6 Sep 2017 06:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750852AbdIFG6L (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 02:58:11 -0400
Received: from 1.mo176.mail-out.ovh.net ([178.33.254.253]:52346 "EHLO
        1.mo176.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750786AbdIFG6L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 02:58:11 -0400
Received: from ex2.mail.ovh.net (gw1.ex2.mail.ovh.net [164.132.80.186])
        by mo176.mail-out.ovh.net (Postfix) with ESMTPS id 3749E82B89
        for <git@vger.kernel.org>; Wed,  6 Sep 2017 08:48:07 +0200 (CEST)
Received: from [10.0.2.127] (86.200.152.136) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 6 Sep
 2017 08:48:06 +0200
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Subject: [PATCHv3 1/2] pull: fix cli and config option parsing order
To:     <git@vger.kernel.org>
References: <884cd3b0-7eeb-b711-2c7f-f93a57a009ee@morey-chaisemartin.com>
Openpgp: preference=signencrypt
Message-ID: <ff1869cf-cee3-bf28-7cb0-ac8821e25887@morey-chaisemartin.com>
Date:   Wed, 6 Sep 2017 08:48:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:56.0) Gecko/20100101
 Thunderbird/56.0
MIME-Version: 1.0
In-Reply-To: <884cd3b0-7eeb-b711-2c7f-f93a57a009ee@morey-chaisemartin.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: fr-xx-classique+reforme1990
Content-Transfer-Encoding: 7bit
X-Originating-IP: [86.200.152.136]
X-ClientProxiedBy: CAS1.indiv2.local (172.16.1.1) To EX7.indiv2.local
 (172.16.2.7)
X-Ovh-Tracer-Id: 11107847009778329565
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelledrvdelgdduudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenuc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

pull parses first the cli options and then the config option.
The expected behavior is the other way around, so that config
options can not override the cli ones.

This patch changes the parsing order so config options are
parsed first.

Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
---
 builtin/pull.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 7fe281414..9ef1ab501 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -815,6 +815,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (!getenv("GIT_REFLOG_ACTION"))
 		set_reflog_message(argc, argv);
 
+	git_config(git_pull_config, NULL);
+
 	argc = parse_options(argc, argv, prefix, pull_options, pull_usage, 0);
 
 	parse_repo_refspecs(argc, argv, &repo, &refspecs);
@@ -825,8 +827,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (opt_rebase < 0)
 		opt_rebase = config_get_rebase();
 
-	git_config(git_pull_config, NULL);
-
 	if (read_cache_unmerged())
 		die_resolve_conflict("pull");
 
-- 
2.14.1.461.g503560879


