Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B932C48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 14:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4F48613CC
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 14:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbhFOONn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 10:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbhFOONY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 10:13:24 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443ACC061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 07:11:16 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id t4-20020a1c77040000b029019d22d84ebdso1868725wmi.3
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 07:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=pdHms0GyzRA9kTrkSi0pQme+VoJqd/UtjydFb2BGjus=;
        b=VkXyPlp1gguzgfRh4u2EfMLM+ye9bHkPJOg5cM9UkNIAUx+f4iHFZCfK01hjHFg8J1
         u5vEkCV2WU99lVdUYf6K7l8+DyZJRghZ4IZq+lD59oWgHBbEE2YqckP1DV95S03xGJdZ
         CH2Y24jzl8+iXN34K+7gYiuPDgOBl4FQHCMbfRyELK5L12ng4t/twMY//3c2pUAR0sHJ
         /4fMhARdlUb2ww0h6uvUWhipmOoLVKbR6KrUfmz30BMAAnLyiG/t1b+X3mCQGx6aSuf2
         B/6sNONIIAhzL3ZRQvsqzJv34JMxO3O5T1Nv2DNYkSFlmLGHy9dChcQlQcygTAlqNyIk
         PUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=pdHms0GyzRA9kTrkSi0pQme+VoJqd/UtjydFb2BGjus=;
        b=Ml+BqqjwPuFKHswcDqHacJVlxC97HVhGStE63+Fio4dobXmyRBk7MOU92I+FO0pZDF
         dPZW7k0KSKwI+dAQ+ET3lamrsve70WqQ5JSN+PvJ/lcKc16gRRdavHFvt9XBl6nU6WtH
         f2UL2/a9oEtize08ye0lefO4RVxkwohFw/jpmLVef2JNt2I2L9q8u2mcc1MVLVlb5SsZ
         bmpneD2dqhb08MxBaCGDQtiy+LMgFqASzty9K9JOVMbelTL6yo3UKevfw+Ts5vZLDbZA
         XMebAFcmOUWXWSVDbb8yt2C0nAKjVHl5nBWI9nQXaPEyjrCrTDLLuxLXGD41cKJ20TXc
         WQgg==
X-Gm-Message-State: AOAM533pYZgeHcciK+zlyj5mSNxikKF3bNSg1uV6upBjL3V8Qf1imTer
        MY76xY3n0FjoLGB6rVzqVSvIsAlR13A=
X-Google-Smtp-Source: ABdhPJwfyEHZTOre4T81XAspkDiZueEVqbCvLO6be6GTJzPDOoyN0bkUM/gYkUjqQedeM7OcfuGXpg==
X-Received: by 2002:a05:600c:20d:: with SMTP id 13mr23297926wmi.174.1623766274760;
        Tue, 15 Jun 2021 07:11:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f14sm2273652wmq.10.2021.06.15.07.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 07:11:14 -0700 (PDT)
Message-Id: <pull.975.v3.git.1623766273.gitgitgadget@gmail.com>
In-Reply-To: <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
References: <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Jun 2021 14:11:08 +0000
Subject: [PATCH v3 0/4] Avoid gendered pronouns
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, stolee@gmail.com,
        jrnieder@gmail.com, emilyshaffer@google.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Phillip Susi <phill@thesusis.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In another topic, I claimed [1] that singular "they" was better than
"he/she" for gender neutrality.

[1]
https://lore.kernel.org/git/44d937a0-e876-e185-f409-a4fd61eae580@gmail.com/

Based on the discussion in earlier versions of this series (and Felipe's
submission [2]), this version makes the official recommendation to avoid
gendered pronouns. Several examples are now listed in CodingGuidelines to
assist contributors to improve their sentences in the process of removing
gendered pronouns.

[2]
https://lore.kernel.org/git/20210611202819.47077-1-felipe.contreras@gmail.com/

Here, I took Felipe's two patches, with edits, as well as a fixed patch 3
(removed an unnecessary comment that had a typo) and a replaced patch 4.
Patch 4 is listed as co-authored-by Junio, but does not have his sign-off.
Junio: please add your sign-off if this is an appropriate edit of your
recommended examples. Otherwise, I can attempt a rewrite.

Thanks, -Stolee

Derrick Stolee (2):
  *: fix typos
  CodingGuidelines: recommend singular they

