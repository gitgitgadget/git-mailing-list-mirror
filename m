Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C339FC433EF
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 18:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB86560F12
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 18:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhJTS3p (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 14:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbhJTS3o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 14:29:44 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0791C061749
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 11:27:29 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o24so13158661wms.0
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 11:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KUqzEgJZjEKIXrK0kNFdT+vF6TskZMhatlfL0tSNhH0=;
        b=Vrni1NCt8jq2IuwVJygyNvUHle3Mz+Si4h6qG+7g5L3mrHEud/QQv/qNC8IANHOlKW
         tygePqY4ZArPXJizwm1IQtSPtfpWwbjIGCvPpGqwhS5106ttwkbF25f5/70SgD2MqIb1
         t+lyA5WrbTTdiyPTc16yX9V/UfErWfTbyNQmiA2qB3fkpPxLfeATIYAkrQkr1eYq3CyT
         9ihLqKthWntV6O3JMCO6OO8sTW4dYlMmkShAaWlzQokpG1oHj42gZVCZn1u3VtqQSw3+
         5tEXtJ1MX7hDCswdbHrrds2GLcTjHjPt72BhmuRyKmXhpNanQlQJBI0Ar3xRKpo4nOzG
         e+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KUqzEgJZjEKIXrK0kNFdT+vF6TskZMhatlfL0tSNhH0=;
        b=7P8zQqXla+R7vgsg1JzvxstbRG6n0MZ5Wav7umy2A3o4iaACciyyiEnvF6FjC+uhXA
         s9Vw8KUQE5o5ba89klZGr6TFZ5zYJm2duDTLkJddmZarP/WMz5NY8MY4eRVtFq7sghbt
         qN/0gC9kF5ISVRmcQJzNokRyFS2WLF0/eE50RU2A3h9t/0oMawSTsFkrv6T17ypsCvoY
         iVjO5T0Mtf6mXHqfGztBniKgdMms34JsylEVvEtn1pQch5+cu3gJUPpRGxUcTvA9QYcc
         PurZLIkDLY1xB03mxpLU5pzr4m6Yg6DivRraaft/hc4D37aOYnNWIzuh2ZGvkOYo/Vut
         JpMw==
X-Gm-Message-State: AOAM531DxsdTu6bSPg8xZLUF3WjUKY7JrQst6VFZggvCe4qR32UZCO+I
        U5GcFMwgeSLmYcj8kaWQXBXeiwMe/VH7dg==
X-Google-Smtp-Source: ABdhPJzdbfHzcnlDTWqSgl8oZDX/rNn3bq4JN4qXyojjWSn4LHbf28uPtW7IwP0qLgeTlMPhR0/sng==
X-Received: by 2002:a05:600c:33a6:: with SMTP id o38mr15338332wmp.58.1634754447475;
        Wed, 20 Oct 2021 11:27:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i13sm3091093wmq.41.2021.10.20.11.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 11:27:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/3] ref-filter: add a ref_sorting_release()
Date:   Wed, 20 Oct 2021 20:27:18 +0200
Message-Id: <cover-0.3-00000000000-20211020T182516Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <RFC-cover-v2-0.4-00000000000-20211020T131627Z-avarab@gmail.com>
References: <RFC-cover-v2-0.4-00000000000-20211020T131627Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A follow-up to
https://lore.kernel.org/git/RFC-cover-v2-0.4-00000000000-20211020T131627Z-avarab@gmail.com/;

Junio: Hopefully this addresses the things you noted, thank[s| you]!
:)

I ejected your patch from this iteration, if you'd like to build on
top of it it should address the build failures in "seen" when combined
with your patch.

Ævar Arnfjörð Bjarmason (3):
  tag: use a "goto cleanup" pattern, leak less memory
  ref-filter API user: add and use a ref_sorting_release()
  branch: use ref_sorting_release()

 builtin/branch.c       |  8 +++++---
 builtin/for-each-ref.c |  2 +-
 builtin/tag.c          | 29 +++++++++++++++++------------
 ref-filter.c           |  9 +++++++++
 ref-filter.h           |  2 ++
 5 files changed, 34 insertions(+), 16 deletions(-)

Range-diff:
1:  fc776c3f1cd ! 1:  8ccd07abf86 tag: use a "goto cleanup" pattern, leak less memory
    @@ Metadata
      ## Commit message ##
         tag: use a "goto cleanup" pattern, leak less memory
     
    -    Change cmd_tag() to free its "struct string_list"'s instead of using
    -    an UNLEAK() pattern. This changes code added in 886e1084d78 (builtin/:
    +    Change cmd_tag() to free its "struct strbuf"'s instead of using an
    +    UNLEAK() pattern. This changes code added in 886e1084d78 (builtin/:
         add UNLEAKs, 2017-10-01).
     
    -    As shown in the context of the deceleration of the "struct
    +    As shown in the context of the declaration of the "struct
         msg_arg" (which I'm changing to use a designated initializer while at
         it, and to show the context in this change), that struct is just a
         thin wrapper around an int and "struct strbuf".
2:  0ae71c19ab7 ! 2:  07062ca276a ref-filter API user: add and use a ref_sorting_release()
    @@ ref-filter.c: int parse_opt_ref_sorting(const struct option *opt, const char *ar
      
     +void ref_sorting_release(struct ref_sorting *sorting)
     +{
    -+	struct ref_sorting *next = sorting->next;
    -+	if (next)
    -+	       ref_sorting_release(next);
    -+	free(sorting);
    ++	while (sorting) {
    ++		struct ref_sorting *next = sorting->next;
    ++		free(sorting);
    ++		sorting = next;
    ++	}
     +}
     +
      int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset)
3:  7abbbe4468c < -:  ----------- for-each-ref: delay parsing of --sort=<atom> options
4:  f7d87aea384 ! 3:  c8e8bc46ac4 branch: use ref_sorting_release()
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/branch.c ##
    -@@ builtin/branch.c: static const char *color_branch_slots[] = {
    - 	[BRANCH_COLOR_WORKTREE] = "worktree",
    - };
    - 
    --static struct string_list output = STRING_LIST_INIT_DUP;
    - static unsigned int colopts;
    - 
    - define_list_config_array(color_branch_slots);
     @@ builtin/branch.c: static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
      	return strbuf_detach(&fmt, NULL);
      }
    @@ builtin/branch.c: static void print_ref_list(struct ref_filter *filter, struct r
      		} else {
      			fwrite(out.buf, 1, out.len, stdout);
      			putchar('\n');
    -@@ builtin/branch.c: int cmd_branch(int argc, const char **argv, const char *prefix)
    - 	enum branch_track track;
    - 	struct ref_filter filter;
    - 	int icase = 0;
    --	static struct ref_sorting *sorting;
    - 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
    - 	struct ref_format format = REF_FORMAT_INIT;
    - 
    -@@ builtin/branch.c: int cmd_branch(int argc, const char **argv, const char *prefix)
    - 		print_current_branch_name();
    - 		return 0;
    - 	} else if (list) {
    -+		struct ref_sorting *sorting;
    -+		static struct string_list output = STRING_LIST_INIT_DUP;
    -+
    - 		/*  git branch --list also shows HEAD when it is detached */
    - 		if ((filter.kind & FILTER_REFS_BRANCHES) && filter.detached)
    - 			filter.kind |= FILTER_REFS_DETACHED_HEAD;
     @@ builtin/branch.c: int cmd_branch(int argc, const char **argv, const char *prefix)
      		ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
      		ref_sorting_set_sort_flags_all(
-- 
2.33.1.1338.g20da966911a

