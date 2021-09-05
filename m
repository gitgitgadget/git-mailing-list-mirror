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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD237C433F5
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 07:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A773260BD3
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 07:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbhIEHfz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 03:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhIEHfy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 03:35:54 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88473C061575
        for <git@vger.kernel.org>; Sun,  5 Sep 2021 00:34:51 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id z4so4847779wrr.6
        for <git@vger.kernel.org>; Sun, 05 Sep 2021 00:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=okXC/BVtR0yWzS7hes5UAJI6wbuwQf+QpK48OOwlEhI=;
        b=fRsBdnTMQoGcWgPRLM/gSm2xk00HsODOIsr0ZjUks+WKm3vNLLiZQnQJ+zb9ZWrmM0
         xT7n/eAwnTgqgyzTh25pvUIzBQGbis2A678sQEb2YywSu0m1tyLYx+PEdyd17HXQawOU
         Lh7/PfvAp3JJwKLZIdBWX3I8DjdBtPqqsZacbpeJQquQ44YBdrCnOPQAhNeItDapm/rd
         YBNWKGxJqAeh5WtEluT2RCu4TKx461Pc+JianN9prj8F8Df4M481ApkMmwr4KYSrULG/
         LIg4WBTdDMKMoiJYpsBQSwx+Dd3guPuMnJGWCOdsOV4GbpOBaAb0aJMqDI+sOgnjl61r
         cpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=okXC/BVtR0yWzS7hes5UAJI6wbuwQf+QpK48OOwlEhI=;
        b=YMhpqWEqBgdTedcYIrrscNZmaCHMg0MylScF6lDIh5oRjJJegvvlUfOU2My692+guR
         b04sHYg/Skg0aDDS2C9ves0sJpF3HUuwWE1QMWZ2YG/lAp8ssLIvOLunuOLPXEKf0ogX
         ju7jsuP/2x2PxserzBTDPhMmZOcwGFla/f3tOhh4HnkMVSruMSJABNiSXae5stIBxfCL
         qhFApZq1GH1YM8cwtzYJktH4vn5IedOSBDYJ8/zwB+/n31FwgOnoA30XusUeS7wTfgMm
         inOoP1Jej6lcbSsqrNfz+9zJUCLs3/ueIHCHm5nY8e92X8ll9BIvvtnsAndo5aHvMH9o
         pFMQ==
X-Gm-Message-State: AOAM533DqGFbXF6Un0xTLOBIi5b6Pvh/uzpFlVz8dbbnUV+LMMR+6Vzm
        6Rx0CncK88sB+VCD7EtxVpalaPEJPZwjOw==
X-Google-Smtp-Source: ABdhPJxrzPe3S6zMvSBTY2+BL1FWE+Y/ZS1zfYHjkmLfvtryEHNT77PKtm79dWq8wyNd1GC8QJ1YmQ==
X-Received: by 2002:adf:fc43:: with SMTP id e3mr7029811wrs.436.1630827289612;
        Sun, 05 Sep 2021 00:34:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q14sm4218734wrc.31.2021.09.05.00.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 00:34:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/4] bundle: show progress on "unbundle"
Date:   Sun,  5 Sep 2021 09:34:41 +0200
Message-Id: <cover-v4-0.4-00000000000-20210905T072750Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.813.g41c39388776
In-Reply-To: <cover-v3-0.5-00000000000-20210826T140414Z-avarab@gmail.com>
References: <cover-v3-0.5-00000000000-20210826T140414Z-avarab@gmail.com>
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

In the v3 I added conditionals to pass the &extra_index_pack_args only
when we had something meanignful to pass along, based on Derrick
Stolee's feedback. Based on the feedback to v4 always passing it is
now back, which makes the progression and end-state more readable.

I removed the new strvec_pushvec() function, now I just use
strvec_pushl() or strvec_pushv(), depending. Perhaps a
strvec_pushvec() makes sense, but let's consider that separate from
this series.

There's also comment & commit message changes here in response to
feedback.

Ævar Arnfjörð Bjarmason (4):
  bundle API: start writing API documentation
  bundle API: change "flags" to be "extra_index_pack_args"
  index-pack: add --progress-title option
  bundle: show progress on "unbundle"

 Documentation/git-bundle.txt     |  2 +-
 Documentation/git-index-pack.txt |  6 ++++++
 builtin/bundle.c                 | 11 ++++++++++-
 builtin/index-pack.c             |  6 ++++++
 bundle.c                         | 12 ++++++------
 bundle.h                         | 14 ++++++++++++--
 transport.c                      |  6 +++++-
 7 files changed, 46 insertions(+), 11 deletions(-)

