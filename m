Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38B751F453
	for <e@80x24.org>; Fri, 21 Sep 2018 22:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391563AbeIVE1v (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 00:27:51 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:43948 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbeIVE1v (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 00:27:51 -0400
Received: by mail-io1-f74.google.com with SMTP id w19-v6so25729456ioa.10
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 15:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3aVAT3rqLUyaHyBUNyJ+QSsf5/Fz+G3E3OGDfYKpE64=;
        b=mq/IW6FIOl9M0yjmtTzqyzdsTv0DTE2LE6Uy0rDLKAMzar0dB2myzLDSRRYXD54+kB
         1Hgq/DKaWa5N7iYbyAgbQs3PxlFYCSicjrf32gybxtyh2S2XHHOcMD+yQ7uIISI6KPqH
         A+Z3Ob8bISnpcvM10eQGcgmV2JmZpvOuCfvYwMgznyRXBL+gXe4fQhBX2JYxuv+LTTOE
         3FjUJw3l6qMKNaCiIwZm8Eid3yiN0JHUT4Rj4sWaYgnGbu3xsnFq9OPuaWx+7yhONXGF
         P2K+aefUJnoqlNDDSnUCdus9m1RDpnCm4wV1tlVIdH1ENPpL5D1o4QJhn0fcjY3vajUE
         0xtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3aVAT3rqLUyaHyBUNyJ+QSsf5/Fz+G3E3OGDfYKpE64=;
        b=jgA0T95tgtGbYNzb2iA8pZxqqNxNLgbQFG1MBC7jxHVMeBj2bPeP1p+KULUFDmKhgL
         9BFjqh3GACjQMpBsp2BdVt3+eWEYPcGWyk3q+o1QW7Ky412MqKFv6zb+NV0UGAqtdqvE
         PLLDbkq7Y9ecNWsrehN05+3qLSO/wzS9b9k+2iL4Dt9YbEVJzCfCK16vDSWeAjLoNZ61
         W4vAKF+RNb1QnlyjwF0bPAopAeAuB7ie+S6FHbZuuE/0jOIssbEq7kyPPzGinXkk+uXE
         bqskYbIyhWB0gjG9ksMoPjUbC6UaYT20O9Ai17/QfE+Ly6TTxwa908gTMjMcSw335vZB
         qWPg==
X-Gm-Message-State: ABuFfogn3TqabPy005Avie8BkPywk11UbpdE1w3Ews+qXnFdoGuR8fUo
        mFu0QBlMWUI3E9oSsNxfF34FP1aoYTdfCVBKIjEOMv7uk+ShEg6BRbJfeLO3eSxii/zIxwbYDIm
        bV4yv4Fyh6SyLwlxisB0pJ6i3FMYiUk79DoX5YUlN3pHVs6k/k0Pij882uE/d
X-Google-Smtp-Source: ACcGV63lO9esXcmeCjB3aso9YP9j2CurXW5kr0rB0P7l+ldtuO+Rk/wF9bchcgcXziSI/yZfCsI4mwyrgz+C
X-Received: by 2002:a6b:8fd1:: with SMTP id r200-v6mr7371388iod.72.1537569414711;
 Fri, 21 Sep 2018 15:36:54 -0700 (PDT)
Date:   Fri, 21 Sep 2018 15:35:58 -0700
In-Reply-To: <20180921223558.65055-1-sbeller@google.com>
Message-Id: <20180921223558.65055-9-sbeller@google.com>
Mime-Version: 1.0
References: <20180921223558.65055-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH 8/8] builtin/fetch: check for submodule updates for non branch fetches
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gerrit, the code review tool, has a different workflow than our mailing
list based approach. Usually users upload changes to a Gerrit server and
continuous integration and testing happens by bots. Sometimes however a
user wants to checkout a change locally and look at it locally. For this
use case, Gerrit offers a command line snippet to copy and paste to your
terminal, which looks like

  git fetch https://<host>/gerrit refs/changes/<id> &&
  git checkout FETCH_HEAD

For Gerrit changes that contain changing submodule gitlinks, it would be
easy to extend both the fetch and checkout with the '--recurse-submodules'
flag, such that this command line snippet would produce the state of a
change locally.

However the functionality added in the previous patch, which would
ensure that we fetch the objects in the submodule that the gitlink pointed
at, only works for remote tracking branches so far, not for FETCH_HEAD.

Make sure that fetching a superproject to its FETCH_HEAD, also respects
the existence checks for objects in the submodule recursion.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/fetch.c             | 5 ++++-
 t/t5526-fetch-submodules.sh | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e3b03ad3bd3..f2d9e548bf0 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -894,11 +894,14 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 				rc |= update_local_ref(ref, what, rm, &note,
 						       summary_width);
 				free(ref);
-			} else
+			} else {
+				check_for_new_submodule_commits(&rm->old_oid);
 				format_display(&note, '*',
 					       *kind ? kind : "branch", NULL,
 					       *what ? what : "HEAD",
 					       "FETCH_HEAD", summary_width);
+			}
+
 			if (note.len) {
 				if (verbosity >= 0 && !shown_url) {
 					fprintf(stderr, _("From %.*s\n"),
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index af12c50e7dd..a509eabb044 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -615,7 +615,7 @@ test_expect_success "fetch new commits on-demand when they are not reachable" '
 	git update-ref refs/changes/2 $D &&
 	(
 		cd downstream &&
-		git fetch --recurse-submodules --recurse-submodules-default on-demand origin refs/changes/2:refs/heads/my_branch &&
+		git fetch --recurse-submodules origin refs/changes/2 &&
 		git -C submodule cat-file -t $C &&
 		git checkout --recurse-submodules FETCH_HEAD
 	)
-- 
2.19.0.444.g18242da7ef-goog

