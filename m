Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D9CC00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 08:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbiG2I0n (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 04:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235111AbiG2I0H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 04:26:07 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5E028E0B
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 01:26:03 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v3so4160863wrp.0
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 01:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=OwCqEtJUbQdMLUNoRKkvdjqkx6eWPz1KROX8PpUN0zQ=;
        b=qfpugIKZiayJWzNtHwRXP8AjyY2KSvdCuh2Ec12DPh3BNtzb98eONNxecZyHTxfWMb
         pvZj2J8SyzwMksNOZXRbg+Ij1lxgWFdr5POEL88B8Z+hsF94w6Ha35Ju4CktHYuN+B3D
         rRcgCjbLqoL6In0pDHcG6a9kYmAJDoRyPXy9zRbsNpmNItgK3K9nO+JsDCnZT2ihwl9b
         m29oX/U++/O7U1i31jhYiSLGhznUtKmb3Ff2JG2e8DS7DdsA3qRaQRtsEaeEakOISNBS
         XEoplk6UQJISBL01UFSmzfPRdzJI3eIdf/UtgU2X7BlB/bPyrb+On+YmS1eJmeO/ljBk
         7jZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=OwCqEtJUbQdMLUNoRKkvdjqkx6eWPz1KROX8PpUN0zQ=;
        b=0zA+PzWedj3GS+UkOFHvnZfU7ZYU4sJ3PcuNmQ+vwE3fCZAfTu+H0UMBeOunKlX3ih
         B+RkBduQBBxsT15iz6oGFYuergN6nZkDQ5ac8KTwUpRPvYnelm0N1jvwxtkc1jeBpFwi
         Z1hA+j8rpjo3ohWBSMScVmN56x6EEjYaYE/Srsj/NyGOf6EAK4KZzK5jfVUCBVZrrzm8
         XhOMctRYZo2QQtHGwNebod8yJy7cS1r71gVbYgtnmOKUkOl4AlepmKOqaHA1KByvGr4J
         QCFj34moBQiRHKQVYYDOFRPBQIPdE8uTzFkUhLz6f3DsrbiLFCkZ26JDE8MkyCXEWjpe
         wb/w==
X-Gm-Message-State: ACgBeo1auNxT+vWVRlMSHGCurtKQ0xECc7S0HOqejyRUp8j+usfxL8TA
        JJRTKaRMnQXvO9Zqe2RuKS3wYbNkEmy/9g==
X-Google-Smtp-Source: AA6agR4wNWus7ujRhayAKS+R+6i3u2bnAfRe497mPGb1QP7rhyhNqqShjND7/FF954XQZ9jOCh7tTw==
X-Received: by 2002:a5d:6c6f:0:b0:21d:cb1b:5776 with SMTP id r15-20020a5d6c6f000000b0021dcb1b5776mr1604008wrz.44.1659083161586;
        Fri, 29 Jul 2022 01:26:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a056000181400b0021e571a99d5sm2994802wrh.17.2022.07.29.01.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 01:26:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/9] notes docs: de-duplicate configuration sections
Date:   Fri, 29 Jul 2022 10:25:51 +0200
Message-Id: <patch-v2-5.9-1b6c8c75df7-20220729T081959Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1196.g8af3636bc64
In-Reply-To: <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com>
References: <cover.1657819649.git.matheus.bernardino@usp.br> <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's also fix the "git-notes(1)" docs so that we link to
"git-config(1)", not "git-log(1)" as a reference for the "notes" docs.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/notes.txt | 43 ++++++++++++++++-----------
 Documentation/git-log.txt      | 16 ++--------
 Documentation/git-notes.txt    | 54 ++--------------------------------
 3 files changed, 32 insertions(+), 81 deletions(-)

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
index 20e87cecf49..ed802bb8e12 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -227,19 +227,9 @@ log.showSignature::
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
index 0a4200674c4..68d547e2474 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -44,7 +44,7 @@ using the `--notes` option. Such notes are added as a patch commentary
 after a three dash separator line.
 
 To change which notes are shown by 'git log', see the
-"notes.displayRef" configuration in linkgit:git-log[1].
+"notes.displayRef" configuration in linkgit:git-config[1].
 
 See the "notes.rewrite.<command>" configuration for a way to carry
 notes across commands that rewrite commits.
@@ -316,57 +316,9 @@ core.notesRef::
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
2.37.1.1196.g8af3636bc64

