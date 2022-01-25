Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543CDC433F5
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 12:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384293AbiAYMvM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 07:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457271AbiAYMtK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 07:49:10 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8755C06173B
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 04:49:08 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id f17so19687452wrx.1
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 04:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7XQZiZcKAoTb+1qb1iuYHdPcndsKE1/j3xewBq84UQs=;
        b=kIlujADcb5rrSATwAU1st1fFWwtuWskrAWK3a29Q3Avv2U5BQsy0XilCNQ1N81IBwq
         Ak0Bz3Dl984kFdDUri3wPyNQNGKzCUCu2iVPKcpA8SfDr03eNByeB1HOJssv8Gqit1Zg
         uLOioVkKIV3Nq/u2opktX3Rkh5AS+omNKsLYad2dw1csBa37T1kCFC0xRpK4oJgCH/oM
         DU3U1dMv/IZkB5SyxxKGwPagczZ6rm0tZ75ctdAzsVVu8dVa/ichphBSBQBVtWUWV8Sa
         JqfpgqwhuFPuUIUBIhzmP/FRt5P62nyK9EaE7NnDbU0VCJqn1TH5UwxzvcRYmAzwlwIn
         14vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7XQZiZcKAoTb+1qb1iuYHdPcndsKE1/j3xewBq84UQs=;
        b=k95RGwnhSeD9LXBXjm05sKfvqJuVuxUV+rhXFWg/VqYgHksm9iTlunFxeQbStmAjvQ
         FzARPcewtGKtjG+O/CUUmE0H55+ruUTjbUt13jeNFiy/zG5JRJxdlnDrtXu6cJg4NFK8
         V8wvVSJYV8qZmwJOgLxKRzFBJOsig4qgK/VaPyGN3NaWhACtuXoV9lIXdtKmfjzo9cqD
         guhMCmzqiALtT6/Euu0VyRQvWQbykbi0V3ku/1WI4/w3oQ4ncevXSQpOapH5RbBQ0wmt
         PjAm8HOiZfuCzZftoc6zKGe7GrHIcJGOgQFLInKVcwu1g7Lvzd9rbS4B4sGI19biYx2t
         PkdQ==
X-Gm-Message-State: AOAM532kSCp7HQcJxojb2Umku5ZwsagpTbDhOFmKtBxPhun02JNWmw1/
        yuS83JamaDXA5K2gvq3adpmt2YdfVD0=
X-Google-Smtp-Source: ABdhPJzeT9PfmiGJKDNSRTNChdUKPSAb9RhxUPb/ZxQf5FLKnnjPnjqk75zgsvSAXq3Lqfi38h/qEw==
X-Received: by 2002:a5d:40c2:: with SMTP id b2mr17994223wrq.335.1643114946883;
        Tue, 25 Jan 2022 04:49:06 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r16sm328979wmq.3.2022.01.25.04.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 04:49:06 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Hongyi Zhao <hongyi.zhao@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        =?UTF-8?q?Jo=C3=A3o=20Victor=20Bonfim?= 
        <JoaoVictorBonfim+Git-Mail-List@protonmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] completion: add a GIT_COMPLETION_SHOW_ALL_COMMANDS
Date:   Tue, 25 Jan 2022 13:49:04 +0100
Message-Id: <patch-1.1-5f18305ca08-20220125T124757Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.rc2.886.ga87834885e8
In-Reply-To: <CAGP6POJ9gwp+t-eP3TPkivBLLbNb2+qj=61Mehcj=1BgrVOSLA@mail.gmail.com>
References: <CAGP6POJ9gwp+t-eP3TPkivBLLbNb2+qj=61Mehcj=1BgrVOSLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a GIT_COMPLETION_SHOW_ALL_COMMANDS=1 configuration setting to go
with the existing GIT_COMPLETION_SHOW_ALL=1 added in
c099f579b98 (completion: add GIT_COMPLETION_SHOW_ALL env var,
2020-08-19).

This will include plumbing commands such as "cat-file" in "git <TAB>"
and "git c<TAB>" completion. Without/with this I have 134 and 243
completion with git <TAB>, respectively.

