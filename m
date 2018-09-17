Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22A5B1F404
	for <e@80x24.org>; Mon, 17 Sep 2018 21:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbeIRDFN (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 23:05:13 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:44817 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbeIRDFN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 23:05:13 -0400
Received: by mail-it0-f74.google.com with SMTP id b124-v6so294275itb.9
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 14:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rHw/yuc2AE4vyydUluivSrkcGjkY97yo9AOaOaXTICU=;
        b=unD8fsw1/aNiV/r0E0puyDGmYgB92vs8J0mTTapX7O+kobbAC1JwdSyvDfuRJUDLBn
         uI29bAAFB4coDFin4m5EETADxfwFbktL2P2tpgjRAgTcMmSEy/afp+dyxRDUdws9zjRz
         RKPy2a/O83TxolWiYxLYpxOgb1hVz8uwHFt/8VQHOX7Dl7HCNrJO7moKX0J5tC3yO4Vj
         W1IZAT5JcEk140QRHjoY/ilXWEMz3BiQtM6zVk+H41bj29P8Eo/cMFPMrMaJp+c94Skn
         mHt45ju9wAYeAF+ZJDMg8MaWmmYtiwGMzG3O6xb1wwDiFG+BeGqF2WQds/slvZxYjggS
         zN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rHw/yuc2AE4vyydUluivSrkcGjkY97yo9AOaOaXTICU=;
        b=i6pOdPbfpYVHQrGU5vCD3pqkhzKrEPmF/H36OIhjEHwDWglygaHiJ3IhZFqEhbU9fh
         ZDAkUalw9Kjr2iQon1MH65o9Eu/zyOr43lEIXXFRvH12vXNktw+/zq7uQykpRilJnuor
         iXNGt/aB8LQRqlKnWYRIA1MGdETsT6iGSvT9Y5s54laa8Xg+tdynPuM4cmVXaGh7P+hG
         t3PZm3zVwM+a1Xx72KndEiLaXXKewGFrM2OxzIuDR9Ow0KJ8CpDR4haXc9bWO4ViJ7pG
         t7Qd+1BWTGQ5Hi9DoBRbq3/yB6WHnaqJPKBpjmk1vd3zCBmPrf4J9R0HMvmcDP8Af2JV
         zwYA==
X-Gm-Message-State: APzg51CUAS8ueG9nXEq3lHjXvBi2ndFFE0BtSCV1ifsFX0Z954XAhaKG
        Ij/t9hs0lFDbYI34ssD25VguLNOgL0qL
X-Google-Smtp-Source: ANB0VdZHCIdifKwT4tUvI1/brBBTBRyzTeZLkerXTJ54wwxaFZC1s2QYW08f0r8bACjWb2asLMItvDmqdnEy
X-Received: by 2002:a24:4567:: with SMTP id y100-v6mr13320542ita.37.1537220163222;
 Mon, 17 Sep 2018 14:36:03 -0700 (PDT)
Date:   Mon, 17 Sep 2018 14:35:50 -0700
In-Reply-To: <20180911234951.14129-1-sbeller@google.com>
Message-Id: <20180917213559.126404-1-sbeller@google.com>
Mime-Version: 1.0
References: <20180911234951.14129-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCHv2 0/9] fetch: make sure submodule oids are fetched
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2:
* extended commit messages,
* plugged a memory leak
* rewrote the patch "sha1-array: provide oid_array_filter" to be much more like 
  object_array_fiter
* fixed a typo pointed out by Ramsay.

The range diff is below.
  
Thanks,
Stefan

v1:
Currently when git-fetch is asked to recurse into submodules, it dispatches
a plain "git-fetch -C <submodule-dir>" (and some submodule related options
such as prefix and recusing strategy, but) without any information of the
remote or the tip that should be fetched.

This works surprisingly well in some workflows, not so well in others,
which this series aims to fix.

The first patches provide new basic functionality and do some refactoring;
the interesting part is in the two last patches.

This was discussed in
https://public-inbox.org/git/20180808221752.195419-1-sbeller@google.com/
and I think I addressed all feedback so far.

