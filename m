Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B30C4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 11:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBE2560E09
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 11:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240380AbhHJLrw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 07:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240264AbhHJLr0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 07:47:26 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC30C0617BF
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 04:47:02 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id e19so7105811pla.10
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 04:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DELuwezVhFEAJ07HiQHE33GpFM8dIXTgyNAbDIcelD8=;
        b=ifY2YqlLGvDkYdioqFrq+Jx/UYHPhMO2h1596ld0AMxm8ZdGrhD59G0Ks/vrzFEYQa
         qp28F1NvoNjLKoLOzgeovz8Az2UC0GNzyxP9NJLTVp3jCm/IyJEKk31gGezEAENM+lOL
         fyOlmif8Yoj57yRxpFPzigp2g3Vs4EpRfsfHkc5Qxi+WaScrxVJGgJWCXqdc5cT1m9zn
         PaKZUmcepHJmWfZwHjwl5DMni5qz0sj+wvurY38P6lLrkINf7HkcHm39U6TuTm5tUszb
         JMLD3RWtgkYCf4c6h6Mzuiq3oC+P/zXgfZUmbkGZ6WQApmSj3ni+x4kLaWoo4m4pSsdn
         M0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DELuwezVhFEAJ07HiQHE33GpFM8dIXTgyNAbDIcelD8=;
        b=MKcmXBDoJ7Dmtf2tWML9jRDwRqlNNBmykTpZYUrvQQBCMWkkTa7jIYZ5cE+fkltszY
         C4Ayx1NkAc3hP54VICqPsucCovZ571bkj6zOiYnCSHn05iMjTOCwNxUz0TlZvUlWV50B
         NVm+YoxXzdKISsVSyHdGuxFe+AATLf0Ymigfou+WpKZ3LH05vx3pZJ8WOnmRBYPKB6Gs
         CMJDT2YYBzlbXvcvKFblYKHheRR5FffX6fnRLL1ZRPgTHKuXBeY562LAMRvSAh83CI1F
         Rqkp/2Tz5gArijWnfZDL631asJs8XMxVeXDODMZHJr3Ilh5Kzk4GiLh6scs2pNYwJCoa
         4Tbw==
X-Gm-Message-State: AOAM531E/uxTzOrV5OXIAR8fr5WFPMpVQ+qbC2/V17eQzIPNwoFeh15N
        etduJBJcOQ6VYxAbnnXdBB8=
X-Google-Smtp-Source: ABdhPJztw1oTcwKXA48QKTNKq4/OLqnOVr86KLaB9+xrEA3Pzp+uytvWp1gTga8PAjL3WfBb4960TA==
X-Received: by 2002:a17:90a:b38e:: with SMTP id e14mr30900038pjr.170.1628596022084;
        Tue, 10 Aug 2021 04:47:02 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id g19sm12410232pfc.168.2021.08.10.04.46.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Aug 2021 04:47:01 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: [GSoC] [PATCH v5 0/9] submodule: convert the rest of 'add' to C
Date:   Tue, 10 Aug 2021 17:16:32 +0530
Message-Id: <20210810114641.27188-1-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210807071613.99610-1-raykar.ath@gmail.com>
References: <20210807071613.99610-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

NOTE: This series uses (ar/submodule-add-config):
https://lore.kernel.org/git/20210806140431.92018-1-raykar.ath@gmail.com/

Since v4:
* Rename a local variable in 'compute_submodule_clone_url()' to reduce ambiguity.
* Add a new patch that renames 'compute_submodule_clone_url()' to
  'resolve_relative_url()' to better convey its use. We add it at the end after
  the 'resolve-relative-url' subcommand is removed so that there is no confusion
  as to what that function name binds to.
* Fix incorrect example in the docstring for 'git_url_basename()'. Also add
  another example for more clarity.

Also since this query of mine got buried in the revisions, I shall include it
here again:

Questions about the cache API used in [PATCH 5/9]:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  1. What is the difference between 'read_cache()' and 'read_cache_preload()'?
     From what I can tell, the latter optimistically preloads the index stat
     data. Is there any reason to use 'read_cache()' over
     'read_cache_preload()'?
  2. Which one is more appropriate for use in 'die_on_index_match()'?

Fetch-it-Via:
git fetch https://github.com/tfidfwastaken/git submodule-helper-add-list-5

Atharva Raykar (9):
  submodule--helper: add options for compute_submodule_clone_url()
  submodule--helper: refactor resolve_relative_url() helper
  submodule--helper: remove repeated code in sync_submodule()
  dir: libify and export helper functions from clone.c
  submodule--helper: convert the bulk of cmd_add() to C
  submodule--helper: remove add-clone subcommand
  submodule--helper: remove add-config subcommand
  submodule--helper: remove resolve-relative-url subcommand
  submodule--helper: rename compute_submodule_clone_url()

 builtin/clone.c             | 118 +-------------
 builtin/submodule--helper.c | 307 +++++++++++++++++++-----------------
 dir.c                       | 114 +++++++++++++
 dir.h                       |  11 ++
 git-submodule.sh            |  96 +----------
 5 files changed, 291 insertions(+), 355 deletions(-)

