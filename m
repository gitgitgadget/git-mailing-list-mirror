Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38A4C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 14:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7FEE6054E
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 14:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242769AbhHZOGo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 10:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242830AbhHZOGo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 10:06:44 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF06C0613CF
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 07:05:56 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id u16so5293649wrn.5
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 07:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qSjH4CUtvoRTSxsob5h9Nf2nHl/GHKYQF7+ecufSSTw=;
        b=gMsi6hl/kOr+Mj0eH3+IjdrNkA433uvO1qEzp8MR5aYapd+mP0Xi+Ix284zEIWTHBg
         yWqsbk9X3m+9Z9EHUhbSsFIVZlyb3x+/GSZwCj5YCemKgZYjlSpP8E6cLWy/W15MqU+G
         eNwjapgbsGmlINBwUCx+c3NUevEtMbbkroe66Ta9fjWISVbj11s4cgIkNJhrxYxSTUWa
         TAJC3+AIhQqPXCMON1n8LP4tobKGRnEmE7M3/PDMQ0CSGIMobem6LZQndAJfLTx0La0Z
         z/jyM/dpsOU9mxwHqW87jS3dY02/JdqVS7WQGiGyNJZ0yWY0zJs2VX1Ae5ylxtO+4VZm
         M4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qSjH4CUtvoRTSxsob5h9Nf2nHl/GHKYQF7+ecufSSTw=;
        b=Q38+90L0qh7XILqovpHNfuYQzQXmkr2v/U3qb6LIL7hBTyG+DREoQJaVvBdllQOmgc
         wy1PDRvFuYiaGvm0I/H8tBClRBr/qxYRSR85nW30z2o75J5vS0nnFBazssMcJ3MZepva
         G1DYXxamIoVKXTvAEukq6GcrpzLNX5c9Eju7jrTx+AW0oiUVi7FhcRACG2oPZIaYLv/M
         LuyZyAtgE11daUTbNodbmxZ+gbmjFh5xd6F5hmEq4vGtONBbHgFe9BDgGDU3EYaR93kK
         AqDgi8OWUGFAQkqDe0Eipjwpde4MVq7aw1Dj+OlMmCo0QOy3U4U0jnKUy4VZJ2eocHO9
         S5uw==
X-Gm-Message-State: AOAM532w7bNxa4r8rNqQ1DAM2EMQbJBCHEwrUV06Pq0hAI8vCxCIt480
        UJffwGYglPRr9JGReekKDNgz+xmO+7qYvA==
X-Google-Smtp-Source: ABdhPJwD7qf4PJYYada/pS1g6LrCFj5fIJK+tjZeJn0QdRfE/xCI7iKZ5rHt+MnCgzcX4oTG+fujWg==
X-Received: by 2002:a5d:6909:: with SMTP id t9mr4051424wru.44.1629986755236;
        Thu, 26 Aug 2021 07:05:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k13sm2471987wms.33.2021.08.26.07.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 07:05:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/5] bundle: show progress on "unbundle"
Date:   Thu, 26 Aug 2021 16:05:46 +0200
Message-Id: <cover-v3-0.5-00000000000-20210826T140414Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.733.ga72a4f1c2e1
In-Reply-To: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This straightforward series addr progress output on "git bundle
unbundle", we already had progress output if bundles were fetched from
via the transport.c (i.e. "git clone/fetch" etc.), but not from "git
bundle unbundle" directly.

This v3 should address all the comments Derrick Stolee had in one way
or another, thanks a lot for the review!

Ævar Arnfjörð Bjarmason (5):
  bundle API: start writing API documentation
  strvec: add a strvec_pushvec()
  bundle API: change "flags" to be "extra_index_pack_args"
  index-pack: add --progress-title option
  bundle: show progress on "unbundle"

 Documentation/git-bundle.txt     |  2 +-
 Documentation/git-index-pack.txt |  6 ++++++
 builtin/bundle.c                 | 15 ++++++++++++++-
 builtin/index-pack.c             |  6 ++++++
 bundle.c                         | 14 ++++++++------
 bundle.h                         | 15 +++++++++++++--
 strvec.c                         |  8 ++++++++
 strvec.h                         |  7 +++++++
 submodule.c                      |  4 +---
 transport.c                      |  6 +++++-
 10 files changed, 69 insertions(+), 14 deletions(-)

