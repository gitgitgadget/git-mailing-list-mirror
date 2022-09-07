Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA62C54EE9
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 08:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiIGI1c (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 04:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiIGI1V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 04:27:21 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC387A2A9D
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 01:27:18 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bq9so6235836wrb.4
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 01:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=93xkCwwLhmP9Q5msCezyeEe9vGiYamLQ7ky3clngnn4=;
        b=CCy9X5FHy8y1VF873M+aYclCV6/nrUgHcNYvWt4yxmUqBr+cOjOwdNNth/JJsDnJ8M
         AyYx3+YPlFUToQ9LYb2Zz6Dqo6dXqwGNwBMFHgyCq3hmeBYEAtsG02eQtOTcw3UeeC9U
         d6TAXhAUW3k1qzotJdg6lk1scFbSrqQtFO9dIwf9sxrYzn5R/F7+PHHFXqDsfE185PZ8
         FcbHVpI5mvoL0R5hamR4ZpyQvK31ipCBWPnNlcQ39i+WBNXFN/6BqevJVwfbOGVklABZ
         ZR/CgRy49sqBlKkA0+ze5cZdm+0Oju1MZG0YLdmEJCxA/EI+PQjep+EVKBHh82fNMXEq
         3NnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=93xkCwwLhmP9Q5msCezyeEe9vGiYamLQ7ky3clngnn4=;
        b=kuOtoiE1kE9KB1+d2Z6xi6+t8KWfA6EpTg2Ge70qefJx5YXMPXyrl6ybvHyCaGHa/n
         D/gOKIThNJYRyI5Y/aQvjyZ45EaJH4IiD8j0eRd8hqXJaMF+nDhxr4opLchW8b8u/JO2
         sP7MQ1zw3LnOc2LOLyAETq55KEXKy2Y6CdieGZc5Ja/DmOQNgjarZi5n4p52dFlu2t8o
         ItL+JBm28ohwqw4wbVp+5N2MmKfHg5Nqxo16IjHmEZromQ+pTTXLXVREB11/K6h5dXNt
         yPiueS/fuSatPFvSos03Kcgmu3xZKw+Hm5PQp3pTvJ6H+HyPlmQ/PqKmSwjPg3qKGOb2
         dmeA==
X-Gm-Message-State: ACgBeo0VYo5K2CustYyRZ9Hww6sIz4+1J5LXUzCX7jElV1GMuw1uOWNV
        4CVm2hiOVsTH+jZh3RzfzOjUmA08SlsMLA==
X-Google-Smtp-Source: AA6agR7hk6vf3d9/rFNmmCj2TFr/C8oeHVloHD2styWxuuiQNyOqCMiJaAuOp9ZJq1cW+WBCTYZNBg==
X-Received: by 2002:a5d:4d0c:0:b0:228:cd9f:5a4c with SMTP id z12-20020a5d4d0c000000b00228cd9f5a4cmr1374137wrt.138.1662539236633;
        Wed, 07 Sep 2022 01:27:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003a3170a7af9sm19532096wmq.4.2022.09.07.01.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 01:27:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 5/9] notes docs: de-duplicate and combine configuration sections
Date:   Wed,  7 Sep 2022 10:27:01 +0200
Message-Id: <patch-v4-5.9-9f1b90298d8-20220907T082419Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1490.g9adf4224da0
In-Reply-To: <cover-v4-0.9-00000000000-20220907T082419Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20220831T083759Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20220907T082419Z-avarab@gmail.com>
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
2.37.3.1490.g9adf4224da0

