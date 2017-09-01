Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59DDB208E3
	for <e@80x24.org>; Fri,  1 Sep 2017 07:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751515AbdIAH36 (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Sep 2017 03:29:58 -0400
Received: from 8.mo176.mail-out.ovh.net ([46.105.58.67]:33908 "EHLO
        8.mo176.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751354AbdIAH35 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2017 03:29:57 -0400
Received: from ex2.mail.ovh.net (gw1.ex2.mail.ovh.net [164.132.80.186])
        by mo176.mail-out.ovh.net (Postfix) with ESMTPS id 7A8F087B3A;
        Fri,  1 Sep 2017 09:29:54 +0200 (CEST)
Received: from [10.0.2.127] (86.200.152.136) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 1 Sep
 2017 09:29:38 +0200
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Subject: [PATCH] pull: honor submodule.recurse config option
To:     <git@vger.kernel.org>
CC:     <magnus@homann.se>
References: <eba8e727-25ef-b34b-cd2b-e92602709c9b@homann.se>
Openpgp: preference=signencrypt
Message-ID: <cc70ea38-9980-120f-afaa-af7a6e3a8c36@morey-chaisemartin.com>
Date:   Fri, 1 Sep 2017 09:29:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:56.0) Gecko/20100101
 Thunderbird/56.0
MIME-Version: 1.0
In-Reply-To: <eba8e727-25ef-b34b-cd2b-e92602709c9b@homann.se>
Content-Type: text/plain; charset="windows-1252"
Content-Language: fr-xx-classique+reforme1990
Content-Transfer-Encoding: 7bit
X-Originating-IP: [86.200.152.136]
X-ClientProxiedBy: CAS3.indiv2.local (172.16.1.3) To EX7.indiv2.local
 (172.16.2.7)
X-Ovh-Tracer-Id: 896779277245671186
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelledrudelgdduvddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenuc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git pull used to not parse the submodule.recurse config option and simply
consider the --recurse-submodules CLI option.
When using the config option, submodules would only be fetched recursively
while the CLi option would tigger both fetch and update/merge.

Reported-by: Magnus Homann <magnus@homann.se>
Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
---
 builtin/pull.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/pull.c b/builtin/pull.c
index 7fe281414..e4edf23c5 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -326,6 +326,11 @@ static int git_pull_config(const char *var, const char *value, void *cb)
 		config_autostash = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "submodule.recurse")) {
+		int r = git_config_bool(var, value) ?
+			RECURSE_SUBMODULES_ON : RECURSE_SUBMODULES_OFF;
+		recurse_submodules = r;
+	}
 	return git_default_config(var, value, cb);
 }
 
-- 
2.14.1.460.g196d2604f

