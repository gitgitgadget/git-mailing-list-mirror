Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF55320953
	for <e@80x24.org>; Thu, 16 Mar 2017 22:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754630AbdCPWiE (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 18:38:04 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34917 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752333AbdCPWiB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 18:38:01 -0400
Received: by mail-pf0-f174.google.com with SMTP id x63so25259030pfx.2
        for <git@vger.kernel.org>; Thu, 16 Mar 2017 15:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sX86MwLp1hHSigfr+M4cIGF8n9e85LMoDXF8nbX54/4=;
        b=esc+iuz4gAhcm8zC75luD8dTw9cb/sxjOA5t3J4Oy51/kzXZDnJwCqdRXCRCMOz/lK
         Zi9mFN8tvwQCuLVf/jdQ2lokDTao6fqny/CxBQcKRUTFv2Xp/YOFOjuNb3UHFfgi7sV/
         D6BRQ3GuZ8jC+YFrCKKtHCRyfCwY1TZLYQNPKRv6KeI4opo9N0A5sA7x+YwR6/LgmGne
         4+WGYf5drNrjXV9d9N9Wk0Eks01x9l6nctN75ogi16EPYWUJGxOXGmkyn9jeRPZm6o1O
         PfwGETHOoP4hZQ9k5psvfZIKh3K5MDKsK9D3zGoE5YBkxzGfhMlK6JGZBh6o+5lr2W2z
         icig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sX86MwLp1hHSigfr+M4cIGF8n9e85LMoDXF8nbX54/4=;
        b=FOP008zFj36ZFadx5VDZ7bweSjGrRsb3aq36WbxxdGPAVli4WaJG8+rZzbhDRNa7Xi
         n/WLIvQnSwR6HqiYFkZairK3WdMKtcvwrWKLhKE0ZYUdvFaxNGopEBJB6V0qqoXr+ilz
         10J5hi9fcHD2bOAytcQyO9MszWo8tterbpaL2Y3vD7uHD+9CEwmFA911ql4lf6+FecoP
         Dl7W7YTSX7K+9I3drsI435LofHRuRwDAZ7RRxjSeGZrcjcToIL69iZtrBuPaUxe7LPz2
         /gxcgcEmuRW5qv8/UriTg0ZmmaaD3ZeaLFCx0LkDLh8MEgDKrag6sCYIfBPx2uNZMjf2
         25VQ==
X-Gm-Message-State: AFeK/H3iKkuCrPLWlIzBmUJ9EpsLuPIPNMUMpA7k90oyS4RBZhUIvmOAVDZFaex34rA5bmLO
X-Received: by 10.84.241.3 with SMTP id a3mr5224688pll.47.1489703404885;
        Thu, 16 Mar 2017 15:30:04 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id t5sm12520946pgb.36.2017.03.16.15.30.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Mar 2017 15:30:03 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v4 04/10] submodule sync: use submodule--helper is-active
Date:   Thu, 16 Mar 2017 15:29:46 -0700
Message-Id: <20170316222952.53801-5-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.367.g23dc2f6d3c-goog
In-Reply-To: <20170316222952.53801-1-bmwill@google.com>
References: <20170313214341.172676-1-bmwill@google.com>
 <20170316222952.53801-1-bmwill@google.com>
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

