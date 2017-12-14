Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9137D1F404
	for <e@80x24.org>; Thu, 14 Dec 2017 21:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753702AbdLNVpH (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 16:45:07 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:33300 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753629AbdLNVo7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 16:44:59 -0500
Received: by mail-it0-f66.google.com with SMTP id o130so26955298itg.0
        for <git@vger.kernel.org>; Thu, 14 Dec 2017 13:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=9/bArT6Pn2D4IWdMYcP2A+gid6W0G3P7tzFS2Tqbxg0=;
        b=ZurMk2/toVmCTg8EArv/6FTEwJCDCxZTUAvIYog9WbrRcyz7p62VoBeIB1ARzszThz
         RNjuhgvj5bFM+yYQ7wASO8qLR2jXQg8GELS9G1ClNvxcEXoqw7wBm9BRwryLN6MjdCmF
         oMRjmC1SRaqNLGm2K7u2p64hhuDkfpl0uuY0AKrN25bZ2Y7oMKuGV7syps/RhCuF83at
         MU6owc8Mygt/sE19bl/PZPcuA2O3YDAWsjg/GNiMJvlkbDxuiWxOwc8pFsJbi2Od9c3K
         k4w+Tgbu8OkQIESA99zaOQFdL205r7+6nZn559BtFmqoVcctXU9rbQhLLd8AWaTMY7ov
         rshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=9/bArT6Pn2D4IWdMYcP2A+gid6W0G3P7tzFS2Tqbxg0=;
        b=qi8IhiNM4fv9AtbaQvUEcX+RqL/kDwf6GqbRE41Ly0Uo5ZJjFr+3doCM19AwEc2XPI
         n47MzeoON76UoYeBy/mD7+E//istaSWBFPcy1QGYZ0NveUoPHPGX+is8qQ3CgF/jB61J
         KlkBlMBY3IjYYSexoWJD4Rxw96nmuqyy5S+mZ4Lp5oOAXbHsL/k4KvkccHSAGqqgpgXu
         nEkoB9DZtilE9joD7+cmbhJvX0pMQl0ujwPeRaW8UbcT3Q0A3XJbs386YlGJe4NJxXFb
         lWv/9I4EoAii+wiErX/1QObdWNc4S5q8UhBLpmUxwBf5mP2CZH6BhR2jVeqwyxMPN5zo
         7vig==
X-Gm-Message-State: AKGB3mJH/275LDBqTwZZhRTAoDLkKliwIq0rEFjIKRV3/RT6Fv7Egsr1
        AS0e1TYFClr3DTM7lY7qi70A6ni/TJQ=
X-Google-Smtp-Source: ACJfBovaOdcu6bADlj5duItZJgjF3yst75kd5Q6fwhh55z4NlASAGMlVnaZGTiE0lRI79VboSATntw==
X-Received: by 10.107.133.37 with SMTP id h37mr9112725iod.257.1513287898322;
        Thu, 14 Dec 2017 13:44:58 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([100.96.218.44])
        by smtp.gmail.com with ESMTPSA id q82sm3079498itb.7.2017.12.14.13.44.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Dec 2017 13:44:57 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, spearce@spearce.org
Subject: [PATCH 1/2] clone, fetch: remove redundant transport check
Date:   Thu, 14 Dec 2017 13:44:44 -0800
Message-Id: <d1fd27a5a102129aa16ecf6e6c19014f7b60b543.1513287544.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.15.1.32.g801bf3c5d
In-Reply-To: <cover.1513287544.git.jonathantanmy@google.com>
References: <cover.1513287544.git.jonathantanmy@google.com>
In-Reply-To: <cover.1513287544.git.jonathantanmy@google.com>
References: <cover.1513287544.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prior to commit a2d725b7bdf7 ("Use an external program to implement
fetching with curl", 2009-08-05), if Git was compiled with NO_CURL, the
get_refs_list and fetch methods in struct transport might not be
populated, hence the checks in clone and fetch. After that commit, all
transports populate get_refs_list and fetch, making the checks in clone
and fetch redundant. Remove those checks.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/clone.c | 3 ---
 builtin/fetch.c | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index dbddd98f8..979af0383 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1083,9 +1083,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		warning(_("--local is ignored"));
 	transport->cloning = 1;
 
-	if (!transport->get_refs_list || (!is_local && !transport->fetch))
-		die(_("Don't know how to clone %s"), transport->url);
-
 	transport_set_option(transport, TRANS_OPT_KEEP, "yes");
 
 	if (option_depth)
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 225c73492..09eb1fc17 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1094,9 +1094,6 @@ static int do_fetch(struct transport *transport,
 			tags = TAGS_UNSET;
 	}
 
-	if (!transport->get_refs_list || !transport->fetch)
-		die(_("Don't know how to fetch from %s"), transport->url);
-
 	/* if not appending, truncate FETCH_HEAD */
 	if (!append && !dry_run) {
 		retcode = truncate_fetch_head();
-- 
2.15.1.504.g5279b80103-goog

