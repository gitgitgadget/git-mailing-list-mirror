Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1AAC433F5
	for <git@archiver.kernel.org>; Thu, 19 May 2022 08:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbiESIRg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 04:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbiESIQc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 04:16:32 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8723961605
        for <git@vger.kernel.org>; Thu, 19 May 2022 01:16:28 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id a11so4519817pff.1
        for <git@vger.kernel.org>; Thu, 19 May 2022 01:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y6+M+gEwz8nsDSZoxwXd5w+3aQp+RiGc2ekdEpNcJHY=;
        b=bEGPUEU+WtFOb9BJvSIsK0IhFLPwfK259/sC3sequxbU8/DWpDCEmjP06bUAM7CMJK
         zxeSX3sO3GEask+GHU4Hb6hiOqs5iyVvPoCFTstS8TEraopphAQx8GKnNSz5hAKuis0G
         K52PqYWn7karKDv+iIo6AoHENC6m0veT7pPd/kn5Fowqvo0hov0iuVozVc5B+cfQwkxj
         CO4LmnWKh3GiNpyAXEfytlFVQnlMmzxg1q4N6k6ZWnwpgrAqorE9j9z7tsEJiMuils+N
         8FDmzrb83M1XYPsC+xcIcKRNK6qH4bDavSOeecy4apPycGOz+Hmj0tNZ5f71qKh/poUN
         dmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y6+M+gEwz8nsDSZoxwXd5w+3aQp+RiGc2ekdEpNcJHY=;
        b=CWUjSPoZwk2fMOK7YAp1DIS5ZCbKlUWdQMsjtPsJo1mt9gqZXN0WgUuTS5qJoa4dWt
         Oj793gpViTQkcq2YXyXVY7Q95jYTt0wumzbteRWMne0ZfuukK1sy6NUbIn/OsiXc7fEq
         +zHZnYJ0DBdjGCQmqvpvcI8Mj4vGKbzVoxSKNSWD2fEO83ipritgO+fXVxooY7Wc88yr
         XO2F3z76o0zg86/QVEQmNDpJshH0hInfpD71wxqi51uUoj6kYWAV93P6Iz1q4LOlSFKB
         fyDKemeT6Wi8ZFB2TRSUkdk6cpSDF5ZUiCFcBbrLuyHjpVHKDT3Gbwa07/Crg75c4MDf
         832A==
X-Gm-Message-State: AOAM530wv1rtKt+cmvpx/bVi4iGwdMA1Rxwc8+VlnIQEHmP91fe6yr8d
        IShaR6Q/xFMAJknjaabgKfA=
X-Google-Smtp-Source: ABdhPJzT5PUbkDEVVNLjekOzS61spa7f34JIoEK6ogKavQaTiY85TogoYCM7s/TG036FNGlFoOgLUg==
X-Received: by 2002:a63:6744:0:b0:3f6:10c2:b0fa with SMTP id b65-20020a636744000000b003f610c2b0famr3060673pgc.498.1652948187702;
        Thu, 19 May 2022 01:16:27 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id u127-20020a627985000000b0050dc76281d3sm3576687pfc.173.2022.05.19.01.16.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 May 2022 01:16:27 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Alexander Shopov <ash@kambanaria.org>,
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
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v2 9/9] l10n: Document the new l10n workflow
Date:   Thu, 19 May 2022 16:15:48 +0800
Message-Id: <20220519081548.3380-10-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220503132354.9567-1-worldhello.net@gmail.com>
References: <20220503132354.9567-1-worldhello.net@gmail.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 po/README.md | 191 ++++++++++++++++++++++++---------------------------
 1 file changed, 88 insertions(+), 103 deletions(-)

diff --git a/po/README.md b/po/README.md
index 19fabb4acf..00c090e7c0 100644
--- a/po/README.md
+++ b/po/README.md
@@ -46,65 +46,67 @@ for a new language translation. Because there are more than 5000 messages
 in the template message file "po/git.pot" that need to be translated,
 this is not a piece of cake for the contributor for a new language.
 
-The core template message file which contains a small set of messages
-will be generated in "po-core/core.pot" automatically by running a helper
-program named "git-po-helper" (described later).
+The "core" set of messages can be generated at "po/git-core.pot" by
+running:
 
 ```shell
-git-po-helper init --core XX.po
+make core-pot
 ```
 
