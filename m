Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB0D31F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 21:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbeJKFPJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 01:15:09 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:39077 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbeJKFPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 01:15:09 -0400
Received: by mail-vk1-f201.google.com with SMTP id y83-v6so2502282vky.6
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 14:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=K2sUjtliowoUR75xLeTIpXUX4me2YUXUkwJgta0pQ0o=;
        b=hwNBL0DQD8km1VJ9ucQj4VXoY2WY5lbskZiSvTkV9RyZCxZBNeKQm5hvuYMijbdFDd
         AOnmPJZp8OQaHJUWIKd9wDn+O6pysG7gRWKmb+ibX6i/tk3QnatcwNXpshgj5aogz5Zk
         ok3sG97NbOANcHtacPzuA5CdTlFKrpcBTGJAUQyTp7nsbeN++4KFMkYoBmaRKJZEXOh2
         nZsCy1sartp5My8Po8EG8ngYo5RITva+iTTuLa5s95iNUQ5WQkWSQCtlMtYiZ7bAVD8P
         MsBtOmLJpLP8PL8YRNXBGhjs+U3vw5qH1kByFx/EgUE0ryvmzfD+hdw6vBOpFf2yVJ26
         oaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=K2sUjtliowoUR75xLeTIpXUX4me2YUXUkwJgta0pQ0o=;
        b=hf0imcPhe0DzkaFlK1YcaFYLShXH32nnToDpqmdExqIhX0N2X4qSvvortLWYWf2ix+
         SfQwIV3SWmJxYmXPORIUBI+XXpAfZYXiebYtekA3EPvaTxhp7PQfxrtTFYAORjuvS/t0
         cMmVWbdjTHgBpDfpkdUciPgk0mUlqoiHZi5hD1feQECRj8inoCJbrcITZNMNUsLxzFlT
         tg/tRItTvFaM1JlLJirdkXetKf+OSpWk4XABsUZDrGYAR+BcM8m+oZ3JG5NtZp6KDENy
         RASGD0mdLBV6gxrw/gv5rGQqDKHoCQKN29k7bFNCPrTctLQ3sMFR9fNkTOXStjLD+bhi
         jrEw==
X-Gm-Message-State: ABuFfogVaulaYC7T4dXUbeDqKOmD+lAzjpLepGhcQQXYHGpmDyzDSPg1
        ZbGOjPHzhoxsh2/ZuD+YC+X5DGDSy8Q1fFOVPrnBrbS6DH48mzKi1CHXsMrcqj1N/ag8KEpWOAn
        T/Q5n7+5ZzP8/+KrDRqCG9j7RdbxxSJBYVUILRp3FjZkFY7EvFs5M+jYwu0jX
X-Google-Smtp-Source: ACcGV632WP/B+O/spzl8jxgQFv3H0V9BpqQyK6rtlpL98YyEwNjHQFMKAyXOLBfDFyaH482fjhoKGa3YQWST
X-Received: by 2002:ab0:446:: with SMTP id 64mr30277082uav.0.1539208263898;
 Wed, 10 Oct 2018 14:51:03 -0700 (PDT)
Date:   Wed, 10 Oct 2018 14:50:08 -0700
In-Reply-To: <20181010215008.233529-1-sbeller@google.com>
Message-Id: <20181010215008.233529-10-sbeller@google.com>
Mime-Version: 1.0
References: <20181010215008.233529-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH v5 9/9] builtin/fetch: check for submodule updates for non
 branch fetches
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
index e3b03ad3bd..f2d9e548bf 100644
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
index af12c50e7d..a509eabb04 100755
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
2.19.0

