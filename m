Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB20C20951
	for <e@80x24.org>; Fri, 17 Mar 2017 23:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751121AbdCQXJe (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 19:09:34 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35642 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751023AbdCQXJe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 19:09:34 -0400
Received: by mail-pf0-f170.google.com with SMTP id x63so37923959pfx.2
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 16:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W3gGLRnSG8ooSNd0/KA5/CS+ifjvdfjx3Ep0x+xdyFA=;
        b=aAFKAcawx7K4p7yZ1ldrbpS0W+EmJgU+qUfSQ3ckjKjAhy0l51GXXU5/Za/gc88iSN
         zaQikjdjySJPpsfTxRVuuLp5peeBefxl8X7Z12TydL2zC7IGT7dFX5goyAGDln6O0LwR
         4RVxmwT/LXc0TNBPvEQ0UrIGqc65/bgRdsfbirOQ0m2Go07mcwWsSrjDaYi7OEJQ66Bs
         n9bymju0BUE4j5+Wze8P7ISuz5UEhbFMfCXKD9OtI5ItE6G/uX+lo85N3FheosqFg3hx
         lGCze3e68qg3rqIKFtWdpY/tByGsPNduO8qCc79kSlJhLdyx0/Frh121bBWzqYOb30y4
         n+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W3gGLRnSG8ooSNd0/KA5/CS+ifjvdfjx3Ep0x+xdyFA=;
        b=ojCMvcI9gJkMEEjY3bRGuJeSZay1HBfDqqxneVMlVRTW7TPpe4O4RxQrTliRIF9HGX
         sDyPLMCoBVKkMd8106iklkm4kKPwru8ragBWmHv6A4daV/0vGrUIvexIAZ4IpFPxzZ63
         yR8VSy54FGVuvQYTGEx+bXI+++k4BytTMAzghW3gr1uurk8ly4StpV8jLKqEXC7p5nLn
         +rgM0cUOpCzksW9oM37iUNXpKxkPyrr/6TkTOzUJbEVxaqR+FTvvaTUJmeVF7w3bV6FV
         q7j7pCJ/3HsdHsDIWBPrk+at5O2ggH1yFADrYxsJ4GINdRRmb+wMy6oHuSExLQRXMzrB
         FlFA==
X-Gm-Message-State: AFeK/H12//+hrRbOeah9appvwTjtAsLci1HNz3guq9PcrwZN5rWW5Ec0SqsWxi932efPxFm/
X-Received: by 10.99.67.1 with SMTP id q1mr19048527pga.210.1489790297828;
        Fri, 17 Mar 2017 15:38:17 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id d3sm18699763pfc.51.2017.03.17.15.38.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 15:38:16 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v5 02/10] submodule status: use submodule--helper is-active
Date:   Fri, 17 Mar 2017 15:37:57 -0700
Message-Id: <20170317223805.95271-3-bmwill@google.com>
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
 git-submodule.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 136e26a2c..ab233712d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1010,14 +1010,13 @@ cmd_status()
 	do
 		die_if_unmatched "$mode" "$sha1"
 		name=$(git submodule--helper name "$sm_path") || exit
-		url=$(git config submodule."$name".url)
 		displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
 		if test "$stage" = U
 		then
 			say "U$sha1 $displaypath"
 			continue
 		fi
-		if test -z "$url" ||
+		if ! git submodule--helper is-active "$sm_path" ||
 		{
 			! test -d "$sm_path"/.git &&
 			! test -f "$sm_path"/.git
-- 
2.12.0.367.g23dc2f6d3c-goog