Range-diff against v4:
 1:  75edf24186 !  1:  78e19c4b01 submodule--helper: add options for compute_submodule_clone_url()
    @@ Commit message
         `resolve_relative_url()` by using this function, something we will do in
         the next patch.
     
    +    We also rename the local variable 'relurl' to avoid potential confusion
    +    with the 'rel_url' parameter while we are at it.
    +
         Having this functionality factored out will be useful for converting the
         rest of `submodule add` in subsequent patches.
     
    @@ builtin/submodule--helper.c: static int module_foreach(int argc, const char **ar
     -static char *compute_submodule_clone_url(const char *rel_url)
     +static char *compute_submodule_clone_url(const char *rel_url, const char *up_path, int quiet)
      {
    - 	char *remoteurl, *relurl;
    +-	char *remoteurl, *relurl;
    ++	char *remoteurl, *resolved_url;
      	char *remote = get_default_remote();
    -@@ builtin/submodule--helper.c: static char *compute_submodule_clone_url(const char *rel_url)
    + 	struct strbuf remotesb = STRBUF_INIT;
      
      	strbuf_addf(&remotesb, "remote.%s.url", remote);
      	if (git_config_get_string(remotesb.buf, &remoteurl)) {
    @@ builtin/submodule--helper.c: static char *compute_submodule_clone_url(const char
      		remoteurl = xgetcwd();
      	}
     -	relurl = relative_url(remoteurl, rel_url, NULL);
    -+	relurl = relative_url(remoteurl, rel_url, up_path);
    ++	resolved_url = relative_url(remoteurl, rel_url, up_path);
      
      	free(remote);
      	free(remoteurl);
    + 	strbuf_release(&remotesb);
    + 
    +-	return relurl;
    ++	return resolved_url;
    + }
    + 
    + struct init_cb {
     @@ builtin/submodule--helper.c: static void init_submodule(const char *path, const char *prefix,
      		if (starts_with_dot_dot_slash(url) ||
      		    starts_with_dot_slash(url)) {
 2:  8e7a3e727a !  2:  faadf74ec1 submodule--helper: refactor resolve_relative_url() helper
    @@ builtin/submodule--helper.c: static char *relative_url(const char *remote_url,
     +static char *compute_submodule_clone_url(const char *rel_url, const char *up_path, int quiet)
      {
     -	char *remoteurl = NULL;
    -+	char *remoteurl, *relurl;
    ++	char *remoteurl, *resolved_url;
      	char *remote = get_default_remote();
     +	struct strbuf remotesb = STRBUF_INIT;
     +
    @@ builtin/submodule--helper.c: static char *relative_url(const char *remote_url,
     +				remotesb.buf);
     +		remoteurl = xgetcwd();
     +	}
    -+	relurl = relative_url(remoteurl, rel_url, up_path);
    ++	resolved_url = relative_url(remoteurl, rel_url, up_path);
     +
     +	free(remote);
     +	free(remoteurl);
     +	strbuf_release(&remotesb);
     +
    -+	return relurl;
    ++	return resolved_url;
     +}
     +
     +static int resolve_relative_url(int argc, const char **argv, const char *prefix)
    @@ builtin/submodule--helper.c: static int module_foreach(int argc, const char **ar
      
     -static char *compute_submodule_clone_url(const char *rel_url, const char *up_path, int quiet)
     -{
    --	char *remoteurl, *relurl;
    +-	char *remoteurl, *resolved_url;
     -	char *remote = get_default_remote();
     -	struct strbuf remotesb = STRBUF_INIT;
     -
    @@ builtin/submodule--helper.c: static int module_foreach(int argc, const char **ar
     -				remotesb.buf);
     -		remoteurl = xgetcwd();
     -	}
    --	relurl = relative_url(remoteurl, rel_url, up_path);
    +-	resolved_url = relative_url(remoteurl, rel_url, up_path);
     -
     -	free(remote);
     -	free(remoteurl);
     -	strbuf_release(&remotesb);
     -
    --	return relurl;
    +-	return resolved_url;
     -}
     -
      struct init_cb {
 3:  82961ddd02 =  3:  d2127bd09a submodule--helper: remove repeated code in sync_submodule()
 4:  fa97d6801e !  4:  4b05f93def dir: libify and export helper functions from clone.c
    @@ dir.h: static inline int is_dot_or_dotdot(const char *name)
     + *
     + * For example:
     + * 	/path/to/repo.git => "repo"
    -+ * 	host.xz.foo/.git => "foo"
    ++ * 	host.xz:foo/.git => "foo"
    ++ * 	http://example.com/user/bar.baz => "bar.baz"
     + */
     +char *git_url_basename(const char *repo, int is_bundle, int is_bare);
     +void strip_dir_trailing_slashes(char *dir);
 5:  a3aa25518d =  5:  1491a011b0 submodule--helper: convert the bulk of cmd_add() to C
 6:  9667159d4b =  6:  5d5d07a6ba submodule--helper: remove add-clone subcommand
 7:  dc87b5627a =  7:  0ea27c2a15 submodule--helper: remove add-config subcommand
 8:  ea08e4fbad !  8:  6bd2571f73 submodule--helper: remove resolve-relative-url subcommand
    @@ Commit message
     
      ## builtin/submodule--helper.c ##
     @@ builtin/submodule--helper.c: static char *compute_submodule_clone_url(const char *rel_url, const char *up_pat
    - 	return relurl;
    + 	return resolved_url;
      }
      
     -static int resolve_relative_url(int argc, const char **argv, const char *prefix)
 -:  ---------- >  9:  14a05a0c1d submodule--helper: rename compute_submodule_clone_url()
-- 
2.32.0

