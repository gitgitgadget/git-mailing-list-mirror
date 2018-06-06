Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 625591F403
	for <e@80x24.org>; Wed,  6 Jun 2018 20:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752810AbeFFUrh (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 16:47:37 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44291 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752552AbeFFUrd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 16:47:33 -0400
Received: by mail-pl0-f66.google.com with SMTP id z9-v6so4538644plk.11
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 13:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0P6wQE5YzBgwzk3GhwRbidr/IyUFLjkrB0OOKU8Yyms=;
        b=j0uLADgpUU/h69xha5u0MfrWdnVeRDmWCtJ0Or3HkrG7PTdPfmf9L6fPOIPf/xyViz
         Y58PUATfPEbQ8Uin/D1HKfxL/OWnTeYI87qhHtAEkFnTNbPxzHX8eBKJPsOIDnYO4pD3
         9RMw3v5dyesk2uqeWM9wfCHATJ1Uqz8K9ENucXnPSPFpvuP3nTmnWEqEsGPyQmVPs8bC
         7YU8u+yHrVU7TJASBrpywsE2vjTAhqKHrrL95xO565GkqylCydQsx1LUEoFKA9klJeb7
         ljqB4av3pjY8bwSR5egh0Q3j26zHJmO0IVdHLZMf/gq9yyYH93W8Lak4bZDMlGa/UQiL
         5KwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0P6wQE5YzBgwzk3GhwRbidr/IyUFLjkrB0OOKU8Yyms=;
        b=FeRaofg4ohdyp7T+foPMWl5wHDkhPUMwyoWTxlYZBOa7zvs9IGk7Ksot9fz2e2apGH
         ZcMa9DEOeOwp3Vg08i2+jiazLWxMMUTyaPkH7618gd3vdNdmdR7Z60djZ2uP5BmI0nwO
         cUISn0xtyvGcUYqmgihH7Yy3LpMMWJVab/q6vOLrpV5dXBDnhHpVm67+hYIaL6XckyTP
         bCiq6PqhJJcG2y4ukkk/1DCdU7Q1RoKwGYhTmpSb4gUlfMBMTYpWc6u4kNe+MWeJjRiP
         sF73mmLnp+P6lrnaXCFrn5ToU+WhlbJssnDc0opoAfTUUvETnhbVYtWt1Mujmxrly9Vx
         kJ4w==
X-Gm-Message-State: APt69E0rl5cnzUb2LnphfQwemUGv03RkobLTrx3Sn+QI7uEWCy4bfpaf
        3G2mQOT8+T59yEvBPJVg+ww7iRMjJ7A=
X-Google-Smtp-Source: ADUXVKJ0vgTibzUFIvXzNKFODpchNE6c5GTyyjLb1V9lRUJtjB5yjy1hYm7kLw/oBU6EPH7F/sSgCQ==
X-Received: by 2002:a17:902:b494:: with SMTP id y20-v6mr4110773plr.136.1528318052138;
        Wed, 06 Jun 2018 13:47:32 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id m1-v6sm20703323pfh.155.2018.06.06.13.47.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 13:47:30 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com
Subject: [PATCH v2 6/8] fetch-pack: move common check and marking together
Date:   Wed,  6 Jun 2018 13:47:12 -0700
Message-Id: <40f3e50ad41ecddf33b3d1b68f507f9e76ab0517.1528317619.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.768.g1526ddbba1.dirty
In-Reply-To: <cover.1528317619.git.jonathantanmy@google.com>
References: <cover.1527894919.git.jonathantanmy@google.com> <cover.1528317619.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When receiving 'ACK <object-id> continue' for a common commit, check if
the commit was already known to be common and mark it as such if not up
front. This should make future refactoring of how the information about
common commits is stored more straightforward.

No visible change intended.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index c31644bb9..4a4ec4da3 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -499,11 +499,14 @@ static int find_common(struct data *data, struct fetch_pack_args *args,
 				case ACK_continue: {
 					struct commit *commit =
 						lookup_commit(result_oid);
+					int was_common;
 					if (!commit)
 						die(_("invalid commit %s"), oid_to_hex(result_oid));
+					was_common = commit->object.flags & COMMON;
+					mark_common(data, commit, 0, 1);
 					if (args->stateless_rpc
 					 && ack == ACK_common
-					 && !(commit->object.flags & COMMON)) {
+					 && !was_common) {
 						/* We need to replay the have for this object
 						 * on the next RPC request so the peer knows
 						 * it is in common with us.
@@ -520,7 +523,6 @@ static int find_common(struct data *data, struct fetch_pack_args *args,
 					} else if (!args->stateless_rpc
 						   || ack != ACK_common)
 						in_vain = 0;
-					mark_common(data, commit, 0, 1);
 					retval = 0;
 					got_continue = 1;
 					if (ack == ACK_ready)
-- 
2.17.0.768.g1526ddbba1.dirty

