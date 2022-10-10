Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE5CC433F5
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 23:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiJJXZF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 19:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJJXZD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 19:25:03 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583FA1A23D
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 16:25:01 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u10so19078088wrq.2
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 16:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtU9LfsFlYSskCVK/IT2W345Nvbz8AA7b+ZYSGzAK+s=;
        b=o37eS3QJW4hErtW9Gv69Q9RNfTLxV3vqljz2ZTUUVifu/mZiNO3LEpiMPEhUBEhYAe
         44+KT1cyAznYlGL9yP/tTKlVR7ovWTL1mx5Gi3FaBYGQeQUUi+MQAL3WdSvLLsN7Wlkm
         MnW4u6kA92ZvgS6tSUIuIVWfDRgsmoMepPFdasTmhuRhUiqDmDek0iHcih8oKy59XPEd
         xH4wkcZ3DcZDg28vGVlYjEpghhy2GY3uPsX2nw24lmphfU02SX+3A9V7VkeUA1vB2rcI
         Pt9F2kC0Jg5k1yMIeburlmWQVJMKUZEjSEd8NaSLgT8XqsMMwPhL2aC/2USZfFGNdPEY
         g/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wtU9LfsFlYSskCVK/IT2W345Nvbz8AA7b+ZYSGzAK+s=;
        b=VfKnEInpDWh394MKFxu5qtOoFCNnULylZ/6OVTVgBtzxbnlwKYea8JDX+FANjNJEil
         7ssHU8RIxA9rpoNeEGp+PxgXzZXlu27Dv3BLCQFK6WbfVGVzlYkoQKi7rxyVkYYS2Ymd
         vhX7lAluAsQcA0hY61SJ2CpKwmBEeJzrWIFd/24JHKyOLrZZ9xFvyKFgJmFIaqdDwK/e
         4/y1iXA/OgVR1kNf630fDXOV6JJxVQVUgYfaQ/CBa/5zhchvkrOjZiYh02qDASJrFckd
         ZaT+wyzRHwgqVSGUpKRH6y9bXvIMs9X0//4jHKO6zae/X9H/P5Obg6YFeVAZ7PaFWuE3
         AiRQ==
X-Gm-Message-State: ACrzQf326vdxs3MoE0HparDYqyh8TMPs3VWnYY+8K1eJWzEJu/wH05G0
        OtcltmJqgwvFFhLW7wh9DI/eSd0TGtc=
X-Google-Smtp-Source: AMsMyM58ME/7vRdJzb9s+PuM1bjyjU901rhgSaIFVHDXWSV/l5cfOkpqJGryGIUwatoiqqm9PBFNQg==
X-Received: by 2002:adf:fad0:0:b0:22e:4998:fd5d with SMTP id a16-20020adffad0000000b0022e4998fd5dmr12867047wrs.267.1665444299724;
        Mon, 10 Oct 2022 16:24:59 -0700 (PDT)
Received: from [192.168.2.52] (138.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.138])
        by smtp.gmail.com with ESMTPSA id k4-20020adff5c4000000b00228dff8d975sm9636568wrp.109.2022.10.10.16.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 16:24:59 -0700 (PDT)
Subject: [PATCH v6] branch: support for shortcuts like @{-1}, completed
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.1346.git.1662388460.gitgitgadget@gmail.com>
 <93b0b442-b277-66a6-3f5f-5a498593aa07@gmail.com>
 <7abdb5a9-5707-7897-4196-8d2892beeb81@gmail.com>
 <2e164aea-7dd8-5018-474a-01643553ea49@gmail.com>
 <de200fa0-379d-c1ce-8446-9e4292d0b66a@gmail.com>
Message-ID: <fbf84e26-4306-c8df-0e2c-45dc94129e3a@gmail.com>
Date:   Tue, 11 Oct 2022 01:24:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <de200fa0-379d-c1ce-8446-9e4292d0b66a@gmail.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

