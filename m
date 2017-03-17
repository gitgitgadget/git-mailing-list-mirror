Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFB1020951
	for <e@80x24.org>; Sat, 18 Mar 2017 00:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751143AbdCRAg4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 20:36:56 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:36257 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751069AbdCRAgz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 20:36:55 -0400
Received: by mail-pg0-f54.google.com with SMTP id g2so50310984pge.3
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 17:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sX86MwLp1hHSigfr+M4cIGF8n9e85LMoDXF8nbX54/4=;
        b=vVmIzeVV8F9qFSdNpAR/rquRn2wBv8IKDQHWp4HOcVra72ZLG8sFDkxiNWCAh+cIpP
         N+JXsQ9ftzbuHrirGncURFMZQfa5TYenXqL05Utbtn9q7EV5a+yrMAHaumwOySOxIP5c
         4d3SnLC9lLQ4VALrYZurLIlLU9B0buKgE8rQCzqvIXXZL21M8RzF7zpui0c7JviwrhHe
         En+gpUndG5MfqMo2t2Z9zfFLfhSflM4eO5JA2+wIwB4h+s87BICOazWSXHa14xhsHOjF
         4jqRUxCbZ8jIf76oyTYOz/X5pgZdDC+O+halo2p7YPr4hK/TdZHvy0XpS5Nl7tNq81fJ
         7koA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sX86MwLp1hHSigfr+M4cIGF8n9e85LMoDXF8nbX54/4=;
        b=PzXR7/eCDpXfyFMmXIrdLlDr/R1d4+iMHJ5Vga4zf96acrqvw27HekhJPxJi/de58o
         7zq/joqpsCs2GT5GWf6EgAbL1qTy+JR+NfR0Ou5duh1OUEf/TyyrCwS22kl666hFTHQM
         V3Mq5o9blN2au0pydFAmEoblyrtO+pO29N1PTKVuGYmBTxCXXQvjUoXGY2pkiMfUhqz+
         mNjPDInsjuP913YQ58HJOozm27vva9VqF0BCrpqezbtUw7YjsFlJuwUV2MWxuq9SD0Ob
         NWiiwiqaOyUX2HtJG315nlq/z61FWqP4UubEIBA3Qk/nA8l1TPkYbXtNyy+hkpoW4uBh
         xU/A==
X-Gm-Message-State: AFeK/H3imijL297u8VjzXQ7RMY5RwBut2hq6gCxn6Sq6VK0ad9fOlhWHJkhPh2lzGyEYAOhN
X-Received: by 10.99.36.5 with SMTP id k5mr18446455pgk.201.1489790300760;
        Fri, 17 Mar 2017 15:38:20 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id d3sm18699763pfc.51.2017.03.17.15.38.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 15:38:19 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v5 04/10] submodule sync: use submodule--helper is-active
Date:   Fri, 17 Mar 2017 15:37:59 -0700
Message-Id: <20170317223805.95271-5-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.367.g23dc2f6d3c-goog
In-Reply-To: <20170317223805.95271-1-bmwill@google.com>
References: <20170316222952.53801-1-bmwill@google.com>
 <20170317223805.95271-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 git-submodule.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 577136148..db94dea3b 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1089,14 +1089,14 @@ cmd_sync()
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode" "$sha1"
-		name=$(git submodule--helper name "$sm_path")
 
 		# skip inactive submodules
-		if ! git config "submodule.$name.url" >/dev/null 2>/dev/null
+		if ! git submodule--helper is-active "$sm_path"
 		then
 			continue
 		fi
 
+		name=$(git submodule--helper name "$sm_path")
 		url=$(git config -f .gitmodules --get submodule."$name".url)
 
 		# Possibly a url relative to parent
-- 
2.12.0.367.g23dc2f6d3c-goog

