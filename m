Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27CCC433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 15:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237840AbiEWPXy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 11:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237819AbiEWPVz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 11:21:55 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBE32BB30
        for <git@vger.kernel.org>; Mon, 23 May 2022 08:21:53 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id m12so13410497plb.4
        for <git@vger.kernel.org>; Mon, 23 May 2022 08:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hXZSYY2KaqV0r0lX1jjSzMnzlS1Dq5mFLVufnMfOnPE=;
        b=EDjy2RwxY+sppiK+p5cVZn98mDhhW1ULiWAig72S/fYrQomGeXCvk0lWGeb4vaQgib
         UXPbsfxPfmDeasvf2BOxqnz1jkiDOLuBK6B7JnL9KfOqRMH61vkQ9kc3IB/NXz8d9+Ey
         s9y9LYWcJo0zQHSFmOZ5piwx5watXYlnaswnCJr6no8lm/1y+M6Fc2xIzljIcnNQzb3g
         ZoXQV9rhsyUy7h7ZyH0RNzNUX+hjXs0YtmqBs+PSz2ZF/uBQKZiEHaS2JGuYVZKwx2S6
         /Crmdejoj6KB4HygyVqZihlGxA4DP2UJv2uzXNJJ8s7oxP/UjJdTTu1gwHcyZSVxoWfZ
         AbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hXZSYY2KaqV0r0lX1jjSzMnzlS1Dq5mFLVufnMfOnPE=;
        b=YXtn12F5ZZZ2Aw38y/CaQopk6nE/eEbV1NPnBc8RJqCl6sgMGT/NDFC5DLrBxNjqdE
         G72XzmHgbxw5b/aqUuOUMzF8ezue0fb04PP5qWC396TZNFc2CVP7rLwHy2xwQvG7MFcG
         S/fWF4PloF6DScOOrATUt5U557Nu9l8jqLVujLPW2l/ShNS3gpiRL897pyUXzaYtrM7D
         ndqTMsSeiYNkOOWDQTFMdZ8p80S4fraAJ5KUUlLUpLsVEHf3Q56G9nyATlUnp5z5AgYI
         L1DDbY+K6wi7uouTqHFPjVDOQFVhS32TWr/4SuGI1dYp0H8EYR+aCdqT8Gr/jmqrZ4E1
         v1RA==
X-Gm-Message-State: AOAM530vURQxayUjbMBNhd+yIPE5RLjHowHgWq1iNRQh/czk5EL6PTIe
        uGTeLsmRZRIN6VnvfOr1qCg=
X-Google-Smtp-Source: ABdhPJyE2POKdLfS5NaxfyEzLx3X96xnITZ8c8XDMm9cjQ+3XvfVG52kiY1onhyA6gPqGLp0D+sNXg==
X-Received: by 2002:a17:90b:4d8b:b0:1dc:c94f:fc29 with SMTP id oj11-20020a17090b4d8b00b001dcc94ffc29mr26429644pjb.186.1653319312881;
        Mon, 23 May 2022 08:21:52 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id y13-20020a1709027c8d00b0015e8d4eb2cfsm5280287pll.281.2022.05.23.08.21.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 May 2022 08:21:52 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Cc:     Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Fangyi Zhou <me@fangyi.io>,
        Yi-Jyun Pan <pan93412@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v4 9/9] l10n: Document the new l10n workflow