This is the v5 with your fix squashed, but with one change to maintain
the -1 on error.

    -			error(!argc
    +			ret = error(!argc
    			      ? _("No commit on branch '%s' yet.")
    			      : _("No branch named '%s'."),
    			      branch_name);


We discussed to keep this and other things like the capitalized error
messages, to be sorted out in next series, when the dust settles after
this and the other patch about errors on unborn branches.

ref:
<xmqqlepp8smc.fsf@gitster.g>
<xmqqmtajosek.fsf@gitster.g>


Range-diff:
1:  00ca255874 ! 1:  11650c6340 branch: support for shortcuts like @{-1}, completed
    @@ builtin/branch.c: int cmd_branch(int argc, const char **argv, const char *prefix
      		const char *branch_name;
      		struct strbuf branch_ref = STRBUF_INIT;
     +		struct strbuf buf = STRBUF_INIT;
    ++		int ret = 1; /* assume failure */
      
      		if (!argc) {
      			if (filter.detached)
    @@ builtin/branch.c: int cmd_branch(int argc, const char **argv, const char *prefix
      			branch_name = head;
     -		} else if (argc == 1)
     -			branch_name = argv[0];
    +-		else
     +		} else if (argc == 1) {
     +			strbuf_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
     +			branch_name = buf.buf;
    -+		}
    - 		else
    ++		} else {
      			die(_("cannot edit description of more than one branch"));
    ++		}
      
      		strbuf_addf(&branch_ref, "refs/heads/%s", branch_name);
    - 		if (!ref_exists(branch_ref.buf)) {
    - 			strbuf_release(&branch_ref);
    -+			strbuf_release(&buf);
    - 
    - 			if (!argc)
    - 				return error(_("No commit on branch '%s' yet."),
    -@@ builtin/branch.c: int cmd_branch(int argc, const char **argv, const char *prefix)
    - 		}
    +-		if (!ref_exists(branch_ref.buf)) {
    +-			strbuf_release(&branch_ref);
    +-
    +-			if (!argc)
    +-				return error(_("No commit on branch '%s' yet."),
    +-					     branch_name);
    +-			else
    +-				return error(_("No branch named '%s'."),
    +-					     branch_name);
    +-		}
    ++		if (!ref_exists(branch_ref.buf))
    ++			ret = error(!argc
    ++			      ? _("No commit on branch '%s' yet.")
    ++			      : _("No branch named '%s'."),
    ++			      branch_name);
    ++		else if (!edit_branch_description(branch_name))
    ++			ret = 0; /* happy */
    ++
      		strbuf_release(&branch_ref);
    ++		strbuf_release(&buf);
      
     -		if (edit_branch_description(branch_name))
    -+		if (edit_branch_description(branch_name)) {
    -+			strbuf_release(&buf);
    - 			return 1;
    -+		}
    -+		strbuf_release(&buf);
    +-			return 1;
    ++		return ret;
      	} else if (copy) {
      		if (!argc)
      			die(_("branch name required"));

 builtin/branch.c                      | 53 +++++++++++++++++----------
 t/t3204-branch-name-interpretation.sh | 24 ++++++++++++
 2 files changed, 58 insertions(+), 19 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 55cd9a6e99..658c9f8741 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -791,31 +791,33 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	} else if (edit_description) {
 		const char *branch_name;
 		struct strbuf branch_ref = STRBUF_INIT;
+		struct strbuf buf = STRBUF_INIT;
+		int ret = 1; /* assume failure */
 
 		if (!argc) {
 			if (filter.detached)
 				die(_("Cannot give description to detached HEAD"));
 			branch_name = head;
-		} else if (argc == 1)
-			branch_name = argv[0];
-		else
+		} else if (argc == 1) {
+			strbuf_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
+			branch_name = buf.buf;
+		} else {
 			die(_("cannot edit description of more than one branch"));
+		}
 
 		strbuf_addf(&branch_ref, "refs/heads/%s", branch_name);
-		if (!ref_exists(branch_ref.buf)) {
-			strbuf_release(&branch_ref);
-
-			if (!argc)
-				return error(_("No commit on branch '%s' yet."),
-					     branch_name);
-			else
-				return error(_("No branch named '%s'."),
-					     branch_name);
-		}
+		if (!ref_exists(branch_ref.buf))
+			ret = error(!argc
+			      ? _("No commit on branch '%s' yet.")
+			      : _("No branch named '%s'."),
+			      branch_name);
+		else if (!edit_branch_description(branch_name))
+			ret = 0; /* happy */
+
 		strbuf_release(&branch_ref);
+		strbuf_release(&buf);
 
-		if (edit_branch_description(branch_name))
-			return 1;
+		return ret;
 	} else if (copy) {
 		if (!argc)
 			die(_("branch name required"));
@@ -835,9 +837,15 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
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
@@ -854,11 +862,17 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
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
@@ -871,6 +885,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
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
