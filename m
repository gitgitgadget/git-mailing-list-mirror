Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A8BECAAD4
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 08:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiHaImJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 04:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiHaImB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 04:42:01 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1B1BC139
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 01:41:58 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id i188-20020a1c3bc5000000b003a7b6ae4eb2so6300473wma.4
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 01:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=loljUwOh+V8eEcPKxiGOV/4liCWlIU/orrgdes9tYLA=;
        b=aE7SzK80CII/xe2n7Z8w3x6ACtI+siOJXx5AyZyAyHxLOOoxyCOyvZxAyqNLR/ULQD
         3Hei8i43rR5tZlTQU5VA1JrZ0XYyhM4mlre3JzVVO3WU54PmIPYSufKu++C2EqRhoTVy
         Ey0aJerJ+JsjqEFTyElkcP3XPXqgL9krHNHW3tZ8FKzFZNqbyFFqoiyinpA+W6GvBupe
         dSXm+dwvBEitqknHcdfAkzMxbIn5mkIzhjOqUPpJodDPUH61cd5sdTY0tsKyjgnxdFoS
         3e69V0a+qmiavNw5MmaiJvBjREl4NrRK6H9xC5tElr1EgNbSszNm6MPP8m5BCL1ovc5l
         nHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=loljUwOh+V8eEcPKxiGOV/4liCWlIU/orrgdes9tYLA=;
        b=XrnR9P0fpOvzy5KcOqtLSG50IN40WGBo+HyV/WNQb72nUonxrhXysVGpLUxToQfRnB
         FJII4UpV4SE421L0h/Qt5s0+AVsqEB+03MdISBzivfneAwl1isxrnx8Y9mEnqWcAJIg3
         ZgAX2rmoetMtU/li/pRvaIEbct+8WMGvdlUCOuX7Ee6hlHvxpr7Z9sZDYaAMSjKTz823
         D8pB9HzfbhbFgoVr3vAZRdLXC0+WTKQYveeIetT2svisdQspyiisjfm6E5qLr7uT9EA0
         rbZ4J3ywwpgXuQTBI9QHiRMdRrq0V4lqfaobCrC5Du5waVqgAVvECqyQQUMwXHlxDc5Y
         103Q==
X-Gm-Message-State: ACgBeo0yFe4bX/Phg13KvEQ+hcc73ZCqCXNBrd6W/gGvBjj199xvACvz
        Elz+SCgOkRds1DQkawZvjnYw07vV1EfZiw==
X-Google-Smtp-Source: AA6agR79TTqO8avVZyYo3+Kp5YfSVa+PPFn0KJVdtdZMnKSkFIUSle7dMXYmwrl9aGYck5+E5XobuA==
X-Received: by 2002:a05:600c:5102:b0:3a5:a46d:5d4b with SMTP id o2-20020a05600c510200b003a5a46d5d4bmr1340268wms.68.1661935316391;
        Wed, 31 Aug 2022 01:41:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n2-20020a7bc5c2000000b003a5c064717csm1439036wmk.22.2022.08.31.01.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 01:41:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 5/9] notes docs: de-duplicate and combine configuration sections
Date:   Wed, 31 Aug 2022 10:41:36 +0200
Message-Id: <patch-v3-5.9-5b0ea00aa33-20220831T083759Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1406.g184357183a6
In-Reply-To: <cover-v3-0.9-00000000000-20220831T083759Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20220831T083759Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Combine the various "notes" configuration sections spread across
Documentation/config/notes.txt and Documentation/git-notes.txt to live
in the former, and to be included in the latter.

We'll now forward link from "git notes" to the "CONFIGURATION" section
below, rather than to "git-config(1)" when discussing configuration
variables that are (also) discussed in that section.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/notes.txt | 43 +++++++++++++++-----------
 Documentation/git-log.txt      | 16 ++--------
 Documentation/git-notes.txt    | 55 +++-------------------------------
 3 files changed, 33 insertions(+), 81 deletions(-)

