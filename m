Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C08C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 15:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242393AbiCGP2V (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 10:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243757AbiCGP2I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 10:28:08 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216CD92871
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 07:27:12 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id e24so10903080wrc.10
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 07:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R6J4WQtbsvBqlVtQgSgfW42NV7FTSFzIUKG/QEOSx9A=;
        b=nRQSFVM+ajMSwGUebhSTZRJcFNk7Bhv5d6mNkZXHJ0Vk3ytLKL4bFalMMYh0URYqid
         +CkuaOU2Bq/nc/H4QJDx+04Vx7wfyoz5nOK5l6oUv5uEQtISyzN3Cyr/F4ltCoiEXWtO
         LM7KVR6ZFQoezYGiGL3N1YNrlsRTy1jZETDLofscBiQv+yCEfCWk8o5qrEFtlZYoZy96
         dA1K/wBjTDwAoJZkn3TQiGtJj7qOEuR+2YBYR5ryEgo/VkxZ3/rveQzCt+T5/D9PboPu
         9pnGM7iH6T6A1cS9dYkxLEbxIBIBdboP87Tr0uJC9WRd9OVTZ9dG/+NFQ17GvrvDubDW
         iotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R6J4WQtbsvBqlVtQgSgfW42NV7FTSFzIUKG/QEOSx9A=;
        b=1ejEipmHHWn2HL6AoJExCiXPWjZ1hHW9Loc7YzfgBroBF7AJUm6xNTppcj81r00O12
         rBnbOhZsuxU2pKSmrl53Q3SaPiJAcZKdKoBRH6K8iQJM/YZCRZ0rPrMvWujhEN0BgkxA
         zA/Dn7/rVn71AZ6Zx8rQLJS5edmuY8l9Ybak8BFlS/mWxnd8gKGP5rozF80m191HGKaW
         6q/k/CmX0W2X9kkfq3GExXsM6lo8ZI29h9ZC7hJ6ass0LKJAaTOPGZEdkCczPVszAFv0
         v/2ztTeB+DK1Tf4ePAzOn+vicHm24pT/NgGa9ZoNtu7/y+TjINAaXouXo/T/Zv8u+Nql
         CtQA==
X-Gm-Message-State: AOAM531CHjlpYF9IYTtsuz8N/OaLOHD0mMN4qmbrlMZMY7JKGsp7rKns
        YVKoRs3xx+MhENec+wqkP+HaDcjLlnf1nw==
X-Google-Smtp-Source: ABdhPJyCqDo/EJCrF/k+mVI1hUMmbt97mTyyxrG/gmFfFAUKDtvUzdEx66HH9e4q+/MuYRN1SqJT3g==
X-Received: by 2002:a05:6000:1b86:b0:1f0:d6f:1424 with SMTP id r6-20020a0560001b8600b001f00d6f1424mr8671756wru.174.1646666830254;
        Mon, 07 Mar 2022 07:27:10 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n15-20020a05600c4f8f00b003842f011bc5sm16927214wmq.2.2022.03.07.07.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 07:27:09 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/2] string-list.h: make "nr" and "alloc" a "size_t"
Date:   Mon,  7 Mar 2022 16:27:06 +0100
Message-Id: <cover-v2-0.2-00000000000-20220307T152316Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1242.gfeba0eae32b
In-Reply-To: <cover-0.2-00000000000-20220307T113707Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20220307T113707Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "struct string_list" to have a "size_t" for "nr" and
"alloc", ensuring we won't overflow on platforms where size_t is 64
bit, but "unsigned int" is 32 bit.

This replaces the v1 1/2 to get rid of the casts we use for Q_(), and
the 2/2's addition of casts is then consistent with those.

Ævar Arnfjörð Bjarmason (2):
  gettext API users: don't explicitly cast ngettext()'s "n"
  string-list API: change "nr" and "alloc" to "size_t"

 builtin/index-pack.c        |  2 +-
 builtin/merge-recursive.c   |  2 +-
 builtin/receive-pack.c      |  9 +++++----
 builtin/shortlog.c          | 10 +++++-----
 bundle.c                    |  8 ++++----
 commit-graph.c              |  6 +++---
 mailmap.c                   |  7 ++++---
 merge-ort.c                 |  4 ++--
 strbuf.c                    |  4 ++--
 string-list.h               |  3 ++-
 t/helper/test-run-command.c |  7 ++++---
 wt-status.c                 | 12 ++++++------
 12 files changed, 39 insertions(+), 35 deletions(-)