Stefan Beller (9):
  string-list: add string_list_{pop, last} functions
  sha1-array: provide oid_array_filter
  submodule.c: fix indentation
  submodule.c: sort changed_submodule_names before searching it
  submodule: move global changed_submodule_names into fetch submodule
    struct
  submodule.c: do not copy around submodule list
  submodule: fetch in submodules git directory instead of in worktree
  fetch: retry fetching submodules if needed objects were not fetched
  builtin/fetch: check for submodule updates for non branch fetches

 builtin/fetch.c             |  14 +--
 sha1-array.c                |  17 ++++
 sha1-array.h                |   9 ++
 string-list.c               |  14 +++
 string-list.h               |  15 +++
 submodule.c                 | 191 ++++++++++++++++++++++++++++--------
 t/t5526-fetch-submodules.sh |  23 ++++-
 7 files changed, 236 insertions(+), 47 deletions(-)

git range-diff origin/sb/submodule-recursive-fetch-gets-the-tip...HEAD 

 1:  6fecf7cd01a !  1:  54d31d90734 string-list: add string_list_{pop, last} functions
    @@ -12,8 +12,8 @@
          - string_list_pop() removes the string_list_item at the end of
            the string list.
     
    -     - string_list_push() is not added, but string_list_append() can be
    -       used in its place.
    +     - there is no string_list_push(); string_list_append() can be used
    +       in its place.
     
         You can use them in this pattern:
     
    @@ -26,7 +26,6 @@
     
         Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      diff --git a/string-list.c b/string-list.c
      --- a/string-list.c
    @@ -66,6 +65,10 @@
     + */
     +void string_list_pop(struct string_list *list, int free_util);
     +
    ++/*
    ++ * Returns the last item of the list. As it returns the raw access, do not
    ++ * modify the list while holding onto the returned pointer.
    ++ */
     +static inline struct string_list_item *string_list_last(struct string_list *list)
     +{
     +	return &list->items[list->nr - 1];
 2:  7007a318a68 <  -:  ----------- sha1-array: provide oid_array_filter
 -:  ----------- >  2:  a2bd6ef2bf0 sha1-array: provide oid_array_filter
 3:  807429234ac !  3:  0300c27cbd7 submodule.c: fix indentation
    @@ -6,7 +6,6 @@
         Fix it while we are here.
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      diff --git a/submodule.c b/submodule.c
      --- a/submodule.c
 4:  f6fa5273af9 !  4:  80cf0221bbe submodule.c: sort changed_submodule_names before searching it
    @@ -12,7 +12,6 @@
         appropriate.
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      diff --git a/submodule.c b/submodule.c
      --- a/submodule.c
 5:  adf7a2fd203 !  5:  7ddb448b748 submodule: move global changed_submodule_names into fetch submodule struct
    @@ -6,7 +6,6 @@
         part of the struct that is passed around for fetching submodules.
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      diff --git a/submodule.c b/submodule.c
      --- a/submodule.c
 6:  56c9398589a !  6:  7975a7f1e3b submodule.c: do not copy around submodule list
    @@ -9,12 +9,11 @@
         Instead use the result list directly and prune items afterwards
         using string_list_remove_empty_items.
     
    -    By doin so we'll have access to the util pointer for longer that
    +    By doing so we'll have access to the util pointer for longer that
         contains the commits that we need to fetch, which will be
         useful in a later patch.
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      diff --git a/submodule.c b/submodule.c
      --- a/submodule.c
 7:  9f70a5f32c9 !  7:  29bc2868f26 submodule: fetch in submodules git directory instead of in worktree
    @@ -3,14 +3,14 @@
         submodule: fetch in submodules git directory instead of in worktree
     
         This patch started as a refactoring to make 'get_next_submodule' more
    -    readable, but upon doing so, I realized that git-fetch actually doesn't
    -    need to be run in the worktree. So let's run it in the git dir instead.
    +    readable, but upon doing so, I realized that "git fetch" of the submodule
    +    actually doesn't need to be run in the submodules worktree. So let's run
    +    it in its git dir instead.
     
         That should pave the way towards fetching submodules that are currently
         not checked out.
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      diff --git a/submodule.c b/submodule.c
      --- a/submodule.c
    @@ -32,7 +32,7 @@
      	return spf->default_option;
      }
      
    -+static const char *get_submodule_git_dir(struct repository *r, const char *path)
    ++static char *get_submodule_git_dir(struct repository *r, const char *path)
     +{
     +	struct repository subrepo;
     +	const char *ret;
    @@ -87,7 +87,11 @@
      			if (!spf->quiet)
      				strbuf_addf(err, "Fetching submodule %s%s\n",
     @@
    + 			argv_array_push(&cp->args, default_argv);
    + 			argv_array_push(&cp->args, "--submodule-prefix");
      			argv_array_push(&cp->args, submodule_prefix.buf);
    ++
    ++			free(git_dir);
      			ret = 1;
      		}
     -		strbuf_release(&submodule_path);
 8:  bab609b4dc1 !  8:  f837c4a0789 fetch: retry fetching submodules if sha1 were not fetched
    @@ -1,9 +1,9 @@
     Author: Stefan Beller <sbeller@google.com>
     
    -    fetch: retry fetching submodules if sha1 were not fetched
    +    fetch: retry fetching submodules if needed objects were not fetched
     
         Currently when git-fetch is asked to recurse into submodules, it dispatches
    -    a plain "git-fetch -C <submodule-dir>" (and some submodule related options
    +    a plain "git-fetch -C <submodule-dir>" (with some submodule related options
         such as prefix and recusing strategy, but) without any information of the
         remote or the tip that should be fetched.
     
    @@ -16,16 +16,22 @@
         topic downloaded as well. However these submodule changes reside in their
         own repository in their own ref (refs/changes/<int>).
     
    -    Retry fetching a submodule if the object id that the superproject points
    -    to, cannot be found.
    +    Retry fetching a submodule by object name if the object id that the
    +    superproject points to, cannot be found.
     
    -    This doesn't support fetching to FETCH_HEAD yet, but only into a local
    -    branch. To make fetching into FETCH_HEAD work, we need some refactoring
    -    in builtin/fetch.c to adjust the calls to 'check_for_new_submodule_commits'
    -    that is coming in the next patch.
    +    This retrying does not happen when the "git fetch" done at the
    +    superproject is not storing the fetched results in remote
    +    tracking branches (i.e. instead just recording them to
    +    FETCH_HEAD) in this step. A later patch will fix this.
    +
    +    builtin/fetch used to only inspect submodules when they were fetched
    +    "on-demand", as in either on/off case it was clear whether the submodule
    +    needs to be fetched. However to know whether we need to try fetching the
    +    object ids, we need to identify the object names, which is done in this
    +    function check_for_new_submodule_commits(), so we'll also run that code
    +    in case the submodule recursion is set to "on".
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      diff --git a/builtin/fetch.c b/builtin/fetch.c
      --- a/builtin/fetch.c
 9:  c16d21313f6 !  9:  71f2bb035b1 builtin/fetch: check for submodule updates for non branch fetches
    @@ -2,11 +2,29 @@
     
         builtin/fetch: check for submodule updates for non branch fetches
     
    -    For Gerrit users that use submodules the invocation of fetch without a
    -    branch is their main use case.
    +    Gerrit, the code review tool, has a different workflow than our mailing
    +    list based approach. Usually users upload changes to a Gerrit server and
    +    continuous integration and testing happens by bots. Sometimes however a
    +    user wants to checkout a change locally and look at it locally. For this
    +    use case, Gerrit offers a command line snippet to copy and paste to your
    +    terminal, which looks like
    +
    +      git fetch https://<host>/gerrit refs/changes/<id> &&
    +      git checkout FETCH_HEAD
    +
    +    For Gerrit changes that contain changing submodule gitlinks, it would be
    +    easy to extend both the fetch and checkout with the '--recurse-submodules'
    +    flag, such that this command line snippet would produce the state of a
    +    change locally.
    +
    +    However the functionality added in the previous patch, which would
    +    ensure that we fetch the objects in the submodule that the gitlink pointed
    +    at, only works for remote tracking branches so far, not for FETCH_HEAD.
    +
    +    Make sure that fetching a superproject to its FETCH_HEAD, also respects
    +    the existence checks for objects in the submodule recursion.
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      diff --git a/builtin/fetch.c b/builtin/fetch.c
      --- a/builtin/fetch.c