It was already possible to do this by tweaking
GIT_COMPLETION_SHOW_ALL_COMMANDS from the outside, that testing
variable was added in 84a97131065 (completion: let git provide the
completable command list, 2018-05-20). Doing this before loading
git-completion.bash worked:

    export GIT_TESTING_PORCELAIN_COMMAND_LIST="$(git --list-cmds=builtins,main,list-mainporcelain,others,nohelpers,alias,list-complete,config)"

But such testing variables are not meant to be used from the outside,
and we make no guarantees that those internal won't change. So let's
expose this as a dedicated configuration knob.

1. https://lore.kernel.org/git/CAGP6POJ9gwp+t-eP3TPkivBLLbNb2+qj=61Mehcj=1BgrVOSLA@mail.gmail.com/

Reported-by: Hongyi Zhao <hongyi.zhao@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

n Sat, Jan 22 2022, Hongyi Zhao wrote:

> On Ubuntu 20.04.3 LTS, I use the following git version installed from
> its apt repository:
>
> $ git --version
> git version 2.25.1
>
> I find that there are some  sub-commands can't be completed by TAB key
> [...]

Others have explained why this happens, but as noted above an easy but
undocumented workaround for this that I use, because I'd like
e.g. "cat-file" to show up in this completion. In your ~/.bashrc or
equivalent do something like this before it loads git-completion.bash:

    export GIT_TESTING_PORCELAIN_COMMAND_LIST="$(git --list-cmds=builtins,main,others,alias)"

But it would be even nicer to turn that into a first-class feature,
this patch does so. With this you can just do:

    export GIT_COMPLETION_SHOW_ALL_COMMANDS=1

 contrib/completion/git-completion.bash | 13 ++++++++++++-
 t/t9902-completion.sh                  | 27 ++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 377d6c5494a..2436b8eb6b9 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -49,6 +49,11 @@
 #     and git-switch completion (e.g., completing "foo" when "origin/foo"
 #     exists).
 #
+#   GIT_COMPLETION_SHOW_ALL_COMMANDS
+#
+#     When set to "1" suggest all commands, including plumbing commands
+#     which are hidden by default (e.g. "cat-file" on "git ca<TAB>").
+#
 #   GIT_COMPLETION_SHOW_ALL
 #
 #     When set to "1" suggest all options, including options which are
@@ -3455,7 +3460,13 @@ __git_main ()
 			then
 				__gitcomp "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
 			else
-				__gitcomp "$(__git --list-cmds=list-mainporcelain,others,nohelpers,alias,list-complete,config)"
+				local list_cmds=list-mainporcelain,others,nohelpers,alias,list-complete,config
+
+				if test "${GIT_COMPLETION_SHOW_ALL_COMMANDS-}" = "1"
+				then
+					list_cmds=builtins,$list_cmds
+				fi
+				__gitcomp "$(__git --list-cmds=$list_cmds)"
 			fi
 			;;
 		esac
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 98c62806328..e3ea6a41b00 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2432,6 +2432,33 @@ test_expect_success 'option aliases are shown with GIT_COMPLETION_SHOW_ALL' '
 	EOF
 '
 
+test_expect_success 'plumbing commands are excluded without GIT_COMPLETION_SHOW_ALL_COMMANDS' '
+	. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
+	sane_unset GIT_TESTING_PORCELAIN_COMMAND_LIST &&
+
+	# Just mainporcelain, not plumbing commands
+	run_completion "git c" &&
+	grep checkout out &&
+	! grep cat-file out
+'
+
+test_expect_success 'all commands are shown with GIT_COMPLETION_SHOW_ALL_COMMANDS (also main non-builtin)' '
+	. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
+	GIT_COMPLETION_SHOW_ALL_COMMANDS=1 &&
+	export GIT_COMPLETION_SHOW_ALL_COMMANDS &&
+	sane_unset GIT_TESTING_PORCELAIN_COMMAND_LIST &&
+
+	# Both mainporcelain and plumbing commands
+	run_completion "git c" &&
+	grep checkout out &&
+	grep cat-file out &&
+
+	# Check "gitk", a "main" command, but not a built-in + more plumbing
+	run_completion "git g" &&
+	grep gitk out &&
+	grep get-tar-commit-id out
+'
+
 test_expect_success '__git_complete' '
 	unset -f __git_wrap__git_main &&
 
-- 
2.35.0.rc2.886.ga87834885e8