-After translating the generated "po-core/XX.po", you can merge it to
-"po/XX.po" using the following commands:
-
-```shell
-msgcat po-core/XX.po po/XX.po -s -o /tmp/XX.po
-mv /tmp/XX.po po/XX.po
-git-po-helper update XX.po
-```
-
-Edit "po/XX.po" by hand to fix "fuzzy" messages, which may have misplaced
-translated messages and duplicate messages.
+And then proceeding with the rest of these instructions on the new
+generated "po/git-core.pot" file.
 
 
 ## Translation Process Flow
 
 The overall data-flow looks like this:
 
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
 
 - Translatable strings are marked in the source file.
-- L10n coordinator pulls from the source (1)
-- L10n coordinator updates the message template "po/git.pot"
-- Language team pulls from L10n coordinator (2)
-- Language team updates the message file "po/XX.po"
-- L10n coordinator pulls from Language team (3)
-- L10n coordinator asks the result to be pulled (4).
+- Language teams can start translation iterations at any time, even
+  before the l10n window opens:
+
+  + Pull from the source (1)
+  + Update the message file by running "make po-update PO\_FILE=po/XX.po"
+  + Translate the message file "po/XX.po"
 
+- The L10n coordinator pulls from source and announces the l10n window
+  open (2)
+- Language team pulls from the l10n coordinator, starts another
+  translation iteration against the l10n coordinator's tree (3)
 
-## Maintaining the "po/git.pot" file
+  + Run "git pull --rebase" from the l10n coordinator
+  + Update the message file by running "make po-update PO\_FILE=po/XX.po"
+  + Translate the message file "po/XX.po"
+  + Squash trivial l10n git commits using "git rebase -i"
 
-(This is done by the l10n coordinator).
+- Language team sends pull request to the l10n coordinator (4)
+- L10n coordinator checks and merges
+- L10n coordinator asks the result to be pulled (5).
 
-The "po/git.pot" file contains a message catalog extracted from Git's
-sources. The l10n coordinator maintains it by adding new translations with
-msginit(1), or update existing ones with msgmerge(1).  In order to update
-the Git sources to extract the messages from, the l10n coordinator is
-expected to pull from the main git repository at strategic point in
-history (e.g. when a major release and release candidates are tagged),
-and then run "make pot" at the top-level directory.
 
-Language contributors use this file to prepare translations for their
-language, but they are not expected to modify it.
+## Creating the "po/git.pot" file
+
+The "po/git.pot" file, once generated by the the l10n coordinator had
+been removed from the tree. L10n contributors can generated it at
+runtime using command:
+
+```shell
+make pot
+```
+
+Then language contributors use this file to prepare translations for
+their language, but they are not expected to modify it.
 
 
 ## Initializing a "XX.po" file
@@ -115,32 +117,14 @@ If your language XX does not have translated message file "po/XX.po" yet,
 you add a translation for the first time by running:
 
 ```shell
-msginit --locale=XX
-```
-
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
+make po-init PO_FILE=po/XX.po
 ```
 
-And change references to PACKAGE VERSION in the PO Header Entry to
-just "Git":
+Where XX is the locale, e.g. "de", "is", "pt\_BR", "zh\_CN", etc.
 
-```shell
-perl -pi -e 's/(?<="Project-Id-Version: )PACKAGE VERSION/Git/' XX.po
-```
+The newly generated message file "po/XX.po" is based on the core pot
+file "po/git-core.pot", so it contains only a minimal set of messages
+and it's a good start for a new language contribution.
 
 Once you are done testing the translation (see below), commit the result
 and ask the l10n coordinator to pull from you.
@@ -153,19 +137,40 @@ and ask the l10n coordinator to pull from you.
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
+- Call "make pot" at runtime to generate new "po/git.pot" file
+- Call "msgmerge --add-location --backup=off -U po/XX.po po/git.pot"
+  to update your "po/XX.po"
+- The "--add-location" option for msgmerge will add location lines,
+  and these location lines will help translation tools to location
+  translation context easily.
+
+Once you are done testing the translation (see below), it's better
+to commit a location-less "po/XX.po" file to save repository space
+and make a user-friendly patch for review.
+
+To save a location-less "po/XX.po" automatically in repository, you
+can:
+
+- Define new attribute for "po/XX.po" by adding new line in
+  ".git/info/attributes":
+
+        /po/XX.po filter=gettext-no-location
+
+- Define driver for "gettext-no-location" filter:
+
+        $ git config --global filter.gettext-no-location.clean \
+              "msgcat --no-location -"
+
+You're now ready to ask the l10n coordinator to pull from you.
 
 
 ## Fuzzy translation
@@ -196,6 +201,14 @@ common errors, e.g. missing printf format strings, or translated
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
 
@@ -370,29 +383,6 @@ l10n workflow.
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
 
@@ -436,13 +426,8 @@ additional conventions:
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

