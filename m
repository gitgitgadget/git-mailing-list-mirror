Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8339BC433F5
	for <git@archiver.kernel.org>; Sat,  8 Oct 2022 22:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiJHWc0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Oct 2022 18:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJHWcY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2022 18:32:24 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D391C265A
        for <git@vger.kernel.org>; Sat,  8 Oct 2022 15:32:21 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j7so12016376wrr.3
        for <git@vger.kernel.org>; Sat, 08 Oct 2022 15:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WcrTMemEBXRRMKKUn2gPnOyQmSq1XiCHX4WxLBHpfWE=;
        b=Eswi3j4+tmP9XH8h50WUUhk1xCCNrz8L0q5ZaAx4Wda+CmpddLxQj7D0BkGOe2loB/
         M4+xefS2jW0n2FBvkrcls0RQWtj5M06uTkDG4Z1qnVY7W/g9OacoJp5dkGe4lZescwSA
         /CCnAkCxbhIiB0h98yw0jyZ+BX+e1+ZlGsE1eBSjJP7BOUcWv59rxIZmi6jCOOdqVH/A
         SrZy+nrHJL0OmKiJm5Kjvw8kPX3sCfASHv5W+lPPoOOiWh1PrDS60MnUOj2UvwCFrkgz
         6OZCyfm1LmWWYOCpM4NcBTt9tsY9P88EFVg4wYj8a0zehAnuuqf+hhdHY7RIvnuwE+uN
         8TQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WcrTMemEBXRRMKKUn2gPnOyQmSq1XiCHX4WxLBHpfWE=;
        b=vz6ryM4MVs+tQZN73dOmUsgE1lMRdzxqa5XfrhmO2b4lbsseqd2Nk/FYnqk66JVm0I
         5WviJs4Oubfq4BG9U+g2leKSNhvMf9wj+Z/cbsG8zQuMlIoMd0NUlZVxZZAkkqwwuf/4
         5el/dsurTlJm1dNiq/dQYzzL3xM96FXM2BmUbaR+mCZPT1HGQNge2tObSiy2xCtPpCiM
         BHbr049eArav1GIk1puv1xI4Ecwnm46oyzjt2qX8Z49lAZ3MpctwYOoEGPCSebZz8+e6
         hUzBg4sK5vodVEDi9b7wAt9aF8D3XP06xzgKz2F2lhRTzDW7xmXBTtm2OH30ZLgzLbuN
         fw1w==
X-Gm-Message-State: ACrzQf0Pqd6w9LHKN895QzB7C77Y0o1pq2/IXLSnGefO4URTEzzLQvZW
        vxHEyhMtq/P80B0KduNgVKIUOHvHJmA=
X-Google-Smtp-Source: AMsMyM54GFtdRgqehXIxJD/srPN/Oo8T+Z2M/sjLDyV3Q+Zg21DWXuveufIBfnp5shl6psNXfyeiCw==
X-Received: by 2002:a5d:4c44:0:b0:22e:3503:41bf with SMTP id n4-20020a5d4c44000000b0022e350341bfmr7451913wrt.0.1665268340299;
        Sat, 08 Oct 2022 15:32:20 -0700 (PDT)
Received: from [192.168.2.52] (138.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.138])
        by smtp.gmail.com with ESMTPSA id z17-20020a1c4c11000000b003b7b36dcb8dsm11079755wmf.31.2022.10.08.15.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Oct 2022 15:32:19 -0700 (PDT)
Subject: [PATCH v5] branch: support for shortcuts like @{-1}, completed
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <pull.1346.git.1662388460.gitgitgadget@gmail.com>
 <93b0b442-b277-66a6-3f5f-5a498593aa07@gmail.com>
 <7abdb5a9-5707-7897-4196-8d2892beeb81@gmail.com>
 <2e164aea-7dd8-5018-474a-01643553ea49@gmail.com>
Message-ID: <de200fa0-379d-c1ce-8446-9e4292d0b66a@gmail.com>
Date:   Sun, 9 Oct 2022 00:32:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <2e164aea-7dd8-5018-474a-01643553ea49@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

branch command with options "edit-description", "set-upstream-to" and
"unset-upstream" expects a branch name.  Since ae5a6c3684 (checkout:
implement "@{-N}" shortcut name for N-th last branch, 2009-01-17) a
branch can be specified using shortcuts like @{-1}.  Those shortcuts
need to be resolved when considering the arguments.

We can modify the description of the previously checked out branch with:

$ git branch --edit--description @{-1}

We can modify the upstream of the previously checked out branch with:

$ git branch --set-upstream-to upstream @{-1}
$ git branch --unset-upstream @{-1}

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---

Changes from v4:
	- Fix non POSIX compatible usage of echo.

Junio, I have taken two approaches to reduce the repetitive code, merging the
two cases "new_upstream" and "unset_upstream".  First keeping the different
error messages to each case, which leads to multiple ugly if/elses.  Second
approach, merging the error messages with generics, which resolves the if/elses
but leads to changes in t/t3200-branch.sh (at least).  I haven't finished
the tests yet, but I already have the same feeling as with the other patch for
branch.  I think this is a good stop point for this change if no new problems
are detected.

