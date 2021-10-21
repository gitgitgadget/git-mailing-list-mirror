Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB164C433FE
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 19:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8538E611C7
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 19:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhJUT4h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 15:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhJUT4h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 15:56:37 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2834C061764
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 12:54:20 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id o20so1247424wro.3
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 12:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4TZVLBf29xDb0dB3O9xoNBYKYNgmErjGZ+fN7kOpz4U=;
        b=l/dTfzvx+TUktsIthyjaJO+GrKj988opUV0H2xTI0Sbf+E0TRp24eC1VXVgV8fmTn0
         AVBv5SNlirN05l+GfYqGTvrpVGEFxSM7o04Vibq4c8T2XzZ7P4U471x4bv2ZzWZgaOB/
         TYiHdc3DNMSNbTyFRCC+B2Ti1Y+CoN3P4iLeLnYj98yDx8l3zFNv720ooekvXqjl1wsJ
         ic+VT631tJH+F8MiqVLx44hZlGeGAAggb59l9VFQc8zOPKzHX8AwJ4SY4DC72izFBNL7
         h3YJgjKUxzGelE4kUGcF39r8i6FN9ZPA64zZ6AM6NPkttL841bdyNtMJyYa6POMdszrG
         jJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4TZVLBf29xDb0dB3O9xoNBYKYNgmErjGZ+fN7kOpz4U=;
        b=UyBA+dCk3EDSf8s+2RxMreyewQbAZVBllsGl+veMnFURyEGyHiiU8oW+j0vWusJrIL
         WmfVPqEqtFHZ7sZzrLtwtjTmePGBLonx6QWIHlOqitjyL2/jPUtr62E95WT971UK0sOk
         BG1BJ0bfLRq1VkTM+dnuE8sOXRn1POfwbKK8hj89L0cOaJ7ntLG1otXpBC96/4b6tLDt
         30yVlGmOdhDjU/j9X9OUGxbri5zzLgvm9ix/PsI8STQttrCLIMci6N49Ah9f1ylh9VJZ
         ybRAhGuT9sTWviKT2RYBUTr7VycXnnnVZ5LiypqNflalo03A4pCRjpt6HsagrMWufbnw
         yGEA==
X-Gm-Message-State: AOAM532KUmQyekX1Hd5GV1Uf4ZaKcv/zJ29z/VW8xAUViIruzM7eQjeu
        Fh2juI6yLEZ4BVevyf7WPmQTbcV5CeMsAA==
X-Google-Smtp-Source: ABdhPJwtzB8LjXKfKWUsHnQLCNqsWO5wYnD6KoG0nKPpC//GIG0fHg6aVaiYQjnQJW65RTtyg0rQJw==
X-Received: by 2002:adf:f902:: with SMTP id b2mr9954630wrr.265.1634846058869;
        Thu, 21 Oct 2021 12:54:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6sm7822492wmp.1.2021.10.21.12.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 12:54:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/3] refs.c + config.c: plug memory leaks
Date:   Thu, 21 Oct 2021 21:54:12 +0200
Message-Id: <cover-v2-0.3-00000000000-20211021T195133Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1494.g88b39a443e1
In-Reply-To: <patch-1.1-5a47bf2e9c9-20211021T114223Z-avarab@gmail.com>
References: <patch-1.1-5a47bf2e9c9-20211021T114223Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In response to the feedback on v1 on this (in particular the
use-after-free, thanks Martin!) here's a v2 which I think is a good
thing to do with our without that particular GCC behavior I ran into.

As noted in 3/3 I think this is a known caveat of those SANITIZE=
modes, e.g. valgrind reports a memory leak regardless of optimization
level.

The only pure workaround for the issue is now 3/3, which I think is a
worthwhile to carry to avoid developer potentially wasting time on it.

Ævar Arnfjörð Bjarmason (3):
  refs.c: make "repo_default_branch_name" static, remove xstrfmt()
  config.c: don't leak memory in handle_path_include()
  config.c: free(expanded) before die(), work around GCC oddity

 config.c                  | 22 ++++++++++++++--------
 refs.c                    |  8 +++-----
 refs.h                    |  1 -
 t/t1305-config-include.sh |  1 +
 4 files changed, 18 insertions(+), 14 deletions(-)

