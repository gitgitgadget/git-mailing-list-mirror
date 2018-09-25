Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5B451F453
	for <e@80x24.org>; Tue, 25 Sep 2018 19:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbeIZB5d (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 21:57:33 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:45107 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbeIZB5d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 21:57:33 -0400
Received: by mail-qt1-f201.google.com with SMTP id t17-v6so9471508qtq.12
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 12:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yXjkJf91n9Rs3zQy4wj5xsWoG/1W5BjZgk3IKxvBYCs=;
        b=f4WxLKLsRgLKj4bLg6cL5C+A+6h94EAnhBfQVuZgu0G17O6JyNDQn+HMX6kRyGiVXp
         dSllwuYSPxqZ+Y8950Pd6mWtotxhdGU3e8iWPQI+HUO1jRnBy8jkJMR6f9Pm76zYWp4m
         pvjmG5IdrB8+SyCUUjyiJWMnFAHeQ7sN0/y8KRnYBnMjhLeill2fr5mj77s9qENyrvrs
         85o82o2tdMoJy5vISBPcr3qjkTUwjt//Uja7zYkNxcGwRMWFUtKiknwgalG3vbzEv8xK
         677s3pplDZNzbfn4SXq1DNAO0vTAYv4zfJBBha98+shC2tseMQ/ULV8aw7D5PjCagAS+
         WADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yXjkJf91n9Rs3zQy4wj5xsWoG/1W5BjZgk3IKxvBYCs=;
        b=gFPWZCWiGwPIlBS3rrWI/RdXDXsZdMYE9nIIjE3lSrYROCoyfWknGYlI7NJIJiQoO2
         ELg3loHRMzvcHGbgHtfWAAKQhq8ewqHugO2j3RH/6Ns0Ni2UTD2AW67WkfDQY/WgIkcc
         /paW/xNDC3nV087Hkhk7S/IfQkpyGW9RH/JYZeUNb/yPJZ1VYpMBH5wsuekvgbyeh7Bq
         jwdKHRUhAe3V628u3HUhSylNaBHdLNNgL+8x8/Krsg6t5SL8w4pWMKW6aEbVWsJydqcf
         UUwhRbvOGqdSoNmi6ic9HoW+w0CqArwBXrTjb8vpCLYHEMNXPjzJRedjbeuA6WwCZJ2I
         zSuA==
X-Gm-Message-State: ABuFfogtyLOThSlOyIS9g3kB7NYd9kMAuK1RUCaqwDOBznLEfQ5EUntf
        XcCFBjSctrfEHxuOKPE6tvl2XUm2TkK8WjaiHRjjgyi81zDm72rM42ldE/fgkfviaHkD6vJ39+8
        /eVWnZpsZ6OOVSbisiNBa2skZShRLyekj6JLptpkTZCOKsVwOSygu2uh1uy7l
X-Google-Smtp-Source: ACcGV61guH+wdAZlmLb6d+MyZyWRlkDL4tL/G5IparfPjorlY935OSQ7lkaOHk8AamlHFndyrgVWe13lvPTH
X-Received: by 2002:a0c:fa83:: with SMTP id o3-v6mr935797qvn.2.1537904904320;
 Tue, 25 Sep 2018 12:48:24 -0700 (PDT)
Date:   Tue, 25 Sep 2018 12:47:55 -0700
In-Reply-To: <20180925194755.105578-1-sbeller@google.com>
Message-Id: <20180925194755.105578-10-sbeller@google.com>
Mime-Version: 1.0
References: <20180925194755.105578-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v4 9/9] builtin/fetch: check for submodule updates for non
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
2.19.0.605.g01d371f741-goog

