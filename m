Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FA3A1F406
	for <e@80x24.org>; Mon, 14 May 2018 21:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752580AbeENV5r (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 17:57:47 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:37756 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752567AbeENV5p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 17:57:45 -0400
Received: by mail-it0-f74.google.com with SMTP id o8-v6so11834888itf.2
        for <git@vger.kernel.org>; Mon, 14 May 2018 14:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=QK9b45t5xm7KCkPeHV3qaGT2BIgPkplVTgDj0g6olIM=;
        b=lvuQcoeMX5jYsKtF7r+r4Y0yzObPW1LGf9UYlnrsZJMEoF8FunSgeU+NKkSh2dpELj
         8LV98RHy/dlZBKt0Aa2b2B1m3nktBRUDFKlJsvJf1ye8HwyKKUFY9DD56/bI6H/m7+AC
         2Syh7CeuJGqPwb5hxWkZZQNZop2DTNznxPCLb0i17EwqRZM5otj6OJuf+4zHiM82sK2K
         4KXR4K8/4XDAqKXqZWjh9jPT+2dU3X9H+RVkK04V4/rs73NF8sbohpX/iZrpZKsKig7K
         8nmge9xFHSyWFJ0pKjidED5zwHHaELCKhExLV2svAwJZR95LYqaKr7TwrpwiAaktn+Ks
         bd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=QK9b45t5xm7KCkPeHV3qaGT2BIgPkplVTgDj0g6olIM=;
        b=r56uLyomraW8ip3RdY5OZ3nCx1ubJmDIGnloFFj1btiUUPkarQG5tTeEpWz+KvhyHD
         SfuGi/oI5JGmLw2Vhfs0AS2LJ9MvAj7rbnGPq3IUhApGotlW/VVzEReoYmq1zRxW6bZ6
         AsZRfRylDPRIHv/HQCF8yeqeSKOXN6tEh2Jo+S6HEjrcIeWGhs/OO7dZhhugP53wOAd7
         zy+r/xEfzi63/KqCHvakXSVmeoNMIyDb3hAaUArcAi0LD5nTaNnW0P7WrkNejKwUHitY
         YrEPzomsRS1mqWUvyFCqL5svHL0A6/wyJ5doHL4+HFsIXNKrpvDKiDVPCrlncrL5RbfC
         twLA==
X-Gm-Message-State: ALKqPwc4i9/HWB0Y2PAFtB93zuKVpCt5LaFGkjwYZaxpts6FBN2uDQcx
        VmCi7EX2Jw4q6OaVpd7oKcw6KW12KxcV1S/Zf1cBBp6S0BQrxEBL4LWi5ZEN0M3oo5lhV0LvPP/
        /b2TUr4EXs3edhnOEkXGcZF4jxMSPu0gLVCcun9ROkm4/v0d9+pBFosWs1A==
X-Google-Smtp-Source: AB8JxZpWjVkP3GBv3F7qIYDHTTwBMP5A3mFfaIDOdti5y2n2bdr50REoIqd8WMaY72I5wvM+9+KB6iVw5Ik=
MIME-Version: 1.0
X-Received: by 2002:a24:f90b:: with SMTP id l11-v6mr13818531ith.53.1526335064555;
 Mon, 14 May 2018 14:57:44 -0700 (PDT)
Date:   Mon, 14 May 2018 14:56:18 -0700
In-Reply-To: <20180514215626.164960-1-bmwill@google.com>
Message-Id: <20180514215626.164960-28-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH 27/35] push: check for errors earlier
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the error checking for using the "--mirror", "--all", and "--tags"
options earlier and explicitly check for the presence of the flags
instead of checking for a side-effect of the flag.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/push.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 6b7e45890..df5df6c0d 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -417,23 +417,6 @@ static int do_push(const char *repo, int flags,
 	if (push_options->nr)
 		flags |= TRANSPORT_PUSH_OPTIONS;
 
-	if ((flags & TRANSPORT_PUSH_ALL) && refspec) {
-		if (!strcmp(*refspec, "refs/tags/*"))
-			return error(_("--all and --tags are incompatible"));
-		return error(_("--all can't be combined with refspecs"));
-	}
-
-	if ((flags & TRANSPORT_PUSH_MIRROR) && refspec) {
-		if (!strcmp(*refspec, "refs/tags/*"))
-			return error(_("--mirror and --tags are incompatible"));
-		return error(_("--mirror can't be combined with refspecs"));
-	}
-
-	if ((flags & (TRANSPORT_PUSH_ALL|TRANSPORT_PUSH_MIRROR)) ==
-				(TRANSPORT_PUSH_ALL|TRANSPORT_PUSH_MIRROR)) {
-		return error(_("--all and --mirror are incompatible"));
-	}
-
 	if (!refspec && !(flags & TRANSPORT_PUSH_ALL)) {
 		if (remote->push.raw_nr) {
 			refspec = remote->push.raw;
@@ -625,6 +608,20 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		die(_("--delete is incompatible with --all, --mirror and --tags"));
 	if (deleterefs && argc < 2)
 		die(_("--delete doesn't make sense without any refs"));
+	if (flags & TRANSPORT_PUSH_ALL) {
+		if (tags)
+			die(_("--all and --tags are incompatible"));
+		if (argc >= 2)
+			die(_("--all can't be combined with refspecs"));
+	}
+	if (flags & TRANSPORT_PUSH_MIRROR) {
+		if (tags)
+			die(_("--mirror and --tags are incompatible"));
+		if (argc >= 2)
+			die(_("--mirror can't be combined with refspecs"));
+	}
+	if ((flags & TRANSPORT_PUSH_ALL) && (flags & TRANSPORT_PUSH_MIRROR))
+		die(_("--all and --mirror are incompatible"));
 
 	if (recurse_submodules == RECURSE_SUBMODULES_CHECK)
 		flags |= TRANSPORT_RECURSE_SUBMODULES_CHECK;
-- 
2.17.0.441.gb46fe60e1d-goog