Range-diff against v1:
-:  ----------- > 1:  4f8554bb02e refs.c: make "repo_default_branch_name" static, remove xstrfmt()
-:  ----------- > 2:  d6d04da1d9d config.c: don't leak memory in handle_path_include()
1:  5a47bf2e9c9 ! 3:  d812358e331 leak tests: free() before die for two API functions
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    leak tests: free() before die for two API functions
    +    config.c: free(expanded) before die(), work around GCC oddity
     
    -    Call free() just before die() in two API functions whose tests are
    -    asserted under SANITIZE=leak. Normally this would not be needed due to
    -    how SANITIZE=leak works, but in these cases my GCC version (10.2.1-6)
    -    will fail tests t0001 and t0017 under SANITIZE=leak depending on the
    -    optimization level.
    +    On my GCC version (10.2.1-6), but not the clang I have available t0017
    +    will fail under SANITIZE=leak on optimization levels higher than -O0,
    +    which is annoying when combined with the change in 956d2e4639b (tests:
    +    add a test mode for SANITIZE=leak, run it in CI, 2021-09-23).
     
    -    See 956d2e4639b (tests: add a test mode for SANITIZE=leak, run it in
    -    CI, 2021-09-23) for the commit that marked t0017 for testing with
    -    SANITIZE=leak, and c150064dbe2 (leak tests: run various built-in tests
    -    in t00*.sh SANITIZE=leak, 2021-10-12) for t0001 (currently in "next").
    +    We really do have a memory leak here in either case, as e.g. running
    +    the pre-image under valgrind(1) will reveal. It's documented
    +    SANITIZE=leak (and "address", which exhibits the same behavior) might
    +    interact with compiler optimization in this way in some cases, and
    +    since this function is called recursively it's going to be especially
    +    interesting as an optimization target.
    +
    +    Let's work around this issue by freeing the "expanded" memory before
    +    we call die(), using the "goto cleanup" pattern introduced in the
    +    preceding commit.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## config.c ##
    +@@ config.c: static int handle_path_include(const char *path, struct config_include_data *inc
    + 	int ret = 0;
    + 	struct strbuf buf = STRBUF_INIT;
    + 	char *expanded;
    ++	int die_depth = 0;
    + 
    + 	if (!path)
    + 		return config_error_nonbool("include.path");
     @@ config.c: static int handle_path_include(const char *path, struct config_include_data *inc
      	}
      
      	if (!access_or_die(path, R_OK, 0)) {
     -		if (++inc->depth > MAX_INCLUDE_DEPTH)
    +-			die(_(include_depth_advice), MAX_INCLUDE_DEPTH, path,
    +-			    !cf ? "<unknown>" :
    +-			    cf->name ? cf->name :
    +-			    "the command line");
     +		if (++inc->depth > MAX_INCLUDE_DEPTH) {
    -+			free(expanded);
    - 			die(_(include_depth_advice), MAX_INCLUDE_DEPTH, path,
    - 			    !cf ? "<unknown>" :
    - 			    cf->name ? cf->name :
    - 			    "the command line");
    ++			die_depth = 1;
    ++			goto cleanup;
     +		}
      		ret = git_config_from_file(git_config_include, path, inc);
      		inc->depth--;
      	}
    -
    - ## refs.c ##
    -@@ refs.c: char *repo_default_branch_name(struct repository *r, int quiet)
    - 	}
    - 
    - 	full_ref = xstrfmt("refs/heads/%s", ret);
    --	if (check_refname_format(full_ref, 0))
    -+	if (check_refname_format(full_ref, 0)) {
    -+		free(ret);
    -+		free(full_ref);
    - 		die(_("invalid branch name: %s = %s"), config_display_key, ret);
    -+	}
    - 	free(full_ref);
    + cleanup:
    + 	strbuf_release(&buf);
    + 	free(expanded);
    +-	return ret;
    ++	if (!die_depth)
    ++		return ret;
    ++	die(_(include_depth_advice), MAX_INCLUDE_DEPTH, path,
    ++	    !cf ? "<unknown>" : cf->name ? cf->name : "the command line");
    + }
      
    - 	return ret;
    + static void add_trailing_starstar_for_dir(struct strbuf *pat)
-- 
2.33.1.1494.g88b39a443e1