Range-diff against v2:
1:  dc8591f6d0b ! 1:  9fb2f7a3a80 bundle API: start writing API documentation
    @@ Commit message
         start. We'll add a parameter to this function in a subsequent commit,
         but let's start by documenting it.
     
    +    The "/**" comment (as opposed to "/*") signifies the start of API
    +    documentation. See [1] and bdfdaa4978d (strbuf.h: integrate
    +    api-strbuf.txt documentation, 2015-01-16) and 6afbbdda333 (strbuf.h:
    +    unify documentation comments beginnings, 2015-01-16) for a discussion
    +    of that convention.
    +
    +    1. https://lore.kernel.org/git/874kbeecfu.fsf@evledraar.gmail.com/
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## bundle.h ##
-:  ----------- > 2:  321b8ba3f0e strvec: add a strvec_pushvec()
2:  3d7bd9c33be ! 3:  637039634e7 bundle API: change "flags" to be "extra_index_pack_args"
    @@ Commit message
         of being able to pass arbitrary arguments to "unbundle" will be used
         in a subsequent commit.
     
    -    We could pass NULL explicitly in cmd_bundle_unbundle(), but let's
    -    instead initialize an empty strvec and pass it, in anticipation of a
    -    subsequent commit wanting to add arguments to it.
    -
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/bundle.c ##
    -@@ builtin/bundle.c: static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
    - 	struct option options[] = {
    - 		OPT_END()
    - 	};
    --	char *bundle_file;
    -+	char* bundle_file;
    -+	struct strvec extra_args = STRVEC_INIT;
    - 
    - 	argc = parse_options_cmd_bundle(argc, argv, prefix,
    - 			builtin_bundle_unbundle_usage, options, &bundle_file);
     @@ builtin/bundle.c: static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
      	}
      	if (!startup_info->have_repository)
      		die(_("Need a repository to unbundle."));
     -	ret = !!unbundle(the_repository, &header, bundle_fd, 0) ||
    -+	ret = !!unbundle(the_repository, &header, bundle_fd, &extra_args) ||
    ++	ret = !!unbundle(the_repository, &header, bundle_fd, NULL) ||
      		list_bundle_refs(&header, argc, argv);
      	bundle_header_release(&header);
      cleanup:
    @@ bundle.c: int create_bundle(struct repository *r, const char *path,
     -	const char *argv_index_pack[] = {"index-pack",
     -					 "--fix-thin", "--stdin", NULL, NULL};
      	struct child_process ip = CHILD_PROCESS_INIT;
    -+	int i;
      
     -	if (flags & BUNDLE_VERBOSE)
     -		argv_index_pack[3] = "-v";
    @@ bundle.c: int create_bundle(struct repository *r, const char *path,
     +	strvec_push(&ip.args, "--fix-thin");
     +	strvec_push(&ip.args, "--stdin");
     +	if (extra_index_pack_args) {
    -+		struct strvec *extra = extra_index_pack_args;
    -+		for (i = 0; i < extra->nr; i++)
    -+			strvec_push(&ip.args, extra->v[i]);
    ++		strvec_pushvec(&ip.args, extra_index_pack_args);
     +		strvec_clear(extra_index_pack_args);
     +	}
      
    @@ transport.c: static int fetch_refs_from_bundle(struct transport *transport,
     +	struct strvec extra_index_pack_args = STRVEC_INIT;
      	int ret;
      
    -+	strvec_push(&extra_index_pack_args, "-v");
    ++	if (transport->progress)
    ++		strvec_push(&extra_index_pack_args, "-v");
     +
      	if (!data->get_refs_from_bundle_called)
      		get_refs_from_bundle(transport, 0, NULL);
      	ret = unbundle(the_repository, &data->header, data->fd,
     -			   transport->progress ? BUNDLE_VERBOSE : 0);
    -+		       &extra_index_pack_args);
    ++		       transport->progress ? &extra_index_pack_args : NULL);
      	transport->hash_algo = data->header.hash_algo;
      	return ret;
      }
3:  67197064a8b ! 4:  e44d825e5df index-pack: add --progress-title option
    @@ Commit message
         index-pack: add --progress-title option
     
         Add a --progress-title option to index-pack, when data is piped into
    -    index-pack its progress is a proxy for whatever's feeding it
    -    data.
    +    index-pack its progress is a proxy for whatever's feeding it data.
     
         This option will allow us to set a more relevant progress bar title in
         "git bundle unbundle", and is also used in my "bundle-uri" RFC
         patches[1] by a new caller in fetch-pack.c.
     
    +    The code change in cmd_index_pack() won't handle
    +    "--progress-title=xyz", only "--progress-title xyz", and the "(i+1)"
    +    style (as opposed to "i + 1") is a bit odd.
    +
    +    Not using the "--long-option=value" style is inconsistent with
    +    existing long options handled by cmd_index_pack(), but makes the code
    +    that needs to call it better (two strvec_push(), instead of needing a
    +    strvec_pushf()).
    +
    +    Since the option is internal-only the inconsistency shouldn't
    +    matter. I'm copying the pattern to handle it as-is from the handling
    +    of the existing "-o" option in the same function, see 9cf6d3357aa (Add
    +    git-index-pack utility, 2005-10-12) for its addition.
    +
    +    Eventually we'd like to migrate all of this this to parse_options(),
    +    which would make these differences in behavior go away.
    +
         1. https://lore.kernel.org/git/RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    @@ Documentation/git-index-pack.txt: OPTIONS
     +--progress-title::
     +	For internal use only.
     ++
    -+Set the title of the "Receiving objects" progress bar (it's "Indexing
    -+objects" under `--stdin`).
    ++Set the title of the progress bar. The title is "Receiving objects" by
    ++default and "Indexing objects" when `--stdin` is specified.
     +
      --check-self-contained-and-connected::
      	Die if the pack contains broken links. For internal use only.
4:  e4ca8b26962 < -:  ----------- bundle: show progress on "unbundle"
-:  ----------- > 5:  cd38b0f0fed bundle: show progress on "unbundle"
-- 
2.33.0.733.ga72a4f1c2e1