Un saludo.


Range-diff:
1:  72a17039e0 ! 1:  393250bbac branch: support for shortcuts like @{-1}, completed
    @@ t/t3204-branch-name-interpretation.sh: test_expect_success 'checkout does not tr
     +	EDITOR=./editor git branch --edit-description @{-1} &&
     +	test_must_fail git config branch.non-desc-branch.description &&
     +	git config branch.desc-branch.description >actual &&
    -+	echo "Branch description\n" >expect &&
    ++	printf "Branch description\n\n" >expect &&
     +	test_cmp expect actual
     +'
     +

 builtin/branch.c                      | 34 +++++++++++++++++++++------
 t/t3204-branch-name-interpretation.sh | 24 +++++++++++++++++++
 2 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 55cd9a6e99..197603241d 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -791,19 +791,23 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	} else if (edit_description) {
 		const char *branch_name;
 		struct strbuf branch_ref = STRBUF_INIT;
+		struct strbuf buf = STRBUF_INIT;
 
 		if (!argc) {
 			if (filter.detached)
 				die(_("Cannot give description to detached HEAD"));
 			branch_name = head;
-		} else if (argc == 1)
-			branch_name = argv[0];
+		} else if (argc == 1) {
+			strbuf_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
+			branch_name = buf.buf;
+		}
 		else
 			die(_("cannot edit description of more than one branch"));
 
 		strbuf_addf(&branch_ref, "refs/heads/%s", branch_name);
 		if (!ref_exists(branch_ref.buf)) {
 			strbuf_release(&branch_ref);
+			strbuf_release(&buf);
 
 			if (!argc)
 				return error(_("No commit on branch '%s' yet."),
@@ -814,8 +818,11 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		}
 		strbuf_release(&branch_ref);
 
-		if (edit_branch_description(branch_name))
+		if (edit_branch_description(branch_name)) {
+			strbuf_release(&buf);
 			return 1;
+		}
+		strbuf_release(&buf);
 	} else if (copy) {
 		if (!argc)
 			die(_("branch name required"));
@@ -835,9 +842,15 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		else
 			die(_("too many arguments for a rename operation"));
 	} else if (new_upstream) {
-		struct branch *branch = branch_get(argv[0]);
+		struct branch *branch;
+		struct strbuf buf = STRBUF_INIT;
 
-		if (argc > 1)
+		if (!argc)
+			branch = branch_get(NULL);
+		else if (argc == 1) {
+			strbuf_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
+			branch = branch_get(buf.buf);
+		} else
 			die(_("too many arguments to set new upstream"));
 
 		if (!branch) {
@@ -854,11 +867,17 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		dwim_and_setup_tracking(the_repository, branch->name,
 					new_upstream, BRANCH_TRACK_OVERRIDE,
 					quiet);
+		strbuf_release(&buf);
 	} else if (unset_upstream) {
-		struct branch *branch = branch_get(argv[0]);
+		struct branch *branch;
 		struct strbuf buf = STRBUF_INIT;
 
-		if (argc > 1)
+		if (!argc)
+			branch = branch_get(NULL);
+		else if (argc == 1) {
+			strbuf_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
+			branch = branch_get(buf.buf);
+		} else
 			die(_("too many arguments to unset upstream"));
 
 		if (!branch) {
@@ -871,6 +890,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (!branch_has_merge_config(branch))
 			die(_("Branch '%s' has no upstream information"), branch->name);
 
+		strbuf_reset(&buf);
 		strbuf_addf(&buf, "branch.%s.remote", branch->name);
 		git_config_set_multivar(buf.buf, NULL, NULL, CONFIG_FLAGS_MULTI_REPLACE);
 		strbuf_reset(&buf);
diff --git a/t/t3204-branch-name-interpretation.sh b/t/t3204-branch-name-interpretation.sh
index 993a6b5eff..793bf4d269 100755
--- a/t/t3204-branch-name-interpretation.sh
+++ b/t/t3204-branch-name-interpretation.sh
@@ -133,4 +133,28 @@ test_expect_success 'checkout does not treat remote @{upstream} as a branch' '
 	expect_branch HEAD one
 '
 
+test_expect_success 'edit-description via @{-1}' '
+	git checkout -b desc-branch &&
+	git checkout -b non-desc-branch &&
+	write_script editor <<-\EOF &&
+		echo "Branch description" >"$1"
+	EOF
+	EDITOR=./editor git branch --edit-description @{-1} &&
+	test_must_fail git config branch.non-desc-branch.description &&
+	git config branch.desc-branch.description >actual &&
+	printf "Branch description\n\n" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'modify branch upstream via "@{-1}" and "@{-1}@{upstream}"' '
+	git checkout -b upstream-branch &&
+	git checkout -b upstream-other -t upstream-branch &&
+	git branch --set-upstream-to upstream-other @{-1} &&
+	git config branch.upstream-branch.merge >actual &&
+	echo "refs/heads/upstream-other" >expect &&
+	test_cmp expect actual &&
+	git branch --unset-upstream @{-1}@{upstream} &&
+	test_must_fail git config branch.upstream-other.merge
+'
+
 test_done
-- 
2.36.1