Range-diff against v3:
1:  9fb2f7a3a80 = 1:  05be8cb0fc3 bundle API: start writing API documentation
2:  321b8ba3f0e < -:  ----------- strvec: add a strvec_pushvec()
3:  637039634e7 ! 2:  9255c766484 bundle API: change "flags" to be "extra_index_pack_args"
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/bundle.c ##
    +@@ builtin/bundle.c: static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
    + 		OPT_END()
    + 	};
    + 	char *bundle_file;
    ++	struct strvec extra_index_pack_args = STRVEC_INIT;
    + 
    + 	argc = parse_options_cmd_bundle(argc, argv, prefix,
    + 			builtin_bundle_unbundle_usage, options, &bundle_file);
     @@ builtin/bundle.c: static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
      	}
      	if (!startup_info->have_repository)
      		die(_("Need a repository to unbundle."));
     -	ret = !!unbundle(the_repository, &header, bundle_fd, 0) ||
    -+	ret = !!unbundle(the_repository, &header, bundle_fd, NULL) ||
    ++	ret = !!unbundle(the_repository, &header, bundle_fd,
    ++			 &extra_index_pack_args) ||
      		list_bundle_refs(&header, argc, argv);
      	bundle_header_release(&header);
      cleanup:
    @@ bundle.c: int create_bundle(struct repository *r, const char *path,
     -	const char *argv_index_pack[] = {"index-pack",
     -					 "--fix-thin", "--stdin", NULL, NULL};
      	struct child_process ip = CHILD_PROCESS_INIT;
    ++	strvec_pushl(&ip.args, "index-pack", "--fix-thin", "--stdin", NULL);
      
     -	if (flags & BUNDLE_VERBOSE)
     -		argv_index_pack[3] = "-v";
    -+	strvec_push(&ip.args, "index-pack");
    -+	strvec_push(&ip.args, "--fix-thin");
    -+	strvec_push(&ip.args, "--stdin");
     +	if (extra_index_pack_args) {
    -+		strvec_pushvec(&ip.args, extra_index_pack_args);
    ++		strvec_pushv(&ip.args, extra_index_pack_args->v);
     +		strvec_clear(extra_index_pack_args);
     +	}
      
    @@ bundle.h: int create_bundle(struct repository *r, const char *path,
       * We'll invoke "git index-pack --stdin --fix-thin" for you on the
       * provided `bundle_fd` from read_bundle_header().
     + *
    -+ * Provide extra_index_pack_args to pass any extra arguments
    ++ * Provide "extra_index_pack_args" to pass any extra arguments
     + * (e.g. "-v" for verbose/progress), NULL otherwise. The provided
    -+ * extra_index_pack_args (if any) will be strvec_clear()'d for you
    -+ * (like the run-command.h API itself does).
    ++ * "extra_index_pack_args" (if any) will be strvec_clear()'d for you.
       */
      int unbundle(struct repository *r, struct bundle_header *header,
     -	     int bundle_fd, int flags);
    @@ transport.c: static int fetch_refs_from_bundle(struct transport *transport,
      		get_refs_from_bundle(transport, 0, NULL);
      	ret = unbundle(the_repository, &data->header, data->fd,
     -			   transport->progress ? BUNDLE_VERBOSE : 0);
    -+		       transport->progress ? &extra_index_pack_args : NULL);
    ++		       &extra_index_pack_args);
      	transport->hash_algo = data->header.hash_algo;
      	return ret;
      }
4:  e44d825e5df ! 3:  338c0e1e518 index-pack: add --progress-title option
    @@ Commit message
         Not using the "--long-option=value" style is inconsistent with
         existing long options handled by cmd_index_pack(), but makes the code
         that needs to call it better (two strvec_push(), instead of needing a
    -    strvec_pushf()).
    +    strvec_pushf()). Since the option is internal-only the inconsistency
    +    shouldn't matter.
     
    -    Since the option is internal-only the inconsistency shouldn't
    -    matter. I'm copying the pattern to handle it as-is from the handling
    -    of the existing "-o" option in the same function, see 9cf6d3357aa (Add
    -    git-index-pack utility, 2005-10-12) for its addition.
    -
    -    Eventually we'd like to migrate all of this this to parse_options(),
    -    which would make these differences in behavior go away.
    +    I'm copying the pattern to handle it as-is from the handling of the
    +    existing "-o" option in the same function, see 9cf6d3357aa (Add
    +    git-index-pack utility, 2005-10-12) for its addition. That's a short
    +    option, but the code to implement the two is the same in functionality
    +    and style. Eventually we'd like to migrate all of this this to
    +    parse_options(), which would make these differences in behavior go
    +    away.
     
         1. https://lore.kernel.org/git/RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com/
     
5:  cd38b0f0fed ! 4:  8f4c7f99799 bundle: show progress on "unbundle"
    @@ builtin/bundle.c: static int cmd_bundle_unbundle(int argc, const char **argv, co
      		OPT_END()
      	};
      	char *bundle_file;
    -+	struct strvec extra_args = STRVEC_INIT;
    - 
    - 	argc = parse_options_cmd_bundle(argc, argv, prefix,
    - 			builtin_bundle_unbundle_usage, options, &bundle_file);
     @@ builtin/bundle.c: static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
      	}
      	if (!startup_info->have_repository)
      		die(_("Need a repository to unbundle."));
    --	ret = !!unbundle(the_repository, &header, bundle_fd, NULL) ||
    -+
    -+	if (progress) {
    -+		strvec_push(&extra_args, "-v");
    -+		strvec_push(&extra_args, "--progress-title");
    -+		strvec_push(&extra_args, _("Unbundling objects"));
    -+	}
    -+
    -+	ret = !!unbundle(the_repository, &header, bundle_fd, progress ?
    -+			 &extra_args : NULL) ||
    ++	if (progress)
    ++		strvec_pushl(&extra_index_pack_args, "-v", "--progress-title",
    ++			     _("Unbundling objects"), NULL);
    + 	ret = !!unbundle(the_repository, &header, bundle_fd,
    + 			 &extra_index_pack_args) ||
      		list_bundle_refs(&header, argc, argv);
    - 	bundle_header_release(&header);
    - cleanup:
-- 
2.33.0.813.g41c39388776