Range-diff against v1:
1:  83659fbc459 < -:  ----------- gettext API users: correct use of casts for Q_()
-:  ----------- > 1:  83fd21741ad gettext API users: don't explicitly cast ngettext()'s "n"
2:  398682c07aa ! 2:  6db8ab7a121 string-list API: change "nr" and "alloc" to "size_t"
    @@ Commit message
         two lines, which is the case for most such struct member
         declarations (e.g. in "strbuf.h" and "strvec.h").
     
    +    Changing e.g. "int i" to "size_t i" in run_and_feed_hook() isn't
    +    strictly necessary, and there are a lot more cases where we'll use a
    +    local "int", "unsigned int" etc. variable derived from the "nr" in the
    +    "struct string_list". But in that case as well as
    +    add_wrapped_shortlog_msg() in builtin/shortlog.c we need to adjust the
    +    printf format referring to "nr" anyway, so let's also change the other
    +    variables referring to it.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/receive-pack.c ##
    @@ bundle.c: int verify_bundle(struct repository *r,
      		r = &header->references;
      		printf_ln(Q_("The bundle contains this ref:",
     -			     "The bundle contains these %d refs:",
    --			     r->nr),
    --			  r->nr);
     +			     "The bundle contains these %"PRIuMAX" refs:",
    -+			     (unsigned long)r->nr),
    + 			     r->nr),
    +-			  r->nr);
     +			  (uintmax_t)r->nr);
      		list_refs(r, 0, NULL);
      		r = &header->prerequisites;
    @@ bundle.c: int verify_bundle(struct repository *r,
      		} else {
      			printf_ln(Q_("The bundle requires this ref:",
     -				     "The bundle requires these %d refs:",
    --				     r->nr),
    --				  r->nr);
     +				     "The bundle requires these %"PRIuMAX" refs:",
    -+				     (unsigned long)r->nr),
    + 				     r->nr),
    +-				  r->nr);
     +				  (uintmax_t)r->nr);
      			list_refs(r, 0, NULL);
      		}
    @@ commit-graph.c: static int fill_oids_from_packs(struct write_commit_graph_contex
      		strbuf_addf(&progress_title,
     -			    Q_("Finding commits for commit graph in %d pack",
     -			       "Finding commits for commit graph in %d packs",
    --			       pack_indexes->nr),
    --			    pack_indexes->nr);
     +			    Q_("Finding commits for commit graph in %"PRIuMAX" pack",
     +			       "Finding commits for commit graph in %"PRIuMAX" packs",
    -+			       (unsigned long)pack_indexes->nr),
    + 			       pack_indexes->nr),
    +-			    pack_indexes->nr);
     +			    (uintmax_t)pack_indexes->nr);
      		ctx->progress = start_delayed_progress(progress_title.buf, 0);
      		ctx->progress_done = 0;
    @@ wt-status.c: static void show_rebase_information(struct wt_status *s,
      			status_printf_ln(s, color,
     -				Q_("Last command done (%d command done):",
     -					"Last commands done (%d commands done):",
    --					have_done.nr),
    --				have_done.nr);
     +				Q_("Last command done (%"PRIuMAX" command done):",
     +					"Last commands done (%"PRIuMAX" commands done):",
    -+					(unsigned long)have_done.nr),
    + 					have_done.nr),
    +-				have_done.nr);
     +				(uintmax_t)have_done.nr);
      			for (i = (have_done.nr > nr_lines_to_show)
      				? have_done.nr - nr_lines_to_show : 0;
    @@ wt-status.c: static void show_rebase_information(struct wt_status *s,
      			status_printf_ln(s, color,
     -				Q_("Next command to do (%d remaining command):",
     -					"Next commands to do (%d remaining commands):",
    --					yet_to_do.nr),
    --				yet_to_do.nr);
     +				Q_("Next command to do (%"PRIuMAX" remaining command):",
     +					"Next commands to do (%"PRIuMAX" remaining commands):",
    -+					(unsigned long)yet_to_do.nr),
    + 					yet_to_do.nr),
    +-				yet_to_do.nr);
     +				(uintmax_t)yet_to_do.nr);
      			for (i = 0; i < nr_lines_to_show && i < yet_to_do.nr; i++)
      				status_printf_ln(s, color, "   %s", yet_to_do.items[i].string);
-- 
2.35.1.1242.gfeba0eae32b

