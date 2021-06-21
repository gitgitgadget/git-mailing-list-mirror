Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE20BC4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 19:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D48D06128A
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 19:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhFUTLQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 15:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhFUTLO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 15:11:14 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB89C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 12:08:59 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 13-20020a17090a08cdb029016eed209ca4so627748pjn.1
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 12:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eSifAKwtOJd+nhbHSqSbRWiFUlwMoPlC7uRbfvQqhD8=;
        b=tzax9iuXbSEl2f2li8enoNqIAnn6jlRAFSff4JRA559MsQygJcnrvELuCD42co75gH
         d5mEC/gqdF4pjROqkFCFdOtdcj45O6heSJkCTqIhdBKc57krBmeVlPIiPJjS0/Xj93Lu
         4YfWedW6uHfhFrzm+h4cXk9Xmc9GL1kqmfciT6GoYLgVO/dWtIc/BLhwpxuF4MkrQgAF
         IDZhJ2nLTsxRez65Pi1NZ/l60qAhCYoeMptwR9xdTBNtEW5DGXqX7DaofxwkqBf9ee3C
         bMZRPG1acJS8SBPoCG8i36Z5CtBgWkzJUFf6ZW3JJlda+IuuN1in4NPuy4C8WAzyoLDF
         nt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eSifAKwtOJd+nhbHSqSbRWiFUlwMoPlC7uRbfvQqhD8=;
        b=guynekwTHuJ4icbgvKe4Q8ESUyhyvcMM43puuq1YUSr5KYcV0yjn1jq7lzxRMBw9ZQ
         SONjnUy+UIUVcfAUHtcXFoDfk8KVqt/n0lfxKoklhqS4GaSnLwKplR1C+ZT/sdYoIbw/
         BUTLZxFhD/YTD53dGaSo4JkHIrgA+SXVy5TOSK6/eZKi3kwiychIVMEKO5w/l8Cx7a7U
         KJ838OJ8ImzDECIa5IkogiiFGxmoxbUmKeRY1czNLLqr2azq1s8EuY6s0hP5JDKWs+yo
         AUFpudQGaIPkGlUyulc7xjfgfVu4rT5X7wgwNNpU0p23IM/dQP4UD/MgawVCDOYA5b5y
         R19g==
X-Gm-Message-State: AOAM532O3y+MNt3TqI/owrqeC4zh+WF8La5mu02oxSpP5hk/1MAwgiWs
        NrAC0cS45G+W5+YR5krTCd2TD1VOphEUnQ==
X-Google-Smtp-Source: ABdhPJzzs5GQVrUw18UVdbGJN0gE3AhUbgGaMZ3lyXsWF68AMLBuTm2iWCFLOO2viHsYljQvA1nVLg==
X-Received: by 2002:a17:902:d50b:b029:121:b5c8:b246 with SMTP id b11-20020a170902d50bb0290121b5c8b246mr16683108plg.51.1624302538614;
        Mon, 21 Jun 2021 12:08:58 -0700 (PDT)
Received: from localhost.localdomain ([49.205.82.114])
        by smtp.gmail.com with ESMTPSA id i125sm16256991pfc.7.2021.06.21.12.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 12:08:58 -0700 (PDT)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH 2/2] submodule: remove unnecessary `prefix` based option logic
Date:   Tue, 22 Jun 2021 00:38:37 +0530
Message-Id: <20210621190837.9487-3-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.32.0.9.g81a5432dce.dirty
In-Reply-To: <20210621190837.9487-1-kaartic.sivaraam@gmail.com>
References: <20210621190837.9487-1-kaartic.sivaraam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Over time when parts of submodule have been ported from shell to
builtin, many instances of the submodule helper have been added.
Also added with them are some unnecessary option passing
logic that are based on the `prefix` shell variable which never
gets set in their code flows.

On analysis, the only shell functions which have a valid usage
for the `prefix` shell variable are:

    - cmd_update: which is the only function which sets the variable
      and thus uses it properly

    - cmd_init: which uses the variable via a call from cmd_update

So, remove the unnecessary option parsing logic based on the `prefix`
shell variable.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 git-submodule.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 4678378424..cb06aa02c8 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -335,7 +335,7 @@ cmd_foreach()
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper foreach ${GIT_QUIET:+--quiet} ${recursive:+--recursive} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper foreach ${GIT_QUIET:+--quiet} ${recursive:+--recursive} -- "$@"
 }
 
 #
@@ -402,7 +402,7 @@ cmd_deinit()
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper deinit ${GIT_QUIET:+--quiet} ${prefix:+--prefix "$prefix"} ${force:+--force} ${deinit_all:+--all} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper deinit ${GIT_QUIET:+--quiet} ${force:+--force} ${deinit_all:+--all} -- "$@"
 }
 
 is_tip_reachable () (
@@ -726,7 +726,7 @@ cmd_set_branch() {
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper set-branch ${GIT_QUIET:+--quiet} ${branch:+--branch "$branch"} ${default:+--default} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper set-branch ${GIT_QUIET:+--quiet} ${branch:+--branch "$branch"} ${default:+--default} -- "$@"
 }
 
 #
@@ -755,7 +755,7 @@ cmd_set_url() {
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper set-url ${GIT_QUIET:+--quiet} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper set-url ${GIT_QUIET:+--quiet} -- "$@"
 }
 
 #
@@ -807,7 +807,7 @@ cmd_summary() {
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper summary ${prefix:+--prefix "$prefix"} ${files:+--files} ${cached:+--cached} ${for_status:+--for-status} ${summary_limit:+-n $summary_limit} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper summary ${files:+--files} ${cached:+--cached} ${for_status:+--for-status} ${summary_limit:+-n $summary_limit} -- "$@"
 }
 #
 # List all submodules, prefixed with:
@@ -848,7 +848,7 @@ cmd_status()
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper status ${GIT_QUIET:+--quiet} ${cached:+--cached} ${recursive:+--recursive} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper status ${GIT_QUIET:+--quiet} ${cached:+--cached} ${recursive:+--recursive} -- "$@"
 }
 #
 # Sync remote urls for submodules
@@ -881,7 +881,7 @@ cmd_sync()
 		esac
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper sync ${GIT_QUIET:+--quiet} ${recursive:+--recursive} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper sync ${GIT_QUIET:+--quiet} ${recursive:+--recursive} -- "$@"
 }
 
 cmd_absorbgitdirs()
-- 
2.32.0.9.g81a5432dce.dirty

