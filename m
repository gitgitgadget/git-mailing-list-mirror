Return-Path: <SRS0=BZy3=CN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5604DC433E2
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 13:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17CC2204FD
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 13:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vNB9VlhX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbgIDNvc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730599AbgIDNux (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Sep 2020 09:50:53 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C559DC061244
        for <git@vger.kernel.org>; Fri,  4 Sep 2020 06:50:52 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id e11so7581145wme.0
        for <git@vger.kernel.org>; Fri, 04 Sep 2020 06:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OMHN2sRDo3HISlS+djK3EIMG9CH7BF9zgiacvZ4DG7I=;
        b=vNB9VlhXfjxio2c21P7JQyFAwGuxnl+PzjxAKK/HikmT6dt8lP/4zwPPoDj/mYaE9f
         8Qgp7tT6rIbU/HgJsX34AkcSu4oYHcCI6kAF1il6JYzlntLRs7WQ7Mfehp2xpvIoxO/l
         zdhBqIBXxXP7ruqHxWd2Qk6FlfJGHUMBW+6KbQe4XocJsG3LWQKRMhudnnOfj5fOPSSt
         unn8gKoJVbtWuhk7nUcWV4CPa87/o+5mwct1SHHiWJskqtkIQywEBathFndtcZRDXHm4
         JkvVRfn3i1PPeV7TkmW52lMYJ8pSeAQi6dpDG01l6zXT04nau7l7R17Mxd0SuZxd1Mv0
         0BJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OMHN2sRDo3HISlS+djK3EIMG9CH7BF9zgiacvZ4DG7I=;
        b=fHbTFyIwcIv5yQqAurCdfLZ9Yfbu5yjSBMl4U+E6H5cMukyMrGclPee5jgKKn1fgDc
         6KQQBQsL87v5Qvzvf9bDTnlulMaNZgw/zpMJKEO/cMCJOpaxvKezXzehN1p+rnPH1BmM
         Rj9zrSJ8D2IWN20hvHPvjcU5L9XpS54x3mSVwNtX6T8ObxdBOdLvOV4cw9BaWeYOTSFK
         xCELxJc9JkkZoTGw7aIpOzNBG4FR0T1x8VAX4a1IDAvb2ALzPORMZbx9ANGog7VxZvbn
         I9HPGX4N4Y0emUa21zFYgJDH460/YJ3dEINKUnOxQUZierVXQ0uu6Y1gutSPWhwhp0Y6
         t3qA==
X-Gm-Message-State: AOAM530KXth/dZHH/hhxo/Buh7hk+9lUenlIGq/rJF0/AN6QtkwvC5QP
        B1uozLn3qctDmPCMJAnGp69yIYm6PhA=
X-Google-Smtp-Source: ABdhPJwtxonkNFUXxurdK1bYAJsH1l1eV1LmNypIvjBOWS7s/u+tElEcsGRdYnGMDsUIBihb4tho0w==
X-Received: by 2002:a1c:2cd7:: with SMTP id s206mr8005599wms.165.1599227451142;
        Fri, 04 Sep 2020 06:50:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t22sm2984138wmt.1.2020.09.04.06.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 06:50:50 -0700 (PDT)
Message-Id: <pull.720.v2.git.1599227449987.gitgitgadget@gmail.com>
In-Reply-To: <pull.720.git.1599056635276.gitgitgadget@gmail.com>
References: <pull.720.git.1599056635276.gitgitgadget@gmail.com>
From:   "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Sep 2020 13:50:49 +0000
Subject: [PATCH v2] fetch: do not look for submodule changes in unchanged refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Orgad Shaneh <orgads@gmail.com>, Orgad Shaneh <orgads@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Orgad Shaneh <orgads@gmail.com>

When fetching recursively with submodules, for each ref in the
superproject, we call check_for_new_submodule_commits() which collects all
the objects that have to be checked for submodule changes on
calculate_changed_submodule_paths(). On the first call, it also collects all
the existing refs for excluding them from the scan.

calculate_changed_submodule_paths() creates an argument array with all the
collected new objects, followed by --not and all the old objects. This argv
is passed to setup_revisions, which parses each argument, converts it back
to an oid and resolves the object. The parsing itself also does redundant
work, because it is treated like user input, while in fact it is a full
oid. So it needlessly attempts to look it up as ref (checks if it has ^, ~
etc.), checks if it is a file name etc.

For a repository with many refs, all of this is expensive. But if the fetch
in the superproject did not update the ref (i.e. the objects that are
required to exist in the submodule did not change), there is no need to
include it in the list.

Before commit be76c212 (fetch: ensure submodule objects fetched,
2018-12-06), submodule reference changes were only detected for refs that
were changed, but not for new refs. This commit covered also this case, but
what it did was to just include every ref.

This change should reduce the number of scanned refs by about half (except
the case of a no-op fetch, which will not scan any ref), because all the
existing refs will still be listed after --not.

The regression was reported here:
https://public-inbox.org/git/CAGHpTBKSUJzFSWc=uznSu2zB33qCSmKXM-
iAjxRCpqNK5bnhRg@mail.gmail.com/

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
    fetch: do not look for submodule changes in unchanged refs
    
    This operation is very expensive, as it scans all the refs using
    setup_revisions, which resolves each ref, including checking if it is
    ambiguous, or if it is a file name etc.
    
    There is no reason to do all that for refs that hasn't changed in this
    fetch.
    
    Reported here:
    https://public-inbox.org/git/CAGHpTBKSUJzFSWc=uznSu2zB33qCSmKXM-iAjxRCpqNK5bnhRg@mail.gmail.com/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-720%2Forgads%2Ffetch-less-submodules-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-720/orgads/fetch-less-submodules-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/720

Range-diff vs v1:

 1:  0f978f487d ! 1:  5348cd7ec8 fetch: do not look for submodule changes in unchanged refs
     @@ Metadata
       ## Commit message ##
          fetch: do not look for submodule changes in unchanged refs
      
     -    This operation is very expensive, as it scans all the refs using
     -    setup_revisions, which resolves each ref, including checking if it
     -    is ambiguous, or if it is a file name etc.
     +    When fetching recursively with submodules, for each ref in the
     +    superproject, we call check_for_new_submodule_commits() which collects all
     +    the objects that have to be checked for submodule changes on
     +    calculate_changed_submodule_paths(). On the first call, it also collects all
     +    the existing refs for excluding them from the scan.
      
     -    There is no reason to do all that for refs that haven't changed in this
     -    fetch.
     +    calculate_changed_submodule_paths() creates an argument array with all the
     +    collected new objects, followed by --not and all the old objects. This argv
     +    is passed to setup_revisions, which parses each argument, converts it back
     +    to an oid and resolves the object. The parsing itself also does redundant
     +    work, because it is treated like user input, while in fact it is a full
     +    oid. So it needlessly attempts to look it up as ref (checks if it has ^, ~
     +    etc.), checks if it is a file name etc.
      
     -    Reported here:
     -    https://public-inbox.org/git/CAGHpTBKSUJzFSWc=uznSu2zB33qCSmKXM-iAjxRCpqNK5bnhRg@mail.gmail.com/
     +    For a repository with many refs, all of this is expensive. But if the fetch
     +    in the superproject did not update the ref (i.e. the objects that are
     +    required to exist in the submodule did not change), there is no need to
     +    include it in the list.
      
     -    Amends commit be76c2128234d94b47f7087152ee55d08bb65d88.
     +    Before commit be76c212 (fetch: ensure submodule objects fetched,
     +    2018-12-06), submodule reference changes were only detected for refs that
     +    were changed, but not for new refs. This commit covered also this case, but
     +    what it did was to just include every ref.
     +
     +    This change should reduce the number of scanned refs by about half (except
     +    the case of a no-op fetch, which will not scan any ref), because all the
     +    existing refs will still be listed after --not.
     +
     +    The regression was reported here:
     +    https://public-inbox.org/git/CAGHpTBKSUJzFSWc=uznSu2zB33qCSmKXM-
     +    iAjxRCpqNK5bnhRg@mail.gmail.com/
      
          Signed-off-by: Orgad Shaneh <orgads@gmail.com>
      


 builtin/fetch.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 0f23dd4b8c..d3f922fc89 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -958,8 +958,10 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 				ref->force = rm->peer_ref->force;
 			}
 
-			if (recurse_submodules != RECURSE_SUBMODULES_OFF)
+			if (recurse_submodules != RECURSE_SUBMODULES_OFF &&
+			    (!rm->peer_ref || !oideq(&ref->old_oid, &ref->new_oid))) {
 				check_for_new_submodule_commits(&rm->old_oid);
+			}
 
 			if (!strcmp(rm->name, "HEAD")) {
 				kind = "";

base-commit: e19713638985533ce461db072b49112da5bd2042
-- 
gitgitgadget