Date:   Mon, 23 May 2022 23:21:28 +0800
Message-Id: <20220523152128.26380-10-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220523012531.4505-1-worldhello.net@gmail.com>
References: <20220523012531.4505-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Change the "flow" of how translators interact with the l10n repository
at [1] to adjust it for a new workflow of not having a po/git.pot file
in-tree at all, and to not commit line numbers to the po/*.po files
that we do track in tree.

The current workflow was added in a combination of dce37b66fb0 (l10n:
initial git.pot for 1.7.10 upcoming release, 2012-02-13) and
271ce198cd0 (Update l10n guide, 2012-02-29).

As noted in preceding commits I think that it came about due to
technical debt I'd left behind in how the "po/git.pot" file was
created, and a mis-impression that the file:line comments were needed
as anything more than a transitory translation aid.

As the updated po/README.md shows the new workflow is substantially
the same, the difference is that translators no longer need to
initially pull from the l10n coordinator for a new po/git.pot, they
can simply use git.git's canonical source repository.

The l10n coordinator is still expected to announce a release to
translate, which presumably would always be Junio's latest release
tag. I'm not certain if this part of the process is actually
important. I.e. the delta translation-wise between that tag and
"master" is usually pretty small, so perhaps translators can just work
on "master" instead.

1. https://github.com/git-l10n/git-po/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 po/README.md | 230 ++++++++++++++++++++++++++-------------------------
 1 file changed, 117 insertions(+), 113 deletions(-)

diff --git a/po/README.md b/po/README.md
index 19fabb4acf..74856ca5bf 100644
--- a/po/README.md
+++ b/po/README.md
@@ -9,8 +9,14 @@ coordinates our localization effort in the l10 coordinator repository:
 
     https://github.com/git-l10n/git-po/
 
-The two character language translation codes are defined by ISO\_639-1, as
-stated in the gettext(1) full manual, appendix A.1, Usual Language Codes.
+We will use XX as an alias to refer to the language translation code in
+the following paragraphs, for example we use "po/XX.po" to refer to the
+translation file for a specific language. But this doesn't mean that
+the language code has only two letters. The language code can be in one
+of two forms: "ll" or "ll\_CC". Here "ll" is the ISO 639 two-letter
+language code and "CC" is the ISO 3166 two-letter code for country names
+and subdivisions. For example: "de" for German language code, "zh\_CN"
+for Simplified Chinese language code.
 
 
 ## Contributing to an existing translation
@@ -39,72 +45,74 @@ language, so that the l10n coordinator only needs to interact with one
 person per language.
 
 
-## Core translation
+## Translation Process Flow
 
-The core translation is the smallest set of work that must be completed
-for a new language translation. Because there are more than 5000 messages
-in the template message file "po/git.pot" that need to be translated,
-this is not a piece of cake for the contributor for a new language.
+The overall data-flow looks like this:
 
-The core template message file which contains a small set of messages
-will be generated in "po-core/core.pot" automatically by running a helper
-program named "git-po-helper" (described later).
+    +-------------------+             +------------------+
+    | Git source code   | ----(2)---> | L10n coordinator |
+    | repository        | <---(5)---- | repository       |
+    +-------------------+             +------------------+
+                    |                     |    ^
+                   (1)                   (3)  (4)
+                    V                     v    |
+               +----------------------------------+
+               |        Language Team XX          |
+               +----------------------------------+
 
-```shell
-git-po-helper init --core XX.po
-```
+- Translatable strings are marked in the source file.
+- Language teams can start translation iterations at any time, even
+  before the l10n window opens:
 
-After translating the generated "po-core/XX.po", you can merge it to
-"po/XX.po" using the following commands:
+  + Pull from the master branch of the source (1)
+  + Update the message file by running "make po-update PO\_FILE=po/XX.po"
+  + Translate the message file "po/XX.po"
 
-```shell
-msgcat po-core/XX.po po/XX.po -s -o /tmp/XX.po
-mv /tmp/XX.po po/XX.po
-git-po-helper update XX.po
-```
+- The L10n coordinator pulls from source and announces the l10n window
+  open (2)
+- Language team pulls from the l10n coordinator, starts another
+  translation iteration against the l10n coordinator's tree (3)
 
-Edit "po/XX.po" by hand to fix "fuzzy" messages, which may have misplaced
-translated messages and duplicate messages.
+  + Run "git pull --rebase" from the l10n coordinator
+  + Update the message file by running "make po-update PO\_FILE=po/XX.po"
+  + Translate the message file "po/XX.po"
+  + Squash trivial l10n git commits using "git rebase -i"
 
+- Language team sends pull request to the l10n coordinator (4)
+- L10n coordinator checks and merges
+- L10n coordinator asks the result to be pulled (5).
 
-## Translation Process Flow
 
-The overall data-flow looks like this:
+## Dynamically generated POT files
 
-    +-------------------+            +------------------+
-    | Git source code   | ---(1)---> | L10n coordinator |
-    | repository        | <---(4)--- | repository       |
-    +-------------------+            +------------------+
-                                          |      ^
-                                         (2)    (3)
-                                          V      |
-                                     +------------------+
-                                     | Language Team XX |
-                                     +------------------+
+POT files are templates for l10n contributors to create or update their
+translation files. We used to have the "po/git.pot" file which was
+generated by the l10n coordinator, but this file had been removed from
+the tree.
 
-- Translatable strings are marked in the source file.
-- L10n coordinator pulls from the source (1)
-- L10n coordinator updates the message template "po/git.pot"
-- Language team pulls from L10n coordinator (2)
-- Language team updates the message file "po/XX.po"
-- L10n coordinator pulls from Language team (3)
-- L10n coordinator asks the result to be pulled (4).
+The two POT files "po/git.pot" and "po/git-core.pot" can be created
+dynamically when necessary.
 
+L10n contributors use "po/git.pot" to prepare translations for their
+languages, but they are not expected to modify it. The "po/git.pot" file
+can be generated manually with the following command:
 
-## Maintaining the "po/git.pot" file
+```shell
+make po/git.pot
+```
 
-(This is done by the l10n coordinator).
+The "po/git-core.pot" file is the template for core translations. A core
+translation is the minimum set of work necessary to complete a
+translation of a new language. Since there are more than 5000 messages
+in the full set of template message file "po/git.pot" that need to be
+translated, this is not a piece of cake for new language contributors.
 
-The "po/git.pot" file contains a message catalog extracted from Git's
-sources. The l10n coordinator maintains it by adding new translations with
-msginit(1), or update existing ones with msgmerge(1).  In order to update
-the Git sources to extract the messages from, the l10n coordinator is
-expected to pull from the main git repository at strategic point in
-history (e.g. when a major release and release candidates are tagged),
-and then run "make pot" at the top-level directory.
+The "core" template file "po/git-core.pot" can be generated manually
+by running:
 
-Language contributors use this file to prepare translations for their
-language, but they are not expected to modify it.
+```shell
+make po/git-core.pot
+```
 
 
 ## Initializing a "XX.po" file
@@ -115,32 +123,14 @@ If your language XX does not have translated message file "po/XX.po" yet,
 you add a translation for the first time by running:
 
 ```shell
-msginit --locale=XX
+make po-init PO_FILE=po/XX.po
 ```
 
-in the "po/" directory, where XX is the locale, e.g. "de", "is", "pt\_BR",
-"zh\_CN", etc.
-
-Then edit the automatically generated copyright info in your new "XX.po"
-to be correct, e.g. for Icelandic:
-
-```diff
-@@ -1,6 +1,6 @@
--# Icelandic translations for PACKAGE package.
--# Copyright (C) 2010 THE PACKAGE'S COPYRIGHT HOLDER
--# This file is distributed under the same license as the PACKAGE package.
-+# Icelandic translations for Git.
-+# Copyright (C) 2010 Ævar Arnfjörð Bjarmason <avarab@gmail.com>
-+# This file is distributed under the same license as the Git package.
- # Ævar Arnfjörð Bjarmason <avarab@gmail.com>, 2010.
-```
-
-And change references to PACKAGE VERSION in the PO Header Entry to
-just "Git":
+where XX is the locale, e.g. "de", "is", "pt\_BR", "zh\_CN", etc.
 
-```shell
-perl -pi -e 's/(?<="Project-Id-Version: )PACKAGE VERSION/Git/' XX.po
-```
+The newly generated message file "po/XX.po" is based on the core pot
+file "po/git-core.pot", so it contains only a minimal set of messages
+and it's a good start for a new language contribution.
 
 Once you are done testing the translation (see below), commit the result
 and ask the l10n coordinator to pull from you.
@@ -153,19 +143,53 @@ and ask the l10n coordinator to pull from you.
 If you are replacing translation strings in an existing "XX.po" file to
 improve the translation, just edit the file.
 
-If there's an existing "XX.po" file for your language, but the repository
-of the l10n coordinator has newer "po/git.pot" file, you would need to first
-pull from the l10n coordinator (see the beginning of this document for its
-URL), and then update the existing translation by running:
+If you want to find new translatable strings in source files of upstream
+repository and propagate them to your "po/XX.po", run command:
 
 ```shell
-msgmerge --add-location --backup=off -U XX.po git.pot
+make po-update PO_FILE=po/XX.po
 ```
 
-in the "po/" directory, where "XX.po" is the file you want to update.
+It will:
 
-Once you are done testing the translation (see below), commit the result
-and ask the l10n coordinator to pull from you.
+- Call "make po/git.pot" to generate new "po/git.pot" file
+- Call "msgmerge --add-location --backup=off -U po/XX.po po/git.pot"
+  to update your "po/XX.po"
+- The "--add-location" option for msgmerge will add location lines,
+  and these location lines will help translation tools to locate
+  translation context easily.
+
+Once you are done testing the translation (see below), it's better
+to commit a location-less "po/XX.po" file to save repository space
+and make a user-friendly patch for review.
+
+To save a location-less "po/XX.po" automatically in repository, you
+can:
+
+First define a new attribute for "po/XX.po" by appending the following
+line in ".git/info/attributes":
+
+```
+/po/XX.po filter=gettext-no-location
+```
+
+Then define the driver for the "gettext-no-location" clean filter to
+strip out both filenames and locations from the contents as follows:
+
+```shell
+git config --global filter.gettext-no-location.clean \
+           "msgcat --no-location -"
+```
+
+For users who have gettext version 0.20 or higher, it is also possible
+to define a clean filter to preserve filenames but not locations:
+
+```shell
+git config --global filter.gettext-no-location.clean \
+           "msgcat --add-location=file -"
+```
+
+You're now ready to ask the l10n coordinator to pull from you.
 
 
 ## Fuzzy translation
@@ -196,6 +220,14 @@ common errors, e.g. missing printf format strings, or translated
 messages that deviate from the originals in whether they begin/end
 with a newline or not.
 
+L10n coordinator will check your contributions using a helper program
+(see "PO helper" section below):
+
+```shell
+git-po-helper check-po po/XX.po
+git-po-helper check-commits <rev-list-opts>
+```
+
 
 ## Marking strings for translation
 
@@ -370,29 +402,6 @@ l10n workflow.
 To build and install the helper program from source, see
 [git-po-helper/README][].
 
-Usage for git-po-helper:
-
-- To start a new language translation:
-
-  ```shell
-  git-po-helper init XX.po
-  ```
-
-- To update your "XX.po" file:
-
-  ```shell
-  git-po-helper update XX.po
-  ```
-
-- To check commit log and syntax of "XX.po":
-
-  ```shell
-  git-po-helper check-po XX.po
-  git-po-helper check-commits
-  ```
-
-Run "git-po-helper" without arguments to show usage.
-
 
 ## Conventions
 
@@ -436,13 +445,8 @@ additional conventions:
 - Initialize proper filename of the "XX.po" file conforming to
   iso-639 and iso-3166.
 
-- Must complete a minimal translation based on the "po-core/core.pot"
-  template. Using the following command to initialize the minimal
-  "po-core/XX.po" file:
-
-  ```shell
-  git-po-helper init --core <your-language>
-  ```
+- Must complete a minimal translation based on the "Core
+  translation". See that section above.
 
 - Add a new entry in the "po/TEAMS" file with proper format, and check
   the syntax of "po/TEAMS" by running the following command:
-- 
2.36.0.1.g15c4090757

