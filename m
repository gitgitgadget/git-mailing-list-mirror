Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78D6C1F406
	for <e@80x24.org>; Mon, 14 May 2018 21:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752620AbeENV57 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 17:57:59 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:59153 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752190AbeENV55 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 17:57:57 -0400
Received: by mail-it0-f73.google.com with SMTP id p11-v6so16026017itb.8
        for <git@vger.kernel.org>; Mon, 14 May 2018 14:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=33VkkJwRWAm8LuFVGGjNvQUAcJ+fvOZ+y86AxgwRoTQ=;
        b=TmMusvVqA0A754yzvC0euRGMA89AkBr3dTQDcCZAdS6k/jf3I2BRfxbvGYF2Dh54H6
         mohhuczbb4lBeVjg/kzZlfXfXBEn60YHcTSr8h7tVRpbyoUFjFo5cz/5BW033PyoKZNo
         3lxbYaA/0fO5cl+QQ5wsx6QYwbKZs30cSgkogZ0FQg6vqG7VbM+bGJAGtCFhjUtV4iEb
         UUI5b4B3S7y9AnD9rB4eDHhjtZJMTGRFnCbGBq/hB2VNBH4FvAwVbPSEuOlTU3Fm2lhl
         Xx8YTeJvax4VCfzueUygzEs/rTof2Gu7qzXLCUJNI5bppHKDOqvc8tMsGV2PGp5XHyHr
         BMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=33VkkJwRWAm8LuFVGGjNvQUAcJ+fvOZ+y86AxgwRoTQ=;
        b=ELTXzlyc5kCkKanlEoNa4jRgCWiXe9LA6LnYvHm4RAibkoRYfxzbRJ5sxD/3yBbPKQ
         NAuA9ZH3ZsCEKdKoNoZd8CrqSOw996jzra45V8RQX3TVQ1zaFbCXz/W9LqYPB8wbYyyn
         CjF65kZEUhx4mny+RVbyuXi/bunSfHFLZ6LX1h5A4RCrAJx+42M5cyxjseSNk4XnSmME
         CAAMI4WkEGgt4SZjmpZkofgtl9C5RGUIlwvK3h55QjWiOi9Tceg8rrf3xkgcY46UBe8N
         Pxo0cvl955wFFcJDhwxShpoZqUNo4u335lLF7koJyDqEpmKQ9gc7LzfPLYqiGkSwms0K
         HVww==
X-Gm-Message-State: ALKqPwe+520lcGjbGxTSM5CV13honQE1oTJ/7mpJ6Bk+Q+60DyJGpQb/
        drk8q7CMjuWCX3Gx3lmjbW81V57TykAIBTHfv3QzyooldyHGayqn1F6GL8/MA/S8MBDTZhpT8IG
        ccHoVDDmX2rgwloK4on1b1btEQonQdCKD3WRuk7H9MDfguzC3X841W6kjog==
X-Google-Smtp-Source: AB8JxZobsuejF+n9SNG3UzO9kuQjWMOcUuk7C8mEcOlRU8GS32ygT0AGeIr/Ehr/ZS5K2iZSdpipHb3Jvnk=
MIME-Version: 1.0
X-Received: by 2002:a24:5a91:: with SMTP id v139-v6mr5603046ita.28.1526335077038;
 Mon, 14 May 2018 14:57:57 -0700 (PDT)
Date:   Mon, 14 May 2018 14:56:23 -0700
In-Reply-To: <20180514215626.164960-1-bmwill@google.com>
Message-Id: <20180514215626.164960-33-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH 32/35] http-push: store refspecs in a struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert http-push.c to store refspecs in a 'struct refspec' instead of
in an array of 'const char *'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 http-push.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/http-push.c b/http-push.c
index f308ce019..a724ef03f 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1692,8 +1692,7 @@ int cmd_main(int argc, const char **argv)
 {
 	struct transfer_request *request;
 	struct transfer_request *next_request;
-	int nr_refspec = 0;
-	const char **refspec = NULL;
+	struct refspec rs = REFSPEC_INIT_PUSH;
 	struct remote_lock *ref_lock = NULL;
 	struct remote_lock *info_ref_lock = NULL;
 	struct rev_info revs;
@@ -1756,8 +1755,7 @@ int cmd_main(int argc, const char **argv)
 			}
 			continue;
 		}
-		refspec = argv;
-		nr_refspec = argc - i;
+		refspec_appendn(&rs, argv, argc - i);
 		break;
 	}
 
@@ -1768,7 +1766,7 @@ int cmd_main(int argc, const char **argv)
 	if (!repo->url)
 		usage(http_push_usage);
 
-	if (delete_branch && nr_refspec != 1)
+	if (delete_branch && rs.nr != 1)
 		die("You must specify only one branch name when deleting a remote branch");
 
 	setup_git_directory();
@@ -1814,18 +1812,19 @@ int cmd_main(int argc, const char **argv)
 
 	/* Remove a remote branch if -d or -D was specified */
 	if (delete_branch) {
-		if (delete_remote_branch(refspec[0], force_delete) == -1) {
+		const char *branch = rs.items[i].src;
+		if (delete_remote_branch(branch, force_delete) == -1) {
 			fprintf(stderr, "Unable to delete remote branch %s\n",
-				refspec[0]);
+				branch);
 			if (helper_status)
-				printf("error %s cannot remove\n", refspec[0]);
+				printf("error %s cannot remove\n", branch);
 		}
 		goto cleanup;
 	}
 
 	/* match them up */
 	if (match_push_refs(local_refs, &remote_refs,
-			    nr_refspec, (const char **) refspec, push_all)) {
+			    rs.raw_nr, rs.raw, push_all)) {
 		rc = -1;
 		goto cleanup;
 	}
-- 
2.17.0.441.gb46fe60e1d-goog