Felipe Contreras (2):
  doc: avoid using the gender of other people
  comments: avoid using the gender of our users

 Documentation/CodingGuidelines  | 28 ++++++++++++++++++++++++++++
 Documentation/SubmittingPatches |  5 ++---
 Documentation/git-push.txt      |  4 ++--
 Documentation/user-manual.txt   |  2 +-
 commit.c                        |  2 +-
 config.c                        |  2 +-
 config.h                        |  4 ++--
 date.c                          |  2 +-
 pathspec.h                      |  2 +-
 strbuf.h                        |  4 ++--
 t/t9300-fast-import.sh          |  1 -
 wt-status.c                     |  2 +-
 12 files changed, 42 insertions(+), 16 deletions(-)


base-commit: c09b6306c6ca275ed9d0348a8c8014b2ff723cfb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-975%2Fderrickstolee%2Fthey-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-975/derrickstolee/they-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/975

Range-diff vs v2:

 1:  fb7a7573782a ! 1:  5b942776bb0a Documentation: use singular they when appropriate
     @@
       ## Metadata ##
     -Author: Derrick Stolee <dstolee@microsoft.com>
     +Author: Felipe Contreras <felipe.contreras@gmail.com>
      
       ## Commit message ##
     -    Documentation: use singular they when appropriate
     +    doc: avoid using the gender of other people
      
     -    There are several instances in our documentation where we refer to an
     -    anonymous user as "a contributor" or "an integrator" or similar. To
     -    avoid repeating this role, pronouns are used. Previous examples
     -    chose a gender for this user, using "he/him" or "she/her" arbitrarily.
     +    Using gendered pronouns for an anonymous person applies a gender where
     +    none is known and further excludes readers who do not use gendered
     +    pronouns. Avoid such examples in the documentation by using "they" or
     +    passive voice to avoid the need for a pronoun.
      
     -    Replace these uses with "they/them" to ensure that these documentation
     -    examples apply to all potential users without exception.
     -
     -    Helped-by: Richard Kerry <richard.kerry@atos.net>
     -    Helped-by: Junio C Hamano <gitster@pobox.com>
     +    Inspired-by: Derrick Stolee <dstolee@microsoft.com>
     +    Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## Documentation/SubmittingPatches ##
      @@ Documentation/SubmittingPatches: If you like, you can put extra tags at the end:
     -   the patch attempts to fix.
       . `Acked-by:` says that the person who is more familiar with the area
         the patch attempts to modify liked the patch.
     --. `Reviewed-by:`, unlike the other tags, can only be offered by the
     + . `Reviewed-by:`, unlike the other tags, can only be offered by the
      -  reviewer and means that she is completely satisfied that the patch
      -  is ready for application.  It is usually offered only after a
      -  detailed review.
     -+. `Reviewed-by:`, unlike the other tags, can only be offered by a
     -+  reviewer when they are completely satisfied with the patch.  It is
     -+  offered only after reviews by reviewers who are known to be experts
     -+  in the affected area by the community members.
     ++  reviewers themselves when they are completely satisfied with the
     ++  patch after a detailed analysis.
       . `Tested-by:` is used to indicate that the person applied the patch
         and found it to have the desired effect.
       
     @@ Documentation/user-manual.txt: A fast-forward looks something like this:
       In some cases it is possible that the new head will *not* actually be
       a descendant of the old head.  For example, the developer may have
      -realized she made a serious mistake, and decided to backtrack,
     -+realized they made a serious mistake, and decided to backtrack,
     ++realized a serious mistake was made and decided to backtrack,
       resulting in a situation like:
       
       ................................................
 2:  f611603718ab ! 2:  57d8486ab7c8 *: use singular they in comments
     @@
       ## Metadata ##
     -Author: Derrick Stolee <dstolee@microsoft.com>
     +Author: Felipe Contreras <felipe.contreras@gmail.com>
      
       ## Commit message ##
     -    *: use singular they in comments
     +    comments: avoid using the gender of our users
      
     -    Several comments in our code refer to an anonymous user with "he/him" or
     -    "she/her" pronouns, and the choice between the two is arbitrary.
     +    We generally avoid specifying the gender of our users in order to be
     +    more inclusive, but sometimes a few slip by due to habit.
      
     -    Replace these uses with "they/them" which universally includes all
     -    potential readers.
     +    Since by doing a little bit of rewording we can avoid this irrelevant
     +    detail, let's do so.
      
     -    Helped-by: Felipe Contreras <felipe.contreras@gmail.com>
     +    Inspired-by: Derrick Stolee <dstolee@microsoft.com>
     +    Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     +    Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## commit.c ##
     @@ commit.c: static void handle_signed_tag(struct commit *parent, struct commit_ext
      
       ## config.h ##
      @@ config.h: void git_configset_init(struct config_set *cs);
     + /**
        * Parses the file and adds the variable-value pairs to the `config_set`,
        * dies if there is an error in parsing the file. Returns 0 on success, or
     -  * -1 if the file does not exist or is inaccessible. The user has to decide
     +- * -1 if the file does not exist or is inaccessible. The user has to decide
      - * if he wants to free the incomplete configset or continue using it when
     -+ * if they want to free the incomplete configset or continue using it when
     ++ * -1 if the file does not exist or is inaccessible. The caller decides
     ++ * whether to free the incomplete configset or continue using it when
        * the function returns -1.
        */
       int git_configset_add_file(struct config_set *cs, const char *filename);
     @@ date.c: int parse_expiry_date(const char *date, timestamp_t *timestamp)
       		 * We take over "now" here, which usually translates
       		 * to the current timestamp.  This is because the user
      -		 * really means to expire everything she has done in
     -+		 * really means to expire everything they have done in
     ++		 * really means to expire everything that was done in
       		 * the past, and by definition reflogs are the record
       		 * of the past, and there is nothing from the future
       		 * to be kept.
     @@ pathspec.h: struct pathspec {
        * A similar process is applied when a new pathspec magic is added. The designer
        * lifts the GUARD_PATHSPEC restriction in the functions that support the new
      - * magic. At the same time (s)he has to make sure this new feature will be
     -+ * magic. At the same time they have to make sure this new feature will be
     ++ * magic while at the same time making sure this new feature will be
        * caught at parse_pathspec() in commands that cannot handle the new magic in
        * some cases. grepping parse_pathspec() should help.
        */
      
       ## strbuf.h ##
      @@ strbuf.h: const char *strbuf_join_argv(struct strbuf *buf, int argc,
     +  * placeholder is unknown, then the percent sign is copied, too.
        *
        * In order to facilitate caching and to make it possible to give
     -  * parameters to the callback, `strbuf_expand()` passes a context pointer,
     +- * parameters to the callback, `strbuf_expand()` passes a context pointer,
      - * which can be used by the programmer of the callback as she sees fit.
     -+ * which can be used by the programmer of the callback as they see fit.
     ++ * parameters to the callback, `strbuf_expand()` passes a context
     ++ * pointer with any kind of data.
        */
       typedef size_t (*expand_fn_t) (struct strbuf *sb,
       			       const char *placeholder,
     @@ wt-status.c: static void wt_status_collect_changes_index(struct wt_status *s)
       		 * changed submodule SHA-1s when comparing index and HEAD, no
       		 * matter what is configured. Otherwise the user won't be
      -		 * shown any submodules she manually added (and which are
     -+		 * shown any submodules they manually added (and which are
     ++		 * shown any submodules manually added (and which are
       		 * staged to be committed), which would be really confusing.
       		 */
       		handle_ignore_submodules_arg(&rev.diffopt, "dirty");
 3:  feecbd7a0c6e ! 3:  6f6fa1b9466e *: fix typos
     @@ Commit message
          *: fix typos
      
          These typos were found while searching the codebase for gendered
     -    pronouns.
     +    pronouns. In the case of t9300-fast-import.sh, remove a confusing
     +    comment that is unnecessary to the understanding of the test.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ t/t9300-fast-import.sh: test_expect_success 'O: comments are all skipped' '
       	# -- ignore all of this text
       	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
      -	# $GIT_COMMITTER_NAME has inserted here for his benefit.
     -+	# $GIT_COMMITTER_NAME has inserted here for this benefit.
       	data <<COMMIT
       	dirty directory copy
       	COMMIT
 4:  065e2fdeb151 < -:  ------------ CodingGuidelines: recommend singular they
 -:  ------------ > 4:  f06092a9053e CodingGuidelines: recommend singular they

-- 
gitgitgadget