diff --git a/Documentation/config/notes.txt b/Documentation/config/notes.txt
index aeef56d49ae..c7c4811734b 100644
--- a/Documentation/config/notes.txt
+++ b/Documentation/config/notes.txt
@@ -3,6 +3,9 @@ notes.mergeStrategy::
 	conflicts.  Must be one of `manual`, `ours`, `theirs`, `union`, or
 	`cat_sort_uniq`.  Defaults to `manual`.  See "NOTES MERGE STRATEGIES"
 	section of linkgit:git-notes[1] for more information on each strategy.
++
+This setting can be overridden by passing the `--strategy` option to
+linkgit:git-notes[1].
 
 notes.<name>.mergeStrategy::
 	Which merge strategy to choose when doing a notes merge into
@@ -11,28 +14,35 @@ notes.<name>.mergeStrategy::
 	linkgit:git-notes[1] for more information on the available strategies.
 
 notes.displayRef::
-	The (fully qualified) refname from which to show notes when
-	showing commit messages.  The value of this variable can be set
-	to a glob, in which case notes from all matching refs will be
-	shown.  You may also specify this configuration variable
-	several times.  A warning will be issued for refs that do not
-	exist, but a glob that does not match any refs is silently
-	ignored.
+	Which ref (or refs, if a glob or specified more than once), in
+	addition to the default set by `core.notesRef` or
+	`GIT_NOTES_REF`, to read notes from when showing commit
+	messages with the 'git log' family of commands.
 +
 This setting can be overridden with the `GIT_NOTES_DISPLAY_REF`
 environment variable, which must be a colon separated list of refs or
 globs.
 +
+A warning will be issued for refs that do not exist,
+but a glob that does not match any refs is silently ignored.
++
+This setting can be disabled by the `--no-notes` option to the 'git
+log' family of commands, or by the `--notes=<ref>` option accepted by
+those commands.
++
 The effective value of "core.notesRef" (possibly overridden by
 GIT_NOTES_REF) is also implicitly added to the list of refs to be
 displayed.
 
 notes.rewrite.<command>::
 	When rewriting commits with <command> (currently `amend` or
-	`rebase`) and this variable is set to `true`, Git
-	automatically copies your notes from the original to the
-	rewritten commit.  Defaults to `true`, but see
-	"notes.rewriteRef" below.
+	`rebase`), if this variable is `false`, git will not copy
+	notes from the original to the rewritten commit.  Defaults to
+	`true`.  See also "`notes.rewriteRef`" below.
++
+This setting can be overridden with the `GIT_NOTES_REWRITE_REF`
+environment variable, which must be a colon separated list of refs or
+globs.
 
 notes.rewriteMode::
 	When copying notes during a rewrite (see the
@@ -46,14 +56,13 @@ environment variable.
 
 notes.rewriteRef::
 	When copying notes during a rewrite, specifies the (fully
-	qualified) ref whose notes should be copied.  The ref may be a
-	glob, in which case notes in all matching refs will be copied.
-	You may also specify this configuration several times.
+	qualified) ref whose notes should be copied.  May be a glob,
+	in which case notes in all matching refs will be copied.  You
+	may also specify this configuration several times.
 +
 Does not have a default value; you must configure this variable to
 enable note rewriting.  Set it to `refs/notes/commits` to enable
 rewriting for the default commit notes.
 +
-This setting can be overridden with the `GIT_NOTES_REWRITE_REF`
-environment variable, which must be a colon separated list of refs or
-globs.
+Can be overridden with the `GIT_NOTES_REWRITE_REF` environment variable.
+See `notes.rewrite.<command>` above for a further description of its format.
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index b1285aee3c2..410095e9a4f 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -237,19 +237,9 @@ log.showSignature::
 mailmap.*::
 	See linkgit:git-shortlog[1].
 
