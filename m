Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E03C433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 14:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358393AbiFVO3p (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 10:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358322AbiFVO2V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 10:28:21 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01D1654C
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 07:28:19 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v14so23691475wra.5
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 07:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fJNPXQJK+f7/uvGPJT9QbCK7uAkE/5n7Pg5H/6sAm+g=;
        b=irXU99k2lxY58PDggcIni7s+/J3pb12uMe84+eTwcye846oCIwrblg7BiYKGHKjLZW
         +LFN9t8zZ7o4auIAAEjkqsKWjq2zHZBGFgDqolTr8B5Jifv8joEhxuxN7DU9K1mG0dhy
         lJ8OEpp6VcshGMDxmYNbrnvAw9ryWY67fZ/FIWPU58reqxGYxBSBfG4ORV1++SSrGRLH
         qBgHc+RdVtHwdtvcU4Cl0fyG/pCZ2xsl1qhV6c4hbp4F20o+IWDigXmQ+VilKLWVIGZR
         HnawdE6DxZr4tmihji6vnLX6qfdypld6k0i6gQwpBmPcwIX2EDpqP3D6xdypp1zLWMWL
         Lt1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fJNPXQJK+f7/uvGPJT9QbCK7uAkE/5n7Pg5H/6sAm+g=;
        b=PvW85N5afU346GCxUUUPZOoDnOKUnwG3NeY4zpZS7K27MVYMJM5uYzkCp/juts6wYm
         72HSp5S3mOMbfF7pq0KMQ/81WsDCXNy0YCz7tyrMNBNZPF5g2AE5/Mp6PWrCthcNRKQx
         3UREX2MrNpEym5f477BF1Lw3Z94WLNvncfUwKVLdXaBXIyxT3P4LH0OriBM2ODmqfGMV
         k93g61/4aMnAbJg/lMsiUeUYzZTLAsu4KMKO3+d2mo4kCMzjcJCO1kxow2Y3lpGXza4S
         uD4x+BI0nzSBctNWmWhjC4YMfJcoOuA+JCVBg1Jn6VBgHuKsJxrACSzCktYJjgXGcuni
         zhsg==
X-Gm-Message-State: AJIora9u8UEl/KP7ZMMcoaxrWsjFLTSy7F5TjpJBjMaZwEYhF077bs9V
        8Ya2/xzs39USaP8cv1ywchkxxd9jr7BmYw==
X-Google-Smtp-Source: AGRyM1uem/cxNFLuhhozIoyLIY6F0N8h8GeuZyQL+EcWcHijW6p5qIecoDgftsOHRk/3mwJt+9aDdg==
X-Received: by 2002:adf:f7cd:0:b0:21b:a237:6973 with SMTP id a13-20020adff7cd000000b0021ba2376973mr2585783wrq.295.1655908098982;
        Wed, 22 Jun 2022 07:28:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j11-20020a05600c190b00b0039c5328ad92sm30468304wmq.41.2022.06.22.07.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 07:28:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 08/12] submodule--helper: report "submodule" as our name in some "-h" output
Date:   Wed, 22 Jun 2022 16:28:03 +0200
Message-Id: <patch-v3-08.12-bb1310b9abe-20220622T142012Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com>
References: <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com> <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the user-facing "git submodule--helper" commands so that
they'll report their name as being "git submodule". To a user these
commands are internal implementation details, and it doesn't make
sense to emit usage about an internal helper when "git submodule" is
invoked with invalid options.

Before this we'd emit e.g.:

	$ git submodule absorbgitdirs --blah
	error: unknown option `blah'
	usage: git submodule--helper absorbgitdirs [<options>] [<path>...]
	[...]
And:

	$ git submodule set-url -- --
	usage: git submodule--helper set-url [--quiet] <path> <newurl>
	[...]

Now we'll start with "usage: git submodule [...]" in both of those
cases. This change does not alter the "list", "name", "clone",
"config" and "create-branch" commands, those are internal-only (as an
aside; their usage info should probably invoke BUG(...)). This only
changes the user-facing commands.

The "status", "deinit" and "update" commands are not included in this
change, because their usage information already used "submodule"
rather than "submodule--helper".

I don't think it's currently possible to emit some of this usage
information in practice, as git-submodule.sh will catch unknown
options, and e.g. it doesn't seem to be possible to get "add" to emit
its usage information from "submodule--helper".

Though that change may be superfluous now, it's also harmless, and
will allow us to eventually dispatch further into "git
submodule--helper" from git-submodule.sh, while emitting the correct
usage output.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a298d8d0c12..6af09d78d4b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -444,7 +444,7 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper foreach [--quiet] [--recursive] [--] <command>"),
+		N_("git submodule foreach [--quiet] [--recursive] [--] <command>"),
 		NULL
 	};
 
@@ -582,7 +582,7 @@ static int module_init(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper init [<options>] [<path>]"),
+		N_("git submodule init [<options>] [<path>]"),
 		NULL
 	};
 
@@ -1185,7 +1185,7 @@ static int module_summary(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper summary [<options>] [<commit>] [--] [<path>]"),
+		N_("git submodule summary [<options>] [<commit>] [--] [<path>]"),
 		NULL
 	};
 
@@ -1349,7 +1349,7 @@ static int module_sync(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper sync [--quiet] [--recursive] [<path>]"),
+		N_("git submodule sync [--quiet] [--recursive] [<path>]"),
 		NULL
 	};
 
@@ -2788,7 +2788,7 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper absorbgitdirs [<options>] [<path>...]"),
+		N_("git submodule absorbgitdirs [<options>] [<path>...]"),
 		NULL
 	};
 
@@ -2893,7 +2893,7 @@ static int module_set_url(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 	const char *const usage[] = {
-		N_("git submodule--helper set-url [--quiet] <path> <newurl>"),
+		N_("git submodule set-url [--quiet] <path> <newurl>"),
 		NULL
 	};
 
@@ -2932,8 +2932,8 @@ static int module_set_branch(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 	const char *const usage[] = {
-		N_("git submodule--helper set-branch [-q|--quiet] (-d|--default) <path>"),
-		N_("git submodule--helper set-branch [-q|--quiet] (-b|--branch) <branch> <path>"),
+		N_("git submodule set-branch [-q|--quiet] (-d|--default) <path>"),
+		N_("git submodule set-branch [-q|--quiet] (-b|--branch) <branch> <path>"),
 		NULL
 	};
 
@@ -3277,7 +3277,7 @@ static int module_add(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const usage[] = {
-		N_("git submodule--helper add [<options>] [--] <repository> [<path>]"),
+		N_("git submodule add [<options>] [--] <repository> [<path>]"),
 		NULL
 	};
 
-- 
2.36.1.1239.gfba91521d90