-notes.displayRef::
-	Which refs, in addition to the default set by `core.notesRef`
-	or `GIT_NOTES_REF`, to read notes from when showing commit
-	messages with the `log` family of commands.  See
-	linkgit:git-notes[1].
-+
-May be an unabbreviated ref name or a glob and may be specified
-multiple times.  A warning will be issued for refs that do not exist,
-but a glob that does not match any refs is silently ignored.
-+
-This setting can be disabled by the `--no-notes` option,
-overridden by the `GIT_NOTES_DISPLAY_REF` environment variable,
-and overridden by the `--notes=<ref>` option.
+include::includes/cmd-config-section-rest.txt[]
+
+include::config/notes.txt[]
 
 GIT
 ---
diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 0a4200674c4..efbc10f0f59 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -44,7 +44,7 @@ using the `--notes` option. Such notes are added as a patch commentary
 after a three dash separator line.
 
 To change which notes are shown by 'git log', see the
-"notes.displayRef" configuration in linkgit:git-log[1].
+"notes.displayRef" discussion in <<CONFIGURATION>>.
 
 See the "notes.rewrite.<command>" configuration for a way to carry
 notes across commands that rewrite commits.
@@ -307,6 +307,7 @@ with 'git log', so if you use such notes, you'll probably need to write
 some special-purpose tools to do something useful with them.
 
 
+[[CONFIGURATION]]
 CONFIGURATION
 -------------
 
@@ -316,57 +317,9 @@ core.notesRef::
 	This setting can be overridden through the environment and
 	command line.
 
-notes.mergeStrategy::
-	Which merge strategy to choose by default when resolving notes
-	conflicts.  Must be one of `manual`, `ours`, `theirs`, `union`, or
-	`cat_sort_uniq`.  Defaults to `manual`.  See "NOTES MERGE STRATEGIES"
-	section above for more information on each strategy.
-+
-This setting can be overridden by passing the `--strategy` option.
-
-notes.<name>.mergeStrategy::
-	Which merge strategy to choose when doing a notes merge into
-	refs/notes/<name>.  This overrides the more general
-	"notes.mergeStrategy".  See the "NOTES MERGE STRATEGIES" section above
-	for more information on each available strategy.
-
-notes.displayRef::
-	Which ref (or refs, if a glob or specified more than once), in
-	addition to the default set by `core.notesRef` or
-	`GIT_NOTES_REF`, to read notes from when showing commit
-	messages with the 'git log' family of commands.
-	This setting can be overridden on the command line or by the
-	`GIT_NOTES_DISPLAY_REF` environment variable.
-	See linkgit:git-log[1].
-
-notes.rewrite.<command>::
-	When rewriting commits with <command> (currently `amend` or
-	`rebase`), if this variable is `false`, git will not copy
-	notes from the original to the rewritten commit.  Defaults to
-	`true`.  See also "`notes.rewriteRef`" below.
-+
-This setting can be overridden by the `GIT_NOTES_REWRITE_REF`
-environment variable.
+include::includes/cmd-config-section-rest.txt[]
 
-notes.rewriteMode::
-	When copying notes during a rewrite, what to do if the target
-	commit already has a note.  Must be one of `overwrite`,
-	`concatenate`, `cat_sort_uniq`, or `ignore`.  Defaults to
-	`concatenate`.
-+
-This setting can be overridden with the `GIT_NOTES_REWRITE_MODE`
-environment variable.
-
-notes.rewriteRef::
-	When copying notes during a rewrite, specifies the (fully
-	qualified) ref whose notes should be copied.  May be a glob,
-	in which case notes in all matching refs will be copied.  You
-	may also specify this configuration several times.
-+
-Does not have a default value; you must configure this variable to
-enable note rewriting.
-+
-Can be overridden with the `GIT_NOTES_REWRITE_REF` environment variable.
+include::config/notes.txt[]
 
 
 ENVIRONMENT
-- 
2.37.3.1406.g184357183a6

